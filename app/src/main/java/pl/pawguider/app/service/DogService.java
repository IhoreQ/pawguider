package pl.pawguider.app.service;

import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;
import pl.pawguider.app.controller.dto.request.DogAddRequest;
import pl.pawguider.app.model.*;
import pl.pawguider.app.repository.*;

import java.util.List;
import java.util.Optional;

@Service
public class DogService {

    private final UserService userService;
    private final ImageService imageService;
    private final DogRepository dogRepository;
    private final DogBreedRepository dogBreedRepository;
    private final DogBehaviorRepository dogBehaviorRepository;
    private final DogsBehaviorsRepository dogsBehaviorsRepository;
    private final GenderRepository genderRepository;

    public DogService(UserService userService, ImageService imageService, DogRepository dogRepository, DogBreedRepository dogBreedRepository, DogBehaviorRepository dogBehaviorRepository, DogsBehaviorsRepository dogsBehaviorsRepository, GenderRepository genderRepository) {
        this.userService = userService;
        this.imageService = imageService;
        this.dogRepository = dogRepository;
        this.dogBreedRepository = dogBreedRepository;
        this.dogBehaviorRepository = dogBehaviorRepository;
        this.dogsBehaviorsRepository = dogsBehaviorsRepository;
        this.genderRepository = genderRepository;
    }

    public Dog getDogById(Long id) {
        Optional<Dog> dog = dogRepository.findById(id);
        return dog.orElse(null);
    }

    public Dog getDogInfo(User user) {
        Optional<Dog> dog = dogRepository.findByOwner(user);
        return dog.orElse(null);
    }

    public boolean deleteDog(User user) {

        Optional<Dog> foundDog = dogRepository.findByOwner(user);

        if (foundDog.isPresent()) {
            Dog dog = foundDog.get();
            imageService.deleteImage(dog.getPhoto());
            dogRepository.delete(dog);

            return true;
        }

        return false;
    }

    @Transactional
    public boolean addDog(User user, DogAddRequest dogAddRequest) {

        Optional<DogBreed> foundBreed = dogBreedRepository.findById(dogAddRequest.breedId());
        Optional<Gender> foundGender = genderRepository.findByName(dogAddRequest.gender());

        if (foundBreed.isPresent() && foundGender.isPresent()) {
            DogBreed breed = foundBreed.get();
            Gender gender = foundGender.get();
            Dog dog = new Dog(dogAddRequest.name(), dogAddRequest.age(), gender, dogAddRequest.description(), breed, dogAddRequest.photoName(), user);

            Dog addedDog = dogRepository.save(dog);

            List<DogsBehaviors> behaviors = dogAddRequest.behaviorsIds()
                    .stream().map((item) -> new DogsBehaviors(new DogBehavior(item), addedDog))
                    .toList();

            dogsBehaviorsRepository.saveAll(behaviors);

            return true;
        }

        return false;
    }

    public List<DogBreed> getAllBreeds() {
        return dogBreedRepository.findAllNamesWithIds();
    }

    public List<DogBehavior> getAllBehaviors() {
        return dogBehaviorRepository.findAll();
    }

}

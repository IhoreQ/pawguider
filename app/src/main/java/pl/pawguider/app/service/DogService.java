package pl.pawguider.app.service;

import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;
import pl.pawguider.app.controller.dto.request.DogAddRequest;
import pl.pawguider.app.model.*;
import pl.pawguider.app.repository.*;

import java.util.List;
import java.util.Objects;
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
    private final DogLikeRepository dogLikeRepository;

    public DogService(UserService userService, ImageService imageService, DogRepository dogRepository, DogBreedRepository dogBreedRepository, DogBehaviorRepository dogBehaviorRepository, DogsBehaviorsRepository dogsBehaviorsRepository, GenderRepository genderRepository, DogLikeRepository dogLikeRepository) {
        this.userService = userService;
        this.imageService = imageService;
        this.dogRepository = dogRepository;
        this.dogBreedRepository = dogBreedRepository;
        this.dogBehaviorRepository = dogBehaviorRepository;
        this.dogsBehaviorsRepository = dogsBehaviorsRepository;
        this.genderRepository = genderRepository;
        this.dogLikeRepository = dogLikeRepository;
    }

    public Dog getDogById(Long id) {
        Optional<Dog> dog = dogRepository.findById(id);
        return dog.orElse(null);
    }

    public Dog getDogInfo(User user) {
        Optional<Dog> dog = dogRepository.findByOwner(user);
        return dog.orElse(null);
    }

    public boolean deleteDog(User user, Long dogId) {

        Optional<Dog> foundDog = dogRepository.findById(dogId);

        if (foundDog.isPresent()) {
            Dog dog = foundDog.get();
            if (isUserDogOwner(user, dog)) {
                imageService.deleteImage(dog.getPhoto());
                dogRepository.delete(dog);
                return true;
            }
        }

        return false;
    }

    private boolean isUserDogOwner(User user, Dog dog) {
        return Objects.equals(dog.getOwner().getIdUser(), user.getIdUser());
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

    public void addLike(User user, Dog dog) {
        DogLike like = new DogLike(user, dog);
        dogLikeRepository.save(like);
    }

    public void deleteLike(User user, Dog dog) {
        DogLike like = dogLikeRepository.findByUserIdAndDogId(user.getIdUser(), dog.getIdDog());
        dogLikeRepository.delete(like);
    }

    public void toggleSelected(Dog dog) {
        dog.setSelected(!dog.getSelected());
        dogRepository.save(dog);
    }

    public boolean isDogAlreadyLiked(User user, Dog dog) {
        return dog.getLikes()
                .stream()
                .anyMatch(like -> like.getUser().getIdUser().equals(user.getIdUser()));
    }

    public boolean isOwner(User user, Dog dog) {
        return dog.getOwner().getIdUser().equals(user.getIdUser());
    }
}

package pl.pawguider.app.service;

import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;
import pl.pawguider.app.controller.dto.request.DogAddRequest;
import pl.pawguider.app.controller.dto.request.DogUpdateRequest;
import pl.pawguider.app.exception.dog.*;
import pl.pawguider.app.model.*;
import pl.pawguider.app.repository.*;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class DogService {

    private final ImageService imageService;
    private final DogRepository dogRepository;
    private final DogBreedService dogBreedService;
    private final DogBehaviorRepository dogBehaviorRepository;
    private final DogsBehaviorsRepository dogsBehaviorsRepository;
    private final GenderService genderService;
    private final DogLikeRepository dogLikeRepository;

    public DogService(ImageService imageService, DogRepository dogRepository, DogBreedService dogBreedService, DogBehaviorRepository dogBehaviorRepository, DogsBehaviorsRepository dogsBehaviorsRepository, GenderService genderService, DogLikeRepository dogLikeRepository) {
        this.imageService = imageService;
        this.dogRepository = dogRepository;
        this.dogBreedService = dogBreedService;
        this.dogBehaviorRepository = dogBehaviorRepository;
        this.dogsBehaviorsRepository = dogsBehaviorsRepository;
        this.genderService = genderService;
        this.dogLikeRepository = dogLikeRepository;
    }

    public Dog getDogById(Long id) {
        return dogRepository.findById(id).orElseThrow(() -> new DogNotFoundException(id));
    }

    public void deleteDog(User user, Long dogId) {

        Dog dog = getDogById(dogId);

        if (!isUserDogOwner(user, dog))
            throw new UnauthorizedDogOperationException("User is not authorized to delete a dog with id: %d".formatted(dogId));

        imageService.deleteImage(dog.getPhoto());

        dogRepository.delete(dog);
    }

    @Transactional
    public Dog addDog(User user, DogAddRequest dogAddRequest) {
        DogBreed breed = dogBreedService.getBreedById(dogAddRequest.breedId());
        Gender gender = genderService.getGenderByName(dogAddRequest.gender());

        Dog dog = new Dog(dogAddRequest.name(), dogAddRequest.age(), gender, dogAddRequest.description(), breed, dogAddRequest.photoName(), user);

        Dog addedDog = dogRepository.save(dog);

        List<DogsBehaviors> behaviors = dogAddRequest.behaviorsIds()
                .stream().map((item) -> new DogsBehaviors(new DogBehavior(item), addedDog))
                .toList();

        dogsBehaviorsRepository.saveAll(behaviors);

        addedDog.setBehaviors(behaviors);

        return addedDog;
    }

    public List<DogBreed> getAllBreeds() {
        return dogBreedService.findAllNamesWithIds();
    }

    public List<DogBehavior> getAllBehaviors() {
        return dogBehaviorRepository.findAll();
    }

    public void addLike(User user, Dog dog) {
        if (isUserDogOwner(user, dog))
            throw new UserOwnedDogLikeException();

        if (isDogAlreadyLiked(user, dog))
            throw new DogAlreadyLikedException(user.getIdUser(), dog.getIdDog());

        DogLike like = new DogLike(user, dog);
        dogLikeRepository.save(like);
    }

    public void deleteLike(User user, Dog dog) {
        if (isUserDogOwner(user, dog))
            throw new UserOwnedDogLikeException();

        if (!isDogAlreadyLiked(user, dog))
            throw new DogNotLikedException(user.getIdUser(), dog.getIdDog());

        DogLike like = dogLikeRepository.findByUserIdAndDogId(user.getIdUser(), dog.getIdDog());
        dogLikeRepository.delete(like);
    }

    public void toggleSelected(User user, Dog dog) {
        if (!isUserDogOwner(user, dog))
            throw new UnauthorizedDogOperationException("User is not authorized to select a dog with id: %d".formatted(dog.getIdDog()));

        dog.setSelected(!dog.getSelected());
        dogRepository.save(dog);
    }

    public boolean isDogAlreadyLiked(User user, Dog dog) {
        return dog.getLikes()
                .stream()
                .anyMatch(like -> like.getUser().getIdUser().equals(user.getIdUser()));
    }

    public boolean isUserDogOwner(User user, Dog dog) {
        return Objects.equals(dog.getOwner().getIdUser(), user.getIdUser());
    }

    @Transactional
    public Dog updateDog(User user, Dog dog, DogUpdateRequest request) {

        if (!isUserDogOwner(user, dog))
            throw new UnauthorizedDogOperationException("User is not authorized to update a dog with id: %d".formatted(request.dogId()));

        DogBreed breed = dogBreedService.getBreedById(request.breedId());
        Gender gender = genderService.getGenderByName(request.gender());

        dog.setName(request.name());
        dog.setAge(request.age());
        dog.setDescription(request.description());
        dog.setBreed(breed);
        dog.setGender(gender);
        dog.setPhoto(request.photoName());
        Dog updatedDog = dogRepository.save(dog);

        List<DogsBehaviors> behaviors = request.behaviorsIds()
                .stream().map((item) -> new DogsBehaviors(new DogBehavior(item), updatedDog))
                .toList();

        dogsBehaviorsRepository.deleteAll(dog.getBehaviors());
        dogsBehaviorsRepository.saveAll(behaviors);

        updatedDog.setBehaviors(behaviors);
        return updatedDog;
    }
}

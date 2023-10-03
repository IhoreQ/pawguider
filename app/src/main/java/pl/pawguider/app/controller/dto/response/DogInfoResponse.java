package pl.pawguider.app.controller.dto.response;

import com.fasterxml.jackson.annotation.JsonCreator;
import pl.pawguider.app.model.Dog;
import pl.pawguider.app.model.DogBehavior;
import pl.pawguider.app.model.DogsBehaviors;
import pl.pawguider.app.model.User;

import java.util.List;
import java.util.Objects;

public record DogInfoResponse(Long idDog,
                              String name,
                              int age,
                              String breed,
                              String gender,
                              String size,
                              String description,
                              String photo,
                              List<DogBehavior> behaviors,
                              int likes,
                              boolean currentUserLiked,
                              Long ownerId) {
    @JsonCreator
    public DogInfoResponse {
    }

    public static DogInfoResponse getResponse(User user, Dog dog) {
        String gender = dog.getGender().getName();
        String breed = dog.getBreed().getName();
        String size = dog.getBreed().getSize().getName();
        List<DogBehavior> behaviors = dog.getDogsBehaviors().stream().map(DogsBehaviors::getBehavior).toList();
        boolean currentUserLiked = dog.getDogsLikes().stream().anyMatch(dogLike -> dogLike.getUser().getIdUser().equals(user.getIdUser()));
        return new DogInfoResponse(dog.getIdDog(), dog.getName(), dog.getAge(), breed, gender, size, dog.getDescription(), dog.getPhoto(), behaviors, dog.getDogsLikes().size(), currentUserLiked, dog.getOwner().getIdUser());
    }
}

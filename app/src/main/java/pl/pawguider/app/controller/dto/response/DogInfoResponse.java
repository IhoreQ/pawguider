package pl.pawguider.app.controller.dto.response;

import com.fasterxml.jackson.annotation.JsonCreator;
import pl.pawguider.app.model.Dog;
import pl.pawguider.app.model.DogBehavior;
import pl.pawguider.app.model.DogsBehaviors;

import java.util.List;

public record DogInfoResponse(String name,
                              int age,
                              String breed,
                              String gender,
                              String size,
                              String description,
                              String photo,
                              List<DogBehavior> behaviors,
                              Long ownerId) {
    @JsonCreator
    public DogInfoResponse {
    }

    public static DogInfoResponse getResponse(Dog dog) {
        String gender = dog.getGender().getName();
        String breed = dog.getBreed().getName();
        String size = dog.getBreed().getSize().getName();
        List<DogBehavior> behaviors = dog.getDogsBehaviors().stream().map(DogsBehaviors::getBehavior).toList();

        return new DogInfoResponse(dog.getName(), dog.getAge(), breed, gender, size, dog.getDescription(), dog.getPhoto(), behaviors, dog.getOwner().getIdUser());
    }
}

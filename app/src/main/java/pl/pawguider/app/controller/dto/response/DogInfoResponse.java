package pl.pawguider.app.controller.dto.response;

import com.fasterxml.jackson.annotation.JsonCreator;
import pl.pawguider.app.model.Dog;

public record DogInfoResponse(String name,
                              int age,
                              String breed,
                              String gender,
                              String size,
                              String description,
                              String photo) {
    @JsonCreator
    public DogInfoResponse {
    }

    public static DogInfoResponse getResponse(Dog dog) {
        String gender = dog.getGender() ? "Male" : "Female";
        String breed = dog.getBreed().getName();
        String size = dog.getBreed().getSize().getName();

        return new DogInfoResponse(dog.getName(), dog.getAge(), breed, gender, size, dog.getDescription(), dog.getPhoto());
    }
}

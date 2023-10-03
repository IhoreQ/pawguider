package pl.pawguider.app.controller.dto.response;

import pl.pawguider.app.model.Dog;

public record DogInfoBoxResponse(Long id,
                                 String name,
                                 String breed,
                                 String gender,
                                 int age,
                                 String photoName) {

    public static DogInfoBoxResponse getResponse(Dog dog) {
        return new DogInfoBoxResponse(dog.getIdDog(), dog.getName(), dog.getBreed().getName(), dog.getGender().getName(), dog.getAge(), dog.getPhoto());
    }
}

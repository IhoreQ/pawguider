package pl.pawguider.app.controller.dto.response;

import pl.pawguider.app.model.DogBreed;

public record DogBreedResponse(Long id,
                               String name) {

    public static DogBreedResponse getResponse(DogBreed breed) {
        return new DogBreedResponse(breed.getIdDogBreed(), breed.getName());
    }
}

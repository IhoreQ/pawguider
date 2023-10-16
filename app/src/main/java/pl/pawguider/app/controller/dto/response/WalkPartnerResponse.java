package pl.pawguider.app.controller.dto.response;

import pl.pawguider.app.model.Dog;

public record WalkPartnerResponse(Long id,
                                  String name,
                                  String photoName,
                                  boolean selected) {

    public static WalkPartnerResponse getResponse(Dog dog) {
        return new WalkPartnerResponse(dog.getIdDog(), dog.getName(), dog.getPhoto(), dog.getSelected());
    }
}

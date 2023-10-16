package pl.pawguider.app.controller.dto.response;

import pl.pawguider.app.model.Place;

public record LikedPlaceResponse(Long id,
                                 String name,
                                 String city,
                                 String street,
                                 String photoName) {

    public static LikedPlaceResponse getResponse(Place place) {
        return new LikedPlaceResponse(place.getIdPlace(), place.getName(), place.getCity().getName(), place.getAddress().getStreet(), place.getPhoto());
    }
}

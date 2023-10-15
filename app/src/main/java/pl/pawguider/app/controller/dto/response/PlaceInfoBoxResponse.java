package pl.pawguider.app.controller.dto.response;


import pl.pawguider.app.model.Place;
import pl.pawguider.app.model.PlaceLike;

import java.util.Collection;

public record PlaceInfoBoxResponse(Long id,
                                   String name,
                                   String street,
                                   int dogsCount,
                                   double averageScore,
                                   String photoName) {

    public PlaceInfoBoxResponse {
    }

    public static PlaceInfoBoxResponse getResponse(Place place) {
        // TODO dogCount ze spacerów
        int dogCount = 0;
        Collection<PlaceLike> likes = place.getLikes();
        double averageScore = likes.stream().mapToDouble(PlaceLike::getRating).average().orElse(0.0);
        return new PlaceInfoBoxResponse(place.getIdPlace(), place.getName(), place.getAddress().getStreet(), dogCount, averageScore, place.getPhoto());
    }
}

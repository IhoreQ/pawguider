package pl.pawguider.app.controller.dto.response;


import pl.pawguider.app.model.Dog;
import pl.pawguider.app.model.Place;
import pl.pawguider.app.model.PlaceRating;

import java.util.Collection;
import java.util.List;

public record PlaceInfoBoxResponse(Long id,
                                   String name,
                                   String street,
                                   String houseNumber,
                                   long dogsCount,
                                   double averageScore,
                                   String photoName) {


    public static PlaceInfoBoxResponse getResponse(Place place) {
        List<Dog> dogs = place.getActiveWalks().stream()
                .flatMap(walk -> walk.getUser().getDogs().stream())
                .toList();

        long dogCount = dogs.stream()
                .filter(Dog::getSelected)
                .count();

        Collection<PlaceRating> ratings = place.getRatings();
        double averageScore = ratings.stream().mapToDouble(PlaceRating::getRating).average().orElse(0.0);

        return new PlaceInfoBoxResponse(place.getIdPlace(), place.getName(), place.getAddress().getStreet(), place.getAddress().getHouseNumber(), dogCount, averageScore, place.getPhoto());
    }
}

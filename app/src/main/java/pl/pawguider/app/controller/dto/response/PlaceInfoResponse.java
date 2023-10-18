package pl.pawguider.app.controller.dto.response;

import pl.pawguider.app.model.*;

import java.util.Collection;

public record PlaceInfoResponse(String name,
                                String street,
                                String houseNumber,
                                String zipCode,
                                String city,
                                String description,
                                double averageScore,
                                double currentUserScore,
                                boolean currentUserLiked,
                                boolean currentUserRated,
                                String photoName) {

    public static PlaceInfoResponse getResponse(User user, Place place) {
        Address address = place.getAddress();
        Collection<PlaceRating> ratings = place.getRatings();
        double averageScore = ratings.stream().mapToDouble(PlaceRating::getRating).average().orElse(0.0);
        double currentUserScore = ratings.stream()
                .filter(rating -> rating.getUser().getIdUser().equals(user.getIdUser()))
                .findFirst()
                .map(PlaceRating::getRating)
                .orElse(0.0);
        boolean currentUserLiked = place.getLikes().stream()
                .anyMatch(like -> like.getUser().getIdUser().equals(user.getIdUser()));
        boolean currentUserRated = currentUserScore != 0.0;
        return new PlaceInfoResponse(place.getName(), address.getStreet(), address.getHouseNumber(), address.getZipCode(), place.getAddress().getCity().getName(), place.getDescription(), averageScore, currentUserScore, currentUserLiked, currentUserRated, place.getPhoto());
    }
}

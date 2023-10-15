package pl.pawguider.app.controller.dto.response;

import pl.pawguider.app.model.Address;
import pl.pawguider.app.model.Place;
import pl.pawguider.app.model.PlaceLike;
import pl.pawguider.app.model.User;

import java.util.Collection;

public record PlaceInfoResponse(String name,
                                String street,
                                String zipCode,
                                String city,
                                String description,
                                double averageScore,
                                double currentUserScore,
                                boolean currentUserLiked,
                                String photoName) {

    public static PlaceInfoResponse getResponse(User user, Place place) {
        Address address = place.getAddress();
        Collection<PlaceLike> likes = place.getLikes();
        double averageScore = likes.stream().mapToDouble(PlaceLike::getRating).average().orElse(0.0);
        double currentUserScore = likes.stream()
                .filter(like -> like.getUser().getIdUser().equals(user.getIdUser()))
                .findFirst()
                .map(PlaceLike::getRating)
                .orElse(0.0);
        boolean currentUserLiked = currentUserScore != 0.0;
        return new PlaceInfoResponse(place.getName(), address.getStreet(), address.getPostalCode(), place.getCity().getName(), place.getDescription(), averageScore, currentUserScore, currentUserLiked, place.getPhoto());
    }
}

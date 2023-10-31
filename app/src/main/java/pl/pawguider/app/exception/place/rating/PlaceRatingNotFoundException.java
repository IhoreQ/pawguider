package pl.pawguider.app.exception.place.rating;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.NOT_FOUND)
public class PlaceRatingNotFoundException extends RuntimeException {
    public PlaceRatingNotFoundException(Long userId, Long placeId) {
        super("User with id %d hadn't rated place with id %d".formatted(userId, placeId));
    }
}

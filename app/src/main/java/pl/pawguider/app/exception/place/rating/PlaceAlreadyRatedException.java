package pl.pawguider.app.exception.place.rating;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.CONFLICT)
public class PlaceAlreadyRatedException extends RuntimeException {
    public PlaceAlreadyRatedException(Long userId, Long placeId) {
        super("User with id %d already rated place with id %d".formatted(userId, placeId));
    }
}

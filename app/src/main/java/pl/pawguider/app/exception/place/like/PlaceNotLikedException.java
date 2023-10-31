package pl.pawguider.app.exception.place.like;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.CONFLICT)
public class PlaceNotLikedException extends RuntimeException {
    public PlaceNotLikedException(Long userId, Long placeId) {
        super("User with id %d hadn't liked place with id %d".formatted(userId, placeId));
    }
}

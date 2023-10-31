package pl.pawguider.app.exception.place.like;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.CONFLICT)
public class PlaceAlreadyLikedException extends RuntimeException {
    public PlaceAlreadyLikedException(Long userId, Long placeId) {
        super("User with id %d already liked place with id %d".formatted(userId, placeId));
    }
}

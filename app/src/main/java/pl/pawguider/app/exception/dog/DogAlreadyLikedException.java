package pl.pawguider.app.exception.dog;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.CONFLICT)
public class DogAlreadyLikedException extends RuntimeException {
    public DogAlreadyLikedException(Long userId, Long dogId) {
        super("User with id %d already liked dog with id %d".formatted(userId, dogId));
    }
}

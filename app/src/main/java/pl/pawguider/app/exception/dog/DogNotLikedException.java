package pl.pawguider.app.exception.dog;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.CONFLICT)

public class DogNotLikedException extends RuntimeException {
    public DogNotLikedException(Long userId, Long dogId) {
        super("User with id %d hadn't liked dog with id %d".formatted(userId, dogId));
    }
}

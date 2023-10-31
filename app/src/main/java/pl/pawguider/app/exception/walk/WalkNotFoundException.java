package pl.pawguider.app.exception.walk;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.NOT_FOUND)
public class WalkNotFoundException extends RuntimeException {
    public WalkNotFoundException(Long userId) {
        super("No active walk found for user with id %d".formatted(userId));
    }
}

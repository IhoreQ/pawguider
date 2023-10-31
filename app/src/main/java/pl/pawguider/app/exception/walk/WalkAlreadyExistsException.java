package pl.pawguider.app.exception.walk;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.CONFLICT)
public class WalkAlreadyExistsException extends RuntimeException {
    public WalkAlreadyExistsException(Long userId) {
        super("User with %d already has a walk".formatted(userId));
    }
}

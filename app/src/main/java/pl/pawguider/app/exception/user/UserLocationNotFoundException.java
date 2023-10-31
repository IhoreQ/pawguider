package pl.pawguider.app.exception.user;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.NOT_FOUND)
public class UserLocationNotFoundException extends RuntimeException {
    public UserLocationNotFoundException(Long userId) {
        super("Location not found for user with id %d".formatted(userId));
    }
}

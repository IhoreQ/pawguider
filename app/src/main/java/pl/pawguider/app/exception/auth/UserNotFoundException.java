package pl.pawguider.app.exception.auth;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.NOT_FOUND)
public class UserNotFoundException extends RuntimeException {
    public UserNotFoundException(Long id) {
        super("User with id %d not found".formatted(id));
    }
    public UserNotFoundException(String email) {
        super("User with email %s not found".formatted(email));
    }
}

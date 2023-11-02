package pl.pawguider.app.exception.auth;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.UNAUTHORIZED)
public class WrongPasswordException extends RuntimeException {
    public WrongPasswordException() {
        super("Your email or password is incorrect.\nPlease try again.");
    }
}

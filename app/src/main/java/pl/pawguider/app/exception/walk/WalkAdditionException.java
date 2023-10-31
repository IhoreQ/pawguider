package pl.pawguider.app.exception.walk;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
public class WalkAdditionException extends RuntimeException {
    public WalkAdditionException() {
        super("An error occurred during walk addition");
    }
}

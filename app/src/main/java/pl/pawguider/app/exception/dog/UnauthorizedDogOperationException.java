package pl.pawguider.app.exception.dog;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.UNAUTHORIZED)
public class UnauthorizedDogOperationException extends RuntimeException {
    public UnauthorizedDogOperationException(String message) {
        super(message);
    }
}

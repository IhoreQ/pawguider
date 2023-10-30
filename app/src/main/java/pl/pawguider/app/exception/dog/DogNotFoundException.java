package pl.pawguider.app.exception.dog;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.NOT_FOUND)
public class DogNotFoundException extends RuntimeException {
    public DogNotFoundException(Long id) {
        super("Dog with id %d not found".formatted(id));
    }
}

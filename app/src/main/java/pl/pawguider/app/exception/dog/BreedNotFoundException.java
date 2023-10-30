package pl.pawguider.app.exception.dog;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class BreedNotFoundException extends RuntimeException {
    public BreedNotFoundException(Long id) {
        super("Breed with id %d not found".formatted(id));
    }
}

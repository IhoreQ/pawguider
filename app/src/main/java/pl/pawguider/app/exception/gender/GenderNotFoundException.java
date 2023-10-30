package pl.pawguider.app.exception.gender;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.NOT_FOUND)
public class GenderNotFoundException extends RuntimeException {
    public GenderNotFoundException(String name) {
        super("Gender with name %s not found".formatted(name));
    }

    public GenderNotFoundException(Long id) {
        super("Gender with id %d not found".formatted(id));
    }
}

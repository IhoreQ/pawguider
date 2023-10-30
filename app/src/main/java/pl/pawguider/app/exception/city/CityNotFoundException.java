package pl.pawguider.app.exception.city;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.NOT_FOUND)
public class CityNotFoundException extends RuntimeException {
    public CityNotFoundException(String name) {
        super("City with name: %s not found".formatted(name));
    }
    public CityNotFoundException(Long id) {
        super("City with id: %d not found".formatted(id));
    }
}

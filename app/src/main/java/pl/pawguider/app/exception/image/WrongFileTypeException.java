package pl.pawguider.app.exception.image;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST)
public class WrongFileTypeException extends RuntimeException {
    public WrongFileTypeException(String type) {
        super("%s is not a valid type of image".formatted(type));
    }
}

package pl.pawguider.app.exception.image;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.NOT_FOUND)
public class ImageNotFoundException extends RuntimeException{
    public ImageNotFoundException(String name) {
        super("Image with name %s not found".formatted(name));
    }
}

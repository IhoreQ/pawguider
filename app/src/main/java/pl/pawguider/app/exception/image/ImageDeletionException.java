package pl.pawguider.app.exception.image;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
public class ImageDeletionException extends RuntimeException {
    public ImageDeletionException(String message) {
        super(message);
    }
}

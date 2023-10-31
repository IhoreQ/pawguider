package pl.pawguider.app.exception.image;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST)
public class EmptyFileRequestException extends RuntimeException {
    public  EmptyFileRequestException() {
        super("Request does not contains file");
    }
}

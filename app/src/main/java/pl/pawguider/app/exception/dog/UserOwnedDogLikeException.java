package pl.pawguider.app.exception.dog;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST)
public class UserOwnedDogLikeException extends RuntimeException {
    public UserOwnedDogLikeException() {
        super("User can't like or dislike his own dog");
    }
}

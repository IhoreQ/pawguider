package pl.pawguider.app.controller.dto.response;

import pl.pawguider.app.model.User;
import pl.pawguider.app.model.UserDetails;

public record CurrentUserResponse(String firstName,
                                  String lastName,
                                  String photoName) {

    public CurrentUserResponse {
    }

    public static CurrentUserResponse getResponse(UserDetails userDetails) {
        return new CurrentUserResponse(userDetails.getFirstName(), userDetails.getLastName(), userDetails.getPhotoName());
    }
}

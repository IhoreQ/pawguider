package pl.pawguider.app.controller.dto.response;

import pl.pawguider.app.model.City;
import pl.pawguider.app.model.UserDetails;

public record CurrentUserResponse(Long idUser,
                                  String firstName,
                                  String lastName,
                                  String photoName,
                                  City city) {

    public CurrentUserResponse {
    }

    public static CurrentUserResponse getResponse(UserDetails userDetails) {
        return new CurrentUserResponse(userDetails.getUser().getIdUser(), userDetails.getFirstName(), userDetails.getLastName(), userDetails.getPhotoName(), userDetails.getCity());
    }
}

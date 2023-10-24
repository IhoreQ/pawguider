package pl.pawguider.app.controller.dto.response;

import pl.pawguider.app.model.City;
import pl.pawguider.app.model.User;
import pl.pawguider.app.model.UserDetails;

public record UserInfoResponse(Long id,
                                  String firstName,
                                  String lastName,
                                  String photoName,
                                  Long cityId,
                                  String cityName,
                                  String phone,
                                  String email,
                                  String gender,
                                  int dogsCount) {

    public static UserInfoResponse getResponse(User user) {
        UserDetails userDetails = user.getDetails();
        City city = userDetails.getCity();
        int dogsCount = user.getDogs().size();
        return new UserInfoResponse(user.getIdUser(), userDetails.getFirstName(), userDetails.getLastName(), userDetails.getPhotoName(), city.getIdCity(), city.getName(), userDetails.getPhone(), user.getEmail(), userDetails.getGender().getName(), dogsCount);
    }
}

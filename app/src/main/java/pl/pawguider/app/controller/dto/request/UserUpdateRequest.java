package pl.pawguider.app.controller.dto.request;

public record UserUpdateRequest(String firstName,
                                String lastName,
                                String gender,
                                String city,
                                String phone) {


}

package pl.pawguider.app.controller.dto.request;

public record RegisterRequest(String firstName,
                              String lastName,
                              String email,
                              String password,
                              String gender,
                              String city,
                              String phone) {

}

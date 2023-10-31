package pl.pawguider.app.controller.dto.request;

public record PasswordUpdateRequest(String oldPassword,
                                    String newPassword) {

}

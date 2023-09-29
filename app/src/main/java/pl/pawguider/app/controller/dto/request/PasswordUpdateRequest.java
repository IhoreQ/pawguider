package pl.pawguider.app.controller.dto.request;

import com.fasterxml.jackson.annotation.JsonCreator;

public record PasswordUpdateRequest(String oldPassword,
                                    String newPassword,
                                    String repeatedNewPassword) {
    @JsonCreator
    public PasswordUpdateRequest {
    }
}

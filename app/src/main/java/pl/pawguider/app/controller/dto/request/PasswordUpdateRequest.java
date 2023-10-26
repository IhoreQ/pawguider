package pl.pawguider.app.controller.dto.request;

import com.fasterxml.jackson.annotation.JsonCreator;

public record PasswordUpdateRequest(String oldPassword,
                                    String newPassword) {
    @JsonCreator
    public PasswordUpdateRequest {
    }
}

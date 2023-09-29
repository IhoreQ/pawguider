package pl.pawguider.app.controller.dto.request;

import com.fasterxml.jackson.annotation.JsonCreator;

public record LoginRequest(String email,
                           String password) {
    @JsonCreator
    public LoginRequest {
    }
}

package pl.pawguider.app.controller.dto.request;

import com.fasterxml.jackson.annotation.JsonCreator;

public record UserAddRequest(String firstName,
                             String lastName,
                             String email,
                             String password,
                             String phone) {
    @JsonCreator
    public UserAddRequest {
    }
}

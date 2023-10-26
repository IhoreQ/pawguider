package pl.pawguider.app.controller.dto.request;

import com.fasterxml.jackson.annotation.JsonCreator;

public record UserUpdateRequest(String firstName,
                                String lastName,
                                String photoName,
                                Long genderId,
                                Long cityId,
                                String phone) {

    @JsonCreator
    public UserUpdateRequest {
    }
}

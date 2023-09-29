package pl.pawguider.app.controller.dto.response;

import com.fasterxml.jackson.annotation.JsonCreator;

public record JwtTokenResponse(String jwtToken) {
    @JsonCreator
    public JwtTokenResponse {
    }
}

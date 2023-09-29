package pl.pawguider.app.controller.dto.request;

import com.fasterxml.jackson.annotation.JsonCreator;

public record WalkStartRequest(String timeOfAWalk,
                               Long placeId) {
    @JsonCreator
    public WalkStartRequest {
    }
}

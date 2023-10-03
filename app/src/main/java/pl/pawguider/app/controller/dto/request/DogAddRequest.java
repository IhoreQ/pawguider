package pl.pawguider.app.controller.dto.request;

import com.fasterxml.jackson.annotation.JsonCreator;

public record DogAddRequest(String name,
                            int age,
                            Long breedId,
                            String gender,
                            String description) {
    @JsonCreator
    public DogAddRequest {
    }
}

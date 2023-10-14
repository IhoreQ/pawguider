package pl.pawguider.app.controller.dto.request;

import com.fasterxml.jackson.annotation.JsonCreator;

import java.util.List;

public record DogAddRequest(String photoName,
                            String name,
                            Long breedId,
                            int age,
                            String gender,
                            List<Long> behaviorsIds,
                            String description) {
    @JsonCreator
    public DogAddRequest {
    }
}

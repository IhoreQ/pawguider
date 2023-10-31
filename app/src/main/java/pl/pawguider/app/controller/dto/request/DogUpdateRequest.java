package pl.pawguider.app.controller.dto.request;

import java.util.List;

public record DogUpdateRequest(Long dogId,
                               String photoName,
                               String name,
                               Long breedId,
                               int age,
                               String gender,
                               List<Long> behaviorsIds,
                               String description) {

}

package pl.pawguider.app.controller.dto.request;

import java.util.List;

public record DogAdditionRequest(String photoName,
                                 String name,
                                 Long breedId,
                                 int age,
                                 String gender,
                                 List<Long> behaviorsIds,
                                 String description) {}

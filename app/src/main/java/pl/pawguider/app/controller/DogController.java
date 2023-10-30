package pl.pawguider.app.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.pawguider.app.controller.dto.request.DogAddRequest;
import pl.pawguider.app.controller.dto.request.DogDeletionRequest;
import pl.pawguider.app.controller.dto.request.DogUpdateRequest;
import pl.pawguider.app.controller.dto.response.DogBreedResponse;
import pl.pawguider.app.controller.dto.response.DogInfoBoxResponse;
import pl.pawguider.app.controller.dto.response.DogInfoResponse;
import pl.pawguider.app.model.Dog;
import pl.pawguider.app.model.DogBehavior;
import pl.pawguider.app.model.DogBreed;
import pl.pawguider.app.model.User;
import pl.pawguider.app.service.DogService;
import pl.pawguider.app.service.UserService;

import java.util.Comparator;
import java.util.List;

@RestController
@RequestMapping("/api/v1/dog")
public class DogController {

    private final DogService dogService;
    private final UserService userService;

    public DogController(DogService dogService, UserService userService) {
        this.dogService = dogService;
        this.userService = userService;
    }

    @PostMapping
    public ResponseEntity<?> addDog(@RequestHeader("Authorization") String header, @RequestBody DogAddRequest dogAddRequest) {
        User user = userService.getUserFromHeader(header);
        dogService.addDog(user, dogAddRequest);

        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getDog(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = userService.getUserFromHeader(header);
        Dog dog = dogService.getDogById(id);

        DogInfoResponse response = DogInfoResponse.getResponse(user, dog);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/owned")
    public List<DogInfoBoxResponse> getCurrentUserDogs(@RequestHeader("Authorization") String header) {
        User user = userService.getUserFromHeader(header);
        List<Dog> dogs  = user.getDogs().stream().toList();

        return dogs.stream().map(DogInfoBoxResponse::getResponse).toList();
    }

    @DeleteMapping
    public ResponseEntity<?> deleteDog(@RequestHeader("Authorization") String header, @RequestBody DogDeletionRequest request) {
        User user = userService.getUserFromHeader(header);

        dogService.deleteDog(user, request.dogId());
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping("/breeds")
    public List<DogBreedResponse> getAllBreeds() {
        List<DogBreed> breeds = dogService.getAllBreeds();
        return breeds.stream()
                .sorted(Comparator.comparing(DogBreed::getName))
                .map(DogBreedResponse::getResponse)
                .toList();
    }

    @GetMapping("/behaviors")
    public List<DogBehavior> getAllBehaviors() {
        return dogService.getAllBehaviors();
    }

    @PostMapping("/{id}/like")
    public ResponseEntity<?> addLike(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = userService.getUserFromHeader(header);
        Dog dog = dogService.getDogById(id);

        dogService.addLike(user, dog);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @DeleteMapping("/{id}/like")
    public ResponseEntity<?> deleteLike(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = userService.getUserFromHeader(header);
        Dog dog = dogService.getDogById(id);

        dogService.deleteLike(user, dog);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PatchMapping("/{id}/select")
    public Boolean toggleSelected(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = userService.getUserFromHeader(header);
        Dog dog = dogService.getDogById(id);

        dogService.toggleSelected(user, dog);
        return true;
    }

    @PutMapping
    public ResponseEntity<?> updateDog(@RequestHeader("Authorization") String header, @RequestBody DogUpdateRequest request) {
        User user = userService.getUserFromHeader(header);
        Dog dog = dogService.getDogById(request.dogId());

        dogService.updateDog(user, dog, request);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}

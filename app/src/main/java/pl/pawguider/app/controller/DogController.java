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
import pl.pawguider.app.model.*;
import pl.pawguider.app.service.DogService;
import pl.pawguider.app.service.JwtService;
import pl.pawguider.app.service.UserService;
import pl.pawguider.app.service.WalkService;

import java.util.Comparator;
import java.util.List;

@RestController
@RequestMapping("/api/v1/dog")
public class DogController {

    private final DogService dogService;
    private final UserService userService;
    private final WalkService walkService;

    public DogController(DogService dogService, UserService userService, WalkService walkService) {
        this.dogService = dogService;
        this.userService = userService;
        this.walkService = walkService;
    }

    @PostMapping
    public ResponseEntity<HttpStatus> addDog(@RequestHeader("Authorization") String header, @RequestBody DogAddRequest dogAddRequest) throws Exception {

        User user = userService.getUserFromHeader(header);

        boolean isAdded = dogService.addDog(user, dogAddRequest);

        if (!isAdded)
            throw new Exception("An error occurred while adding a dog!");

        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getDog(@RequestHeader("Authorization") String header, @PathVariable Long id) throws Exception {
        User user = userService.getUserFromHeader(header);

        Dog dog = dogService.getDogById(id);

        if (dog == null) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

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
    public Boolean deleteDog(@RequestHeader("Authorization") String header, @RequestBody DogDeletionRequest request) {

        User user = userService.getUserFromHeader(header);

        return dogService.deleteDog(user, request.dogId());
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

    @PostMapping("/like/{id}")
    public Boolean addLike(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = userService.getUserFromHeader(header);
        Dog dog = dogService.getDogById(id);

        if (dogService.isDogAlreadyLiked(user, dog))
            return false;

        dogService.addLike(user, dog);
        return true;
    }

    @DeleteMapping("/like/{id}")
    public Boolean deleteLike(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = userService.getUserFromHeader(header);
        Dog dog = dogService.getDogById(id);

        if (!dogService.isDogAlreadyLiked(user, dog))
            return false;

        dogService.deleteLike(user, dog);
        return true;
    }

    @PatchMapping("/select/{id}")
    public Boolean toggleSelected(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = userService.getUserFromHeader(header);
        Dog dog = dogService.getDogById(id);

        if (!dogService.isOwner(user, dog)) {
            return false;
        }

        dogService.toggleSelected(dog);
        return true;
    }

    @PutMapping
    public ResponseEntity<Boolean> updateDog(@RequestHeader("Authorization") String header, @RequestBody DogUpdateRequest request) {
        User user = userService.getUserFromHeader(header);
        Dog dog = dogService.getDogById(request.dogId());

        if (dog != null && dogService.isOwner(user, dog)) {
            boolean isUpdated = dogService.updateDog(dog, request);
            return ResponseEntity.ok(isUpdated);
        }


        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }
}

package pl.pawguider.app.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.pawguider.app.controller.dto.request.DogAddRequest;
import pl.pawguider.app.controller.dto.request.DogDeletionRequest;
import pl.pawguider.app.controller.dto.response.DogBreedResponse;
import pl.pawguider.app.controller.dto.response.DogInfoBoxResponse;
import pl.pawguider.app.controller.dto.response.DogInfoResponse;
import pl.pawguider.app.controller.dto.response.WalkPartnerResponse;
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
    private final JwtService jwtService;

    public DogController(DogService dogService, UserService userService, WalkService walkService, JwtService jwtService) {
        this.dogService = dogService;
        this.userService = userService;
        this.walkService = walkService;
        this.jwtService = jwtService;
    }

    @PostMapping
    public ResponseEntity<HttpStatus> addDog(@RequestHeader("Authorization") String header, @RequestBody DogAddRequest dogAddRequest) throws Exception {

        User user = getUserFromHeader(header);

        boolean isAdded = dogService.addDog(user, dogAddRequest);

        if (!isAdded)
            throw new Exception("An error occurred while adding a dog!");

        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getDog(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = getUserFromHeader(header);

        Dog dog = dogService.getDogById(id);
        // TODO ErrorResponse z treścią błędu
        DogInfoResponse response = DogInfoResponse.getResponse(user, dog);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/owned")
    public List<DogInfoBoxResponse> getCurrentUserDogs(@RequestHeader("Authorization") String header) {
        User user = getUserFromHeader(header);
        List<Dog> dogs  = user.getDogs().stream().toList();

        return dogs.stream().map(DogInfoBoxResponse::getResponse).toList();
    }

    @DeleteMapping
    public Boolean deleteDog(@RequestHeader("Authorization") String header, @RequestBody DogDeletionRequest request) {

        User user = getUserFromHeader(header);

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
        User user = getUserFromHeader(header);
        Dog dog = dogService.getDogById(id);

        if (isAlreadyLiked(user, dog))
            return false;

        dogService.addLike(user, dog);
        return true;
    }

    @DeleteMapping("/like/{id}")
    public Boolean deleteLike(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = getUserFromHeader(header);
        Dog dog = dogService.getDogById(id);

        if (!isAlreadyLiked(user, dog))
            return false;

        dogService.deleteLike(user, dog);
        return true;
    }

    @PatchMapping("/select/{id}")
    public Boolean toggleSelected(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = getUserFromHeader(header);
        Dog dog = dogService.getDogById(id);

        if (!isOwner(user, dog)) {
            return false;
        }

        dogService.toggleSelected(dog);
        return true;
    }

    private User getUserFromHeader(String header) {
        String email = jwtService.extractEmailFromHeader(header);
        return userService.getUserByEmail(email);
    }

    private boolean isAlreadyLiked(User user, Dog dog) {
        return dog.getLikes()
                .stream()
                .anyMatch(like -> like.getUser().getIdUser().equals(user.getIdUser()));
    }

    private boolean isOwner(User user, Dog dog) {
        return dog.getOwner().getIdUser().equals(user.getIdUser());
    }
}

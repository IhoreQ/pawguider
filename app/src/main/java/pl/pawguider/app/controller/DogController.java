package pl.pawguider.app.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.pawguider.app.controller.dto.request.DogAddRequest;
import pl.pawguider.app.controller.dto.response.DogBreedResponse;
import pl.pawguider.app.controller.dto.response.DogInfoResponse;
import pl.pawguider.app.model.ActiveWalk;
import pl.pawguider.app.model.Dog;
import pl.pawguider.app.model.DogBreed;
import pl.pawguider.app.model.User;
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
    public ResponseEntity<HttpStatus> addDog(@RequestHeader("Authorization") String header, @RequestParam String photo, @RequestBody DogAddRequest dogAddRequest) throws Exception {

        String email = jwtService.extractEmailFromHeader(header);

        User user = userService.getUserByEmail(email);
        if (user.hasDog())
            throw new Exception("User already has a dog!");

        boolean isAdded = dogService.addDog(user, dogAddRequest, photo);

        if (!isAdded)
            throw new Exception("An error occurred while adding a dog!");

        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<?> getDogInfo(@RequestHeader("Authorization") String header) {

        String email = jwtService.extractEmailFromHeader(header);

        User user = userService.getUserByEmail(email);
        if (!user.hasDog())
            return ResponseEntity.ok(false);

        Dog dog = dogService.getDogInfo(user);
        DogInfoResponse response = DogInfoResponse.getResponse(dog);

        return ResponseEntity.ok(response);
    }

    @DeleteMapping
    public Boolean deleteDog(@RequestHeader("Authorization") String header) {

        String email = jwtService.extractEmailFromHeader(header);

        User user = userService.getUserByEmail(email);
        ActiveWalk activeWalk = walkService.getActiveWalkByUser(user);
        boolean isDeleted = false;

        if (activeWalk == null) {
            isDeleted = dogService.deleteDog(user);
        }

        return isDeleted;
    }

    @GetMapping("/breeds")
    public List<DogBreedResponse> getAllBreeds() {
        List<DogBreed> breeds = dogService.getAllBreeds();
        return breeds.stream()
                .sorted(Comparator.comparing(DogBreed::getName))
                .map(DogBreedResponse::getResponse)
                .toList();
    }

}

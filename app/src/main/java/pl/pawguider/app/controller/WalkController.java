package pl.pawguider.app.controller;

import org.apache.coyote.Response;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.pawguider.app.controller.dto.request.UserLocationRequest;
import pl.pawguider.app.controller.dto.request.WalkAdditionRequest;
import pl.pawguider.app.controller.dto.request.WalkStartRequest;
import pl.pawguider.app.controller.dto.response.DogInfoBoxResponse;
import pl.pawguider.app.controller.dto.response.DogInfoResponse;
import pl.pawguider.app.controller.dto.response.UserActiveWalkResponse;
import pl.pawguider.app.model.ActiveWalk;
import pl.pawguider.app.model.Dog;
import pl.pawguider.app.model.Place;
import pl.pawguider.app.model.User;
import pl.pawguider.app.service.JwtService;
import pl.pawguider.app.service.PlaceService;
import pl.pawguider.app.service.UserService;
import pl.pawguider.app.service.WalkService;

import java.time.LocalTime;
import java.util.Collection;
import java.util.List;

@RestController
@RequestMapping("/api/v1/walk")
public class WalkController {
    private final UserService userService;

    private final WalkService walkService;
    private final PlaceService placeService;

    public WalkController(UserService userService, WalkService walkService, PlaceService placeService) {
        this.userService = userService;
        this.walkService = walkService;
        this.placeService = placeService;
    }

    @GetMapping
    public ResponseEntity<UserActiveWalkResponse> isUserOnTheWalk(@RequestHeader("Authorization") String header) {

        User user = userService.getUserFromHeader(header);

        ActiveWalk activeWalk = walkService.getActiveWalkByUser(user);

        if (activeWalk == null)
            return ResponseEntity.ok(null);

        return ResponseEntity.ok(UserActiveWalkResponse.getResponse(activeWalk));
    }

    @GetMapping("/dogs/place/{placeId}")
    public List<DogInfoBoxResponse> getAllDogsFromPlace(@PathVariable Long placeId) {
        List<Dog> dogs = walkService.getDogsFromPlace(placeId);
        return dogs.stream()
                .map(DogInfoBoxResponse::getResponse)
                .toList();
    }

    @DeleteMapping
    public ResponseEntity<?> deleteWalk(@RequestHeader("Authorization") String header) throws Exception {

        User user = userService.getUserFromHeader(header);
        Collection<ActiveWalk> activeWalks = user.getActiveWalks();

        if (activeWalks.isEmpty()) {
            throw new Exception("User is not on a walk!");
        }

        ActiveWalk activeWalk = activeWalks.stream().findFirst().get();
        walkService.deleteWalk(activeWalk);

        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping
    public ResponseEntity<UserActiveWalkResponse> addWalk(@RequestHeader("Authorization") String header, @RequestBody WalkAdditionRequest request) {
        User user = userService.getUserFromHeader(header);
        if (walkService.userHasWalk(user)) {
            return null;
        }
        ActiveWalk walk = walkService.addWalk(user, request.placeId());

        if (walk == null) {
            return null;
        }

        return ResponseEntity.ok(UserActiveWalkResponse.getResponse(walk));
    }
}
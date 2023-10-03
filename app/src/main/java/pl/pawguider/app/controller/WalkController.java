package pl.pawguider.app.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.pawguider.app.controller.dto.request.WalkStartRequest;
import pl.pawguider.app.controller.dto.response.DogInfoResponse;
import pl.pawguider.app.controller.dto.response.UserActiveWalkResponse;
import pl.pawguider.app.model.ActiveWalk;
import pl.pawguider.app.model.Dog;
import pl.pawguider.app.model.Place;
import pl.pawguider.app.model.User;
import pl.pawguider.app.service.JwtService;
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
    private final JwtService jwtService;

    public WalkController(UserService userService, WalkService walkService, JwtService jwtService) {
        this.userService = userService;
        this.walkService = walkService;
        this.jwtService = jwtService;
    }

    @PostMapping
    public ResponseEntity<?> goForAWalk(@RequestHeader("Authorization") String header, @RequestBody WalkStartRequest request) {

        String email = jwtService.extractEmailFromHeader(header);
        User user = userService.getUserByEmail(email);

        ActiveWalk activeWalk = new ActiveWalk(request.timeOfAWalk(), LocalTime.now(), new Place(request.placeId()), user);

        walkService.saveWalk(activeWalk);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<?> getActiveWalk(@RequestHeader("Authorization") String header) {

        String email = jwtService.extractEmailFromHeader(header);
        User user = userService.getUserByEmail(email);

        ActiveWalk activeWalk = walkService.getActiveWalkByUser(user);

        if (activeWalk == null)
            return ResponseEntity.ok(false);

        LocalTime timeLeft = walkService.getLeftTime(activeWalk);

        UserActiveWalkResponse response = UserActiveWalkResponse.getResponse(activeWalk, timeLeft);

        return ResponseEntity.ok(response);
    }

    @GetMapping("/{placeId}")
    public List<DogInfoResponse> getAllDogsFromPlace(@PathVariable Long placeId) {
        List<Dog> dogs = walkService.getDogsFromPlace(placeId);
        return dogs.stream()
                .map(DogInfoResponse::getResponse)
                .toList();
    }

    @DeleteMapping
    public ResponseEntity<String> finishWalk(@RequestHeader("Authorization") String header) throws Exception {

        String email = jwtService.extractEmailFromHeader(header);
        User user = userService.getUserByEmail(email);
        Collection<ActiveWalk> activeWalks = user.getActiveWalks();

        if (activeWalks.isEmpty()) {
            throw new Exception("User is not on a walk!");
        }

        ActiveWalk activeWalk = activeWalks.stream().findFirst().get();
        walkService.finishWalk(activeWalk);

        return ResponseEntity.ok("Finished.");
    }
}
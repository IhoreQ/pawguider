package pl.pawguider.app.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.pawguider.app.controller.dto.request.WalkAdditionRequest;
import pl.pawguider.app.controller.dto.response.DogInfoBoxResponse;
import pl.pawguider.app.controller.dto.response.UserActiveWalkResponse;
import pl.pawguider.app.model.ActiveWalk;
import pl.pawguider.app.model.Dog;
import pl.pawguider.app.model.User;
import pl.pawguider.app.service.PlaceService;
import pl.pawguider.app.service.UserService;
import pl.pawguider.app.service.WalkService;

import java.util.Collection;
import java.util.List;

@RestController
@RequestMapping("/api/v1/walk")
public class WalkController {
    private final UserService userService;

    private final WalkService walkService;

    public WalkController(UserService userService, WalkService walkService) {
        this.userService = userService;
        this.walkService = walkService;
    }

    @GetMapping
    public ResponseEntity<UserActiveWalkResponse> isUserOnTheWalk(@RequestHeader("Authorization") String header) {

        User user = userService.getUserFromHeader(header);

        ActiveWalk activeWalk = walkService.getActiveWalkByUser(user);

        if (activeWalk == null)
            return ResponseEntity.ok(null);

        return ResponseEntity.ok(UserActiveWalkResponse.getResponse(activeWalk));
    }

    @DeleteMapping
    public ResponseEntity<Boolean> deleteWalk(@RequestHeader("Authorization") String header) {

        User user = userService.getUserFromHeader(header);
        Collection<ActiveWalk> activeWalks = user.getActiveWalks();

        if (activeWalks.isEmpty()) {
            return ResponseEntity.ok(false);
        }

        ActiveWalk activeWalk = activeWalks.stream().findFirst().get();
        walkService.deleteWalk(activeWalk);

        return ResponseEntity.ok(true);
    }

    @PostMapping
    public ResponseEntity<Boolean> addWalk(@RequestHeader("Authorization") String header, @RequestBody WalkAdditionRequest request) {
        User user = userService.getUserFromHeader(header);
        if (walkService.userHasWalk(user)) {
            return ResponseEntity.ok(false);
        }
        ActiveWalk walk = walkService.addWalk(user, request.placeId());

        if (walk == null) {
            return ResponseEntity.ok(false);
        }

        return ResponseEntity.ok(true);
    }
}
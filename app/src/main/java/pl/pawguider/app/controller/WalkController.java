package pl.pawguider.app.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.pawguider.app.controller.dto.request.WalkAdditionRequest;
import pl.pawguider.app.controller.dto.response.UserActiveWalkResponse;
import pl.pawguider.app.exception.walk.WalkAdditionException;
import pl.pawguider.app.exception.walk.WalkNotFoundException;
import pl.pawguider.app.model.ActiveWalk;
import pl.pawguider.app.model.User;
import pl.pawguider.app.service.UserService;
import pl.pawguider.app.service.WalkService;

import java.util.Collection;

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
    public ResponseEntity<UserActiveWalkResponse> getUserActiveWalk(@RequestHeader("Authorization") String header) {
        User user = userService.getUserFromHeader(header);
        ActiveWalk activeWalk = walkService.getActiveWalkByUser(user);

        if (activeWalk == null)
            return ResponseEntity.ok(null);

        return ResponseEntity.ok(UserActiveWalkResponse.getResponse(activeWalk));
    }

    @DeleteMapping
    public ResponseEntity<?> deleteWalk(@RequestHeader("Authorization") String header) {

        User user = userService.getUserFromHeader(header);
        Collection<ActiveWalk> activeWalks = user.getActiveWalks();

        if (activeWalks.isEmpty()) {
            throw new WalkNotFoundException(user.getIdUser());
        }

        ActiveWalk activeWalk = activeWalks.stream().findFirst().get();
        walkService.deleteWalk(activeWalk);

        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping
    public ResponseEntity<?> addWalk(@RequestHeader("Authorization") String header, @RequestBody WalkAdditionRequest request) {
        User user = userService.getUserFromHeader(header);

        ActiveWalk walk = walkService.addWalk(user, request.placeId());
        if (walk == null) {
            throw new WalkAdditionException();
        }

        return new ResponseEntity<>(HttpStatus.OK);
    }
}
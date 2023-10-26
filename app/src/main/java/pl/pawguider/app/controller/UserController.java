package pl.pawguider.app.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.pawguider.app.controller.dto.request.PasswordUpdateRequest;
import pl.pawguider.app.controller.dto.request.UserLocationRequest;
import pl.pawguider.app.controller.dto.request.UserUpdateRequest;
import pl.pawguider.app.controller.dto.response.UserInfoResponse;
import pl.pawguider.app.model.User;
import pl.pawguider.app.service.UserService;

@RestController
@RequestMapping("/api/v1/user")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PatchMapping("/password")
    public ResponseEntity<Boolean> updatePassword(@RequestHeader("Authorization") String header, @RequestBody PasswordUpdateRequest request) {

        User user = userService.getUserFromHeader(header);

        Boolean isUpdated = userService.updateUserPassword(user, request);

        return ResponseEntity.ok(isUpdated);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getUserById(@PathVariable Long id) {
        User user = userService.getUserById(id);

        if (user == null) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        return ResponseEntity.ok(UserInfoResponse.getResponse(user));
    }

    @GetMapping
    public ResponseEntity<UserInfoResponse> getCurrentUser(@RequestHeader("Authorization") String header) {
        User user = userService.getUserFromHeader(header);
        UserInfoResponse response = UserInfoResponse.getResponse(user);

        return ResponseEntity.ok(response);
    }

    @PatchMapping("/location")
    public ResponseEntity<?> updateUserLocation(@RequestHeader("Authorization") String header, @RequestBody UserLocationRequest request) {
        User user = userService.getUserFromHeader(header);
        userService.updateUserLocation(user, request.latitude(), request.longitude());
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PutMapping("/details")
    public ResponseEntity<Boolean> updateUserDetails(@RequestHeader("Authorization") String header, @RequestBody UserUpdateRequest request) {
        User user = userService.getUserFromHeader(header);
        Boolean isUpdated = userService.updateUserDetails(user, request);

        return ResponseEntity.ok(isUpdated);
    }
}
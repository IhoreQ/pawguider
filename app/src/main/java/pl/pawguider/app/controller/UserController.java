package pl.pawguider.app.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.pawguider.app.controller.dto.request.PasswordUpdateRequest;
import pl.pawguider.app.controller.dto.request.UserLocationUpdateRequest;
import pl.pawguider.app.controller.dto.request.UserPhotoUpdateRequest;
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
    public ResponseEntity<HttpStatus> updatePassword(@RequestHeader("Authorization") String header, @RequestBody PasswordUpdateRequest request) {
        User user = userService.getUserFromHeader(header);
        userService.updateUserPassword(user, request);

        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<UserInfoResponse> getUserById(@PathVariable Long id) {
        User user = userService.getUserById(id);
        UserInfoResponse response = UserInfoResponse.getResponse(user);

        return ResponseEntity.ok(response);
    }

    @GetMapping
    public ResponseEntity<UserInfoResponse> getCurrentUser(@RequestHeader("Authorization") String header) {
        User user = userService.getUserFromHeader(header);
        UserInfoResponse response = UserInfoResponse.getResponse(user);

        return ResponseEntity.ok(response);
    }

    @PatchMapping("/location")
    public ResponseEntity<HttpStatus> updateUserLocation(@RequestHeader("Authorization") String header, @RequestBody UserLocationUpdateRequest request) {
        User user = userService.getUserFromHeader(header);
        userService.updateUserLocation(user, request.latitude(), request.longitude());

        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PutMapping("/details")
    public ResponseEntity<HttpStatus> updateUserDetails(@RequestHeader("Authorization") String header, @RequestBody UserUpdateRequest request) {
        User user = userService.getUserFromHeader(header);
        userService.updateUserDetails(user, request);

        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PatchMapping("/photo")
    public ResponseEntity<HttpStatus> updateUserPhoto(@RequestHeader("Authorization") String header, @RequestBody UserPhotoUpdateRequest request) {
        User user = userService.getUserFromHeader(header);
        userService.updateUserPhoto(user, request.photoName());

        return new ResponseEntity<>(HttpStatus.OK);
    }
}
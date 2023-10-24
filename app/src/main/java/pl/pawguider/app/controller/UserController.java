package pl.pawguider.app.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import pl.pawguider.app.controller.dto.request.PasswordUpdateRequest;
import pl.pawguider.app.controller.dto.request.UserLocationRequest;
import pl.pawguider.app.controller.dto.response.CurrentUserResponse;
import pl.pawguider.app.controller.dto.response.UserInfoResponse;
import pl.pawguider.app.model.User;
import pl.pawguider.app.service.UserService;

@RestController
@RequestMapping("/api/v1/user")
public class UserController {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @PatchMapping("/password")
    public ResponseEntity<Boolean> updatePassword(@RequestHeader("Authorization") String header, @RequestBody PasswordUpdateRequest request) {

        User user = userService.getUserFromHeader(header);

        if (!passwordEncoder.matches(request.oldPassword(), user.getPassword())) {
            return ResponseEntity.ok(false);
        }

        user.setPassword(passwordEncoder.encode(request.newPassword()));
        userService.saveUser(user);

        return ResponseEntity.ok(true);
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
}
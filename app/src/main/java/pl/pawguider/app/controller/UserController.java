package pl.pawguider.app.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import pl.pawguider.app.controller.dto.request.PasswordUpdateRequest;
import pl.pawguider.app.model.User;
import pl.pawguider.app.service.JwtService;
import pl.pawguider.app.service.UserService;

@RestController
@RequestMapping("/api/v1/user")
public class UserController {

    private final UserService userService;
    private final JwtService jwtService;
    private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService, PasswordEncoder passwordEncoder, JwtService jwtService) {
        this.userService = userService;
        this.jwtService = jwtService;
        this.passwordEncoder = passwordEncoder;
    }

    @PatchMapping("/password")
    public ResponseEntity<Boolean> updatePassword(@RequestHeader("Authorization") String header, @RequestBody PasswordUpdateRequest request) {

        String email = jwtService.extractEmailFromHeader(header);
        User user = userService.getUserByEmail(email);

        if (!passwordEncoder.matches(request.oldPassword(), user.getPassword())) {
            return ResponseEntity.ok(false);
        }

        user.setPassword(passwordEncoder.encode(request.newPassword()));
        userService.saveUser(user);

        return ResponseEntity.ok(true);
    }

    @GetMapping("/{id}")
    public ResponseEntity<String> getUserById(@PathVariable Long id) {
        User user = userService.getUserById(id);

        return ResponseEntity.ok(user.getEmail());
    }

    @GetMapping
    public ResponseEntity<String> getCurrentUser(@RequestHeader("Authorization") String header) {
        String email = jwtService.extractEmailFromHeader(header);
        User user = userService.getUserByEmail(email);

        return ResponseEntity.ok(user.getPassword());
    }
}
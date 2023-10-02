package pl.pawguider.app.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;
import pl.pawguider.app.controller.dto.request.LoginRequest;
import pl.pawguider.app.controller.dto.request.UserAddRequest;
import pl.pawguider.app.controller.dto.request.UserExistsRequest;
import pl.pawguider.app.controller.dto.response.JwtTokenResponse;
import pl.pawguider.app.service.AuthService;
import pl.pawguider.app.service.JwtService;

@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {

    private final AuthService authService;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;

    public AuthController(AuthService authService, JwtService jwtService, AuthenticationManager authenticationManager) {
        this.authService = authService;
        this.jwtService = jwtService;
        this.authenticationManager = authenticationManager;
    }

    @PostMapping("/authenticate")
    public ResponseEntity<JwtTokenResponse> authenticateUser(@RequestBody LoginRequest loginRequest) throws UsernameNotFoundException {

        String token = "";

        try {
            Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(loginRequest.email(), loginRequest.password()));
            if (authentication.isAuthenticated())
                token = jwtService.generateToken(loginRequest.email());

        } catch (BadCredentialsException e) {
            return ResponseEntity.ok(new JwtTokenResponse(token));
        }

        return ResponseEntity.ok(new JwtTokenResponse(token));
    }

    @PostMapping("/signup")
    public ResponseEntity<?> registerUser(@RequestBody UserAddRequest request) {

        if (authService.userExists(request.email())) {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }

        authService.addUser(request);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping("/user-exists")
    public ResponseEntity<?> userExists(@RequestBody UserExistsRequest request) {
        if (authService.userExists(request.email())) {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }

        return new ResponseEntity<>(HttpStatus.OK);
    }

}

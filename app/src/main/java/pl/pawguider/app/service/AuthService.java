package pl.pawguider.app.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import pl.pawguider.app.controller.dto.request.UserAddRequest;
import pl.pawguider.app.model.User;
import pl.pawguider.app.model.UserDetails;
import pl.pawguider.app.repository.UserRepository;


@Service
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public AuthService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public void addUser(UserAddRequest request) {

        User user = new User(request.email(), new UserDetails(request.firstName(), request.lastName()));
        user.setPassword(passwordEncoder.encode(request.password()));

        userRepository.save(user);
    }

    public boolean userExists(UserAddRequest request) {
        return userRepository.existsByEmail(request.email());
    }

}

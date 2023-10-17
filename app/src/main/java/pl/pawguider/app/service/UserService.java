package pl.pawguider.app.service;

import org.springframework.stereotype.Service;
import pl.pawguider.app.model.User;
import pl.pawguider.app.repository.UserRepository;

import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final JwtService jwtService;

    public UserService(UserRepository userRepository, JwtService jwtService) {
        this.userRepository = userRepository;
        this.jwtService = jwtService;
    }

    public User getUserFromHeader(String header) {
        String email = jwtService.extractEmailFromHeader(header);
        return getUserByEmail(email);
    }

    public User getUserByEmail(String email) {
        Optional<User> user = userRepository.findByEmail(email);
        return user.orElse(null);
    }

    public User getUserById(Long id) {
        Optional<User> user = userRepository.findById(id);
        return user.orElse(null);
    }

    public void saveUser(User user) {
        userRepository.save(user);
    }
}

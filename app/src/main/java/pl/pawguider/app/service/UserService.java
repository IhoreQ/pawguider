package pl.pawguider.app.service;

import org.springframework.stereotype.Service;
import pl.pawguider.app.model.User;
import pl.pawguider.app.repository.UserRepository;

import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User getUserByEmail(String email) {
        Optional<User> user = userRepository.findByEmail(email);
        return user.orElse(null);
    }

    public User getUserById(Long id) {
        Optional<User> user = userRepository.findById(id);
        return user.orElse(null);
    }

    public void changeHasDogState(User user) {
        boolean actualState = user.hasDog();
        user.setHasDog(!actualState);
        userRepository.save(user);
    }

    public void saveUser(User user) {
        userRepository.save(user);
    }
}

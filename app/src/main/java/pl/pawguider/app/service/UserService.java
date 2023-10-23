package pl.pawguider.app.service;

import org.springframework.stereotype.Service;
import pl.pawguider.app.model.User;
import pl.pawguider.app.model.UserLocation;
import pl.pawguider.app.repository.UserLocationRepository;
import pl.pawguider.app.repository.UserRepository;

import java.time.LocalTime;
import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final JwtService jwtService;
    private final UserLocationRepository userLocationRepository;

    public UserService(UserRepository userRepository, JwtService jwtService, UserLocationRepository userLocationRepository) {
        this.userRepository = userRepository;
        this.jwtService = jwtService;
        this.userLocationRepository = userLocationRepository;
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

    public void updateUserLocation(User user, double latitude, double longitude) {
        Optional<UserLocation> foundUserLocation = userLocationRepository.findByUserIdUser(user.getIdUser());
        if (foundUserLocation.isPresent()) {
            UserLocation location = foundUserLocation.get();
            location.setLatitude(latitude);
            location.setLongitude(longitude);
            location.setLastUpdate(LocalTime.now());
            userLocationRepository.save(location);
        }
    }
}

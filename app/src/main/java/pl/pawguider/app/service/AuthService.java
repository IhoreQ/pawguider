package pl.pawguider.app.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import pl.pawguider.app.controller.dto.request.UserAddRequest;
import pl.pawguider.app.model.*;
import pl.pawguider.app.repository.CityRepository;
import pl.pawguider.app.repository.GenderRepository;
import pl.pawguider.app.repository.UserRepository;


@Service
public class AuthService {

    private final UserRepository userRepository;
    private final CityRepository cityRepository;
    private final GenderRepository genderRepository;
    private final PasswordEncoder passwordEncoder;

    public AuthService(UserRepository userRepository, CityRepository cityRepository, GenderRepository genderRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.cityRepository = cityRepository;
        this.genderRepository = genderRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public void addUser(UserAddRequest request) {

        City city = cityRepository.findByName(request.city()).orElse(null);
        Gender gender = genderRepository.findByName(request.gender()).orElse(null);
        String defaultPhotoName = "user_profile_picture.png";
        UserDetails userDetails = new UserDetails(request.firstName(), request.lastName(), request.phone(), city, gender, defaultPhotoName);
        UserLocation userLocation = new UserLocation(50.07208368710892, 19.942688926110346);

        User user = new User(request.email(), userDetails, userLocation);
        user.setPassword(passwordEncoder.encode(request.password()));

        userRepository.save(user);
    }

    public boolean userExists(String email) {
        return userRepository.existsByEmail(email);
    }

}

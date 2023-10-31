package pl.pawguider.app.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import pl.pawguider.app.controller.dto.request.RegisterRequest;
import pl.pawguider.app.model.*;
import pl.pawguider.app.repository.UserRepository;
import pl.pawguider.app.util.Constants;


@Service
public class AuthService {

    private final UserRepository userRepository;
    private final CityService cityService;
    private final GenderService genderService;
    private final PasswordEncoder passwordEncoder;

    public AuthService(UserRepository userRepository, CityService cityService, GenderService genderService, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.cityService = cityService;
        this.genderService = genderService;
        this.passwordEncoder = passwordEncoder;
    }

    public void addUser(RegisterRequest request) {
        City city = cityService.getCityByName(request.city());
        Gender gender = genderService.getGenderByName(request.gender());

        String photoName = Constants.DEFAULT_USER_PROFILE_PHOTO_NAME;

        UserDetails userDetails = new UserDetails(request.firstName(), request.lastName(), request.phone(), city, gender, photoName);
        UserLocation userLocation = new UserLocation(Constants.DEFAULT_LATITUDE, Constants.DEFAULT_LONGITUDE);

        User user = new User(request.email(), userDetails, userLocation);

        user.setPassword(passwordEncoder.encode(request.password()));

        userRepository.save(user);
    }

    public boolean userExists(String email) {
        return userRepository.existsByEmail(email);
    }

}

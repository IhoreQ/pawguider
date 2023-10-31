package pl.pawguider.app.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import pl.pawguider.app.controller.dto.request.PasswordUpdateRequest;
import pl.pawguider.app.controller.dto.request.UserUpdateRequest;
import pl.pawguider.app.exception.auth.PasswordMismatchException;
import pl.pawguider.app.exception.auth.UserNotFoundException;
import pl.pawguider.app.exception.user.UserLocationNotFoundException;
import pl.pawguider.app.model.*;
import pl.pawguider.app.repository.UserDetailsRepository;
import pl.pawguider.app.repository.UserLocationRepository;
import pl.pawguider.app.repository.UserRepository;

import java.time.LocalTime;
import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final JwtService jwtService;
    private final UserLocationRepository userLocationRepository;
    private final UserDetailsRepository userDetailsRepository;
    private final GenderService genderService;
    private final CityService cityService;
    private final PasswordEncoder passwordEncoder;


    public UserService(UserRepository userRepository, JwtService jwtService, UserLocationRepository userLocationRepository, UserDetailsRepository userDetailsRepository, GenderService genderService, CityService cityService, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.jwtService = jwtService;
        this.userLocationRepository = userLocationRepository;
        this.userDetailsRepository = userDetailsRepository;
        this.genderService = genderService;
        this.cityService = cityService;
        this.passwordEncoder = passwordEncoder;
    }

    public User getUserFromHeader(String header) {
        String email = jwtService.extractEmailFromHeader(header);
        return getUserByEmail(email);
    }

    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email).orElseThrow(() -> new UserNotFoundException(email));
    }

    public User getUserById(Long id) {
        return userRepository.findById(id).orElseThrow(() -> new UserNotFoundException(id));
    }

    public UserLocation getUserLocationByIdUser(Long idUser) {
        return userLocationRepository.findByUserIdUser(idUser).orElseThrow(() -> new UserLocationNotFoundException(idUser));
    }

    public void updateUserLocation(User user, double latitude, double longitude) {
        UserLocation location = getUserLocationByIdUser(user.getIdUser());

        location.setLatitude(latitude);
        location.setLongitude(longitude);
        location.setLastUpdate(LocalTime.now());
        userLocationRepository.save(location);
    }

    public void updateUserDetails(User user, UserUpdateRequest request) {
        Gender gender = genderService.getGenderByName(request.gender());
        City city = cityService.getCityByName(request.city());

        UserDetails details = user.getDetails();

        details.setFirstName(request.firstName());
        details.setLastName(request.lastName());
        details.setPhone(request.phone());
        details.setGender(gender);
        details.setCity(city);

        userDetailsRepository.save(details);
    }

    public void updateUserPassword(User user, PasswordUpdateRequest request) {
        if (!passwordEncoder.matches(request.oldPassword(), user.getPassword()))
            throw new PasswordMismatchException();

        user.setPassword(passwordEncoder.encode(request.newPassword()));
        userRepository.save(user);
    }

    public void updateUserPhoto(User user, String photoName) {
        UserDetails details = user.getDetails();

        details.setPhotoName(photoName);
        userDetailsRepository.save(details);
    }
}

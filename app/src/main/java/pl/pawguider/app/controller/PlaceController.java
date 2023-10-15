package pl.pawguider.app.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.pawguider.app.controller.dto.request.RatingRequest;
import pl.pawguider.app.controller.dto.response.PlaceInfoBoxResponse;
import pl.pawguider.app.controller.dto.response.PlaceInfoResponse;
import pl.pawguider.app.model.Place;
import pl.pawguider.app.model.User;
import pl.pawguider.app.service.JwtService;
import pl.pawguider.app.service.PlaceService;
import pl.pawguider.app.service.UserService;

import java.util.List;

@RestController
@RequestMapping("/api/v1/place")
public class PlaceController {

    private final PlaceService placeService;
    private final JwtService jwtService;
    private final UserService userService;

    public PlaceController(PlaceService placeService, JwtService jwtService, UserService userService) {
        this.placeService = placeService;
        this.jwtService = jwtService;
        this.userService = userService;
    }

    @GetMapping("/all")
    public List<Place> getALlPlaces() {
        return placeService.getAllPlaces();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getPlaceById(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = getUserFromHeader(header);
        Place place = placeService.getPlaceById(id);

        return ResponseEntity.ok(PlaceInfoResponse.getResponse(user, place));
    }

    @GetMapping("/city-{cityId}")
    public List<PlaceInfoBoxResponse> getPlacesByCityId(@PathVariable Long cityId) {
        List<Place> places = placeService.getPlacesByCityId(cityId);
        return places.stream().map(PlaceInfoBoxResponse::getResponse).toList();
    }

    @PostMapping("/like/{id}")
    public Boolean addLike(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = getUserFromHeader(header);
        Place place = placeService.getPlaceById(id);

        if (isAlreadyLiked(user, place))
            return false;

        placeService.addLike(user, place);
        return true;
    }

    @DeleteMapping("/like/{id}")
    public Boolean deleteLike(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = getUserFromHeader(header);
        Place place = placeService.getPlaceById(id);

        if (!isAlreadyLiked(user, place))
            return false;

        placeService.deleteLike(user, place);
        return true;
    }

    @PostMapping("/rate")
    public Boolean addRating(@RequestHeader("Authorization") String header, @RequestBody RatingRequest request) {
        User user = getUserFromHeader(header);
        Place place = placeService.getPlaceById(request.placeId());

        if (isAlreadyRated(user, place)) {
            return false;
        }

        placeService.addRating(user, place, request.rating());
        return true;
    }

    @PatchMapping("/rate")
    public Boolean updateRating(@RequestHeader("Authorization") String header, @RequestBody RatingRequest request) {
        User user = getUserFromHeader(header);
        Place place = placeService.getPlaceById(request.placeId());

        if (!isAlreadyRated(user, place)) {
            return false;
        }

        placeService.updateRating(user, place, request.rating());
        return true;
    }

    private User getUserFromHeader(String header) {
        String email = jwtService.extractEmailFromHeader(header);
        return userService.getUserByEmail(email);
    }

    private boolean isAlreadyLiked(User user, Place place) {
        return place.getLikes()
                .stream()
                .anyMatch(like -> like.getUser().getIdUser().equals(user.getIdUser()));
    }

    private boolean isAlreadyRated(User user, Place place) {
        return place.getRatings()
                .stream()
                .anyMatch(rating -> rating.getUser().getIdUser().equals(user.getIdUser()));
    }


}

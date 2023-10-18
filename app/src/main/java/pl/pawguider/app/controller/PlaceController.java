package pl.pawguider.app.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.pawguider.app.controller.dto.request.RatingRequest;
import pl.pawguider.app.controller.dto.request.UserLocationRequest;
import pl.pawguider.app.controller.dto.response.LikedPlaceResponse;
import pl.pawguider.app.controller.dto.response.PlaceAreaResponse;
import pl.pawguider.app.controller.dto.response.PlaceInfoBoxResponse;
import pl.pawguider.app.controller.dto.response.PlaceInfoResponse;
import pl.pawguider.app.model.Place;
import pl.pawguider.app.model.User;
import pl.pawguider.app.service.PlaceService;
import pl.pawguider.app.service.UserService;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/v1/place")
public class PlaceController {

    private final PlaceService placeService;
    private final UserService userService;

    public PlaceController(PlaceService placeService, UserService userService) {
        this.placeService = placeService;
        this.userService = userService;
    }

    @GetMapping("/all")
    public List<Place> getALlPlaces() {
        return placeService.getAllPlaces();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getPlaceById(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = userService.getUserFromHeader(header);
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
        User user = userService.getUserFromHeader(header);
        Place place = placeService.getPlaceById(id);

        if (placeService.isPlaceAlreadyLiked(user, place))
            return false;

        placeService.addLike(user, place);
        return true;
    }

    @DeleteMapping("/like/{id}")
    public Boolean deleteLike(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = userService.getUserFromHeader(header);
        Place place = placeService.getPlaceById(id);

        if (!placeService.isPlaceAlreadyLiked(user, place))
            return false;

        placeService.deleteLike(user, place);
        return true;
    }

    @PostMapping("/rate")
    public Boolean addRating(@RequestHeader("Authorization") String header, @RequestBody RatingRequest request) {
        User user = userService.getUserFromHeader(header);
        Place place = placeService.getPlaceById(request.placeId());

        if (placeService.isPlaceAlreadyRated(user, place)) {
            return false;
        }

        placeService.addRating(user, place, request.rating());
        return true;
    }

    @PatchMapping("/rate")
    public Boolean updateRating(@RequestHeader("Authorization") String header, @RequestBody RatingRequest request) {
        User user = userService.getUserFromHeader(header);
        Place place = placeService.getPlaceById(request.placeId());

        if (!placeService.isPlaceAlreadyRated(user, place)) {
            return false;
        }

        placeService.updateRating(user, place, request.rating());
        return true;
    }

    @GetMapping("/favourites")
    public List<LikedPlaceResponse> getUserLikedPlaces(@RequestHeader("Authorization") String header) {
        User user = userService.getUserFromHeader(header);
        List<Place> likedPlaces = placeService.getUserLikedPlaces(user);

        return likedPlaces.stream().map(LikedPlaceResponse::getResponse).toList();
    }

    @GetMapping("/areas/city/{id}")
    public List<PlaceAreaResponse> getAreas(@PathVariable Long id) {
        List<Place> places = placeService.getPlacesByCityId(id);
        return places.stream().map(PlaceAreaResponse::getResponse).toList();
    }

    @GetMapping("/area/{placeId}")
    public boolean isUserInPlaceArea(@PathVariable Long placeId, @RequestBody UserLocationRequest request) {
        return placeService.isUserInPlaceArea(request.latitude(), request.longitude(), placeId);
    }

    @GetMapping("/area")
    public Place findUserPlaceArea(@RequestHeader("Authorization") String header, @RequestBody UserLocationRequest request) {
        User user = userService.getUserFromHeader(header);
        return placeService.findPlaceBasedOnUserLocationAndHisCity(user, request.latitude(), request.longitude());
    }

}

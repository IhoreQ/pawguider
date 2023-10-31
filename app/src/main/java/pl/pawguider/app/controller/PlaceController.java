package pl.pawguider.app.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pl.pawguider.app.controller.dto.request.RatingRequest;
import pl.pawguider.app.controller.dto.request.UserLocationUpdateRequest;
import pl.pawguider.app.controller.dto.response.*;
import pl.pawguider.app.model.Dog;
import pl.pawguider.app.model.Place;
import pl.pawguider.app.model.User;
import pl.pawguider.app.service.PlaceService;
import pl.pawguider.app.service.UserService;
import pl.pawguider.app.service.WalkService;

import java.util.List;

@RestController
@RequestMapping("/api/v1/place")
public class PlaceController {

    private final PlaceService placeService;
    private final UserService userService;
    private final WalkService walkService;

    public PlaceController(PlaceService placeService, UserService userService, WalkService walkService) {
        this.placeService = placeService;
        this.userService = userService;
        this.walkService = walkService;
    }

    @GetMapping("/all")
    public List<Place> getALlPlaces() {
        return placeService.getAllPlaces();
    }

    @GetMapping("/{id}")
    public ResponseEntity<PlaceInfoResponse> getPlaceById(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = userService.getUserFromHeader(header);
        Place place = placeService.getPlaceById(id);

        PlaceInfoResponse response = PlaceInfoResponse.getResponse(user, place);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/city/{cityId}")
    public List<PlaceInfoBoxResponse> getPlacesByCityId(@PathVariable Long cityId) {
        List<Place> places = placeService.getPlacesByCityId(cityId);
        return places.stream().map(PlaceInfoBoxResponse::getResponse).toList();
    }

    @PostMapping("/{id}/like")
    public ResponseEntity<?> addLike(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = userService.getUserFromHeader(header);
        Place place = placeService.getPlaceById(id);

        placeService.addLike(user, place);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @DeleteMapping("/{id}/like")
    public ResponseEntity<?> deleteLike(@RequestHeader("Authorization") String header, @PathVariable Long id) {
        User user = userService.getUserFromHeader(header);
        Place place = placeService.getPlaceById(id);

        placeService.deleteLike(user, place);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/rate")
    public ResponseEntity<?> addRating(@RequestHeader("Authorization") String header, @RequestBody RatingRequest request) {
        User user = userService.getUserFromHeader(header);
        Place place = placeService.getPlaceById(request.placeId());

        placeService.addRating(user, place, request.rating());
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PatchMapping("/rate")
    public ResponseEntity<?> updateRating(@RequestHeader("Authorization") String header, @RequestBody RatingRequest request) {
        User user = userService.getUserFromHeader(header);
        Place place = placeService.getPlaceById(request.placeId());

        placeService.updateRating(user, place, request.rating());
        return new ResponseEntity<>(HttpStatus.OK);
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

    @GetMapping("/{placeId}/area")
    public boolean isUserInPlaceArea(@PathVariable Long placeId, @RequestBody UserLocationUpdateRequest request) {
        return placeService.isUserInPlaceArea(request.latitude(), request.longitude(), placeId);
    }

    @GetMapping("/area")
    public ResponseEntity<Long> findUserPlaceArea(@RequestHeader("Authorization") String header, @RequestBody UserLocationUpdateRequest request) {
        User user = userService.getUserFromHeader(header);
        Long placeId = placeService.findPlaceBasedOnUserLocationAndHisCity(user, request.latitude(), request.longitude());
        return ResponseEntity.ok(placeId);
    }

    @GetMapping("/{placeId}/dogs")
    public List<DogInfoBoxResponse> getAllDogsFromPlace(@PathVariable Long placeId) {
        List<Dog> dogs = walkService.getDogsFromPlace(placeId);
        return dogs.stream()
                .map(DogInfoBoxResponse::getResponse)
                .toList();
    }

}

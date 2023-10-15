package pl.pawguider.app.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
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
        String email = jwtService.extractEmailFromHeader(header);
        User user = userService.getUserByEmail(email);
        Place place = placeService.getPlaceById(id);

        return ResponseEntity.ok(PlaceInfoResponse.getResponse(user, place));
    }

    @GetMapping("/city-{cityId}")
    public List<PlaceInfoBoxResponse> getPlacesByCityId(@PathVariable Long cityId) {
        List<Place> places = placeService.getPlacesByCityId(cityId);
        return places.stream().map(PlaceInfoBoxResponse::getResponse).toList();
    }
}

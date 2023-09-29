package pl.pawguider.app.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.pawguider.app.model.Place;
import pl.pawguider.app.service.PlaceService;

import java.util.List;

@RestController
@RequestMapping("/api/v1/place")
public class PlaceController {

    private final PlaceService placeService;

    public PlaceController(PlaceService placeService) {
        this.placeService = placeService;
    }

    @GetMapping("/all")
    public List<Place> getALlPlaces() {
        return placeService.getAllPlaces();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getPlaceName(@PathVariable Long id) {
        Place place = placeService.getPlaceById(id);

        if (place == null) {
            return ResponseEntity.ok(false);
        }

        return ResponseEntity.ok(place.getName());
    }
}

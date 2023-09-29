package pl.pawguider.app.service;

import org.springframework.stereotype.Service;
import pl.pawguider.app.model.Place;
import pl.pawguider.app.repository.CityRepository;
import pl.pawguider.app.repository.PlaceRepository;

import java.util.List;

@Service
public class PlaceService {

    private final PlaceRepository placeRepository;
    private final CityRepository cityRepository;

    public PlaceService(PlaceRepository placeRepository, CityRepository cityRepository) {
        this.placeRepository = placeRepository;
        this.cityRepository = cityRepository;
    }

    public List<Place> getAllPlaces() {
        return placeRepository.findAllPlaces();
    }

    public Place getPlaceById(Long id) {
        return placeRepository.findById(id).orElse(null);
    }

}

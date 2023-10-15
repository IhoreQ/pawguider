package pl.pawguider.app.service;

import org.springframework.stereotype.Service;
import pl.pawguider.app.model.City;
import pl.pawguider.app.model.Place;
import pl.pawguider.app.repository.CityRepository;
import pl.pawguider.app.repository.PlaceRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

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

    public List<Place> getPlacesByCityId(Long cityId) {
        Optional<City> foundCity = cityRepository.findById(cityId);

        if (foundCity.isPresent()) {
            City city = foundCity.get();
            return placeRepository.findByCity(city);
        }
        return new ArrayList<>();
    }
}

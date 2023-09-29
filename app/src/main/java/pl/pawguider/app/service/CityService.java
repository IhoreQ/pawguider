package pl.pawguider.app.service;

import org.springframework.stereotype.Service;
import pl.pawguider.app.model.City;
import pl.pawguider.app.repository.CityRepository;

import java.util.List;

@Service
public class CityService {

    private final CityRepository cityRepository;

    public CityService(CityRepository cityRepository) {
        this.cityRepository = cityRepository;
    }

    public List<City> getAllCities() {
        return cityRepository.findAll();
    }
}

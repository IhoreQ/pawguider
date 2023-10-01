package pl.pawguider.app.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.pawguider.app.model.City;
import pl.pawguider.app.service.CityService;

import java.util.List;

@RestController
@RequestMapping("/api/v1/city")
public class CityController {

    private final CityService cityService;

    public CityController(CityService cityService) {
        this.cityService = cityService;
    }

    @GetMapping("/all")
    public List<City> getAllCities() {
        return cityService.getAllCities();
    }
}

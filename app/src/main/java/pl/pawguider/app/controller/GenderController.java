package pl.pawguider.app.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.pawguider.app.model.Gender;
import pl.pawguider.app.service.GenderService;

import java.util.List;

@RestController
@RequestMapping("/api/v1/gender")
public class GenderController {

    private final GenderService genderService;

    public GenderController(GenderService genderService) {
        this.genderService = genderService;
    }

    @GetMapping("/all")
    public List<Gender> getAllGenders() {
        return genderService.getAllGenders();
    }

    @GetMapping("/basic")
    public List<Gender> getBasicGenders() {
        return genderService.getBasicGenders();
    }

}

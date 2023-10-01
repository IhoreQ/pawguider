package pl.pawguider.app.service;

import org.springframework.stereotype.Service;
import pl.pawguider.app.model.Gender;
import pl.pawguider.app.repository.GenderRepository;

import java.util.List;

@Service
public class GenderService {

    private final GenderRepository genderRepository;

    public GenderService(GenderRepository genderRepository) {
        this.genderRepository = genderRepository;
    }

    public List<Gender> getAllGenders() {
        return genderRepository.findAll();
    }
}

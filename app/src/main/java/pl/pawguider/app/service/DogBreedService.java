package pl.pawguider.app.service;

import org.springframework.stereotype.Service;
import pl.pawguider.app.exception.dog.BreedNotFoundException;
import pl.pawguider.app.model.DogBreed;
import pl.pawguider.app.repository.DogBreedRepository;

import java.util.List;

@Service
public class DogBreedService {

    private final DogBreedRepository dogBreedRepository;

    public DogBreedService(DogBreedRepository dogBreedRepository) {
        this.dogBreedRepository = dogBreedRepository;
    }

    public DogBreed getBreedById(Long id) {
        return dogBreedRepository.findById(id).orElseThrow(() -> new BreedNotFoundException(id));
    }

    public List<DogBreed> findAllNamesWithIds() {
        return dogBreedRepository.findAllNamesWithIds();
    }
}

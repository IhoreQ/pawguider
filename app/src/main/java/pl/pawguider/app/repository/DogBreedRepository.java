package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import pl.pawguider.app.model.DogBreed;

import java.util.List;
import java.util.Optional;

@Repository
public interface DogBreedRepository extends JpaRepository<DogBreed, Long> {

    @Query("select new DogBreed (idDogBreed, name) from DogBreed")
    List<DogBreed> findAllNamesWithIds();
    Optional<DogBreed> findByName(String name);
}

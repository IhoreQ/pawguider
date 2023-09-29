package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.pawguider.app.model.City;

import java.util.Optional;

public interface CityRepository extends JpaRepository<City, Long> {

    Optional<City> findByName(String name);
}

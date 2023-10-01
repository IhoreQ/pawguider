package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.pawguider.app.model.Gender;

import java.util.Optional;

public interface GenderRepository extends JpaRepository<Gender, Long> {
    Optional<Gender> findByName(String name);

}

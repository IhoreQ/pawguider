package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.pawguider.app.model.Image;

import java.util.Optional;

public interface ImageRepository extends JpaRepository<Image, Long> {
    Optional<Image> findByName(String name);
}

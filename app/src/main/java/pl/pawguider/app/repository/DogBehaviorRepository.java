package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.pawguider.app.model.DogBehavior;

public interface DogBehaviorRepository extends JpaRepository<DogBehavior, Long> {
}

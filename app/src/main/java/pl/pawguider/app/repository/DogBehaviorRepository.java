package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.pawguider.app.model.DogBehavior;

@Repository
public interface DogBehaviorRepository extends JpaRepository<DogBehavior, Long> {
}

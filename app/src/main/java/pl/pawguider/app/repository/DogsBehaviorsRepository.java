package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.pawguider.app.model.DogsBehaviors;

public interface DogsBehaviorsRepository extends JpaRepository<DogsBehaviors, Long> {
}

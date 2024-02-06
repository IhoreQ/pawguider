package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.pawguider.app.model.DogsBehaviors;

@Repository
public interface DogsBehaviorsRepository extends JpaRepository<DogsBehaviors, Long> {
}

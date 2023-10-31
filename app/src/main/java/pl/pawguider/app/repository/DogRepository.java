package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.pawguider.app.model.Dog;

@Repository
public interface DogRepository extends JpaRepository<Dog, Long> {
}

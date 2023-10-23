package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.pawguider.app.model.UserLocation;

import java.util.Optional;

public interface UserLocationRepository extends JpaRepository<UserLocation, Long> {
    Optional<UserLocation> findByUserIdUser(Long idUser);
}

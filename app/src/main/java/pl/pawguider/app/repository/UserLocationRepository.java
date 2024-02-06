package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.pawguider.app.model.UserLocation;

import java.util.Optional;

@Repository
public interface UserLocationRepository extends JpaRepository<UserLocation, Long> {
    Optional<UserLocation> findByUserIdUser(Long idUser);
}

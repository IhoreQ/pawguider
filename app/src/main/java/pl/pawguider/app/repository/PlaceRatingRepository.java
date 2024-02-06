package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import pl.pawguider.app.model.PlaceRating;

import java.util.Optional;

@Repository
public interface PlaceRatingRepository extends JpaRepository<PlaceRating, Long> {
    @Query("select new PlaceRating(p.idRating, p.rating, p.user, p.place) from PlaceRating p where p.user.idUser = ?1 and p.place.idPlace = ?2")
    Optional<PlaceRating> findByUserIdAndPlaceId(Long userId, Long placeId);
}

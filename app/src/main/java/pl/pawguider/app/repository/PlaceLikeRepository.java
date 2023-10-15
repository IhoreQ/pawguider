package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import pl.pawguider.app.model.PlaceLike;

public interface PlaceLikeRepository extends JpaRepository<PlaceLike, Long> {

    @Query("select new PlaceLike(p.idLike) from PlaceLike p where p.user.idUser = ?1 and p.place.idPlace = ?2")
    PlaceLike findByUserIdAndPlaceId(Long userId, Long placeId);
}

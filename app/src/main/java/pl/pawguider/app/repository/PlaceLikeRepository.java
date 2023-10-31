package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import pl.pawguider.app.model.PlaceLike;

import java.util.List;

public interface PlaceLikeRepository extends JpaRepository<PlaceLike, Long> {
    @Query("select new PlaceLike(pl.idLike) from PlaceLike pl where pl.user.idUser = ?1 and pl.place.idPlace = ?2")
    PlaceLike findByUserIdAndPlaceId(Long userId, Long placeId);

    @Query("select new PlaceLike (pl.place) from PlaceLike pl where pl.user.idUser = ?1")
    List<PlaceLike> findByIdUser(Long userId);
}

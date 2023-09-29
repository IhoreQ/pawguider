package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import pl.pawguider.app.model.Place;

import java.util.List;

@Repository
public interface PlaceRepository extends JpaRepository<Place, Long> {

    @Query("select new Place(p.idPlace, p.name, p.photo) from Place p")
    List<Place> findAllPlaces();

}

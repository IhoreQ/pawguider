package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import pl.pawguider.app.model.Gender;

import java.util.List;
import java.util.Optional;

@Repository
public interface GenderRepository extends JpaRepository<Gender, Long> {
    Optional<Gender> findByName(String name);

    @Query("select new Gender(g.idGender, g.name) from Gender g where g.name = 'Male' or g.name = 'Female'")
    List<Gender> findBasicGenders();
}

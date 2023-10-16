package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import pl.pawguider.app.model.DogLike;

public interface DogLikeRepository extends JpaRepository<DogLike, Long> {

    @Query("select new DogLike(dl.idLike) from DogLike dl where dl.user.idUser = ?1 and dl.dog.idDog = ?2")
    DogLike findByUserIdAndDogId(Long userId, Long dogId);
}

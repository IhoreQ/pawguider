package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.pawguider.app.model.UserDetails;

@Repository
public interface UserDetailsRepository extends JpaRepository<UserDetails, Long> {}

package pl.pawguider.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.pawguider.app.model.UserDetails;

public interface UserDetailsRepository extends JpaRepository<UserDetails, Long> {}

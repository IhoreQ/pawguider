package pl.pawguider.app.config.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import pl.pawguider.app.model.User;
import pl.pawguider.app.repository.UserRepository;

import java.util.Optional;

@Component
public class UserDetailsConfigService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<User> user = userRepository.findByEmail(username);
        return user.map(UserDetailsConfig::new)
                .orElseThrow(() -> new UsernameNotFoundException("User: " + username + " not found!"));
    }
}

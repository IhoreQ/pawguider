package pl.pawguider.app.config.user;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import pl.pawguider.app.model.User;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class UserDetailsConfig implements UserDetails {

    private final String email;
    private final String password;
    private final List<GrantedAuthority> authorities = new ArrayList<>();

    public UserDetailsConfig(User user) {
        this.email = user.getEmail();
        this.password = user.getPassword();
        this.authorities.add(new SimpleGrantedAuthority(user.getRole().getRole()));
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}

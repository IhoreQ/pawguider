package pl.pawguider.app.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import org.hibernate.annotations.DynamicUpdate;

import java.sql.Date;
import java.util.Collection;

@Entity
@DynamicUpdate
@Table(name = "users", schema = "public", catalog = "dogout")
public class User {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_user")
    private Long idUser;

    @Column
    private String email;

    @Column
    private String password;

    @Column(name = "created_at")
    private Date createdAt;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "user")
    private Collection<ActiveWalk> activeWalks;
    @OneToMany(fetch = FetchType.EAGER, mappedBy = "owner")
    private Collection<Dog> dogs;

    @ManyToOne
    @JoinColumn(name = "id_role", referencedColumnName = "id_role", nullable = false)
    private Role role;
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "id_user_details", referencedColumnName = "id_user_details", nullable = false)
    private UserDetails details;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "id_user_location", referencedColumnName = "id_user_location", nullable = false)
    private UserLocation location;

    @JsonIgnore
    @OneToMany(mappedBy = "user")
    private Collection<DogLike> dogsLikes;

    @JsonIgnore
    @OneToMany(mappedBy = "user")
    private Collection<PlaceLike> placesLikes;

    @JsonIgnore
    @OneToMany(mappedBy = "user")
    private Collection<PlaceRating> placesRatings;

    public User() {
    }

    public User(Long idUser) {
        this.idUser = idUser;
    }

    public User(String email, UserDetails details, UserLocation location) {
        this.email = email;
        this.createdAt = new Date(System.currentTimeMillis());
        this.role = new Role(1L);
        this.details = details;
        this.location = location;
    }

    public User(Long idUser, String email, String password, Date createdAt, Collection<ActiveWalk> activeWalks, Collection<Dog> dogs, Role role, UserDetails details) {
        this.idUser = idUser;
        this.email = email;
        this.password = password;
        this.createdAt = createdAt;
        this.activeWalks = activeWalks;
        this.dogs = dogs;
        this.role = role;
        this.details = details;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public Collection<ActiveWalk> getActiveWalks() {
        return activeWalks;
    }

    public Collection<Dog> getDogs() {
        return dogs;
    }

    public Role getRole() {
        return role;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserDetails getDetails() {
        return details;
    }

    public Long getIdUser() {
        return idUser;
    }

    public UserLocation getLocation() {
        return location;
    }
}

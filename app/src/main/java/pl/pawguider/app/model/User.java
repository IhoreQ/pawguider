package pl.pawguider.app.model;

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

    @Column(name = "has_dog")
    private boolean hasDog;
    @OneToMany(fetch = FetchType.EAGER, mappedBy = "user")
    private Collection<ActiveWalk> activeWalks;
    @OneToMany(fetch = FetchType.EAGER, mappedBy = "owner")
    private Collection<Dog> dogs;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    private Collection<NewPlaceIdea> newPlacesIdeas;
    @ManyToOne
    @JoinColumn(name = "id_role", referencedColumnName = "id_role", nullable = false)
    private Role role;
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "id_user_details", referencedColumnName = "id_user_details", nullable = false)
    private UserDetails details;

    public User() {
    }

    public User(Long idUser) {
        this.idUser = idUser;
    }

    public User(String email, UserDetails details) {
        this.email = email;
        this.hasDog = false;
        this.createdAt = new Date(System.currentTimeMillis());
        this.role = new Role(1L);
        this.details = details;
    }

    public User(Long idUser, String email, String password, Date createdAt, boolean hasDog, Collection<ActiveWalk> activeWalks, Collection<Dog> dogs, Collection<NewPlaceIdea> newPlacesIdeas, Role role, UserDetails details) {
        this.idUser = idUser;
        this.email = email;
        this.password = password;
        this.createdAt = createdAt;
        this.hasDog = hasDog;
        this.activeWalks = activeWalks;
        this.dogs = dogs;
        this.newPlacesIdeas = newPlacesIdeas;
        this.role = role;
        this.details = details;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public boolean hasDog() {
        return hasDog;
    }

    public void setHasDog(boolean hasDog) {
        this.hasDog = hasDog;
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
}

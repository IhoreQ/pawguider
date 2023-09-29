package pl.pawguider.app.model;

import jakarta.persistence.*;
import lombok.Getter;

@Getter
@Entity
@Table(name = "users_details", schema = "public", catalog = "dogout")
public class UserDetails {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_user_details")
    private Long idUserDetails;

    @Column
    private String name;

    @Column
    private String surname;

    @OneToOne(mappedBy = "details")
    private User user;
    @ManyToOne
    @JoinColumn(name = "id_city", referencedColumnName = "id_city", nullable = false)
    private City city;

    public UserDetails() {
    }

    public UserDetails(String name, String surname) {
        this.name = name;
        this.surname = surname;
        this.city = new City(1L);
    }

    public UserDetails(Long idUserDetails, String name, String surname, User user, City city) {
        this.idUserDetails = idUserDetails;
        this.name = name;
        this.surname = surname;
        this.user = user;
        this.city = city;
    }
}

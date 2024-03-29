package pl.pawguider.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Entity
@Table(name = "users_details", schema = "public", catalog = "dogout")
public class UserDetails {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_user_details")
    private Long idUserDetails;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column
    private String phone;

    @Column(name = "photo_name")
    private String photoName;

    @OneToOne(mappedBy = "details")
    private User user;
    @ManyToOne
    @JoinColumn(name = "id_city", referencedColumnName = "id_city", nullable = false)
    private City city;

    @ManyToOne
    @JoinColumn(name = "id_gender", referencedColumnName = "id_gender", nullable = false)
    private Gender gender;

    public UserDetails(String firstName, String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.city = new City(1L);
        this.gender = new Gender(1L);
    }

    public UserDetails(String firstName, String lastName, String phone, City city, Gender gender, String photoName) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.phone = phone;
        this.city = city;
        this.gender = gender;
        this.photoName = photoName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setPhotoName(String photoName) {
        this.photoName = photoName;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }
}

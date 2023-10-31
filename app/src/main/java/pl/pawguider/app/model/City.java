package pl.pawguider.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.util.Collection;

@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "cities", schema = "public", catalog = "dogout")
public class City {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_city")
    private Long idCity;

    @Column
    private String name;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "city")
    private Collection<Address> addresses;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "city")
    private Collection<UserDetails> usersDetails;

    public City(String name) {
        this.name = name;
    }

    public City(Long idCity) {
        this.idCity = idCity;
    }

    public Long getIdCity() {
        return idCity;
    }

    public String getName() {
        return name;
    }

}

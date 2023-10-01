package pl.pawguider.app.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.util.Collection;

@Entity
@Table(name = "cities", schema = "public", catalog = "dogout")
public class City {
    @JsonIgnore
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_city")
    private Long idCity;

    @Column
    private String name;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "city")
    private Collection<Address> addresses;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "city")
    private Collection<Place> places;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "city")
    private Collection<UserDetails> usersDetails;

    public City() {
    }

    public City(Long idCity) {
        this.idCity = idCity;
    }

    public City(Long idCity, String name, Collection<Address> addresses, Collection<Place> places, Collection<UserDetails> usersDetails) {
        this.idCity = idCity;
        this.name = name;
        this.addresses = addresses;
        this.places = places;
        this.usersDetails = usersDetails;
    }

    public Long getIdCity() {
        return idCity;
    }

    public String getName() {
        return name;
    }
}

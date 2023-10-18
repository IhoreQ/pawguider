package pl.pawguider.app.model;

import jakarta.persistence.*;

import java.util.Collection;

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

    public City() {
    }

    public City(String name) {
        this.name = name;
    }

    public City(Long idCity) {
        this.idCity = idCity;
    }

    public City(Long idCity, String name, Collection<Address> addresses, Collection<UserDetails> usersDetails) {
        this.idCity = idCity;
        this.name = name;
        this.addresses = addresses;
        this.usersDetails = usersDetails;
    }

    public Long getIdCity() {
        return idCity;
    }

    public String getName() {
        return name;
    }
}

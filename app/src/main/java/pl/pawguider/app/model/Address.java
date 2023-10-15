package pl.pawguider.app.model;

import jakarta.persistence.*;

import java.util.Collection;

@Entity
@Table(name = "addresses", schema = "public", catalog = "dogout")
public class Address {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_address")
    private Long idAddress;

    @Column(name = "postal_code")
    private String postalCode;

    @Column
    private String street;

    @Column(name = "home_number")
    private String homeNumber;

    @Column
    private String country;

    @ManyToOne
    @JoinColumn(name = "city", referencedColumnName = "id_city", nullable = false)
    private City city;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "address")
    private Collection<Place> places;

    public Address() {
    }

    public Address(Long idAddress, String postalCode, String street, String homeNumber, String country, City city, Collection<Place> places) {
        this.idAddress = idAddress;
        this.postalCode = postalCode;
        this.street = street;
        this.homeNumber = homeNumber;
        this.country = country;
        this.city = city;
        this.places = places;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public String getStreet() {
        return street;
    }

    public String getHomeNumber() {
        return homeNumber;
    }

    public String getCountry() {
        return country;
    }

    public City getCity() {
        return city;
    }
}

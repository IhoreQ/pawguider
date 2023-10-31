package pl.pawguider.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.util.Collection;

@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "addresses", schema = "public", catalog = "dogout")
public class Address {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_address")
    private Long idAddress;

    @Column(name = "zip_code")
    private String zipCode;

    @Column
    private String street;

    @Column(name = "house_number")
    private String houseNumber;

    @Column
    private String country;

    @ManyToOne
    @JoinColumn(name = "city", referencedColumnName = "id_city", nullable = false)
    private City city;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "address")
    private Collection<Place> places;

    public Long getIdAddress() {
        return idAddress;
    }

    public Collection<Place> getPlaces() {
        return places;
    }

    public String getZipCode() {
        return zipCode;
    }

    public String getStreet() {
        return street;
    }

    public String getHouseNumber() {
        return houseNumber;
    }

    public String getCountry() {
        return country;
    }

    public City getCity() {
        return city;
    }
}

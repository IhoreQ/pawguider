package pl.pawguider.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.util.Collection;

@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "places", schema = "public", catalog = "dogout")
public class Place {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_place")
    private Long idPlace;

    @Column
    private String name;

    @Column
    private String description;

    @Column
    private String photo;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "place")
    private Collection<ActiveWalk> activeWalks;

    @ManyToOne
    @JoinColumn(name = "id_address", referencedColumnName = "id_address", nullable = false)
    private Address address;

    @OneToMany(mappedBy = "place")
    private Collection<PlaceLike> likes;

    @OneToMany(mappedBy = "place")
    private Collection<PlaceRating> ratings;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "id_area", referencedColumnName = "id_area", nullable = false)
    private PlaceArea area;

    public Place(Long idPlace) {
        this.idPlace = idPlace;
    }

    public Place(Long idPlace, String name, String photo) {
        this.idPlace = idPlace;
        this.name = name;
        this.photo = photo;
    }

    public Place(Long idPlace, String name, String photo, Collection<ActiveWalk> activeWalks, Address address) {
        this.idPlace = idPlace;
        this.name = name;
        this.photo = photo;
        this.activeWalks = activeWalks;
        this.address = address;
    }

    public Long getIdPlace() {
        return idPlace;
    }

    public String getName() {
        return name;
    }

    public String getPhoto() {
        return photo;
    }

    public String getDescription() {
        return description;
    }

    public Address getAddress() {
        return address;
    }

    public Collection<PlaceLike> getLikes() {
        return likes;
    }

    public Collection<ActiveWalk> getActiveWalks() {
        return activeWalks;
    }

    public Collection<PlaceRating> getRatings() {
        return ratings;
    }

    public PlaceArea getArea() {
        return area;
    }
}

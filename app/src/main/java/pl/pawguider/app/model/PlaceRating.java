package pl.pawguider.app.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "places_ratings", schema = "public", catalog = "dogout")
public class PlaceRating {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_rating")
    private int idRating;

    @Column(name = "rating")
    private double rating;

    @ManyToOne
    @JoinColumn(name = "id_user", referencedColumnName = "id_user", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "id_place", referencedColumnName = "id_place", nullable = false)
    private Place place;

    public PlaceRating() {}

    public PlaceRating(int idRating) {
        this.idRating = idRating;
    }

    public PlaceRating(User user, Place place, double rating) {
        this.user = user;
        this.place = place;
        this.rating = rating;
    }

    public PlaceRating(int idRating, double rating, User user, Place place) {
        this.idRating = idRating;
        this.rating = rating;
        this.user = user;
        this.place = place;
    }

    public int getIdLike() {
        return idRating;
    }


    public User getUser() {
        return user;
    }

    public Place getPlace() {
        return place;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }
}

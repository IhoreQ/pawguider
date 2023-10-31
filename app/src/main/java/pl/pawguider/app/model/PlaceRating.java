package pl.pawguider.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
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

    public PlaceRating(User user, Place place, double rating) {
        this.user = user;
        this.place = place;
        this.rating = rating;
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

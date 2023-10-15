package pl.pawguider.app.model;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "places_likes", schema = "public", catalog = "dogout")
public class PlaceLike {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_like")
    private int idLike;

    @Column(name = "rating")
    private double rating;

    @ManyToOne
    @JoinColumn(name = "id_user", referencedColumnName = "id_user", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "id_place", referencedColumnName = "id_place", nullable = false)
    private Place place;

    public int getIdLike() {
        return idLike;
    }

    public double getRating() {
        return rating;
    }

    public User getUser() {
        return user;
    }

    public Place getPlace() {
        return place;
    }
}

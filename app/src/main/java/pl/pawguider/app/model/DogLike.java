package pl.pawguider.app.model;

import jakarta.persistence.*;

@Entity
@Table(name = "dogs_likes", schema = "public", catalog = "dogout")
public class DogLike {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_like")
    private int idLike;

    @ManyToOne
    @JoinColumn(name = "id_user", referencedColumnName = "id_user", nullable = false)
    private User user;
    @ManyToOne
    @JoinColumn(name = "id_dog", referencedColumnName = "id_dog", nullable = false)
    private Dog dog;

    public int getIdLike() {
        return idLike;
    }

    public User getUser() {
        return user;
    }

    public Dog getDog() {
        return dog;
    }

}

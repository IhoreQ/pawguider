package pl.pawguider.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "dogs_behaviors", schema = "public", catalog = "dogout")
public class DogsBehaviors {

    @ManyToOne
    @JoinColumn(name = "id_behavior", referencedColumnName = "id_behavior", nullable = false)
    private DogBehavior behavior;

    @ManyToOne
    @JoinColumn(name = "id_dog", referencedColumnName = "id_dog", nullable = false)
    private Dog dog;

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_dogs_behaviors")
    private Long idDogsBehaviors;

    public DogsBehaviors(DogBehavior behavior, Dog dog) {
        this.behavior = behavior;
        this.dog = dog;
    }

    public Long getIdDogsBehaviors() {
        return idDogsBehaviors;
    }

    public DogBehavior getBehavior() {
        return behavior;
    }

    public Dog getDog() {
        return dog;
    }

    @Override
    public String toString() {
        return "DogsBehaviors{" +
                "behavior=" + behavior +
                ", dog=" + dog +
                ", idDogsBehaviors=" + idDogsBehaviors +
                '}';
    }
}

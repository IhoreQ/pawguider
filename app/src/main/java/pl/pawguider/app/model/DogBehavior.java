package pl.pawguider.app.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.util.Collection;

@Entity
@Table(name = "dog_behaviors", schema = "public", catalog = "dogout")
public class DogBehavior {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_behavior")
    private Long idBehavior;

    @Column(name = "name")
    private String name;

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "behavior")
    private Collection<DogsBehaviors> dogsBehaviors;

    public DogBehavior() {
    }

    public DogBehavior(Long idBehavior) {
        this.idBehavior = idBehavior;
    }

    public DogBehavior(Long idBehavior, String name, Collection<DogsBehaviors> dogsBehaviors) {
        this.idBehavior = idBehavior;
        this.name = name;
        this.dogsBehaviors = dogsBehaviors;
    }

    public Long getIdBehavior() {
        return idBehavior;
    }

    public String getName() {
        return name;
    }

    public Collection<DogsBehaviors> getDogsBehaviors() {
        return dogsBehaviors;
    }

    @Override
    public String toString() {
        return "DogBehavior{" +
                "idBehavior=" + idBehavior +
                ", name='" + name + '\'' +
                ", dogsBehaviors=" + dogsBehaviors +
                '}';
    }
}

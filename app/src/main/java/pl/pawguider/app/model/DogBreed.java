package pl.pawguider.app.model;

import jakarta.persistence.*;

import java.util.Collection;

@Entity
@Table(name = "dogs_breed", schema = "public", catalog = "dogout")
public class DogBreed {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_dog_breed")
    private Long idDogBreed;

    @Column
    private String name;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "breed")
    private Collection<Dog> dogsByBreed;
    @ManyToOne
    @JoinColumn(name = "id_dog_size", referencedColumnName = "id_dog_size")
    private DogSize size;

    public DogBreed() {
    }

    public DogBreed(Long idDogBreed, String name) {
        this.idDogBreed = idDogBreed;
        this.name = name;
    }

    public DogBreed(Long idDogBreed, String name, Collection<Dog> dogsByBreed, DogSize size) {
        this.idDogBreed = idDogBreed;
        this.name = name;
        this.dogsByBreed = dogsByBreed;
        this.size = size;
    }

    public Long getIdDogBreed() {
        return idDogBreed;
    }

    public String getName() {
        return name;
    }

    public DogSize getSize() {
        return size;
    }

}

package pl.pawguider.app.model;

import jakarta.persistence.*;

import java.util.Collection;

@Entity
@Table(name = "dogs_sizes", schema = "public", catalog = "dogout")
public class DogSize {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_dog_size")
    private Long idDogSize;

    @Column
    private String name;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "size")
    private Collection<DogBreed> breedsBySize;

    public DogSize() {
    }

    public DogSize(Long idDogSize, String name, Collection<DogBreed> breedsBySize) {
        this.idDogSize = idDogSize;
        this.name = name;
        this.breedsBySize = breedsBySize;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}

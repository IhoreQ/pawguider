package pl.pawguider.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.util.Collection;

@NoArgsConstructor
@AllArgsConstructor
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
    private Collection<DogBreed> breeds;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}

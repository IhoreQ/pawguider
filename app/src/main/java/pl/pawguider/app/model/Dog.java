package pl.pawguider.app.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.util.Collection;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "dogs", schema = "public", catalog = "dogout")
public class Dog {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_dog")
    private Long idDog;

    @Column
    private String name;

    @Column
    private int age;

    @Column
    private String description;

    @Column
    private String photo;

    @ManyToOne
    @JoinColumn(name = "id_breed", referencedColumnName = "id_dog_breed", nullable = false)
    private DogBreed breed;
    @ManyToOne
    @JoinColumn(name = "id_user", referencedColumnName = "id_user", nullable = false)
    private User owner;

    @ManyToOne
    @JoinColumn(name = "id_gender", referencedColumnName = "id_gender", nullable = false)
    private Gender gender;

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "dog")
    private Collection<DogsBehaviors> behaviors;

    @JsonIgnore
    @OneToMany(mappedBy = "dog")
    private Collection<DogLike> likes;

    public Dog(String name, int age, Gender gender, String description, DogBreed breed, String photo, User user) {
        this.name = name;
        this.gender = gender;
        this.age = age;
        this.description = description;
        this.photo = photo;
        this.breed = breed;
        this.owner = user;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public Gender getGender() {
        return gender;
    }

    public String getDescription() {
        return description;
    }

    public String getPhoto() {
        return photo;
    }

    public DogBreed getBreed() {
        return breed;
    }

    public User getOwner() {
        return owner;
    }

    public Long getIdDog() {
        return idDog;
    }

    public Collection<DogsBehaviors> getBehaviors() {
        return behaviors;
    }

    public Collection<DogLike> getLikes() {
        return likes;
    }
}

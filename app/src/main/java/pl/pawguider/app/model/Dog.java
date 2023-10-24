package pl.pawguider.app.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.util.Collection;

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

    @Column
    private Boolean selected;

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
        this.selected = false;
    }

    public Dog(Long idDog, String name, int age, String description, String photo, DogBreed breed, Gender gender, User owner) {
        this.idDog = idDog;
        this.name = name;
        this.age = age;
        this.description = description;
        this.photo = photo;
        this.breed = breed;
        this.gender = gender;
        this.owner = owner;
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

    public Boolean getSelected() {
        return selected;
    }

    public void setSelected(Boolean selected) {
        this.selected = selected;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public void setBreed(DogBreed breed) {
        this.breed = breed;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public void setBehaviors(Collection<DogsBehaviors> behaviors) {
        this.behaviors = behaviors;
    }
}

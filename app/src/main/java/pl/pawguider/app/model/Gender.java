package pl.pawguider.app.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;

import java.util.Collection;

@Getter
@Entity
@Table(name = "genders", schema = "public", catalog = "dogout")
public class Gender {
    @JsonIgnore

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_gender")
    private Long idGender;

    @Column
    private String name;

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "gender")
    private Collection<UserDetails> usersDetails;

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "gender")
    private Collection<Dog> dogs;

    public Gender() {
    }

    public Gender(String name) {
        this.name = name;
    }

    public Gender(Long id) {
        this.idGender = id;
    }

    public Gender(Long idGender, String name, Collection<UserDetails> usersDetails) {
        this.idGender = idGender;
        this.name = name;
        this.usersDetails = usersDetails;
    }

    public String getName() {
        return name;
    }
}

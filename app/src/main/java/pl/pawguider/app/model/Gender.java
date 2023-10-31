package pl.pawguider.app.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.util.Collection;

@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "genders", schema = "public", catalog = "dogout")
public class Gender {

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

    public Gender(Long id) {
        this.idGender = id;
    }

    public Gender(Long idGender, String name) {
        this.idGender = idGender;
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public Long getIdGender() {
        return idGender;
    }
}

package pl.pawguider.app.model;

import jakarta.persistence.*;


@Entity
@Table(name = "new_places_ideas", schema = "public", catalog = "dogout")
public class NewPlaceIdea {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_new_place_idea")
    private Long idNewPlaceIdea;

    @Column
    private String city;

    @Column
    private String name;

    @Column
    private String street;

    @ManyToOne
    @JoinColumn(name = "id_user", referencedColumnName = "id_user", nullable = false)
    private User user;

    public NewPlaceIdea() {
    }

    public NewPlaceIdea(Long idNewPlaceIdea, String city, String name, String street, User user) {
        this.idNewPlaceIdea = idNewPlaceIdea;
        this.city = city;
        this.name = name;
        this.street = street;
        this.user = user;
    }
}

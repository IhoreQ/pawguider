package pl.pawguider.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "places_areas", schema = "public", catalog = "dogout")
public class PlaceArea {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_area")
    private int idArea;

    @OneToOne(mappedBy = "area")
    Place place;

    @Column(name = "polygon", columnDefinition = "polygon")
    private String polygon;

    public String getPolygon() {
        return polygon;
    }
}

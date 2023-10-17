package pl.pawguider.app.model;

import jakarta.persistence.*;

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

    public int getIdArea() {
        return idArea;
    }

    public void setIdArea(int idArea) {
        this.idArea = idArea;
    }

    public String getPolygon() {
        return polygon;
    }

    public void setPolygon(String polygon) {
        this.polygon = polygon;
    }

}

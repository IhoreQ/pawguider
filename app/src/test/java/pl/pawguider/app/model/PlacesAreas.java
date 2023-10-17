package pl.pawguider.app.model;

import jakarta.persistence.*;

import java.awt.*;

@Entity
@Table(name = "places_areas", schema = "public", catalog = "dogout")
public class PlacesAreas {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_area")
    private int idArea;

    @Column(name = "polygon")
    private Polygon polygon;

    public int getIdArea() {
        return idArea;
    }

    public void setIdArea(int idArea) {
        this.idArea = idArea;
    }

    public Object getPolygon() {
        return polygon;
    }

    public void setPolygon(Polygon polygon) {
        this.polygon = polygon;
    }

}

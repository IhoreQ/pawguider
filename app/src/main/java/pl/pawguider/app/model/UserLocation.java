package pl.pawguider.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.time.LocalTime;

@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "users_locations", schema = "public", catalog = "dogout")
public class UserLocation {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_user_location")
    private int idUserLocation;

    @Column(name = "latitude")
    private double latitude;

    @Column(name = "longitude")
    private double longitude;

    @Column(name = "last_update")
    private LocalTime lastUpdate;

    @OneToOne(mappedBy = "location")
    private User user;

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public LocalTime getLastUpdate() {
        return lastUpdate;
    }

    public void setLastUpdate(LocalTime lastUpdate) {
        this.lastUpdate = lastUpdate;
    }

    public UserLocation(double latitude, double longitude) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.lastUpdate = LocalTime.now();
    }
}

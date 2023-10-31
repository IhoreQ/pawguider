package pl.pawguider.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.time.LocalTime;

@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "active_walks", schema = "public", catalog = "dogout")
public class ActiveWalk {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_active_walk")
    private Long idActiveWalk;

    @Column(name = "started_at", nullable = false)
    private LocalTime startedAt;

    @ManyToOne
    @JoinColumn(name = "id_place", referencedColumnName = "id_place", nullable = false)
    private Place place;
    @ManyToOne
    @JoinColumn(name = "id_user", referencedColumnName = "id_user", nullable = false)
    private User user;

    public ActiveWalk(LocalTime startedAt, Place place, User user) {
        this.startedAt = startedAt;
        this.place = place;
        this.user = user;
    }

    public Long getIdActiveWalk() {
        return idActiveWalk;
    }

    public LocalTime getStartedAt() {
        return startedAt;
    }

    public Place getPlace() {
        return place;
    }

    public User getUser() {
        return user;
    }

    public void setPlace(Place place) {
        this.place = place;
    }
}

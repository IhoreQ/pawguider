package pl.pawguider.app.model;

import jakarta.persistence.*;

import java.time.LocalTime;

@Entity
@Table(name = "active_walks", schema = "public", catalog = "dogout")
public class ActiveWalk {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_active_walk")
    private Long idActiveWalk;

    @Column(name = "time_of_walk", nullable = false)
    private String timeOfWalk;

    @Column(name = "started_at", nullable = false)
    private LocalTime startedAt;

    @ManyToOne
    @JoinColumn(name = "id_place", referencedColumnName = "id_place", nullable = false)
    private Place place;
    @ManyToOne
    @JoinColumn(name = "id_user", referencedColumnName = "id_user", nullable = false)
    private User user;

    public ActiveWalk() {
    }

    public ActiveWalk(String timeOfWalk, LocalTime startedAt, Place place, User user) {
        this.timeOfWalk = timeOfWalk;
        this.startedAt = startedAt;
        this.place = place;
        this.user = user;
    }

    public ActiveWalk(Long idActiveWalk, String timeOfWalk, LocalTime startedAt, Place place, User user) {
        this.idActiveWalk = idActiveWalk;
        this.timeOfWalk = timeOfWalk;
        this.startedAt = startedAt;
        this.place = place;
        this.user = user;
    }

    public Long getIdActiveWalk() {
        return idActiveWalk;
    }

    public String getTimeOfWalk() {
        return timeOfWalk;
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


}

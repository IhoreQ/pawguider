package pl.pawguider.app.model;

import jakarta.persistence.*;

import java.util.Collection;

@Entity
@Table(name = "roles", schema = "public", catalog = "dogout")
public class Role {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_role")
    private Long idRole;

    @Column
    private String role;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "role")
    private Collection<User> usersByRole;

    public Role() {
    }

    public Role(Long idRole) {
        this.idRole = idRole;
    }

    public Role(Long idRole, String role, Collection<User> usersByRole) {
        this.idRole = idRole;
        this.role = role;
        this.usersByRole = usersByRole;
    }

    public String getRole() {
        return role;
    }

}

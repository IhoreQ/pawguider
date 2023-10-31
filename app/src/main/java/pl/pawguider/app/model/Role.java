package pl.pawguider.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.util.Collection;

@NoArgsConstructor
@AllArgsConstructor
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

    public Role(Long idRole) {
        this.idRole = idRole;
    }

    public String getRole() {
        return role;
    }

}

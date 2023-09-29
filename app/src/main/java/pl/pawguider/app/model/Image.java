package pl.pawguider.app.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Image {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_image")
    private Long idImage;

    @Column(unique = true)
    private String name;

    @Column
    private String type;

    @Column(unique = false, nullable = false, length = 100000)
    private byte[] image;

    public Image(String name, String type, byte[] image) {
        this.name = name;
        this.type = type;
        this.image = image;
    }

    public byte[] getImage() {
        return image;
    }

    public String getType() {
        return type;
    }
}

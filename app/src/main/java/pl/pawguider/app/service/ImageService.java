package pl.pawguider.app.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import pl.pawguider.app.model.Image;
import pl.pawguider.app.repository.ImageRepository;
import pl.pawguider.app.util.ImageUtil;

import java.io.IOException;
import java.util.Optional;
import java.util.UUID;

@Service
public class ImageService {

    ImageRepository imageRepository;

    public ImageService(ImageRepository imageRepository) {
        this.imageRepository = imageRepository;
    }

    public String uploadImage(MultipartFile file) throws IOException {

        int nameLength = 10;
        String filename = UUID.randomUUID()
                .toString()
                .substring(0, nameLength);

        imageRepository.save(Image.builder()
                .name(filename)
                .type(file.getContentType())
                .image(ImageUtil.compressImage(file.getBytes())).build());

        return filename;
    }

    public Image downloadImage(String fileName) {
        Optional<Image> image = imageRepository.findByName(fileName);
        return image.orElse(null);
    }

    public boolean deleteImage(String imageName) {
        Optional<Image> foundImage = imageRepository.findByName(imageName);
        if (foundImage.isPresent()) {
            imageRepository.delete(foundImage.get());
            return true;
        }
        return false;
    }

}
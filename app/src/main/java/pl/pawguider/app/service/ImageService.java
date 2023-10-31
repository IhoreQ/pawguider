package pl.pawguider.app.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import pl.pawguider.app.exception.image.ImageNotFoundException;
import pl.pawguider.app.model.Image;
import pl.pawguider.app.repository.ImageRepository;
import pl.pawguider.app.util.Constants;
import pl.pawguider.app.util.ImageUtil;

import java.io.IOException;
import java.util.UUID;

@Service
public class ImageService {

    ImageRepository imageRepository;

    public ImageService(ImageRepository imageRepository) {
        this.imageRepository = imageRepository;
    }

    public Image getImageByName(String name) {
        return imageRepository.findByName(name).orElseThrow(() -> new ImageNotFoundException(name));
    }

    public String uploadImage(MultipartFile file) throws IOException {

        String filename = UUID.randomUUID()
                .toString()
                .substring(0, Constants.IMAGE_NAME_LENGTH);

        imageRepository.save(Image.builder()
                .name(filename)
                .type(file.getContentType())
                .image(ImageUtil.compressImage(file.getBytes())).build());

        return filename;
    }

    public Image downloadImage(String fileName) {
        return getImageByName(fileName);
    }

    public void deleteImage(String imageName) {
        Image image = getImageByName(imageName);
        imageRepository.delete(image);
    }

    public boolean isValidContentType(String contentType) {
        return contentType.equals("image/png") || contentType.equals("image/jpeg");
    }
}
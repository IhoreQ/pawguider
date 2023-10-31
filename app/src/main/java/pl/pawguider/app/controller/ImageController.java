package pl.pawguider.app.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import pl.pawguider.app.exception.image.EmptyFileRequestException;
import pl.pawguider.app.exception.image.WrongFileTypeException;
import pl.pawguider.app.model.Image;
import pl.pawguider.app.service.ImageService;
import pl.pawguider.app.util.ImageUtil;

import java.io.IOException;

@RestController
@RequestMapping("/api/v1/image")
public class ImageController {

    private final ImageService imageService;

    public ImageController(ImageService imageService) {
        this.imageService = imageService;
    }

    @PostMapping
    public ResponseEntity<?> uploadImage(@RequestParam("image") MultipartFile file) throws IOException {
        String contentType = file.getContentType();

        if (contentType == null)
            throw new EmptyFileRequestException();

        if (!imageService.isValidContentType(contentType))
            throw new WrongFileTypeException(contentType);

        String response = imageService.uploadImage(file);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{name}")
    public ResponseEntity<byte[]> downloadImage(@PathVariable("name") String name) {
        Image image = imageService.downloadImage(name);

        return ResponseEntity.status(HttpStatus.OK)
                        .contentType(MediaType.valueOf(image.getType()))
                        .body(ImageUtil.decompressImage(image.getImage()));
    }

    @DeleteMapping("/{name}")
    public ResponseEntity<?> deleteImage(@PathVariable("name") String name) {
        imageService.deleteImage(name);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}

package pl.pawguider.app.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
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
    public ResponseEntity<?> uploadImage(@RequestParam("image") MultipartFile file) {
        try {
            String response = imageService.uploadImage(file);
            return ResponseEntity.ok(response);
        } catch (IOException e) {
            return ResponseEntity.ok(false);
        }
    }

    @GetMapping("/{name}")
    public ResponseEntity<byte[]> downloadImage(@PathVariable("name") String name) {
        Image image = imageService.downloadImage(name);

        return image == null ?
                new ResponseEntity<>(HttpStatus.NOT_FOUND) :
                ResponseEntity.status(HttpStatus.OK)
                        .contentType(MediaType.valueOf(image.getType()))
                        .body(ImageUtil.decompressImage(image.getImage()));
    }
}

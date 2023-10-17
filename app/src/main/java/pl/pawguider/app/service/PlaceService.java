package pl.pawguider.app.service;

import org.springframework.stereotype.Service;
import pl.pawguider.app.controller.dto.response.PlaceAreaResponse;
import pl.pawguider.app.model.*;
import pl.pawguider.app.repository.CityRepository;
import pl.pawguider.app.repository.PlaceLikeRepository;
import pl.pawguider.app.repository.PlaceRatingRepository;
import pl.pawguider.app.repository.PlaceRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class PlaceService {

    private final PlaceRepository placeRepository;
    private final CityRepository cityRepository;
    private final PlaceLikeRepository placeLikeRepository;
    private final PlaceRatingRepository placeRatingRepository;

    public PlaceService(PlaceRepository placeRepository, CityRepository cityRepository, PlaceLikeRepository placeLikeRepository, PlaceRatingRepository placeRatingRepository) {
        this.placeRepository = placeRepository;
        this.cityRepository = cityRepository;
        this.placeLikeRepository = placeLikeRepository;
        this.placeRatingRepository = placeRatingRepository;
    }

    public List<Place> getAllPlaces() {
        return placeRepository.findAllPlaces();
    }

    public Place getPlaceById(Long id) {
        return placeRepository.findById(id).orElse(null);
    }

    public List<Place> getPlacesByCityId(Long cityId) {
        Optional<City> foundCity = cityRepository.findById(cityId);

        if (foundCity.isPresent()) {
            City city = foundCity.get();
            return placeRepository.findByCity(city);
        }
        return new ArrayList<>();
    }

    public void addLike(User user, Place place) {
        PlaceLike like = new PlaceLike(user, place);
        placeLikeRepository.save(like);
    }

    public void deleteLike(User user, Place place) {
        PlaceLike like = placeLikeRepository.findByUserIdAndPlaceId(user.getIdUser(), place.getIdPlace());
        placeLikeRepository.delete(like);
    }

    public void addRating(User user, Place place, double rating) {
        PlaceRating placeRating = new PlaceRating(user, place, rating);
        placeRatingRepository.save(placeRating);
    }

    public void updateRating(User user, Place place, double rating) {
        PlaceRating placeRating = placeRatingRepository.findByUserIdAndPlaceId(user.getIdUser(), place.getIdPlace());
        placeRating.setRating(rating);
        placeRatingRepository.save(placeRating);
    }

    public List<Place> getUserLikedPlaces(User user) {
        List<PlaceLike> likes = placeLikeRepository.findByIdUser(user.getIdUser());

        return likes.stream().map(PlaceLike::getPlace).toList();
    }

    public boolean isPlaceAlreadyLiked(User user, Place place) {
        return place.getLikes()
                .stream()
                .anyMatch(like -> like.getUser().getIdUser().equals(user.getIdUser()));
    }

    public boolean isPlaceAlreadyRated(User user, Place place) {
        return place.getRatings()
                .stream()
                .anyMatch(rating -> rating.getUser().getIdUser().equals(user.getIdUser()));
    }
}

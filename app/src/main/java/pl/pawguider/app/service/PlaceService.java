package pl.pawguider.app.service;

import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.Point;
import org.locationtech.jts.geom.Polygon;
import org.locationtech.jts.io.ParseException;
import org.locationtech.jts.io.WKTReader;
import org.springframework.stereotype.Service;
import pl.pawguider.app.exception.place.like.PlaceAlreadyLikedException;
import pl.pawguider.app.exception.place.rating.PlaceAlreadyRatedException;
import pl.pawguider.app.exception.place.PlaceNotFoundException;
import pl.pawguider.app.exception.place.like.PlaceNotLikedException;
import pl.pawguider.app.exception.place.rating.PlaceRatingNotFoundException;
import pl.pawguider.app.model.*;
import pl.pawguider.app.repository.PlaceLikeRepository;
import pl.pawguider.app.repository.PlaceRatingRepository;
import pl.pawguider.app.repository.PlaceRepository;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Service
public class PlaceService {

    private final PlaceRepository placeRepository;
    private final CityService cityService;
    private final PlaceLikeRepository placeLikeRepository;
    private final PlaceRatingRepository placeRatingRepository;

    public PlaceService(PlaceRepository placeRepository, CityService cityService, PlaceLikeRepository placeLikeRepository, PlaceRatingRepository placeRatingRepository) {
        this.placeRepository = placeRepository;
        this.cityService = cityService;
        this.placeLikeRepository = placeLikeRepository;
        this.placeRatingRepository = placeRatingRepository;
    }

    public List<Place> getAllPlaces() {
        return placeRepository.findAllPlaces();
    }

    public Place getPlaceById(Long id) {
        return placeRepository.findById(id).orElseThrow(() -> new PlaceNotFoundException(id));
    }

    public List<Place> getPlacesByCityId(Long cityId) {
        City city = cityService.getCityById(cityId);
        return placeRepository.findAllByAddress_City(city);
    }

    public void addLike(User user, Place place) {
        if (isPlaceAlreadyLiked(user, place))
            throw new PlaceAlreadyLikedException(user.getIdUser(), place.getIdPlace());

        PlaceLike like = new PlaceLike(user, place);
        placeLikeRepository.save(like);
    }

    public void deleteLike(User user, Place place) {
        if (!isPlaceAlreadyLiked(user, place))
            throw new PlaceNotLikedException(user.getIdUser(), place.getIdPlace());

        PlaceLike like = placeLikeRepository.findByUserIdAndPlaceId(user.getIdUser(), place.getIdPlace());
        placeLikeRepository.delete(like);
    }

    public void addRating(User user, Place place, double rating) {
        if (isPlaceAlreadyRated(user, place))
            throw new PlaceAlreadyRatedException(user.getIdUser(), place.getIdPlace());

        PlaceRating placeRating = new PlaceRating(user, place, rating);
        placeRatingRepository.save(placeRating);
    }

    public void updateRating(User user, Place place, double rating) {
        PlaceRating placeRating = placeRatingRepository.findByUserIdAndPlaceId(user.getIdUser(), place.getIdPlace())
                .orElseThrow(() -> new PlaceRatingNotFoundException(user.getIdUser(), place.getIdPlace()));

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

    public boolean isUserInPlaceArea(double latitude, double longitude, Long placeId) {
        Place place = getPlaceById(placeId);
        return isPointInPolygon(latitude, longitude, place.getArea().getPolygon(), placeId);
    }

    public Long findPlaceBasedOnUserLocationAndHisCity(User user, double latitude, double longitude) {
        List<Place> places = placeRepository.findAllByAddress_City(user.getDetails().getCity());

        Optional<Place> foundPlace = places.stream()
                .filter(place -> isPointInPolygon(latitude, longitude, place.getArea().getPolygon(), place.getIdPlace()))
                .findFirst();

        return foundPlace.map(Place::getIdPlace).orElse(null);
    }

    private boolean isPointInPolygon(double latitude, double longitude, String rawAreaString, Long placeId) {
        // WKTReader needs string in format POLYGON((a b, c d, e f,...)) so area from database needs to be converted
        String rawAreaWithoutCommasInside = removeInnerCommas(rawAreaString);
        String rawAreaWithoutParentheses = removeParentheses(rawAreaWithoutCommasInside);
        String firstPoint = getFirstPoint(rawAreaWithoutParentheses);
        String completePolygon = rawAreaWithoutParentheses + ", " + firstPoint;

        GeometryFactory geometryFactory = new GeometryFactory();
        WKTReader reader = new WKTReader(geometryFactory);
        Polygon polygon;

        try {
            polygon = (Polygon) reader.read("POLYGON((" + completePolygon + "))");
        } catch (ParseException e) {
            System.err.println("An error occurred while parsing the place area with place id: " + placeId);
            return false;
        }

        Point point = geometryFactory.createPoint(new Coordinate(latitude, longitude));

        return polygon.contains(point);
    }

    private String removeInnerCommas(String input) {
        return input.replaceAll("\\(([^,]+),([^)]+)\\)", "($1 $2)");
    }

    private String removeParentheses(String input) {
        return input.replaceAll("[()]", "");
    }

    private String getFirstPoint(String input) {
        Optional<String> firstPointOptional = Arrays.stream(input.split(",")).findFirst();
        return firstPointOptional.orElse("");
    }
}

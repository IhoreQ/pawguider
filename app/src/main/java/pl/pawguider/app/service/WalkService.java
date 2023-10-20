package pl.pawguider.app.service;

import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.Point;
import org.locationtech.jts.geom.Polygon;
import org.locationtech.jts.io.ParseException;
import org.locationtech.jts.io.WKTReader;
import org.springframework.stereotype.Service;
import pl.pawguider.app.model.ActiveWalk;
import pl.pawguider.app.model.Dog;
import pl.pawguider.app.model.Place;
import pl.pawguider.app.model.User;
import pl.pawguider.app.repository.DogRepository;
import pl.pawguider.app.repository.PlaceRepository;
import pl.pawguider.app.repository.UserRepository;
import pl.pawguider.app.repository.WalkRepository;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class WalkService {

    private final WalkRepository walkRepository;
    private final UserRepository userRepository;
    private final DogRepository dogRepository;
    private final PlaceRepository placeRepository;


    public WalkService(WalkRepository walkRepository, UserRepository userRepository, DogRepository dogRepository, PlaceRepository placeRepository) {
        this.walkRepository = walkRepository;
        this.userRepository = userRepository;
        this.dogRepository = dogRepository;
        this.placeRepository = placeRepository;
    }


    public ActiveWalk getActiveWalkByUser(User user) {
        Optional<ActiveWalk> walk = user.getActiveWalks().stream().findFirst();
        ActiveWalk activeWalk;

        if (walk.isEmpty())
            return null;

        activeWalk = walk.get();

        return activeWalk;
    }

    public void deleteWalk(ActiveWalk activeWalk) {
        walkRepository.delete(activeWalk);
    }

    public void saveWalk(ActiveWalk activeWalk) {
        walkRepository.save(activeWalk);
    }

    public List<Dog> getDogsFromPlace(Long placeId) {
        Place place = new Place(placeId);

        List<ActiveWalk> activeWalks = walkRepository.findAllByPlace(place);

        return activeWalks.stream()
                .flatMap(walk -> walk.getUser().getDogs().stream())
                .filter(Dog::getSelected).toList();
    }

    public ActiveWalk addWalk(User user, Long placeId) {
        Optional<Place> foundPlace = placeRepository.findById(placeId);
        if (foundPlace.isPresent()) {
            LocalTime now = LocalTime.now();
            Place place = foundPlace.get();
            ActiveWalk activeWalk = new ActiveWalk(now, place, user);
            return walkRepository.save(activeWalk);
        }
        return null;
    }

    public boolean userHasWalk(User user) {
        return walkRepository.findByUser(user).isPresent();
    }
}

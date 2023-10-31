package pl.pawguider.app.service;

import org.springframework.stereotype.Service;
import pl.pawguider.app.exception.walk.WalkAlreadyExistsException;
import pl.pawguider.app.model.ActiveWalk;
import pl.pawguider.app.model.Dog;
import pl.pawguider.app.model.Place;
import pl.pawguider.app.model.User;
import pl.pawguider.app.repository.WalkRepository;

import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@Service
public class WalkService {

    private final WalkRepository walkRepository;
    private final PlaceService placeService;

    public WalkService(WalkRepository walkRepository, PlaceService placeService) {
        this.walkRepository = walkRepository;
        this.placeService = placeService;
    }

    public ActiveWalk getActiveWalkByUser(User user) {
        Optional<ActiveWalk> walk = user.getActiveWalks().stream().findFirst();
        return walk.orElse(null);
    }

    public void deleteWalk(ActiveWalk activeWalk) {
        walkRepository.delete(activeWalk);
    }

    public List<Dog> getDogsFromPlace(Long placeId) {
        Place place = new Place(placeId);

        List<ActiveWalk> activeWalks = walkRepository.findAllByPlace(place);

        return activeWalks.stream()
                .flatMap(walk -> walk.getUser().getDogs().stream())
                .filter(Dog::getSelected).toList();
    }

    public ActiveWalk addWalk(User user, Long placeId) {
        if (userHasWalk(user))
            throw new WalkAlreadyExistsException(user.getIdUser());

        Place place = placeService.getPlaceById(placeId);

        LocalTime now = LocalTime.now();
        ActiveWalk activeWalk = new ActiveWalk(now, place, user);

        return walkRepository.save(activeWalk);
    }

    public boolean userHasWalk(User user) {
        return walkRepository.findByUser(user).isPresent();
    }

    public List<ActiveWalk> getAllWalks() {
        return walkRepository.findAll();
    }
}

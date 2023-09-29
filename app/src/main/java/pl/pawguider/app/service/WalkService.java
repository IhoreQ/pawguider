package pl.pawguider.app.service;

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
import java.util.List;
import java.util.Optional;

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

        if (checkIfTimeExceeded(activeWalk)) {
            finishWalk(activeWalk);
            return null;
        }

        return activeWalk;
    }

    public void finishWalk(ActiveWalk activeWalk) {
        walkRepository.delete(activeWalk);
    }

    private boolean checkIfTimeExceeded(ActiveWalk activeWalk) {
        LocalTime now = LocalTime.now();
        LocalTime startedAt = activeWalk.getStartedAt();
        LocalTime duration = LocalTime.parse(activeWalk.getTimeOfWalk());

        LocalTime endTime = startedAt.plusHours(duration.getHour())
                .plusMinutes(duration.getMinute())
                .plusSeconds(duration.getSecond());

        return now.isAfter(endTime) || now.isBefore(startedAt);
    }

    public LocalTime getLeftTime(ActiveWalk activeWalk) {
        LocalTime now = LocalTime.now();
        LocalTime startedAt = activeWalk.getStartedAt();
        LocalTime duration = LocalTime.parse(activeWalk.getTimeOfWalk());

        LocalTime difference = now.minusSeconds(startedAt.getSecond()).minusMinutes(startedAt.getMinute()).minusHours(startedAt.getHour());

        return duration.minusSeconds(difference.getSecond()).minusMinutes(difference.getMinute()).minusHours(difference.getHour());
    }

    public void saveWalk(ActiveWalk activeWalk) {
        walkRepository.save(activeWalk);
    }

    public List<Dog> getDogsFromPlace(Long placeId) {
        Place place = new Place(placeId);

        List<ActiveWalk> activeWalks = walkRepository.findAllByPlace(place);

        List<ActiveWalk> activeWalksAfterTheGreatPurge = new ArrayList<>();

        for (ActiveWalk activeWalk : activeWalks) {
            if (checkIfTimeExceeded(activeWalk))
                finishWalk(activeWalk);
            else
                activeWalksAfterTheGreatPurge.add(activeWalk);
        }

        return activeWalksAfterTheGreatPurge.stream().map(walk -> walk.getUser()
                        .getDogs()
                        .stream()
                        .findFirst()
                        .get())
                .toList();
    }
}

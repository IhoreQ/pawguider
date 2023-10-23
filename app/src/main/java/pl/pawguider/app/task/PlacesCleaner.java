package pl.pawguider.app.task;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import pl.pawguider.app.model.ActiveWalk;
import pl.pawguider.app.model.UserLocation;
import pl.pawguider.app.service.PlaceService;
import pl.pawguider.app.service.WalkService;

import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Component
@EnableScheduling
public class PlacesCleaner {

    private final WalkService walkService;
    private final PlaceService placeService;

    public PlacesCleaner(WalkService walkService, PlaceService placeService) {
        this.walkService = walkService;
        this.placeService = placeService;
    }

    @Scheduled(cron = "0 0/15 * * * ?")
    public void cleanPlaces() {
        List<ActiveWalk> walks = walkService.getAllWalks();
        for (ActiveWalk walk : walks) {
            removeIfUserNotInTheSamePlace(walk);
            removeIfLastUpdateTimeExceeded(walk);
        }
    }

    private void removeIfUserNotInTheSamePlace(ActiveWalk walk) {
        UserLocation location = walk.getUser().getLocation();
        boolean inPlaceArea = placeService.isUserInPlaceArea(location.getLatitude(), location.getLongitude(), walk.getPlace().getIdPlace());
        if (!inPlaceArea) {
            walkService.deleteWalk(walk);
        }
    }

    private void removeIfLastUpdateTimeExceeded(ActiveWalk walk) {
        LocalTime lastUpdate = walk.getUser().getLocation().getLastUpdate();
        LocalTime currentTime = LocalTime.now();

        long minutesDifference = lastUpdate.until(currentTime, ChronoUnit.MINUTES);

        if (minutesDifference >= 10) {
            walkService.deleteWalk(walk);
        }
    }
}

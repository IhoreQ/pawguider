package pl.pawguider.app.controller.dto.response;

import pl.pawguider.app.model.ActiveWalk;
import pl.pawguider.app.model.Address;
import pl.pawguider.app.model.Place;

import java.time.format.DateTimeFormatter;

public record UserActiveWalkResponse(Long walkId,
                                     Long placeId,
                                     String placeName,
                                     String placePhoto,
                                     String placeStreet,
                                     String houseNumber,
                                     String startTime) {

    public static UserActiveWalkResponse getResponse(ActiveWalk activeWalk) {
        Place place = activeWalk.getPlace();
        Address address = place.getAddress();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        String startTime = activeWalk.getStartedAt().format(formatter);

        return new UserActiveWalkResponse(activeWalk.getIdActiveWalk(), place.getIdPlace(), place.getName(), place.getPhoto(), address.getStreet(), address.getHouseNumber(), startTime);
    }
}

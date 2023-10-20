package pl.pawguider.app.controller.dto.response;

import com.fasterxml.jackson.annotation.JsonCreator;
import pl.pawguider.app.model.ActiveWalk;
import pl.pawguider.app.model.Address;
import pl.pawguider.app.model.Place;

import java.time.LocalTime;

public record UserActiveWalkResponse(Long walkId,
                                     Long placeId,
                                     String placeName,
                                     String placePhoto,
                                     String placeStreet,
                                     String houseNumber) {

    @JsonCreator
    public UserActiveWalkResponse {
    }

    public static UserActiveWalkResponse getResponse(ActiveWalk activeWalk) {
        Place place = activeWalk.getPlace();
        Address address = place.getAddress();
        return new UserActiveWalkResponse(activeWalk.getIdActiveWalk(), place.getIdPlace(), place.getName(), place.getPhoto(), address.getStreet(), address.getHouseNumber());
    }
}

package pl.pawguider.app.service;

import org.junit.jupiter.api.Test;
import org.springframework.cglib.core.Local;

import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalTime;
import java.util.Date;

public class WalkServiceTest {

    @Test
    void checkIfTimeExceededTest() throws ParseException {
        LocalTime now = LocalTime.now();
        String durationString = "01:00:00";
        LocalTime duration = LocalTime.parse(durationString);
        LocalTime endTime = now.plusHours(duration.getHour())
                                .plusMinutes(duration.getMinute())
                                .plusSeconds(duration.getSecond());


        System.out.println("Now: " + now);
        System.out.println("Duration: " + duration);
        System.out.println("endTime: " + endTime);

    }

    @Test
    void getLeftTimeTest() {
        LocalTime now = LocalTime.now();
        String durationString = "01:00:00";
        LocalTime duration = LocalTime.parse(durationString);
        String startedAtDuration = "13:45:12";
        LocalTime startedAt = LocalTime.parse(startedAtDuration);

        LocalTime difference = now.minusSeconds(startedAt.getSecond()).minusMinutes(startedAt.getMinute()).minusHours(startedAt.getHour());
        LocalTime result = duration.minusSeconds(difference.getSecond()).minusMinutes(difference.getMinute()).minusHours(difference.getHour());
    }
}



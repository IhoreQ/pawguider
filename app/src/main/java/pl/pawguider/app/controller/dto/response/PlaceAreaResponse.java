package pl.pawguider.app.controller.dto.response;

import pl.pawguider.app.model.Place;

import java.awt.geom.Point2D;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public record PlaceAreaResponse(Long id,
                                List<Point2D.Double> points) {

    public static PlaceAreaResponse getResponse(Place place) {
        List<Point2D.Double> points = new ArrayList<>();
        String polygon = place.getArea().getPolygon();
        Pattern pattern = Pattern.compile("\\((-?\\d+\\.\\d+),(-?\\d+\\.\\d+)\\)");
        polygon = polygon.replaceAll(",\\s+", ",");
        Matcher matcher = pattern.matcher(polygon);

        while (matcher.find()) {
            Point2D.Double point = new Point2D.Double(Double.parseDouble(matcher.group(1)), Double.parseDouble(matcher.group(2)));
            points.add(point);
        }

        return new PlaceAreaResponse(place.getIdPlace(), points);
    }
}

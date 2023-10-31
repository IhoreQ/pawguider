package pl.pawguider.app.service;

import org.junit.jupiter.api.Test;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.Point;
import org.locationtech.jts.geom.Polygon;
import org.locationtech.jts.io.WKTReader;
import org.springframework.cglib.core.Local;

import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalTime;
import java.util.Arrays;
import java.util.Date;
import java.util.Optional;

public class WalkServiceTest {
    @Test
    void isPointInPolygon() throws org.locationtech.jts.io.ParseException {
        String area = "(50.09305358981643,19.975102797167985),(50.09324330228522,19.974571719787775),(50.09355475604932,19.974849328418713),(50.093738013809016,19.97430685164863),(50.09399225052792,19.974518075606653),(50.09403006862937,19.97550872990501),(50.09390402599063,19.975553656905785),(50.09377110011716,19.975565056294183),(50.09363602296168,19.975540245861247),(50.09350266616048,19.975465814561705)";
        String withoutCommasInside = removeInnerCommas(area);
        String withoutParentheses = removeParentheses(withoutCommasInside);
        String firstPoint = getFirstPoint(withoutParentheses);
        String completePolygon = withoutParentheses + ", " + firstPoint;

        GeometryFactory geometryFactory = new GeometryFactory();
        WKTReader reader = new WKTReader(geometryFactory);
        Polygon polygon = (Polygon) reader.read("POLYGON((" + completePolygon + "))");
        Point point = geometryFactory.createPoint(new Coordinate(50.089266877821935, 19.920589884085526));

        System.out.println(polygon.contains(point));
    }

    private static String removeInnerCommas(String input) {
        return input.replaceAll("\\(([^,]+),([^)]+)\\)", "($1 $2)");
    }

    private static String removeParentheses(String input) {
        return input.replaceAll("[()]", "");
    }

    private static String getFirstPoint(String input) {
        Optional<String> firstPointOptional = Arrays.stream(input.split(",")).findFirst();
        return firstPointOptional.orElse("");
    }
}



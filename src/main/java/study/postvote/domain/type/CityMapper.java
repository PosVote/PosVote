package study.postvote.domain.type;

public class CityMapper {
    public static City mapStringToCity(String cityString) {
        for (City city : City.values()) {
            if (city.getDescription().equals(cityString)) {
                return city;
            }
        }
        throw new IllegalArgumentException("Invalid city string: " + cityString);
    }
}
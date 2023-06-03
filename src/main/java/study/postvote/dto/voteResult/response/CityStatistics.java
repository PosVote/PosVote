package study.postvote.dto.voteResult.response;

import study.postvote.domain.type.City;

public class CityStatistics {
    private City city;
    private int count;
    private long option_id;
    private String label;

    public CityStatistics(City city,  long option_id, String label,int count) {
        this.city = city;
        this.count = count;
        this.option_id = option_id;
        this.label = label;
    }

    public City getCity() {
        return city;
    }

    public int getCount() {
        return count;
    }

    public long getOption_id() {
        return option_id;
    }

    public String getLabel() {
        return label;
    }
}

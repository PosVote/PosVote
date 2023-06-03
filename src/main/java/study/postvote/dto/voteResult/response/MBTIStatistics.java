package study.postvote.dto.voteResult.response;

import study.postvote.domain.type.Mbti;

public class MBTIStatistics {
    private Mbti mbti;
    private int count;
    private long option_id;
    private String label;

    public Mbti getMbti() {
        return mbti;
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

    public MBTIStatistics(Mbti mbti,  long option_id, String label,int count) {
        this.mbti = mbti;
        this.count = count;
        this.option_id = option_id;
        this.label = label;
    }
}

package study.postvote.dto.voteResult.response;

public class VoteResult {
    long option_id;
    String label;
    int count;

    public VoteResult(long option_id, String label, int count) {
        this.option_id = option_id;
        this.label = label;
        this.count = count;
    }

    public long getOption_id() {
        return option_id;
    }

    public String getLabel() {
        return label;
    }

    public int getCount() {
        return count;
    }
}

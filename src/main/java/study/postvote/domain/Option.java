package study.postvote.domain;

public class Option {
    private Long optionId;
    private String label;
    private Long voteId;

    public Option() {
    }

    public Option(String label, Long voteId) {
        this.label = label;
        this.voteId = voteId;
    }

    public Option(Long optionId, String label, Long voteId) {
        this.optionId = optionId;
        this.label = label;
        this.voteId = voteId;
    }

    public Long getOptionId() {
        return optionId;
    }

    public String getLabel() {
        return label;
    }

    public Long getVoteId() {
        return voteId;
    }
}

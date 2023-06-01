package study.postvote.domain;

public class VoteUser {
    private Long voteUserId;
    private Long voteId;
    private Long userId;
    private Long optionId;

    public VoteUser() {
    }

    public VoteUser(Long voteId, Long userId, Long optionId) {
        this.voteId = voteId;
        this.userId = userId;
        this.optionId = optionId;
    }

    public VoteUser(Long voteUserId, Long voteId, Long userId, Long optionId) {
        this.voteUserId = voteUserId;
        this.voteId = voteId;
        this.userId = userId;
        this.optionId = optionId;
    }

    public Long getVoteUserId() {
        return voteUserId;
    }

    public Long getVoteId() {
        return voteId;
    }

    public Long getUserId() {
        return userId;
    }

    public Long getOptionId() {
        return optionId;
    }
}

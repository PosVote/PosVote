package study.postvote.domain;

import java.time.LocalDateTime;

public class Vote {
    private Long voteId;
    private Long postId;
    private boolean isAnonymous;
    private String isMulti;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    public Vote() {}

    public Vote(Long voteId, Long postId, boolean isAnonymous, String isMulti, LocalDateTime startTime, LocalDateTime endTime) {
        this.voteId = voteId;
        this.postId = postId;
        this.isAnonymous = isAnonymous;
        this.isMulti = isMulti;
        this.startTime = startTime;
        this.endTime = endTime;
    }
    public Vote(Long postId, boolean isAnonymous, String isMulti, LocalDateTime startTime, LocalDateTime endTime) {
        this.postId = postId;
        this.isAnonymous = isAnonymous;
        this.isMulti = isMulti;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public Long getVoteId() {
        return voteId;
    }

    public Long getPostId() {
        return postId;
    }

    public boolean isAnonymous() {
        return isAnonymous;
    }

    public String getIsMulti() {
        return isMulti;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }


}

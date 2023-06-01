package study.postvote.domain;

import java.time.LocalDateTime;

public class Vote {
    private Long voteId;
    private Long postId;
    private boolean isAnonymous;
    private String inputType;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    public Vote() {}

    public Vote(Long voteId, Long postId, boolean isAnonymous, String inputType, LocalDateTime startTime, LocalDateTime endTime) {
        this.voteId = voteId;
        this.postId = postId;
        this.isAnonymous = isAnonymous;
        this.inputType = inputType;
        this.startTime = startTime;
        this.endTime = endTime;
    }
    public Vote(Long postId, boolean isAnonymous, String inputType, LocalDateTime startTime, LocalDateTime endTime) {
        this.postId = postId;
        this.isAnonymous = isAnonymous;
        this.inputType = inputType;
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

    public String getInputType() {
        return inputType;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }
}

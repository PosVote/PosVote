package study.postvote.service;

import study.postvote.domain.Vote;
import study.postvote.respository.VoteRepository;

public class VoteService {
    private final VoteRepository voteRepository;

    public VoteService() {
        this.voteRepository = new VoteRepository();
    }

    public Long insert(Vote vote) {
        return voteRepository.insert(vote);
    }

    public Vote findByPostId(Long postId) {
        return voteRepository.findByPostId(postId);
    }

    public Vote findByVoteId(Long voteId) {
        return voteRepository.findByVoteId(voteId);
    }

    public int countVote(Long postId) {
        return voteRepository.countVote(postId);
    }

    public void setVoteEnd(Long voteId) {
        voteRepository.setVoteEnd(voteId);
    }
}

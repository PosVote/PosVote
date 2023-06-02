package study.postvote.service;

import study.postvote.domain.VoteUser;
import study.postvote.respository.VoteUserRepository;

import java.util.List;

public class VoteUserService {
    private final VoteUserRepository voteUserRepository;

    public VoteUserService() {
        this.voteUserRepository = new VoteUserRepository();
    }

    public void save(VoteUser voteUser) {
        voteUserRepository.save(voteUser);
    }

    public List<VoteUser> findAll() {
        return voteUserRepository.findAll();
    }

    public List<VoteUser> findVoteUserByVoteId(long voteId) {
        return voteUserRepository.findVoteUserByVoteId(voteId);
    }


    public List<VoteUser> findVoteUserByUserId(long userId) {
        return voteUserRepository.findVoteUserByUserId(userId);
    }

    public VoteUser findVoteUserByUserIdVoteId(long userId, long voteId) {
        return voteUserRepository.findVoteUserByUserIdVoteId(userId, voteId);
    }

    public void updateVoteUser(VoteUser voteUser) {
        voteUserRepository.updateVoteUser(voteUser);
    }

    public void deleteAll() {
        voteUserRepository.deleteAll();
    }


    public void deleteVoteUserByUserId(long userId) {
        voteUserRepository.deleteVoteUserByUserId(userId);
    }

    public void deleteVoteUserByUserIdVoteId(long userId, long voteId) {
        voteUserRepository.deleteVoteUserByUserIdVoteId(userId, voteId);
    }

    public int findByAvgAge(int optionId) {
        return voteUserRepository.findByAvgAge(optionId);
    }
}

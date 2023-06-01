package study.postvote.service;

import study.postvote.domain.VoteUser;
import study.postvote.respository.VoteUserRepository;
import java.util.List;

public class VoteUserService {
    private final VoteUserRepository voteUserRepository;

    public VoteUserService() {
        this.voteUserRepository = new VoteUserRepository();
    }

    void save(VoteUser voteUser){voteUserRepository.save(voteUser);}

    List<VoteUser> findAll(){return voteUserRepository.findAll();}

    List<VoteUser> findVoteUserByVoteId(long voteId){return voteUserRepository.findVoteUserByVoteId(voteId);}


    List<VoteUser> findVoteUserByUserId(long userId){return voteUserRepository.findVoteUserByUserId(userId);}

    VoteUser findVoteUserByUserIdVoteId(long userId, long voteId){return voteUserRepository.findVoteUserByUserIdVoteId(userId, voteId);}

    void updateVoteUser(VoteUser voteUser){voteUserRepository.updateVoteUser(voteUser);}

    void deleteAll(){voteUserRepository.deleteAll();}


    void deleteVoteUserByUserId(long userId){voteUserRepository.deleteVoteUserByUserId(userId);}

    void deleteVoteUserByUserIdVoteId(long userId, long voteId){voteUserRepository.deleteVoteUserByUserIdVoteId(userId, voteId);}
}

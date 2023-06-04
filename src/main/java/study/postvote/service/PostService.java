package study.postvote.service;

import study.postvote.domain.Post;
import study.postvote.dto.post.response.PostListResponse;
import study.postvote.respository.OptionRepository;
import study.postvote.respository.PostRepository;
import study.postvote.respository.VoteRepository;
import study.postvote.respository.VoteUserRepository;

import java.util.List;

public class PostService {
    private final PostRepository postRepository;
    private final VoteRepository voteRepository;
    private final VoteUserRepository voteUserRepository;
    private final OptionRepository optionRepository;


    public PostService() {
        this.postRepository = new PostRepository();
        this.voteRepository = new VoteRepository();
        this.voteUserRepository = new VoteUserRepository();
        this.optionRepository = new OptionRepository();
    }

    public Long save(Post post) {
        return postRepository.save(post);
    }

    public List<Post> findByPostId(Long postId) {
        return postRepository.findByPostId(postId);
    }

    public List<Post> findByTitle(String title, Long orgId) {
        return postRepository.findByTitle(title, orgId);
    }

    public List<Post> findByMyVote(Long id) {
        return postRepository.findByMyVote(id);
    }

    public void deleteById(Long postId, Long voteId) {
        System.out.println(postId + " " + voteId);
        voteUserRepository.deleteVoteUserByVoteId(voteId);
        optionRepository.deleteByVoteId(voteId);
        voteRepository.deleteById(voteId);
        postRepository.deleteById(postId);
    }

    public void updatePost(Post updatePost) {
        postRepository.updatePost(updatePost);
    }

    public int isAnonymous(Long postId) {
        return postRepository.isAnonymous(postId);
    }

    public List<Post> findAll() {
        return postRepository.findAll();
    }

    public List<PostListResponse> findAllPostListResponse(Long orgId) {
        return postRepository.findAllPostListResponse(orgId);
    }
}
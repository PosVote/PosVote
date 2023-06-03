package study.postvote.service;

import study.postvote.domain.Post;
import study.postvote.dto.post.response.PostListResponse;
import study.postvote.respository.PostRepository;
import study.postvote.respository.VoteRepository;

import java.util.List;

public class PostService {
    private final PostRepository postRepository;
    private final VoteRepository voteRepository;

    public PostService() {
        this.postRepository = new PostRepository();
        this.voteRepository = new VoteRepository();
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
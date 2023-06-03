package study.postvote.service;

import study.postvote.domain.Post;
import study.postvote.domain.User;
import study.postvote.dto.post.response.PostListResponse;
import study.postvote.respository.PostRepository;

import java.util.List;

public class PostService {
    private final PostRepository postRepository;

    public PostService() {
        this.postRepository = new PostRepository();
    }

    public Long save(Post post) {return postRepository.save(post);}
    public List<Post> findByPostId(Long postId) {return postRepository.findByPostId(postId);}
    public List<Post> findByTitle(String title) {
        return postRepository.findByTitle(title);
    }
    public List<Post> findByMyVote(Long id) { return postRepository.findByMyVote(id);}
    public void deleteById(Long post_Id) {
        postRepository.deleteById(post_Id);
    }

    public void updatePost(Post updatePost) {
        postRepository.updatePost(updatePost);
    }

    public List<Post> findAll() {
        return postRepository.findAll();
    }

    public List<PostListResponse> findAllPostListResponse() {
        return postRepository.findAllPostListResponse();
    }
}
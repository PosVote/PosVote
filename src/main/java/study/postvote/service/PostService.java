package study.postvote.service;

import study.postvote.domain.Post;
import study.postvote.respository.PostRepository;

import java.util.List;

public class PostService {
    private final PostRepository postRepository;

    public PostService(PostRepository postRepository) {
        this.postRepository = postRepository;
    }

    public List<Post> findByTitle(Long title) {
        return postRepository.findByTitle(title);
    }

    public void deleteById(Long post_Id) {
        postRepository.deleteById(post_Id);
    }

    public void updatePost(Post updatePost) {
        postRepository.updatePost(updatePost);
    }

    public List<Post> findAll() {
        return postRepository.findAll();
    }
}

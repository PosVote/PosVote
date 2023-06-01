package study.postvote.dto.post.response;

import java.time.LocalDateTime;

public class PostListResponse {
    private Long postId;
    private String title;
    private LocalDateTime date;
    private Long userId;
    private String name;

    public PostListResponse() {
    }

    public PostListResponse(Long postId, String title, LocalDateTime date, Long userId, String name) {
        this.postId = postId;
        this.title = title;
        this.date = date;
        this.userId = userId;
        this.name = name;
    }

    public Long getPostId() {
        return postId;
    }

    public String getTitle() {
        return title;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public Long getUserId() {
        return userId;
    }

    public String getName() {
        return name;
    }
}

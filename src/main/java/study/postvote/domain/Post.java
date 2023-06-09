package study.postvote.domain;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Post {
    private Long postId;
    private Long userId;
    private String title;
    private String description;
    private LocalDateTime date;

    public Post(Long postId, Long userId, String title, String description, LocalDateTime date) {
        this.postId = postId;
        this.userId = userId;
        this.title = title;
        this.description = description;
        this.date = date;
    }

    public Post(Long userId, String title, String description, LocalDateTime date)  {
        this.userId = userId;
        this.title = title;
        this.description = description;
        this.date = date;
    }

    public Long getPostId() { return postId; }

    public Long getUserId() { return userId; }

    public String getTitle() { return title; }

    public String getDescription() { return description; }


    public LocalDateTime getDate() { return date;  }
}


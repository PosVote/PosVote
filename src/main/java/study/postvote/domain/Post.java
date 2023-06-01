package study.postvote.domain;

import java.time.LocalDate;

public class Post {
    private Long postId;
    private Long userId;
    private String title;
    private String description;
    private Long voidId;
    private LocalDate date;

    public Post(Long postId, Long userId, String title, String description, Long voidId, LocalDate date) {
        this.postId = postId;
        this.userId = userId;
        this.title = title;
        this.description = description;
        this.voidId = voidId;
        this.date = date;
    }

    public Post(Long userId, String title, String description, Long voidId, LocalDate date)  {
        this.userId = userId;
        this.title = title;
        this.description = description;
        this.voidId = voidId;
        this.date = date;
    }

    public Long getPostId() { return postId; }

    public Long getUserId() { return userId; }

    public String getTitle() { return title; }

    public String getDescription() { return description; }

    public Long getVoidId() { return voidId; }

    public LocalDate getDate() { return date;  }
}


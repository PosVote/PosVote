package study.postvote.domain;

public class Admin {
    private Long userId;

    public Admin() {
    }

    public Admin(Long userId) {
        this.userId = userId;
    }

    public Long getUserId() {
        return userId;
    }
}

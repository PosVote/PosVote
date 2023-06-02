package study.postvote.domain.type;

public enum Status {
    WAITING("WAITING"), ACCEPT("ACCEPT");
    private String description;

    Status(String description) {
        this.description = description;
    }
}

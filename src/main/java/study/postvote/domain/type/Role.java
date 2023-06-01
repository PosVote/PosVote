package study.postvote.domain.type;

public enum Role {
    ADMIN("ADMIN"), USER("USER");
    private String description;

    Role(String description) {
        this.description = description;
    }
}

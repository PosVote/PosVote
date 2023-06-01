package study.postvote.domain.type;

public enum Mbti {
    ISTJ("ISTJ"), ISFJ("ISFJ"),
    INFJ("INFJ"), INTJ("INTJ"),
    ISTP("ISTP"), ISFP("ISFP"),
    INFP("INFP"), INTP("INTP"),
    ESTP("ESTP"), ESFP("ESFP"),
    ENFP("ENFP"), ENTP("ENTP"),
    ESTJ("ESTJ"), ESFJ("ESFJ"),
    ENFJ("ENFJ"), ENTJ("ENTJ");
    private String description;

    Mbti(String description) {
        this.description = description;
    }
}

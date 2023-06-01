package study.postvote.domain.type;

public enum City {
    SEOUL("서울"),

    GYEONGGI("경기"),

    INCHEON("인천"),

    GANGWON("강원"),

    SEJONG("세종"),

    DAEJEON("대전"),

    GYEONGBOOK("경북"),

    GYEONGNAM("경남"),

    BUSAN("부산"),

    JEONBOOK("전북"),

    JEONNAM("전남"),

    GWANGJU("광주"),

    JEJU("제주");

    private String description;

    City(String description) {
        this.description = description;
    }
}

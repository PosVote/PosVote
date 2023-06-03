package study.postvote.domain.type;

public class MbtiMapper {
    public static Mbti mapStringToMbti(String mbtiString) {
        try {
            return Mbti.valueOf(mbtiString);
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("Invalid MBTI string: " + mbtiString);
        }
    }
}
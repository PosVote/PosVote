package study.postvote.domain;

import study.postvote.domain.type.City;
import study.postvote.domain.type.Mbti;

public class User {
    private Long userId;
    private String name;
    private int age;
    private boolean gender;
    private City city;
    private String email;
    private String password;
    private Mbti mbti;

    public User() {
    }

    public User(String name, int age, boolean gender, City city, String email, String password, Mbti mbti) {
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.city = city;
        this.email = email;
        this.password = password;
        this.mbti = mbti;
    }

    public User(Long userId, String name, int age, boolean gender, City city, String email, String password, Mbti mbti) {
        this.userId = userId;
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.city = city;
        this.email = email;
        this.password = password;
        this.mbti = mbti;
    }

    public Long getUserId() {
        return userId;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public boolean isGender() {
        return gender;
    }

    public City getCity() {
        return city;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public Mbti getMbti() {
        return mbti;
    }
}

package study.postvote.domain;

import study.postvote.domain.type.City;
import study.postvote.domain.type.Mbti;
import study.postvote.domain.type.Role;

public class User {
    private Long userId;
    private String name;
    private int age;
    private boolean gender;
    private City city;
    private String email;
    private String password;
    private Mbti mbti;
    private Role role;

    public User() {
    }

    public User(String name, int age, boolean gender, City city, String email, String password, Mbti mbti, Role role) {
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.city = city;
        this.email = email;
        this.password = password;
        this.mbti = mbti;
        this.role = role;
    }

    public User(Long userId, String name, int age, boolean gender, City city, String email, String password, Mbti mbti, Role role) {
        this.userId = userId;
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.city = city;
        this.email = email;
        this.password = password;
        this.mbti = mbti;
        this.role = role;
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

    public Role getRole() {
        return role;
    }
}

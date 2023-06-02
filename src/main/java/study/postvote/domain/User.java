package study.postvote.domain;

import study.postvote.domain.type.City;
import study.postvote.domain.type.Mbti;
import study.postvote.domain.type.Role;
import study.postvote.domain.type.Status;

public class User {
    private Long userId;
    private String name;
    private int age;
    private int gender;
    private City city;
    private String email;
    private String password;
    private Mbti mbti;
    private Role role;
    private Long orgId;
    private Status status;

    public User() {
    }

    public User(String name, int age, int gender, City city, String email, String password, Mbti mbti, Role role, Long orgId, Status status) {
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.city = city;
        this.email = email;
        this.password = password;
        this.mbti = mbti;
        this.role = role;
        this.orgId = orgId;
        this.status = status;
    }

    public User(Long userId, String name, int age, int gender, City city, String email, String password, Mbti mbti, Role role, Long orgId, Status status) {
        this.userId = userId;
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.city = city;
        this.email = email;
        this.password = password;
        this.mbti = mbti;
        this.role = role;
        this.orgId = orgId;
        this.status = status;
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

    public int getGender() {
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

    public Long getOrgId() {
        return orgId;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatusWaiting() {
        this.status = Status.WAITING;
    }
}

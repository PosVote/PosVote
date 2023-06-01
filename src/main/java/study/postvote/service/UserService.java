package study.postvote.service;

import study.postvote.domain.User;
import study.postvote.respository.UserRepository;

import java.util.List;

public class UserService {
    private final UserRepository userRepository;

    public UserService() {
        this.userRepository = new UserRepository();
    }

    public void save(User user) {
        User findUser = findByEmail(user.getEmail());
        if (findUser == null) {
            userRepository.save(user);
        } else {
            System.out.println("이미 이메일이 존재합니다.");
        }
    }

    public User findById(Long id) {
        return userRepository.findById(id);
    }

    public User findByEmail(String email) {
        List<User> users = userRepository.findByEmail(email);
        return users.size() > 0 ? users.get(0) : null;
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public void deleteById(Long id) {
        userRepository.deleteById(id);
    }

    public void updateUser(User updateUser) {
        userRepository.updateUser(updateUser);
    }
}

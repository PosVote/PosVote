package study.postvote.service;

import study.postvote.domain.User;
import study.postvote.domain.type.Role;
import study.postvote.domain.type.Status;
import study.postvote.respository.UserRepository;

import java.util.List;

public class UserService {
    private final UserRepository userRepository;

    public UserService() {
        this.userRepository = new UserRepository();
    }

    public User login(String email, String password) {
        return userRepository.login(email, password);
    }

    public void save(User user) throws Exception {
        User findUser = userRepository.findByEmail(user.getEmail());
        if (findUser == null) {
            findUser.setStatusWaiting();
            userRepository.save(user);
        } else {
            throw new Exception();
        }
    }

    public User findById(Long id) {
        return userRepository.findById(id);
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public void deleteById(Long id) {
        User findUser = userRepository.findById(id);
        userRepository.deleteById(findUser.getUserId());
    }

    public void updateUser(User updateUser) {
        userRepository.updateUser(updateUser);
    }

    public void updateStatus(User user, Status status) {
        userRepository.updateStatus(user, status);
    }

    public void updateRoleUser(Long id) throws Exception {
        User findUser = userRepository.findById(id);
        if (findUser != null) {
            userRepository.updateRole(findUser, Role.USER);
        } else {
            throw new Exception();
        }
    }

    public void updateRoleAdmin(Long id) throws Exception {
        User findUser = userRepository.findById(id);
        if (findUser != null) {
            userRepository.updateRole(findUser, Role.ADMIN);
        } else {
            throw new Exception();
        }
    }
}

package study.postvote.respository;

import study.postvote.domain.User;
import study.postvote.domain.type.City;
import study.postvote.domain.type.Mbti;
import study.postvote.domain.type.Role;
import study.postvote.domain.type.Status;
import study.postvote.respository.db.ConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class UserRepository {
    Connection conn;
    PreparedStatement pstmt;

    public User login(String email, String password) {
        String sql = "select * from user where email = ? and password = ?";
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            return executeQuery(pstmt).get(0);
        } catch (Exception e) {
            return null;
        }
    }

    public void save(User user) {
        String sql = "insert into user (name, age, gender, city, email, password, mbti, role, org_id, status) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = ConnectionManager.getConnection();

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getName());
            pstmt.setInt(2, user.getAge());
            pstmt.setInt(3, user.getGender());
            pstmt.setString(4, String.valueOf(user.getCity()));
            pstmt.setString(5, user.getEmail());
            pstmt.setString(6, user.getPassword());
            pstmt.setString(7, String.valueOf(user.getMbti()));
            pstmt.setString(8, String.valueOf(user.getRole()));
            pstmt.setString(9, String.valueOf(user.getOrgId()));
            pstmt.setString(10, String.valueOf(user.getStatus()));

            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                conn.close();
                pstmt.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public User findById(Long id) {
        String sql = "select * from user where user_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, id);
            return executeQuery(pstmt).get(0);
        } catch (Exception e) {
            return null;
        }
    }

    public List<User> findByOrgIdAndStatus(Long orgId, Status status) {
        String sql = "select * from user where org_Id = ? and status = ? and role != 'owner'";
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, orgId);
            pstmt.setString(2, status.toString());
            return executeQuery(pstmt);
        } catch (Exception e) {
            return null;
        }
    }

    public User findByEmail(String email) {
        String sql = "select * from user where email = ?";
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            return executeQuery(pstmt).get(0);
        } catch (Exception e) {
            return null;
        }
    }

    public List<User> findAll() {
        String sql = "select * from user";
        try {
            conn = ConnectionManager.getConnection();

            pstmt = conn.prepareStatement(sql);

            return executeQuery(pstmt);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int countByOrgId(Long orgId) {
        String sql = "SELECT COUNT(*) AS count FROM user WHERE org_id = ?;";
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, orgId);
            return executeQueryCount(pstmt);
        } catch (Exception e) {
            return 0;
        }
    }

    public void deleteById(Long id) {
        String sql = "delete from user where user_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, id);
            pstmt.executeUpdate();
        } catch (Exception ignored) {

        } finally {
            try {
                conn.close();
                pstmt.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public void deleteByOrdId(Long id) {
        String sql = "delete from user where org_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, id);
            pstmt.executeUpdate();
        } catch (Exception ignored) {

        } finally {
            try {
                conn.close();
                pstmt.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public void updateUser(User user) {
        String sql = "update user set " +
                "name = ?, age = ?, gender = ?, city = ?, email = ?, password = ?, mbti = ?, role = ?, org_id = ?, status = ? where user_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, user.getName());
            pstmt.setInt(2, user.getAge());
            pstmt.setInt(3, user.getGender());
            pstmt.setString(4, String.valueOf(user.getCity()));
            pstmt.setString(5, user.getEmail());
            pstmt.setString(6, user.getPassword());
            pstmt.setString(7, String.valueOf(user.getMbti()));
            pstmt.setString(8, String.valueOf(user.getRole()));
            pstmt.setString(9, String.valueOf(user.getOrgId()));
            pstmt.setString(10, String.valueOf(user.getStatus()));
            pstmt.setLong(11, user.getUserId());

            pstmt.executeUpdate();
        } catch (Exception ignored) {

        } finally {
            try {
                conn.close();
                pstmt.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public void updateRole(User user, Role role) {
        String sql = "update user set " +
                "role = ? where user_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, String.valueOf(role));
            pstmt.setLong(2, user.getUserId());

            pstmt.executeUpdate();
        } catch (Exception ignored) {

        } finally {
            try {
                conn.close();
                pstmt.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public void updateStatus(User user, Status status) {
        String sql = "update user set " +
                "status = ? where user_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, String.valueOf(status));
            pstmt.setLong(2, user.getUserId());

            pstmt.executeUpdate();
        } catch (Exception ignored) {

        } finally {
            try {
                conn.close();
                pstmt.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public List<User> findByMyVote(Long id) {
        String sql = "select PS.* " +
                "from vote_user VS " +
                "join vote VT on VS.vote_id = VT.vote_id " +
                "join post PS on VT.post_id = PS.post_id WHERE VS.user_id = ?";

        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, id);

            return executeQuery(pstmt);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }

    private List<User> executeQuery(PreparedStatement pstmt) {
        List<User> userList = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = pstmt.executeQuery();

            while (rs.next()) {
                userList.add(new User(rs.getLong(1), rs.getString(2), Integer.parseInt(rs.getString(3)),
                        Integer.parseInt(rs.getString(4)), City.valueOf(rs.getString(5)), rs.getString(6), rs.getString(7),
                        Mbti.valueOf(rs.getString(8)), Role.valueOf(rs.getString(9)), rs.getLong(10), Status.valueOf(rs.getString(11))));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            OrganizationRepository.connclose(pstmt, rs, conn);
        }

        return userList;
    }

    private int executeQueryCount(PreparedStatement pstmt) {
        ResultSet rs = null;
        try {
            rs = pstmt.executeQuery();

            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            OrganizationRepository.connclose(pstmt, rs, conn);
        }

        return 0;
    }
}
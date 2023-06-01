package study.postvote.respository;

import study.postvote.domain.User;
import study.postvote.domain.type.City;
import study.postvote.domain.type.Mbti;
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

    public void insert(User user) {
        String sql = "insert into user (name, age, gender, city, email, password, mbti) values(?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = ConnectionManager.getConnection();

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, String.valueOf(user.getAge()));
            pstmt.setString(3, String.valueOf(user.isGender()));
            pstmt.setString(4, String.valueOf(user.getCity()));
            pstmt.setString(5, user.getEmail());
            pstmt.setString(6, user.getPassword());
            pstmt.setString(7, String.valueOf(user.getMbti()));

            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    private List<User> executeQuery(PreparedStatement pstmt) {
        List<User> libraryList = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = pstmt.executeQuery();

            while (rs.next()) {
                libraryList.add(new User(Long.parseLong(rs.getString(1)), rs.getString(2), Integer.parseInt(rs.getString(3)),
                        Boolean.parseBoolean(rs.getString(4)), City.valueOf(rs.getString(5)), rs.getString(6), rs.getString(7),
                        Mbti.valueOf(rs.getString(8))));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                Objects.requireNonNull(rs).close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                Objects.requireNonNull(pstmt).close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return libraryList;
    }
}

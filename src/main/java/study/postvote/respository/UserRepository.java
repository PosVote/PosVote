package study.postvote.respository;

import study.postvote.domain.User;
import study.postvote.respository.db.ConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class UserRepository implements UserRepository{
    Connection conn;

    @Override
    public void insert(User library) {
        String sql = "insert into user (name, author, publisher, isbn, release_year, count, summary, image, category) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = ConnectionManager.getConnection();

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, library.getName());

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

//            while (rs.next()) {
//                libraryList.add(new User(Long.parseLong(rs.getString(1)), rs.getString(2), rs.getString(3),
//                        rs.getString(4), rs.getString(5), Integer.parseInt(rs.getString(6)), Integer.parseInt(rs.getString(7)),
//                        rs.getString(8), rs.getString(9), rs.getString(10)));
//            }
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

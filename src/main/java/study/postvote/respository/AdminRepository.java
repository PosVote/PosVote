package study.postvote.respository;

import study.postvote.domain.Admin;
import study.postvote.respository.db.ConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class AdminRepository {
    Connection conn;

    public void Admin(Admin admin) {
        String sql = "insert into admin (user_id) values(?)";
        try {
            conn = ConnectionManager.getConnection();

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, admin.getUserId());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Admin findById(Long id) {
        String sql = "select * from admin where user_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, id);
            return executeQuery(pstmt).get(0);
        } catch (Exception e) {
            return null;
        }
    }

    public List<Admin> findAll() {
        String sql = "select * from admin";
        try {
            conn = ConnectionManager.getConnection();

            PreparedStatement pstmt = conn.prepareStatement(sql);

            return executeQuery(pstmt);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteById(Long id) {
        String sql = "delete from admin where user_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, id);
            pstmt.executeUpdate();
        } catch (Exception ignored) {

        }
    }

    private List<Admin> executeQuery(PreparedStatement pstmt) {
        List<Admin> libraryList = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = pstmt.executeQuery();

            while (rs.next()) {
                libraryList.add(new Admin(Long.parseLong(rs.getString(1))));
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

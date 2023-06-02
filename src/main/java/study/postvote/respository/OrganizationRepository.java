package study.postvote.respository;

import study.postvote.domain.Organization;
import study.postvote.respository.db.ConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class OrganizationRepository {
    Connection conn = null;

    public void save(Organization organization) {
        String sql = "insert into user (org_name) values(?)";
        try {
            conn = ConnectionManager.getConnection();

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, organization.getOrgName());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                conn.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public Organization findById(Long id) {
        String sql = "select * from organization where org_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, id);
            return executeQuery(pstmt).get(0);
        } catch (Exception e) {
            return null;
        }
    }

    public void deleteById(Long id) {
        String sql = "delete from organization where org_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, id);
            pstmt.executeUpdate();
        } catch (Exception ignored) {

        }
    }

    private List<Organization> executeQuery(PreparedStatement pstmt) {
        List<Organization> organizations = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = pstmt.executeQuery();

            while (rs.next()) {
                organizations.add(new Organization(rs.getLong(1),
                        rs.getString(2)));
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

        return organizations;
    }
}

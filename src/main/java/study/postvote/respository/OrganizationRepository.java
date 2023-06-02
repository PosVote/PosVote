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

import static java.sql.Statement.RETURN_GENERATED_KEYS;

public class OrganizationRepository {
    Connection conn = null;

    public Long save(Organization organization) {
        String sql = "insert into organization (org_name) values(?)";
        ResultSet rs;

        try {
            conn = ConnectionManager.getConnection();

            PreparedStatement pstmt = conn.prepareStatement(sql, RETURN_GENERATED_KEYS);
            pstmt.setString(1, organization.getOrgName());

            pstmt.executeUpdate();
            Long orgKey = -1l;
            rs = pstmt.getGeneratedKeys();
            if (rs.next()) orgKey = rs.getLong(1);
            return orgKey;
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

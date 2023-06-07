package study.postvote.respository;

import study.postvote.domain.Organization;
import study.postvote.dto.organization.response.OrganizationAdminViewResponse;
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

    public List<Organization> findAll() {
        String sql = "select * from organization";
        try {
            conn = ConnectionManager.getConnection();

            PreparedStatement pstmt = conn.prepareStatement(sql);

            return executeQuery(pstmt);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<OrganizationAdminViewResponse> findAllWaitingOrg() {
        String sql = "SELECT org.org_id, org.org_name, user.user_id, user.name, user.email, COUNT(*) AS orgMemberCount " +
                "                FROM organization org " +
                "                JOIN user ON org.org_id = user.org_id " +
                "                WHERE user.role = 'owner' AND user.status = 'waiting' " +
                "                GROUP BY org.org_id, org.org_name, user.user_id, user.email";
        try {
            conn = ConnectionManager.getConnection();

            PreparedStatement pstmt = conn.prepareStatement(sql);

            return executeQueryAdminView(pstmt);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<OrganizationAdminViewResponse> findAllOrgAdminView() {
        String sql = "   SELECT orgCount.org_id, orgCount.org_name, user.user_id, user.name, user.email, orgMemberCount \n" +
                "                FROM (SELECT org.org_id,org.org_name, COUNT(*) AS orgMemberCount  \n" +
                "                FROM organization org  \n" +
                "                JOIN user ON org.org_id = user.org_id  \n" +
                "                WHERE user.status = 'ACCEPT'  \n" +
                "                GROUP BY org.org_id, org.org_name) as orgCount, user  \n" +
                "                WHERE user.role='OWNER'  \n" +
                "                AND orgCount.org_id = user.org_id;";
        try {
            conn = ConnectionManager.getConnection();

            PreparedStatement pstmt = conn.prepareStatement(sql);

            return executeQueryAdminView(pstmt);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteById(Long id) {
        String sql = "delete from organization where org_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, id);
            System.out.println(pstmt);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
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

    private List<OrganizationAdminViewResponse> executeQueryAdminView(PreparedStatement pstmt) {
        List<OrganizationAdminViewResponse> organizations = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = pstmt.executeQuery();

            while (rs.next()) {
                organizations.add(
                        new OrganizationAdminViewResponse(
                                rs.getLong(1),
                                rs.getString(2),
                                rs.getLong(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getInt(6)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            connclose(pstmt, rs, conn);
        }

        return organizations;
    }

    static void connclose(PreparedStatement pstmt, ResultSet rs, Connection conn) {
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
}

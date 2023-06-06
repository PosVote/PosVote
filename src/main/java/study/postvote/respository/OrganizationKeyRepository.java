package study.postvote.respository;

import study.postvote.domain.OrganizationKey;
import study.postvote.respository.db.ConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OrganizationKeyRepository {

    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

    public void save(OrganizationKey organizationKey) {
        String sql = "insert into organization_key (org_id, org_key) values(?, ?)";

        try {
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1, organizationKey.getOrgId());
            ps.setString(2, organizationKey.getOrgKey());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                conn.close();
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }
    }

    public void updateKey(String updateKey, Long orgId) {
        String sql = "update organization_key set org_key = ? where org_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, updateKey);
            ps.setLong(2, orgId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                conn.close();
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
                throw new RuntimeException(e);

            }
        }
    }

    public OrganizationKey findByOrgId(Long orgId) {
        String sql = "select * from organization_key where org_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1, orgId);

            rs = ps.executeQuery();
            if (rs.next()) {
                return new OrganizationKey(
                        rs.getLong("org_id"),
                        rs.getString("org_key")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            try {
                conn.close();
                rs.close();
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }
        return null;
    }

    public OrganizationKey findByKey(String key) {
        String sql = "select * from organization_key where org_key = ?";
        try {
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, key);

            rs = ps.executeQuery();
            if (rs.next()) {
                return new OrganizationKey(
                        rs.getLong("org_id"),
                        rs.getString("org_key")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            try {
                conn.close();
                rs.close();
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }
        return null;
    }

    public void deleteById(Long orgId) {
        String sql = "delete from organization_key where org_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, orgId);
            System.out.println(pstmt);
            pstmt.executeUpdate();
        } catch (Exception ignored) {

        }
    }
}

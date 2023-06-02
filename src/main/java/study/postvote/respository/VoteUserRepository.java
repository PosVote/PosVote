package study.postvote.respository;

import study.postvote.domain.*;
import study.postvote.respository.db.ConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class VoteUserRepository {
    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

    public void save(VoteUser voteUser) {
        String sql = "insert into vote_user (vote_id, user_id, option_id) values(?, ?, ?)";
        try {
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1, voteUser.getVoteId());
            ps.setLong(2, voteUser.getUserId());
            ps.setLong(3, voteUser.getOptionId());
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

    public List<VoteUser> findAll() {
        String sql = "select * from vote_user";
        List<VoteUser> voteUsers = new ArrayList<>();
        try {
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                voteUsers.add(
                        new VoteUser(
                                rs.getLong("vote_user_id"),
                                rs.getLong("vote_id"),
                                rs.getLong("user_id"),
                                rs.getLong("option_id")
                        )
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
        return voteUsers;
    }

    public List<VoteUser> findVoteUserByVoteId(long voteId) {
        String sql = "select * from vote_user where vote_id = ?";
        List<VoteUser> voteUsers = new ArrayList<>();
        try {
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1, voteId);
            rs = ps.executeQuery();
            while (rs.next()) {
                voteUsers.add(
                        new VoteUser(
                                rs.getLong("vote_user_id"),
                                rs.getLong("vote_id"),
                                rs.getLong("user_id"),
                                rs.getLong("option_id")
                        )
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
        return voteUsers;
    }

    //나이 통계
    public int findByAvgAge(int optionId) {
        String sql = "SELECT AVG(user.age) FROM vote_user join user on vote_user.user_id = user.user_id where vote_user.option_id = ?;";
        try {
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1, optionId);
            return executeQueryInteger(ps).get(0);
        } catch (Exception e) {
            return -1;
        }
    }

//  제작 보류
//    VoteUser findVoteUserById(long voteUserId){
//
//    }

    public List<VoteUser> findVoteUserByUserId(long userId) {
        String sql = "select * from vote_user where user_id = ?";
        List<VoteUser> voteUsers = new ArrayList<>();
        try {
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                voteUsers.add(
                        new VoteUser(
                                rs.getLong("vote_user_id"),
                                rs.getLong("vote_id"),
                                rs.getLong("user_id"),
                                rs.getLong("option_id")
                        )
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
        return voteUsers;
    }

    public VoteUser findVoteUserByUserIdVoteId(long userId, long voteId) {
        String sql = "select * from vote_user where user_id = ? and vote_id = ?";
        List<VoteUser> voteUsers = new ArrayList<>();
        try {
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1, userId);
            ps.setLong(2, voteId);

            rs = ps.executeQuery();
            if (rs.next()) {
                return new VoteUser(
                        rs.getLong("vote_user_id"),
                        rs.getLong("vote_id"),
                        rs.getLong("user_id"),
                        rs.getLong("option_id")
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

    public void updateVoteUser(VoteUser voteUser) {
        String sql = "update vote_user set vote_id = ?, user_id = ?, option_id = ? where vote_user_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1, voteUser.getVoteId());
            ps.setLong(2, voteUser.getVoteUserId());
            ps.setLong(3, voteUser.getOptionId());
            ps.setLong(4, voteUser.getVoteUserId());
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

//제작 보류
//    void deleteVoteUserByVoteUserId(long voteUserId){
//
//    }

    public void deleteAll() {
        String sql = "delete from vote_user";
        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
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


    public void deleteVoteUserByUserId(long userId) {
        String sql = "delete from vote_user where user_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
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

    public void deleteVoteUserByUserIdVoteId(long userId, long voteId) {
        String sql = "delete from vote_user where user_id = ? and vote_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, userId);
            ps.setLong(2, voteId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
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

// 제작 보류
//    void deleteVoteUserByVoteId(long voteId){
//    }

    private List<Integer> executeQueryInteger(PreparedStatement pstmt) {
        List<Integer> integers = new ArrayList<>();
        try {
            rs = pstmt.executeQuery();

            while (rs.next()) {
                integers.add(rs.getInt(1));
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

        return integers;
    }
}

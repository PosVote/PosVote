package study.postvote.respository;

import study.postvote.domain.Vote;
import study.postvote.respository.db.ConnectionManager;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import static java.sql.Statement.RETURN_GENERATED_KEYS;

public class VoteRepository {
    Connection conn;
    ResultSet rs;

    public Long insert(Vote vote) {
        String sql = "insert into vote (post_id, is_anonymous, input_type, start_time, end_time) values(?, ?, ?, ?, ?)";
        try {
            conn = ConnectionManager.getConnection();

            PreparedStatement pstmt = conn.prepareStatement(sql, RETURN_GENERATED_KEYS);
            pstmt.setLong(1, vote.getPostId());
            pstmt.setInt(2, vote.isAnonymous());
            pstmt.setString(3, vote.getInputType());
            pstmt.setString(4, String.valueOf(vote.getStartTime()));
            pstmt.setString(5, String.valueOf(vote.getEndTime()));

            pstmt.executeUpdate();
            rs = pstmt.getGeneratedKeys();
            Long vote_key = -1l;
            if (rs.next()) vote_key = rs.getLong(1);
            return vote_key;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Vote findByPostId(Long postId) {
        String sql = "select * from vote where post_id = ?";
        Vote v = null;
        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, postId);

            ResultSet rs = pstmt.executeQuery();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

//            System.out.println("rs: " + rs.getLong(1));
//            java.sql.Date sqlDate = rs.getDate(5);
//            LocalDateTime startTime = sqlDate.toLocalDate().atStartOfDay();
//            java.sql.Date sqlDate2 = rs.getDate(6);
//            LocalDateTime endTime = sqlDate2.toLocalDate().atStartOfDay();
            while (rs.next()) {
                java.sql.Date sqlDate = rs.getDate(5);
                LocalDateTime startTime = sqlDate.toLocalDate().atStartOfDay();
//                java.sql.Date sqlDate2 = rs.getDate(6);
//                LocalDateTime endTime = sqlDate2.toLocalDate().atStartOfDay();
                System.out.println(LocalDateTime.parse(rs.getString(6), formatter));
                v = new Vote(
                        rs.getLong(1),
                        rs.getLong(2),
                        rs.getInt(3),
                        rs.getString(4),
                        startTime,
                        LocalDateTime.parse(rs.getString(6), formatter)
                );
            }
//            return new Vote(
//                    rs.getLong(1),
//                    rs.getLong(2),
//                    rs.getInt(3),
//                    rs.getString(4),
//                    startTime,
//                    endTime
//            );
            return v;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Vote findByVoteId(Long voteId) {
        String sql = "select * from vote where vote_id = ?";
        Vote v = null;
        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, voteId);

            ResultSet rs = pstmt.executeQuery();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            while (rs.next()) {
                java.sql.Date sqlDate = rs.getDate(5);
                LocalDateTime startTime = sqlDate.toLocalDate().atStartOfDay();
                System.out.println(LocalDateTime.parse(rs.getString(6), formatter));
                v = new Vote(
                        rs.getLong(1),
                        rs.getLong(2),
                        rs.getInt(3),
                        rs.getString(4),
                        startTime,
                        LocalDateTime.parse(rs.getString(6), formatter)
                );
            }
            return v;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public int countVote(Long postId) {
        String sql = "select COUNT(distinct vu.user_id) from vote v " +
                "join post p on v.post_id = p.post_id " +
                "join vote_user vu on v.vote_id = vu.vote_id " +
                "where p.post_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, postId);
            ResultSet rs = pstmt.executeQuery();
            System.out.println(rs);
            int count = 0;
            while (rs.next()) {
                count = rs.getInt(1);
            }
            System.out.println("count: " + count);
            return count;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void setVoteEnd(Long voteId) {
        String sql = "UPDATE vote SET end_time = ? WHERE vote_id = ?";
        PreparedStatement pstmt = null;

        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setLong(2, voteId);

            pstmt.executeUpdate();
            conn.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteById(Long voteId) {
        String sql = "delete from vote where vote_id = ?";
        PreparedStatement pstmt = null;

        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, voteId);
            pstmt.executeUpdate();

            conn.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}


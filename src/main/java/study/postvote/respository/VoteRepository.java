package study.postvote.respository;

import study.postvote.domain.Vote;
import study.postvote.respository.db.ConnectionManager;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class VoteRepository {
    Connection conn;
    ResultSet rs;
    public Long insert(Vote vote){
        String sql = "insert into vote (post_id, is_anonymous, input_type, start_time, end_time) values(?, ?, ?, ?, ?)";
        try {
            conn = ConnectionManager.getConnection();

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, vote.getPostId());
            pstmt.setBoolean(2, vote.isAnonymous());
            pstmt.setString(3, vote.getInputType());
            pstmt.setDate(4, Date.valueOf(String.valueOf(vote.getStartTime())));
            pstmt.setDate(5, Date.valueOf(String.valueOf(vote.getEndTime())));

            pstmt.executeUpdate();
            rs = pstmt.getGeneratedKeys();
            Long vote_key = rs.getLong(1);
            return vote_key;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public Vote findByPostId(Long postId){
        Vote v = new Vote();
        String sql = "select * from vote where post_id = ?";
        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, postId);
            ResultSet rs = pstmt.executeQuery();
            java.sql.Date sqlDate = rs.getDate(5);
            LocalDateTime startTime = sqlDate.toLocalDate().atStartOfDay();
            java.sql.Date sqlDate2 = rs.getDate(6);
            LocalDateTime endTime = sqlDate2.toLocalDate().atStartOfDay();

            return new Vote(
                    rs.getLong(1),
                    rs.getLong(2),
                    rs.getBoolean(3),
                    rs.getString(4),
                    startTime,
                    endTime
            );
        } catch (Exception e) {
            return null;
        }
    }
}

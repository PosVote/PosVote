package study.postvote.respository;

import study.postvote.domain.Post;
import study.postvote.domain.User;
import study.postvote.domain.type.City;
import study.postvote.domain.type.Mbti;
import study.postvote.domain.type.Role;
import study.postvote.dto.post.response.PostListResponse;
import study.postvote.respository.db.ConnectionManager;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;

public class PostRepository {
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;


    public Long save(Post post) {
        String sql = "insert into post (user_id, title, description, date) values(?,?,?,?)";
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setLong(1, post.getUserId());
            pstmt.setString(2, post.getTitle());
            pstmt.setString(3, post.getDescription());
            pstmt.setDate(4, Date.valueOf(String.valueOf(post.getDate())));

            pstmt.executeUpdate();
            rs = pstmt.getGeneratedKeys();
            Long post_pk = rs.getLong(1);
            conn.close();
            pstmt.close();
            rs.close();
            return post_pk;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Post> findByPostId(Long postId) {
        String sql = "select * from post where post_id = ?";

        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, postId);
            return executeQuery(pstmt);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public List<Post> findByTitle(Long title) {
        String sql = "select * from post where title like ?";

        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + title + "%");
            return executeQuery(pstmt);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteById(Long post_id) {
        String sql = "delte from post where post_id = ?";
        PreparedStatement pstmt = null;

        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, post_id);
            pstmt.executeUpdate();

            conn.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void updatePost(Post post) {
        String sql = "update user set " + "title = ?, description = ?, date = ?";

        PreparedStatement pstmt = null;

        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getDescription());
            pstmt.setDate(3, Date.valueOf(String.valueOf(post.getDate())));

            conn.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Post> findAll() {
        String sql = "select * from post";
        PreparedStatement pstmt = null;
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);

            return executeQuery(pstmt);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<PostListResponse> findAllPostListResponse() {
//        String sql = "SELECT p.post_id, p.title, p.date, p.user_id, u.name FROM post p join user u on p.user_id = u.user_id ORDER BY p.date DESC LIMIT ? OFFSET ?;";
        String sql = "SELECT p.post_id, p.title, p.date, p.user_id, u.name FROM post p join user u on p.user_id = u.user_id;";

        PreparedStatement pstmt = null;
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);

            return executeQueryPostListResponse(pstmt);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private List<Post> executeQuery(PreparedStatement pstmt) {
        List<Post> postList = new ArrayList<>();
        ResultSet rs = null;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        try {
            rs = pstmt.executeQuery();

            while (rs.next()) {
                postList.add(new Post(rs.getLong(1),
                        rs.getLong(2),
                        rs.getString(3),
                        rs.getString(4),
                        LocalDateTime.parse(rs.getString(5), formatter)));
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

        return postList;
    }

    private List<PostListResponse> executeQueryPostListResponse(PreparedStatement pstmt) {
        List<PostListResponse> postListResponses = new ArrayList<>();
        ResultSet rs = null;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        try {
            rs = pstmt.executeQuery();

            while (rs.next()) {
                postListResponses.add(new PostListResponse(rs.getLong(1),
                        rs.getString(2),
                        LocalDateTime.parse(rs.getString(3), formatter),
                        rs.getLong(4),
                        rs.getString(5)));
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

        return postListResponses;
    }
}
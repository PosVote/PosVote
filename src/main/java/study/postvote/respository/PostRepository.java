package study.postvote.respository;

import study.postvote.domain.Post;
import study.postvote.dto.post.response.PostListResponse;
import study.postvote.respository.db.ConnectionManager;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import static java.sql.Statement.RETURN_GENERATED_KEYS;
import static study.postvote.util.StaticStr.POSTPERPAGE;

public class PostRepository {
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;


    public Long save(Post post) {
        String sql = "insert into post (user_id, title, description, date) values(?,?,?,?)";
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql, RETURN_GENERATED_KEYS);

            pstmt.setLong(1, post.getUserId());
            pstmt.setString(2, post.getTitle());
            pstmt.setString(3, post.getDescription());
            pstmt.setString(4, (String.valueOf(post.getDate())));

            pstmt.executeUpdate();
            rs = pstmt.getGeneratedKeys();
            Long post_pk = -1l;
            if (rs.next()) post_pk = rs.getLong(1);
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

    public List<Post> findByTitle(String title, Long orgId) {
        String sql = "select * from post join user on post.user_id = user.user_id where title like ? and user.org_id = ? ORDER BY post.date DESC";

        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + title + "%");
            pstmt.setLong(2, orgId);
            return executeQuery(pstmt);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteById(Long postId) {
        String sql = "delete from post where post_id = ?";
        PreparedStatement pstmt = null;

        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, postId);
            pstmt.executeUpdate();

            conn.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int isAnonymous(Long postId) {
        String sql = "SELECT is_anonymous FROM vote WHERE post_id = ?;";

        try {
            conn = ConnectionManager.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, postId);
            ResultSet rs = null;
            try {
                System.out.println(pstmt);
                rs = pstmt.executeQuery();
                rs.next();
                return rs.getInt(1);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            } finally {
                OrganizationRepository.connclose(pstmt, rs, conn);
            }
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

    public List<PostListResponse> findAllPostListResponse(Long orgId, int currentPage) {
        String sql = "SELECT p.post_id, p.title, p.date, p.user_id, u.name FROM post p join user u on p.user_id = u.user_id where u.org_id = ? ORDER BY p.date DESC LIMIT ? OFFSET ?";

        PreparedStatement pstmt = null;
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setLong(1, orgId);
            pstmt.setInt(2, POSTPERPAGE);
            pstmt.setInt(3, POSTPERPAGE * (currentPage - 1));

            return executeQueryPostListResponse(pstmt);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int findAllPostCount(Long orgId) {
        String sql = "SELECT COUNT(*) count FROM post p join user u on p.user_id = u.user_id where u.org_id = ? ORDER BY p.date DESC";

        pstmt = null;
        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setLong(1, orgId);

            rs = pstmt.executeQuery();

            if(rs.next()) return rs.getInt("count");


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            try{
                conn.close();
                pstmt.close();
                rs.close();
            }catch (SQLException e){
                e.printStackTrace();
            }
        }

        return -1;
    }

    public List<Post> findByMyVote(Long id) {
        String sql = "select PS.* " +
                "from vote_user VS " +
                "join vote VT on VS.vote_id = VT.vote_id " +
                "join post PS on VT.post_id = PS.post_id " +
                "where VS.user_id = ?";

        try {
            conn = ConnectionManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, id);

            return executeQuery(pstmt);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    private List<Post> executeQuery(PreparedStatement pstmt) {
        List<Post> postList = new ArrayList<>();
        ResultSet rs = null;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        try {
            System.out.println(pstmt);
            rs = pstmt.executeQuery();
            System.out.println(Objects.isNull(rs));
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
            OrganizationRepository.connclose(pstmt, rs, conn);
        }
        System.out.println(postList);
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
            OrganizationRepository.connclose(pstmt, rs, conn);
        }

        return postListResponses;
    }
}
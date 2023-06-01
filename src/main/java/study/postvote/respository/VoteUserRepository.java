package study.postvote.respository;

import study.postvote.domain.Option;
import study.postvote.domain.VoteUser;
import study.postvote.respository.db.ConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VoteUserRepository {
    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

    void save(VoteUser voteUser){
        String sql = "insert into vote_user (vote_id, u_id, option_id) values(?, ?, ?)";
        try{
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1, voteUser.getVoteId());
            ps.setLong(2, voteUser.getUserId());
            ps.setLong(3, voteUser.getOptionId());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            try{
                conn.close();
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }
    }

    List<VoteUser> findAll(){
        String sql = "select * from vote_user";
        List<VoteUser> voteUsers = new ArrayList<>();
        try{
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                voteUsers.add(
                        new VoteUser(
                                rs.getLong("vote_user_id"),
                                rs.getLong("vote_id"),
                                rs.getLong("u_id"),
                                rs.getLong("option_id")
                        )
                );
            }
        }catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }finally {
            try{
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

    List<VoteUser> findVoteUserByVoteId(long voteId){
        String sql = "select * from vote_user where vote_id = ?";
        List<VoteUser> voteUsers = new ArrayList<>();
        try{
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1, voteId);
            rs = ps.executeQuery();
            while(rs.next()){
                voteUsers.add(
                        new VoteUser(
                                rs.getLong("vote_user_id"),
                                rs.getLong("vote_id"),
                                rs.getLong("u_id"),
                                rs.getLong("option_id")
                        )
                );
            }
        }catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }finally {
            try{
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

//  제작 보류
//    VoteUser findVoteUserById(long voteUserId){
//
//    }

    List<VoteUser> findVoteUserByUId(long uId){
        String sql = "select * from vote_user where u_id = ?";
        List<VoteUser> voteUsers = new ArrayList<>();
        try{
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1, uId);
            rs = ps.executeQuery();
            while(rs.next()){
                voteUsers.add(
                        new VoteUser(
                                rs.getLong("vote_user_id"),
                                rs.getLong("vote_id"),
                                rs.getLong("u_id"),
                                rs.getLong("option_id")
                        )
                );
            }
        }catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }finally {
            try{
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

    VoteUser findVoteUserByUIdVoteId(long uId, long voteId){
        String sql = "select * from vote_user where u_id = ? and vote_id = ?";
        List<VoteUser> voteUsers = new ArrayList<>();
        try{
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1, uId);
            ps.setLong(2, voteId);

            rs = ps.executeQuery();
            if(rs.next()){
                       return new VoteUser(
                                rs.getLong("vote_user_id"),
                                rs.getLong("vote_id"),
                                rs.getLong("u_id"),
                                rs.getLong("option_id")
                        );
            }
        }catch (SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }finally {
            try{
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

    void updateVoteUser(VoteUser voteUser){
        String sql = "update vote_user set vote_id = ?, u_id = ?, option_id = ? where vote_user_id = ?";
        try{
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1, voteUser.getVoteId());
            ps.setLong(2, voteUser.getVoteUserId());
            ps.setLong(3, voteUser.getOptionId());
            ps.setLong(4, voteUser.getVoteUserId());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            try{
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

    void deleteAll(){
        String sql = "delete from vote_user";
        try{
            conn = ConnectionManager.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }finally {
            try{
                conn.close();
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }
    }
    

    void deleteVoteUserByUId(long uId){
        String sql = "delete from vote_user where u_id = ?";
        try{
            conn = ConnectionManager.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, uId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }finally {
            try{
                conn.close();
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }
    }

    void deleteVoteUserByUIdVoteId(long uId, long voteId){
        String sql = "delete from vote_user where u_id = ? and vote_id = ?";
        try{
            conn = ConnectionManager.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1,uId);
            ps.setLong(2,voteId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }finally {
            try{
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
}

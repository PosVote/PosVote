package study.postvote.respository;

import study.postvote.domain.Option;
import study.postvote.respository.db.ConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OptionRepository {

    Connection conn;
    PreparedStatement ps;
    ResultSet rs;

    void save(Option option){ // Option 하나만 넣을 때.
        String sql = "insert into option (label, vote_id) values(?, ?)";

        try{
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, option.getLabel());
            ps.setLong(2, option.getVoteId());
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

    void saveList(List<Option> optionList){ //Option List 형식으로 받아서 한번에 업데이트.
        String sql = "insert into option (label, vote_id) values ";

        for(int i = 0; i < optionList.size() -1; i++){
            sql += "(?, ?), ";
        }
        sql += "(?, ?)";

        try{
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            int psIndex = 1;
            for(Option option: optionList){
                ps.setString(psIndex++, option.getLabel());
                ps.setLong(psIndex++, option.getVoteId());
            }
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

    void update(Option option){
        String sql = "update option set label = ?, vote_id = ? where option_id = ?";
        try{
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, option.getLabel());
            ps.setLong(2, option.getVoteId());
            ps.setLong(3, option.getOptionId());
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

    Option findByOptionId(long id){
        String sql = "select * from option where option_id = ?";
        try{
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1, id);

            rs = ps.executeQuery();
            if(rs.next()){
                       return new Option(
                                rs.getLong("option_id"),
                                rs.getString("label"),
                                rs.getLong("vote_id")
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


    List<Option> findByVoteId(long id){
        String sql = "select * from option where vote_id = ?";
        List<Option> optionList = new ArrayList<>();
        try{
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1, id);

            rs = ps.executeQuery();
            while(rs.next()){
                optionList.add(
                        new Option(
                                rs.getLong("option_id"),
                                rs.getString("label"),
                                rs.getLong("vote_id")
                        )
                );
            }
            return optionList;
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
    }


    List<Option> findAll(){
        String sql = "select * from option";
        List<Option> optionList = new ArrayList<>();
        try{
            conn = ConnectionManager.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                optionList.add(
                        new Option(
                                rs.getLong("option_id"),
                                rs.getString("label"),
                                rs.getLong("vote_id")
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
        return optionList;
    }

    void deleteByVoteId(long id){
        String sql = "delete from option where vote_id = ?";
        try{
            conn = ConnectionManager.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, id);
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

    void deleteByOptionId(long id){
        String sql = "delete from option where option_id = ?";
        try{
            conn = ConnectionManager.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, id);
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
    void deleteAll(){
        String sql = "delete from option";
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


}

package study.postvote.respository.db;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ConnectionManager {

    public static Connection getConnection() {
        Connection con = null;
        String driver = "com.mysql.cj.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/posvote";
        String id = "root";
        String pwd = "1234";

        try {
            Class.forName(driver);
            try {
                con = DriverManager.getConnection(url, id, pwd);
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                System.out.println("Connection Failed!");
                e.printStackTrace();    // 예외 발생시 내용 출력
            }
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            System.out.println("Connection Failed. Check Driver or URL");
            e.printStackTrace();        // 예외 발생시 내용 출력
        }

        return con;
    }
}
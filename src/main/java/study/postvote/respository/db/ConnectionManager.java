package study.postvote.respository.db;

import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PropertiesLoaderUtils;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ConnectionManager {

    public static Connection getConnection() {
        Connection con = null;
        String driver = "com.mysql.cj.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/db01";
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

    private static Properties loadPropertiesFromFile(String filePath) throws IOException, IOException {
        ClassPathResource resource = new ClassPathResource(filePath);
        return PropertiesLoaderUtils.loadProperties(resource);
    }
}
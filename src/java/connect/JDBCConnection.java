/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package connect;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author User
 */
public class JDBCConnection {
    
    public static Connection getJDBCConnection()
    {
        final String url = "jdbc:mysql://localhost:3306/demo?useUnicode=true&characterEncoding=utf-8";
        final String user = "root";
        final String password = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(JDBCConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return null;
    }
    
    public static void main(String[] args) {
        Connection con = getJDBCConnection();
        if( con != null)
        {
            System.out.println("Thanh Cong");
        }
        else
        {
            System.out.println("That Bai");
        }
    }
}

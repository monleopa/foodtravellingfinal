/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import connect.JDBCConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;
import model.Report;

/**
 *
 * @author User
 */
public class ReportDao {
    public static boolean addReport(Report report){
        Connection con = JDBCConnection.getJDBCConnection();
        PreparedStatement ps = null;
        String sql = "insert into report(report_content, user_id, user_name, post_id, report_status) values(?,?,?,?,?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, report.getReportContent());
            ps.setLong(2, report.getUserID());
            ps.setString(3, report.getUserName());  
            ps.setLong(4, report.getPostID());
            ps.setLong(5, report.getReportStatus());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(ReportDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public ArrayList<Report> getListReport() throws SQLException{
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = "SELECT * FROM report";
        PreparedStatement ps = con.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Report> list = new ArrayList<>();
        while(rs.next()){
            Report report = new Report();
            report.setReportID(rs.getLong("report_id"));
            report.setReportContent(rs.getString("report_content"));
            report.setUserID(rs.getLong("user_id"));
            report.setUserName(rs.getString("user_name"));
            report.setPostID(rs.getLong("post_id"));
            report.setReportStatus(rs.getLong("report_status"));
            list.add(report);
        }
        return list;   
    }
    
    public static boolean deleteReport(String postID){
        Connection con = JDBCConnection.getJDBCConnection();
        String sqlReport = "DELETE FROM report WHERE post_id = '" + postID + "'";
        Statement st;
        try {
            st = con.createStatement();
            st.executeUpdate(sqlReport);
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return false;
    }
    
        public static String countReport(){
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = "SELECT COUNT(*) FROM report WHERE report_status = '0'";
        Statement st;
        try {
            st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            String count = "";
            while(rs.next()){
                count = rs.getString(1);
            }
            return count;
        } catch (SQLException ex) {
            Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "0";
    }
}

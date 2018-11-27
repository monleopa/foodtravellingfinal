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
import model.Comment;
import model.Post;

/**
 *
 * @author User
 */
public class CommentDao {

    public static boolean AddComment(Comment cmt) {
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = "insert into comment(comment_content,comment_post_id,comment_user_id,comment_user_name)"
                + " values(?,?,?,?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, cmt.getCommentContent());
            ps.setLong(2, cmt.getPostID());
            ps.setLong(3, cmt.getUserCommentID());
            ps.setString(4, cmt.getUserCommentName());
            ps.executeUpdate();
            con.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(CommentDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static ArrayList<Comment> getListComment(long postID) throws SQLException {
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = "SELECT * FROM comment WHERE comment_post_id = '" + postID + "'";
        PreparedStatement ps = con.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Comment> listComment = new ArrayList<>();
        while (rs.next()) {
            Comment cmt = new Comment();
            cmt.setCommentID(rs.getLong("comment_id"));
            cmt.setCommentContent(rs.getString("comment_content"));
            cmt.setPostID(rs.getLong("comment_post_id"));
            cmt.setUserCommentID(rs.getLong("comment_user_id"));
            cmt.setUserCommentName(rs.getString("comment_user_name"));
            listComment.add(cmt);
        }
        con.close();
        return listComment;
    }
    
    public static boolean deleteComment(String commentID){
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = "DELETE FROM comment WHERE comment_id = '" + commentID + "'";
        Statement st;
        try {
            st = con.createStatement();
            st.executeUpdate(sql);
            con.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return false;
    }
    
    public static boolean editComment(String commentID, String content){
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = "UPDATE comment set comment_content=? WHERE comment_id='"+commentID+"'";
        PreparedStatement ps = null;
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, content);
            ps.executeUpdate();
            con.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }
}

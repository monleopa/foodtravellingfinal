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
import model.Post;
import model.User;

/**
 *
 * @author User
 */
public class PostDao {

    public static boolean UploadPost(Post post) {
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = "insert into post(post_name,post_location,post_filename,post_content,post_image,post_category,user_id)"
                + " values(?,?,?,?,?,?,?)";
        PreparedStatement ps = null;
        try {
            System.out.println("haha");
            ps = con.prepareStatement(sql);
            ps.setString(1, post.getPostName());
            ps.setString(2, post.getPostLocation());
            ps.setString(3, post.getPostFileName());
            ps.setString(4, post.getPostContent());
            ps.setString(5, post.getPostImage());
            ps.setLong(6, post.getPostCategory());
            ps.setLong(7, post.getPostUserId());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public ArrayList<Post> getListPost(String category, long userID) throws SQLException {
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = null;
        if (category.equalsIgnoreCase("full")) {
            sql = "SELECT * FROM post, user WHERE post.user_id = user.user_id ORDER BY post_id DESC";
        } else if (category.equalsIgnoreCase("food")) {
            sql = "SELECT * FROM post, user WHERE post_category = 1 AND post.user_id = user.user_id ORDER BY post_id DESC";
        } else if (category.equalsIgnoreCase("travelling")) {
            sql = "SELECT * FROM post, user WHERE post_category = 2 AND post.user_id = user.user_id ORDER BY post_id DESC";
        } else if (category.equalsIgnoreCase("follow")) {
            sql = "SELECT * FROM post, relationship, user WHERE follower_id = '"+ userID +"' AND following_id = post.user_id AND post.user_id = user.user_id ORDER BY post_id DESC";
        } else {
            sql = "SELECT * FROM post, user WHERE post.user_id = " + category + " AND post.user_id = user.user_id ORDER BY post_id DESC";
        }

        PreparedStatement ps = con.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Post> list = new ArrayList<>();
        while (rs.next()) {
            Post post = new Post();
            post.setPostID(rs.getLong("post_id"));
            post.setPostName(rs.getString("post_name"));
            post.setPostLocation(rs.getString("post_location"));
            post.setPostContent(rs.getString("post_content"));
            post.setPostFileName(rs.getString("post_filename"));
            post.setPostImage(rs.getString("post_image"));
            post.setPostCategory(rs.getLong("post_category"));
            post.setPostUserName(rs.getString("user_name"));
            post.setPostUserId(rs.getLong("post.user_id"));
            list.add(post);
        }
        con.close();
        return list;
    }

    public static Post getPost(String postID) {
        try {
            System.out.println(postID);
            Connection con = JDBCConnection.getJDBCConnection();
            String sql = "SELECT * FROM post, user WHERE post_id = '" + postID + "' AND post.user_id = user.user_id";
            PreparedStatement ps = con.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            Post post = new Post();
            if(rs.next()) {
                post.setPostID(rs.getLong("post_id"));
                post.setPostName(rs.getString("post_name"));
                post.setPostLocation(rs.getString("post_location"));
                post.setPostContent(rs.getString("post_content"));
                post.setPostFileName(rs.getString("post_filename"));
                post.setPostImage(rs.getString("post_image"));
                post.setPostCategory(rs.getLong("post_category"));
                post.setPostUserName(rs.getString("user.user_name"));
                post.setPostUserId(rs.getLong("user_id"));
                con.close();
                return post;
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public static void likePost(User user, String postID) throws SQLException{
        Connection con = JDBCConnection.getJDBCConnection();
        long pID = Long.parseLong(postID);
        String sql = "insert into liked(user_id, post_id) values(?,?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setLong(1, user.getUserID());
        ps.setLong(2, pID);
        ps.executeUpdate();
        con.close();
    }
    
    public static boolean checkLiked(User user, long postID){
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = "SELECT * FROM liked WHERE user_id = '" + user.getUserID() + "' AND post_id = '"+postID+"'";
        PreparedStatement ps;
        try {
            ps = con.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                con.close();
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
        } 
        
        return true;
    }
    
    public static void dislikePost(User user, String postID) throws SQLException{
        Connection con = JDBCConnection.getJDBCConnection();
        long pID = Long.parseLong(postID);
        String sql = "DELETE FROM liked WHERE user_id = '" + user.getUserID() + "' AND post_id = '"+postID+"'";
        Statement st = con.createStatement();
        st.executeUpdate(sql);
        con.close();
    }
    
    public static boolean deletePost(String postID){
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = "DELETE FROM post WHERE post_id = '" + postID + "'";
        String sqlLike = "DELETE FROM liked WHERE post_id = '" + postID + "'";
        String sqlCmt = "DELETE FROM comment WHERE comment_post_id = '" + postID + "'";
        String sqlReport = "DELETE FROM report WHERE post_id = '" + postID + "'";
        Statement st;
        try {
            st = con.createStatement();
            st.executeUpdate(sql);
            st.executeUpdate(sqlLike);
            st.executeUpdate(sqlCmt);
            st.executeUpdate(sqlReport);
            con.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return false;
    }
    
    public static String countlikePost(long postID){
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = "SELECT COUNT(*) FROM liked WHERE post_id = '"+postID+"'";
        Statement st;
        try {
            st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            String count = "";
            while(rs.next()){
                count = rs.getString(1);
            }
            con.close();
            return count;
        } catch (SQLException ex) {
            Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "0";
    }
    
    public static String countCommentPost(long postID){
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = "SELECT COUNT(*) FROM comment WHERE  comment_post_id = '"+postID+"'";
        Statement st;
        try {
            st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            String count = "";
            while(rs.next()){
                count = rs.getString(1);
            }
            con.close();
            return count;
        } catch (SQLException ex) {
            Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "0";
    }
    
//    public static void main(String[] args) throws SQLException {
//        System.out.println(PostDao.countCommentPost(23));
//    }
    
    public static boolean EditPost(Post post){
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = "UPDATE post set post_name=?,post_location=?,post_content=?,post_category=? WHERE post_id='"+post.getPostID()+"'";
        PreparedStatement ps = null;
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, post.getPostName());
            ps.setString(2, post.getPostLocation());
            ps.setString(3, post.getPostContent());
            ps.setLong(4, post.getPostCategory());
            ps.executeUpdate();
            con.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }
    
    public static ArrayList<Post> searchFood(String name){
        Connection con = JDBCConnection.getJDBCConnection();
        ArrayList<Post> list = new ArrayList<>();
        String sql;
        sql = "SELECT * FROM post, user WHERE post.user_id = user.user_id AND post_category = 1 AND (post_name LIKE '%"+name+"%' OR post_location LIKE '%"+name+"%')";
        try {
            PreparedStatement ps = con.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Post post = new Post();
                post.setPostID(rs.getLong("post_id"));
                post.setPostName(rs.getString("post_name"));
                post.setPostLocation(rs.getString("post_location"));
                post.setPostContent(rs.getString("post_content"));
                post.setPostFileName(rs.getString("post_filename"));
                post.setPostImage(rs.getString("post_image"));
                post.setPostCategory(rs.getLong("post_category"));
                post.setPostUserName(rs.getString("user.user_name"));
                post.setPostUserId(rs.getLong("user_id"));
                list.add(post);
            }
            con.close();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public static ArrayList<Post> searchTravel(String name){
        Connection con = JDBCConnection.getJDBCConnection();
        ArrayList<Post> list = new ArrayList<>();
        String sql = "SELECT * FROM post, user WHERE post.user_id = user.user_id AND post_category = 2 AND (post_name LIKE '%"+name+"%' OR post_location LIKE '%"+name+"%')";
        try {
            PreparedStatement ps = con.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Post post = new Post();
                post.setPostID(rs.getLong("post_id"));
                post.setPostName(rs.getString("post_name"));
                post.setPostLocation(rs.getString("post_location"));
                post.setPostContent(rs.getString("post_content"));
                post.setPostFileName(rs.getString("post_filename"));
                post.setPostImage(rs.getString("post_image"));
                post.setPostCategory(rs.getLong("post_category"));
                post.setPostUserName(rs.getString("user.user_name"));
                post.setPostUserId(rs.getLong("user_id"));
                list.add(post);
            }
            con.close();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
} 

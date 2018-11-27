/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author User
 */
public class User {
    private long userID;
    private String email, username, password,avata,avata_name;

    public String getAvata() {
        return avata;
    }

    public void setAvata(String avata) {
        this.avata = avata;
    }

    public String getAvata_name() {
        return avata_name;
    }

    public void setAvata_name(String avata_name) {
        this.avata_name = avata_name;
    }
    private long admin;

    public User() {
    }

    public User(long userID, String email, String username, String password, String avata, String avata_name, long admin) {
        this.userID = userID;
        this.email = email;
        this.username = username;
        this.password = password;
        this.avata = avata;
        this.avata_name = avata_name;
        this.admin = admin;
    }
    
    

    public User(long userID, String email, String username, String password, long admin) {
        this.userID = userID;
        this.email = email;
        this.username = username;
        this.password = password;
        this.admin = admin;
    }

    public long getUserID() {
        return userID;
    }

    public void setUserID(long userID) {
        this.userID = userID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public long getAdmin() {
        return admin;
    }

    public void setAdmin(long admin) {
        this.admin = admin;
    }
    
    
}

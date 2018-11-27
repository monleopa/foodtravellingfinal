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
public class Comment {

    @Override
    public String toString() {
        return "Comment{" + "commentID=" + commentID + ", userCommentID=" + userCommentID + ", postID=" + postID + ", userCommentName=" + userCommentName + ", commentContent=" + commentContent + '}';
    }
    private long commentID, userCommentID, postID;
    private String userCommentName, commentContent;
    
    public long getPostID() {
        return postID;
    }

    public void setPostID(long postID) {
        this.postID = postID;
    }

    public long getCommentID() {
        return commentID;
    }

    public void setCommentID(long commentID) {
        this.commentID = commentID;
    }

    public long getUserCommentID() {
        return userCommentID;
    }

    public void setUserCommentID(long userCommentID) {
        this.userCommentID = userCommentID;
    }

    public String getUserCommentName() {
        return userCommentName;
    }

    public void setUserCommentName(String userCommentName) {
        this.userCommentName = userCommentName;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public Comment(long commentID, long userCommentID, String userCommentName, String commentContent) {
        this.commentID = commentID;
        this.userCommentID = userCommentID;
        this.userCommentName = userCommentName;
        this.commentContent = commentContent;
    }

    public Comment() {
    }
    
    
}

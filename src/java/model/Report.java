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
public class Report {
    private long reportID, userID, postID, reportStatus;
    private String reportContent, userName;

    public Report(long reportID, long userID, long postID, long reportStatus, String reportContent, String userName) {
        this.reportID = reportID;
        this.userID = userID;
        this.postID = postID;
        this.reportStatus = reportStatus;
        this.reportContent = reportContent;
        this.userName = userName;
    }

    public Report() {
    }

    public long getReportID() {
        return reportID;
    }

    public void setReportID(long reportID) {
        this.reportID = reportID;
    }

    public long getUserID() {
        return userID;
    }

    public void setUserID(long userID) {
        this.userID = userID;
    }

    public long getPostID() {
        return postID;
    }

    public void setPostID(long postID) {
        this.postID = postID;
    }

    public long getReportStatus() {
        return reportStatus;
    }

    public void setReportStatus(long reportStatus) {
        this.reportStatus = reportStatus;
    }

    public String getReportContent() {
        return reportContent;
    }

    public void setReportContent(String reportContent) {
        this.reportContent = reportContent;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    
}

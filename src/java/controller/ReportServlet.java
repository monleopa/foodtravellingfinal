/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.ReportDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Report;
import model.User;

/**
 *
 * @author User
 */
@WebServlet(name = "ReportServlet", urlPatterns = {"/ReportServlet"})
public class ReportServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset = UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = new User();
        user = (User) session.getAttribute("user");
        String postid = request.getParameter("reportPostID");
        long postID = Long.parseLong(postid);
        System.out.println(postID);
        String content = request.getParameter("contentRP");
        
        Report report = new Report();
        report.setReportContent(content);
        report.setReportStatus(0);
        report.setUserName(user.getUsername());
        report.setUserID(user.getUserID());
        report.setPostID(postID);
        
        if(ReportDao.addReport(report) == true ){
            request.setAttribute("error2", "Report Success");
            response.sendRedirect("index.jsp");
        }
        else{
            request.setAttribute("error2", "Report Not Success");
            RequestDispatcher rq = request.getRequestDispatcher("index.jsp");
            rq.forward(request, response);
        }
    }
}

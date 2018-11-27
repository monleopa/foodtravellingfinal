/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.PostDao;
import DAO.ReportDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
@WebServlet(name = "OkReportServlet", urlPatterns = {"/OkReportServlet"})
public class OkReportServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String postID = request.getParameter("btnOKReport");
        if(ReportDao.deleteReport(postID) == true){
            response.sendRedirect("admin.jsp");
        }
        else{
            request.setAttribute("error2", "Delete Not Success");
            RequestDispatcher rq = request.getRequestDispatcher("admin.jsp");
            rq.forward(request, response);
        }
    }

}

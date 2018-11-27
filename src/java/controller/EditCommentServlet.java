/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.CommentDao;
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
@WebServlet(name = "EditCommentServlet", urlPatterns = {"/EditCommentServlet"})
public class EditCommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset = UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String commentID = request.getParameter("commentID");
        String postID = request.getParameter("postID");
        String content = request.getParameter("editContent");
        
        if(content.equals("")){
            response.sendRedirect("DetailUpload.jsp?postID=" + postID);
        }
        else {
            if (CommentDao.editComment(commentID, content) == true) {
            response.sendRedirect("DetailUpload.jsp?postID=" + postID);
            } else {
                request.setAttribute("error2", "Delete Not Success");
                RequestDispatcher rq = request.getRequestDispatcher("index.jsp");
                rq.forward(request, response);
            }
        }
    }
}

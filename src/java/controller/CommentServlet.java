/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.CommentDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Comment;
import model.User;

/**
 *
 * @author User
 */
@WebServlet(name = "CommentServlet", urlPatterns = {"/CommentServlet"})
public class CommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset = UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String content = request.getParameter("content_comment");
        String pID = request.getParameter("postID");
        long postID = Long.parseLong(pID);
        if(content.equals("")){
            response.sendRedirect("DetailUpload.jsp?postID=" + postID);
        }
        else {
            HttpSession session = request.getSession();
            User user = new User();
            user = (User) session.getAttribute("user");
            Comment cmt = new Comment();
            cmt.setCommentContent(content);
            cmt.setUserCommentID(user.getUserID());
            cmt.setUserCommentName(user.getUsername());
            cmt.setPostID(postID);

            System.out.println(cmt.toString());

            if (CommentDao.AddComment(cmt)) {
                response.sendRedirect("DetailUpload.jsp?postID=" + postID);
            } else {
                System.out.println("Error");
            }
        }

    }
}

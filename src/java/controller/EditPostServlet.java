/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.PostDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Post;

/**
 *
 * @author User
 */
@WebServlet(name = "EditPostServlet", urlPatterns = {"/EditPostServlet"})
public class EditPostServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset = UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String postID = request.getParameter("editPostID");
        String editName = request.getParameter("editName");
        String editLocation = request.getParameter("editLocation");
        String editContent = request.getParameter("editContent");
        String category = request.getParameter("editCategory");
        
        long postCategory = 2;
        if(category == null){
            postCategory = 1;
        }

        Post post = new Post();
        post = PostDao.getPost(postID);
        post.setPostName(editName);
        post.setPostLocation(editLocation);
        post.setPostContent(editContent);
        post.setPostCategory(postCategory);
        
        PostDao.EditPost(post);
        
        response.sendRedirect("index.jsp");
    }
}

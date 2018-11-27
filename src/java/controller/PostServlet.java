/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.PostDao;
import java.io.File;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.Post;
import model.User;

/**
 *
 * @author User
 */
@WebServlet(name = "PostServlet", urlPatterns = {"/PostServlet"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 *10,
    maxRequestSize = 1024 * 1024 * 5)
public class PostServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset = UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String postName = request.getParameter("postname");
        String postLocation = request.getParameter("location");
        String postContent = request.getParameter("content");    
        
        String category = request.getParameter("category");
        
        long postCategory = 2;
        if(category == null){
            postCategory = 1;
        }
        
        Part part = request.getPart("postfile");
        if(part == null){
            response.sendRedirect("index.jsp");
        }
    
        String fileName = extractFileName(part);
        if(fileName.equals("")){
            request.setAttribute("error2", "Phải đăng kèm ảnh");
            RequestDispatcher rq = request.getRequestDispatcher("index.jsp");
            rq.forward(request, response);
        }
        String savePath = "C:\\Users\\User\\Desktop\\foodtravelling-master\\build\\web\\PostImages" + File.separator + fileName;
        File fileSave = new File(savePath);
        
        System.out.println("clgt "+fileSave.getUsableSpace());
        
        part.write(savePath + File.separator);
        HttpSession session =  request.getSession();
        
        User user = new User();
        user = (User) session.getAttribute("user");
        
        Post post = new Post();
        post.setPostName(postName);
        post.setPostLocation(postLocation);
        post.setPostContent(postContent);
        post.setPostImage(savePath);
        post.setPostCategory(postCategory);
        post.setPostFileName(fileName);
        post.setPostUserId(user.getUserID());
        post.setPostUserName(user.getUsername());
        
        if(PostDao.UploadPost(post) == true ){
            response.sendRedirect("index.jsp");
        }
        else{
            request.setAttribute("error2", "Not Success");
            RequestDispatcher rq = request.getRequestDispatcher("index.jsp");
            rq.forward(request, response);
        }
//        response.sendRedirect("index.jsp");
//        out.println("<h1>Thanh Cong</h1>");
        
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for(String s : items){
            if(s.trim().startsWith("filename")){
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}

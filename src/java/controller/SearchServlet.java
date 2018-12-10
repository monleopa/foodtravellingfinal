/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.PostDao;
import DAO.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Post;
import model.User;

/**
 *
 * @author User
 */
@WebServlet(name = "SearchServlet", urlPatterns = {"/SearchServlet"})
public class SearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("searchname");
        ArrayList<User> listUser = UserDao.searchUser(name);
        ArrayList<Post> listFood = PostDao.searchFood(name);
        ArrayList<Post> listTravel = PostDao.searchTravel(name);
        
        request.setAttribute("listUser", listUser);
        request.setAttribute("listFood", listFood);
        request.setAttribute("listTravel", listTravel);
        RequestDispatcher view = request.getRequestDispatcher("search.jsp");
        view.forward(request, response);
    }
}

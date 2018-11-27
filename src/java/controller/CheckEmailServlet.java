/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.UserDao;

/**
 *
 * @author User
 */
public class CheckEmailServlet extends HttpServlet {

    UserDao userDao = new UserDao();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        if (userDao.checkEmail(request.getParameter("username"))) {
            response.getWriter().write("<img src=\"img/non-available.png\" />");
        } else {
            response.getWriter().write("<img src=\"img/available.png\" />");
        }
    }

}

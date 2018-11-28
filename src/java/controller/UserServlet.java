/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.UserDao;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;
import tools.MD5;

/**
 *
 * @author User
 */
public class UserServlet extends HttpServlet {

    UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String command = request.getParameter("command");
        String url = "index.jsp";
        String name = "";
        User user = new User();
        HttpSession session = request.getSession();
        switch (command) {
            case "insert":
                String email = request.getParameter("email");
                Pattern regex = Pattern.compile("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");
                Matcher matcher = regex.matcher(email);
                String uname = request.getParameter("uname");
                String password = request.getParameter("pass");
                String cfpassword = request.getParameter("copass");
                User getUser = new User();
                if (email.equals("") || email == null) {
                    request.setAttribute("error", "Email not null");
                    request.setAttribute("uname", uname);

                    RequestDispatcher rq = request.getRequestDispatcher(url);
                    rq.forward(request, response);
                }
                if (!matcher.matches()) {
                    request.setAttribute("error", "Email not right form");
                    request.setAttribute("uname", uname);

                    RequestDispatcher rq = request.getRequestDispatcher(url);
                    rq.forward(request, response);
                }

                if (uname.equals("") || uname == null) {
                    request.setAttribute("error", "UserName not null");
                    request.setAttribute("email", email);
                    RequestDispatcher rq = request.getRequestDispatcher(url);
                    rq.forward(request, response);
                }
                Pattern regexUname = Pattern.compile("[$&+,:;=?@#|'<>.-^*()%!]");
                Matcher matcherUname = regexUname.matcher(uname);
                if (matcherUname.find()) {
                    request.setAttribute("error", "Username don't have special character ");
                    request.setAttribute("uname", uname);

                    RequestDispatcher rq = request.getRequestDispatcher(url);
                    rq.forward(request, response);
                }
                if (password.equals("") || password == null) {
                    request.setAttribute("error", "Pass not null");
                    request.setAttribute("email", email);
                    request.setAttribute("uname", uname);
                    RequestDispatcher rq = request.getRequestDispatcher(url);
                    rq.forward(request, response);
                }
                
                if (!cfpassword.equals(password)) {
                    request.setAttribute("error", "Confirm password is wrong");
                    request.setAttribute("email", email);
                    request.setAttribute("uname", uname);
                    RequestDispatcher rq = request.getRequestDispatcher(url);
                    rq.forward(request, response);
                }

                if (!email.equals("") && email != null && !password.equals("") && password != null && !uname.equals("") && uname != null && cfpassword.equals(password)) {
                    String pass = MD5.encryption(request.getParameter("pass"));
                    boolean checkemail = userDao.checkEmail(email);
                    if (checkemail == true) {
                        request.setAttribute("error", "Email existed");
                        request.setAttribute("email", email);
                        request.setAttribute("uname", uname);
                        RequestDispatcher rq = request.getRequestDispatcher(url);
                        rq.forward(request, response);
                    } else {
                        user.setEmail(email);
                        user.setUsername(uname);
                        user.setPassword(pass);
                        user.setAdmin(2);
                        if(userDao.inseartUser(user) == true){
                            User u = UserDao.getUserByEmail(user.getEmail());
                            try {
                                UserDao.follow(u.getUserID(), String.valueOf(u.getUserID()) );
                            } catch (SQLException ex) {
                                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
                            }
                            session.setAttribute("user", u);
                        }
                        response.sendRedirect("index.jsp");
                        break;
                    }
                }
            case "login":
                user = userDao.login(request.getParameter("login-email"), MD5.encryption(request.getParameter("login-pass")));
                if (user != null) {
                    session.setAttribute("user", user);
                    response.sendRedirect("index.jsp");
                } else {
                    request.setAttribute("error", "Wrong email or password");
                    response.sendRedirect(url);
                }
                break;
            case "logout":
                session.setAttribute("user", null);
                response.sendRedirect("index.jsp");
                break;
            case "updatePass": {
                String url1 = "changePass.jsp";
                User user2 = new User();
                user2 = (User) session.getAttribute("user");
                String password1 = user2.getPassword();
                long id1 = user2.getUserID();
                System.out.println(user2.getUserID());
                String oldPass = request.getParameter("oldPass");
                String newPass = request.getParameter("newPass");
                String cfnewPass = request.getParameter("cfnewPass");
                String pass1 = MD5.encryption(oldPass);
                if (oldPass.equals("") || oldPass == null) {
                    request.setAttribute("error", "OldPass not null");
                   
                    RequestDispatcher rq = request.getRequestDispatcher(url1);
                    rq.forward(request, response);
                }
                if (!password1.equals(pass1)) {
                    request.setAttribute("error", "Wrong Password!");
                    RequestDispatcher rq = request.getRequestDispatcher(url1);
                    rq.forward(request, response);
                }
                if (newPass.equals("") || newPass == null) {
                    request.setAttribute("error", "NewPass not null");
                   
                    RequestDispatcher rq = request.getRequestDispatcher(url1);
                    rq.forward(request, response);
                }
                if (!cfnewPass.equals(newPass)) {
                    request.setAttribute("error", "Confirm Password False");
                    RequestDispatcher rq = request.getRequestDispatcher(url1);
                    rq.forward(request, response);
                }

                if (password1.equals(pass1) && cfnewPass.equals(newPass)) {
                    String passnew = MD5.encryption(newPass);
                    userDao.updatePass(id1, passnew);
                    RequestDispatcher rq = request.getRequestDispatcher(url);
                    rq.forward(request, response);
                    break;
                }

            }
            case "update": {
                String newemail = request.getParameter("email");
                String newuname = request.getParameter("uname");
//                String id = request.getParameter("userID");
//                long num = Long.parseLong(id);
                User user1 = new User();
                user1 = (User) session.getAttribute("user");
                System.out.println(user1.getUserID());
//                user1.setUserID(num);
                user1.setEmail(newemail);
                user1.setUsername(newuname);
                long id = user1.getUserID();

//                userDao.updateUser(user1);
                UserDao userDao1 = new UserDao();
                try {
                    if (userDao1.updateUser(user1)) {
                        response.sendRedirect("index.jsp");
                    } else {
                        response.sendRedirect("error.jsp");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            }
            
        }
    }

}

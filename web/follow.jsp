<%@page import="DAO.UserDao"%>
<%@page import="model.User"%>
<%
    String followingID = request.getParameter("param2");
    User user = new User();
    user = (User) session.getAttribute("user");
    UserDao.follow(user.getUserID(), followingID);
%>
<%@page import="DAO.PostDao"%>
<%@page import="model.User"%>
<%
    String idPost = request.getParameter("param1");
    User user = new User();
    user = (User) session.getAttribute("user");
    PostDao.dislikePost(user, idPost);
    response.sendRedirect("index.jsp");
%>
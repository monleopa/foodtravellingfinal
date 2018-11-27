<%-- 
    Document   : ttcn
    Created on : Nov 26, 2018, 9:14:33 PM
    Author     : Han
--%>

<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/ttcn.css" rel="stylesheet" type="text/css" media="all" />
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        <%
            User user = new User();
            user = (User) session.getAttribute("user");
        %>
        <br><br><br><br>
    <center>
        <h1>Information</h1> <br>
        <h2><%= user.getUsername()%></h2>
        <br>
        <form method="POST" action="UserServlet">
<!--                        <input type="hidden" value="<%= user.getUserID()%>" name="userID" id="userID">-->
            <p style="margin-right: 250px; margin-bottom: 8px;" >Email</p>
            <input type="text" value="<%=user.getEmail()%>" name="email" id="email" class="custom-size">
            <br><br>
            <p style="margin-right: 220px; margin-bottom: 8px;" >UserName</p>
            <span id="user-result"></span>
            <input type="text" value="<%=user.getUsername()%>" name="uname" id="uname" class="custom-size">
            <br><br>
            <input type="hidden" value="update" name="command">
            <input type="submit" value="Update" class="custom-inp">
        </form>
            <br>
            <p><a href="changePass.jsp">Change Password</a></p>
    </center>
</body>
</html>

<%-- 
    Document   : changePass
    Created on : Nov 26, 2018, 10:06:18 PM
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
        <h1>Thay đổi mật khẩu</h1> <br>
        <h5 style="color: red"><%= request.getAttribute("error") != null ? request.getAttribute("error") : " "%></h5>
        <form method="POST" action="UserServlet">
            <input type="hidden" value="<%= user.getUserID()%>" name="userID" id="userID">
            <input type="password" placeholder=" Mật khẩu cũ" name="oldPass" id="oldPass" class="custom-size">
            <br><br>
            <input type="password" placeholder=" Mật khẩu mới" name="newPass" id="newPass" class="custom-size">
            <br><br>
            <input type="password" placeholder=" Xác nhận mật khẩu mới" name="cfnewPass" id="cfnewPass" class="custom-size">
            <br><br>
            
            <input type="hidden" value="updatePass" name="command">
            <input type="submit" value="Update" class="custom-inp">
        </form>
    </center>
    </body>
</html>

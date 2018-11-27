<%-- 
    Document   : FoodPost
    Created on : Oct 30, 2018, 10:15:17 AM
    Author     : User
--%>

<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        <% User user = null; %>
        <% if(session.getAttribute("user") != null){ 
        %>
        <div class="post">
            <div class="fix-detail-post"></div>
            <div class="detail-post">
                <br><br><br><br>
                <jsp:include page="ListPostUpload.jsp"><jsp:param name="loadPost" value="food"></jsp:param></jsp:include>
            </div>
            <div class="fix-detail-post"></div>
        </div>
        <% } else { %>
            <jsp:include page="signup.jsp"></jsp:include>
        <% } %>
    </body>
</html>

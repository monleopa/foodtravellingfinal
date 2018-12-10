<%-- 
    Document   : search
    Created on : Dec 10, 2018, 4:53:37 PM
    Author     : User
--%>

<%@page import="DAO.PostDao"%>
<%@page import="model.Post"%>
<%@page import="DAO.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/search.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/post.css" rel="stylesheet" type="text/css" media="all" />
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        
        <% User user = null; %>
        <% if(session.getAttribute("user") != null){ %>
        <br><br><br><br>
        <center>
            <button class="btn-search" onclick="showUsers()"> Users </button>
            <button class="btn-search" onclick="showFoods()"> Foods </button>
            <button class="btn-search" onclick="showTravels()"> Travellings </button>
        </center>
        <div id="listuser">
        <%
            if(request.getAttribute("listUser") != null) {
                ArrayList<User> list = (ArrayList) request.getAttribute("listUser");
        
                for(User u : list) {
        %>
            <center>
                <div class="search-user">
                    <div class="search-user-avatar">
                        <img src="img/avatar-default.png" width="75px" height="75px">
                    </div>

                    <div class="search-user-fix">
                        <div class="search-user-name">
                            <a href="home.jsp?userID=<%=u.getUserID()%>" class="link-search"><b><%= u.getUsername() %></b></a>
                        </div>
                        <div class="search-user-follow">
                            <img src="img/follow.png" width="15px" height="15px">  <%= UserDao.countFollowing(u.getUserID()) %> people following
                        </div>
                    </div>
                </div>
            </center>
        <% } } %>
        </div>
    
        <div id="listfood" style="display: none;">
        <%
            if(request.getAttribute("listFood") != null) {
            ArrayList<Post> listFood = (ArrayList) request.getAttribute("listFood");
            for(Post p : listFood) {
                int a = p.getPostContent().length();
                int b;
                int h;
                int h2 = 90;
                if (a % 64 == 0) {
                    b = a / 64;
                } else {
                    b = a / 64 + 1;
                }
                h = b * 16;
                if (b > 2) {
                    h2 = 90 + 16 * (b - 1);
                }
        %>
                <center>
                    <div class="search-user-food" style="height: <%=h2%>px;">
                        <a href="DetailUpload.jsp?postID=<%=p.getPostID()%>" style="text-decoration: none;">
                        <div class="upload-nalo">
                            <div class="upload-name" style="text-align: left; color: black;"><b><%=p.getPostName()%></b></div>
                            <div class="upload-location" style="text-align: left; color: #777;"><%=p.getPostLocation()%></div>
                        </div>
                        
                        <div class="post-content" style="text-align: left; color: black;">
                            <%=p.getPostContent()%>
                        </div>
                        <hr>
                        <div style="width: 100%;">
                            <div class="btn-fix-btn"></div>
                            <button type="submit" class="btn-search-btn">
                                <img src="img/love.png" width="15px" height="15px"> Like (<%=PostDao.countlikePost(p.getPostID())%>)
                            </button>
                            <button class="btn-search-btn">
                                <img src="img/message.png" width="15px" height="15px"> Comment (<%=PostDao.countCommentPost(p.getPostID())%>)
                            </button>
                            <div class="btn-fix-btn"></div>
                        </div>
                        </a>
                    </div>
                </center>
            
        <% } } %>
        </div>
        
        <div id="listtravel" style="display: none; width: 100%;">
        <%
            if(request.getAttribute("listTravel") != null) {
            ArrayList<Post> listTravel = (ArrayList) request.getAttribute("listTravel");
            for(Post p : listTravel) {
                int a = p.getPostContent().length();
                int b;
                int h;
                int h2 = 90;
                if (a % 64 == 0) {
                    b = a / 64;
                } else {
                    b = a / 64 + 1;
                }
                h = b * 16;
                if (b > 2) {
                    h2 = 90 + 16 * (b - 1);
                }
        %>
                <center>
                    <div class="search-user-food" style="height: <%=h2%>px;">
                        <a href="DetailUpload.jsp?postID=<%=p.getPostID()%>" style="text-decoration: none;">
                        <div class="upload-nalo">
                            <div class="upload-name" style="text-align: left; color: black;"><b><%=p.getPostName()%></b></div>
                            <div class="upload-location" style="text-align: left; color: #777;"><%=p.getPostLocation()%></div>
                        </div>
                        
                        <div class="post-content" style="text-align: left; color: black;">
                            <%=p.getPostContent()%>
                        </div>
                        <hr>
                        <div style="width: 100%;">
                            <div class="btn-fix-btn"></div>
                            <button type="submit" class="btn-search-btn">
                                <img src="img/love.png" width="15px" height="15px"> Like (<%=PostDao.countlikePost(p.getPostID())%>)
                            </button>
                            <button class="btn-search-btn">
                                <img src="img/message.png" width="15px" height="15px"> Comment (<%=PostDao.countCommentPost(p.getPostID())%>)
                            </button>
                            <div class="btn-fix-btn"></div>
                        </div>
                        </a>
                    </div>
                </center>
            
        <% } } %>
        </div>
        
        <% } else { %>
            <jsp:include page="signup.jsp"></jsp:include>
        <% } %>
    </body>
</html>

<script type="text/javascript">
    function showUsers(){
        document.getElementById("listuser").style.display = "block";
        document.getElementById("listfood").style.display = "none";
        document.getElementById("listtravel").style.display = "none";
    }
    
    function showFoods(){
        document.getElementById("listuser").style.display = "none";
        document.getElementById("listfood").style.display = "block";
        document.getElementById("listtravel").style.display = "none";
    }
    
    function showTravels(){
        document.getElementById("listuser").style.display = "none";
        document.getElementById("listfood").style.display = "none";
        document.getElementById("listtravel").style.display = "block";
    }
</script>
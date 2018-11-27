<%-- 
    Document   : home.jsp
    Created on : Oct 30, 2018, 2:00:48 PM
    Author     : User
--%>

<%@page import="DAO.UserDao"%>
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
        <%
            User user = new User();
            if(session.getAttribute("user") != null) {
            user = (User) session.getAttribute("user");
            User user2 = new User();
            String postUserId = request.getParameter("userID");
            user2 = UserDao.getUser(postUserId);
        %>
        <br><br><br><br>
        <div class="container-follow">
            <div class="fix-follow"></div>
            <div class="fix-avatar-follow-img">
                <div class="avatar-follow-img" style="background-image: url('img/avatar-default.png');"></div>
            </div>
            <div class="fix-follow2">
                <div class="name-follow"><b><%=user2.getUsername()%></b></div>
                <div class="following">
                    <div class="follow">Following: (<%= UserDao.countFollowing(user2.getUserID()) %>) </div>
                    <div class="follow">Followers: (<%= UserDao.countFollower(user2.getUserID()) %>) </div>
                </div>
            </div>
            <div class="follow-button">
                <% if(user.getUserID() != user2.getUserID()){
                        if(UserDao.checkFollow(user.getUserID(),user2.getUserID())){ %>        
                            <button class="btn-follow" value="0" onclick="return follow(<%= user2.getUserID() %>)" id="btnFollow">Follow</button>
                        <%} else { %> 
                            <button class="btn-follow" value="1" onclick="return follow(<%= user2.getUserID() %>)" id="btnFollow">Unfollow</button>
                        <% } } %>
            </div>
            <div class="fix-follow"></div>
        </div>

        <div class="post">
            <div class="fix-detail-post"></div>
            <div class="detail-post">
                <jsp:include page="ListPostUpload.jsp"><jsp:param name="loadPost" value="<%=postUserId%>"></jsp:param></jsp:include>
            </div>
            <div class="fix-detail-post"></div>
        </div>
            
        <% } else {%>
            <jsp:include page="signup.jsp"></jsp:include>
        <% } %>
    </body>
</html>


<script type="text/javascript">
    function follow(a){
        var btnFollow = "btnFollow";

        var checkFollow = document.getElementById(btnFollow).value;
        if(checkFollow == 0)
        {
            console.log("follow");
            document.getElementById(btnFollow).innerHTML = "Unfollow";
            document.getElementById(btnFollow).value = 1;
            var http = new XMLHttpRequest();
            http.open("POST", "http://localhost:8080/TravellingFood/follow.jsp", true);
            http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            var params = "param2=" + a;
            http.send(params);
            http.onload;
        }
        else
        {
            console.log("un");
            document.getElementById(btnFollow).innerHTML = "Follow";
            document.getElementById(btnFollow).value = 0;
            var http = new XMLHttpRequest();
            http.open("POST", "http://localhost:8080/TravellingFood/unfollow.jsp", true);
            http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            var params = "param2=" + a;
            http.send(params);
            http.onload;
        }
    }
</script>

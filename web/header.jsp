  
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
        <div class="header">			
            <div class="header-logo">
                <center><a href="index.jsp"><img src="img/logo.png" style="border-radius: 8px;"></a></center>
            </div>

            <% 
            User user = new User();
            if(session.getAttribute("user") != null)
            {
                user = (User) session.getAttribute("user");
                String ttcnUrl = "ttcn.jsp?userID=" + user.getUserID();
            %>    
                <div class="header-content">
                    <div class="header-search">
                        <form action="SearchServlet" method="GET">
                            <input type="text" name="searchname" class="txtsearch" placeholder=" Search">
                            <button type="submit" class="btnsearch"><img src="img/search.png" with="25px" height="25px"></button>
                        </form>
                    </div>

                    <div class="header-menu">
                        <ul>
                            <%
                                if(user.getAdmin() == 1 ){
                            %>
                            <li><a href="admin.jsp"><b>ADMIN</b> </a></li>
                            <% } %>
                            
                            <li><a href="home.jsp?userID=<%=user.getUserID()%>" style="text-transform: uppercase;"><b><%= user.getUsername() %></b></a></li>
                            <li><a href="FoodPost.jsp" value="1" name="food"><b>FOOD</b></a></li>
                            <li><a href="TravellingPost.jsp" value="2" name="travelling"><b>TRAVELLING</b> </a></li>
<!--                            <li><a href="<%=ttcnUrl%>" style=" padding-left: 5px;padding-right: 20px;"><b>PROFILE</b></a></li>
                            <img src="PostImages/<%=user.getAvata_name()%>" class="img-circle" width="17px;" alt="ttcn">-->
                            <li>
                                <form action="UserServlet" method="post">
                                    <input type="hidden" value="logout" name="command">
                                    <button type="submit" value="logout" class="btn-logout"><b>LOG OUT</b></button>
                                </form>
                            </li>	
                        </ul>
                    </div>
                </div>      
            <% } else { %>        
            <jsp:include page="login.jsp"></jsp:include>
            <% } %>
        </div>
    </body>
</html>

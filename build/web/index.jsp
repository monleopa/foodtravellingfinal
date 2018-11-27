<%-- 
    Document   : index
    Created on : Oct 17, 2018, 4:33:06 PM
    Author     : User
--%>

<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>JSP Page</title>
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
    </head>
    <body>    
        <jsp:include page="header.jsp"></jsp:include>
        <% 
            User user = null;
            if(session.getAttribute("user") != null)
            {
                user = (User) session.getAttribute("user");
            } else {
        %>        
        <%--<jsp:include page="login.jsp"></jsp:include>--%>
        <jsp:include page="signup.jsp"></jsp:include>
        <% } %>
        <br><br><br><br>
        <% if(user != null){ %>  
        <center>
            <h5 style="color: red"><%= request.getAttribute("error2") != null ? request.getAttribute("error2") : " "%></h5><br>
            
            <div class="show-post2">
                <div class="show-post3">
                    <img src="img/pencil.svg" width="12px" height="12px">
                    <b> Make a Post</b>
                </div>
            </div>
            
            <div style="display: block;" id="showpost">
                <form method="POST" action="PostServlet" enctype="multipart/form-data" id="formpost">
                    <input type="text" name="postname" id="nameOf" class="fix-post" placeholder="  Name of Food"/>
                    <input type="text" name="location" class="fix-post" placeholder="  Location"/> <br><br>
                    <textarea name="content" form="formpost" placeholder="  Write something" class="text-post"></textarea> <br>
                    <div class="fix-post2">
                        <input type="checkbox" name="category" id="category" onclick="myCheck()" value="1"/> Food/Travelling
                        <input type="file" name="postfile" class="btn-file"/>
                        <input type="submit" value="Upload" class="btn-post" />
                    </div>
                </form>
            </div>
        </center>
        
        <br><br> 
        
        <div class="post">
            <div class="fix-detail-post"></div>
            <div class="detail-post">
                <jsp:include page="ListPostUpload.jsp"><jsp:param name="loadPost" value="follow"></jsp:param></jsp:include>
            </div>
            <div class="fix-detail-post"></div>
        </div>
          
        <% } %>
        
    </body>
</html>

<script type="text/javascript">
    var checkBox = document.getElementById("category");
    function myCheck(){
        if(checkBox.checked === true){
            document.getElementById("nameOf").setAttribute("placeholder", "  Name of Travelling");
            document.getElementById("category").value = 2;
        }else{
            document.getElementById("nameOf").setAttribute("placeholder", "  Name of Food");
            document.getElementById("category").value = 1;
        }
    }
    
    function showPost(){
        if(document.getElementById("checkshow").value === '1'){
            document.getElementById("showpost").style.display = 'block';
            document.getElementById("checkshow").value = 2;
            document.getElementById("checkshow").innerHTML = "Close Post";
        }
        else{
            document.getElementById("showpost").style.display = 'none';
            document.getElementById("checkshow").value = 1;
            document.getElementById("checkshow").innerHTML = "What's on your mine, guy?";
        }
    }
</script>

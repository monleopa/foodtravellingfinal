<%-- 
    Document   : PostUpload
    Created on : Oct 29, 2018, 11:39:44 PM
    Author     : User
--%>

<%@page import="model.User"%>
<%@page import="DAO.PostDao"%>
<%@page import="model.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/post.css" rel="stylesheet" type="text/css" media="all" />
    </head>
    <body>     
        <%
        User user = null;
        if(session.getAttribute("user") != null) {
        user = (User) session.getAttribute("user");
        String param = request.getParameter("loadPost");
        long id = user.getUserID();
        %>
        <% PostDao pd = new PostDao(); %>
        <% for (Post p : pd.getListPost(param, id)) {%>
        <div class="upload">
            <div class="header-upload">
                <div class="avatar-post">
                    <img src="img/avatar-default.png" width="40px" height="40px">
                </div>
                <div class="postusername">
                    <a href="home.jsp?userID=<%=p.getPostUserId()%>" class="link-user"><b><%= p.getPostUserName()%></b></a>
                </div>
                <div class="option-upload">
                    <button class="btn-option"><b>...</b></button>
                    <div class="dropdown-option">
                        <%
                            if (user.getUserID() == p.getPostUserId() || user.getAdmin() == 1) {
                        %>
                        <form action="DeletePostServlet" method="POST">
                            <button type="submit" name="btnDelete" value="<%=p.getPostID()%>" class="btn-option-detail">
                                <b>Delete Post</b>
                            </button>
                        </form>

                        <button type="submit" name="<%="btnUpdate" + p.getPostID()%>" class="btn-option-detail" onclick="openEdit(<%=p.getPostID()%>)">
                            <b>Edit Post</b>
                        </button>
                        <%} else {%>
                        <button type="submit" name="<%="btnRP" + p.getPostID()%>" class="btn-option-detail" onclick="openReport(<%=p.getPostID()%>)">
                            <b>Report Post</b>
                        </button>
                        <% } %>
                    </div>
                </div>
            </div>

            <% if (user.getUserID() == p.getPostUserId() || user.getAdmin() == 1) {%>       
            <div class="edit-form" id="<%="btnEdit" + p.getPostID()%>" style="display: none;">
                <center>
                    <form method="POST" action="EditPostServlet" id="<%="edit" + p.getPostID()%>">
                        <input type="text" name="editName" id="nameOf" class="fix-post" value="<%=p.getPostName()%>"/>
                        <input type="text" name="editLocation" class="fix-post" value="<%=p.getPostLocation()%>" <br><br><br>
                        <textarea name="editContent" form="<%="edit" + p.getPostID()%>" class="text-post"><%=p.getPostContent()%></textarea><br>
                        <input type="hidden" value="<%=p.getPostID()%>" name="editPostID">
                        <div class="fix-post2">
                            <input type="checkbox" name="editCategory" id="category" onclick="myCheck()" value="1"/> Food/Travelling
                            <input type="submit" value="Edit" class="btn-edit" />
                            <input type="button" value="Close" class="btn-closeed" onclick="closeEdit(<%=p.getPostID()%>)"/>
                        </div>
                    </form>
                </center>
            </div>

            <% } else {%>

            <div class="report-form" id="<%="btnRP" + p.getPostID()%>" >
                <h4 style="margin: 5px 0 5px 5px">Report this Post</h4>
                <form id="<%="formRP" + p.getPostID()%>" name="<%="formRP" + p.getPostID()%>" action="ReportServlet" method="POST">
                    <textarea name="contentRP" form="<%="formRP" + p.getPostID()%>" placeholder=" Why are you report" class="content-report"></textarea> <br>
                    <input type="hidden" value="<%=p.getPostID()%>" name="reportPostID">
                    <input type="submit" value="Report" class="btn-report">
                    <button type="button" onclick="closeReport(<%=p.getPostID()%>)" class="btn-closerp">Close</button>
                </form>
            </div>

            <% }%>

            <div class="upload-nalo" id="<%="nalo" + p.getPostID()%>">
                <div class="upload-name"><b><%=p.getPostName()%></b></div>
                <div class="upload-location"><%=p.getPostLocation()%></div>
            </div>

            <%
                int a = p.getPostContent().length();
                int b;
                int h;
                int h2 = 530;
                if (a % 80 == 0) {
                    b = a / 80;
                } else {
                    b = a / 80 + 1;
                }
                h = b * 16;
                if (b > 2) {
                    h2 = 530 + 16 * (b - 1);
                }
            %>
            <div class="post-article" style="height: <%=h2%>px;">
                <div class="post-content" id="<%="content" + p.getPostID()%>" style="height: <%=h%>px;"><%=p.getPostContent()%></div>
                <a href="DetailUpload.jsp?postID=<%=p.getPostID()%>">
                    <div class="post-img" style="background-image: url('PostImages/<%=p.getPostFileName()%>')"></div>
                </a>
            </div>
            <center>
                <hr>
                <div style="width: 100%;">
                    <div class="fix-btn"></div>
                    <%
                        if (PostDao.checkLiked(user, p.getPostID())) {
                    %>
                    <button type="submit" class="btn" onclick="return liked(<%=p.getPostID()%>)" value="0" id="<%="btn" + p.getPostID()%>">
                        <img id="<%="img" + p.getPostID()%>" src="img/love.png" width="15px" height="15px"> Like (<%=PostDao.countlikePost(p.getPostID())%>)
                    </button>
                    <%} else {%>
                    <button type="submit" class="btn" onclick="return liked(<%=p.getPostID()%>)" value="1" id="<%="btn" + p.getPostID()%>">
                        <img id="<%="img" + p.getPostID()%>" src="img/love.png" width="15px" height="15px" style="background-color: #fb5e33;"> Like (<%=PostDao.countlikePost(p.getPostID())%>)
                    </button>
                    <%}%>


                    <button class="btn">
                        <img src="img/message.png" width="15px" height="15px"> Comment (<%=PostDao.countCommentPost(p.getPostID())%>)
                    </button>
                    <div class="fix-btn"></div>
                </div>
            </center>
        </div>
        <% } } %>

    </body>
</html>

<script type="text/javascript">
    function liked(a) {
        var btnLike = "btn" + a;
        var imgLike = "img" + a;
        var checkLike = document.getElementById(btnLike).value;
        if (checkLike == 0)
        {
            document.getElementById(imgLike).style.backgroundColor = "#fb5e33";
            document.getElementById(btnLike).value = 1;
            var http = new XMLHttpRequest();
  //          http.open("POST", "http://localhost:8080/TravellingFood/sublike.jsp", true);
            http.open("POST", "http://node194332-travellingfood.jelastic.servint.net/sublike.jsp", true);
            http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            var params = "param1=" + a;
            http.send(params);
            http.onload;
        } else
        {
            document.getElementById(imgLike).style.backgroundColor = "white";
            document.getElementById(btnLike).value = 0;
            var http = new XMLHttpRequest();
 //           http.open("POST", "http://localhost:8080/TravellingFood/dislike.jsp", true);
            http.open("POST", "http://node194332-travellingfood.jelastic.servint.net/dislike.jsp", true);
            http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            var params = "param1=" + a;
            http.send(params);
            http.onload;
        }
    }

    function openReport(a) {
        var btnRP = "btnRP" + a;
        document.getElementById(btnRP).style.display = "block";
    }

    function closeReport(a) {
        var btnRP = "btnRP" + a;
        document.getElementById(btnRP).style.display = "none";
    }

    function openEdit(a) {
        var btnEdit = "btnEdit" + a;
        var nalo = "nalo" + a;
        var content = "content" + a;
        document.getElementById(btnEdit).style.display = "block";
        document.getElementById(nalo).style.display = "none";
        document.getElementById(content).style.display = "none";
    }

    function closeEdit(a) {
        var btnEdit = "btnEdit" + a;
        var nalo = "nalo" + a;
        var content = "content" + a;
        document.getElementById(btnEdit).style.display = "none";
        document.getElementById(nalo).style.display = "block";
        document.getElementById(content).style.display = "block";
    }
</script>

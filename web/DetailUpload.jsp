<%-- 
    Document   : DetailUpload
    Created on : Nov 6, 2018, 2:30:06 PM
    Author     : User
--%>

<%@page import="model.Comment"%>
<%@page import="DAO.CommentDao"%>
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
        <link href="css/comment.css" rel="stylesheet" type="text/css" media="all" />
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        <%
            User user = new User();
            if (session.getAttribute("user") != null) {
                user = (User) session.getAttribute("user");
                Post p = new Post();
                String postID = "";

                if (request.getParameter("postID") != null) {
                    postID = request.getParameter("postID");
                    p = PostDao.getPost(postID);
                }
        %>
        <br><br><br><br>
        <div class="post">
            <div class="fix-detail-post"></div>
            <div class="detail-post">  
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
                                    user = (User) session.getAttribute("user");
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
                        <div class="post-img" style="background-image: url('PostImages/<%=p.getPostFileName()%>')"></div>
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
                        <hr>
                    </center>
                    <br>
                    <%
                        for (Comment cmt : CommentDao.getListComment(p.getPostID())) {
                    %>
                    <center>
                        <%
                            int a2 = cmt.getCommentContent().length();
                            int h3;
                            int b2;
                            if (a2 % 43 == 0) {
                                b2 = a2 / 43;
                            } else {
                                b2 = a2 / 43 + 1;
                            }
                            h3 = b2 * 15;
                        %>
                        <div class="zone-comment" style="height: <%=h3%>px;">
                            <div class="username-comment">
                                <b><%= cmt.getUserCommentName()%></b>
                            </div>
                            <div class="content-comment" id="<%= "comment"+cmt.getCommentID() %>">
                                <%= cmt.getCommentContent()%>
                            </div>
                            <% if( user.getUserID() == cmt.getUserCommentID() || user.getAdmin() == 1 ) { %>
                                <div class="form-edit-comment" id="<%= "formComment"+cmt.getCommentID() %>">
                                    <form action="EditCommentServlet" method="POST" id="<%= "editCMT"+cmt.getCommentID() %>">
                                        <input type="text" name="editContent" value="<%= cmt.getCommentContent()%>" style="width: 80%; height: <%=h3%>px;">
                                        <input type="hidden" name="commentID"  value="<%= cmt.getCommentID()%>">
                                        <input type="hidden" value="<%=p.getPostID()%>" name="postID">
                                        <button type="button" onclick="closeEditCMT(<%= cmt.getCommentID() %>)">close</button>
                                    </form>
                                </div>
                                <div class="delete-comment">
                                    <form action="DeleteCommentServlet" method="POST" id="<%="deleteComment" + cmt.getCommentID()%>">
                                        <input type="hidden" name="commentDelete"  value="<%= cmt.getCommentID()%>">
                                        <input type="hidden" value="<%=p.getPostID()%>" name="postID">
                                        <button type="submit" style="background-color: transparent; border: none;"><img src="img/delete.png" width="15px" height="15px"></button>
                                    </form>
                                </div>
                                <div class="edit-comment">
                                    <button id="<%="editCMT"+cmt.getCommentID()%>" onclick="showEditComment(<%=cmt.getCommentID()%>)" style="background-color: transparent; border: none;">
                                        <img src="img/pencil.svg" width="15px" height="15px">
                                    </button>
                                </div>  
                            <% } %>
                        </div>
                    </center> <br>

                    <% }%>

                    <center>
                        <div class="form-comment">
                            <form action="CommentServlet" method="POST" class="form-comments" id="comment">
                                <div class="user-comment"><b><%=user.getUsername()%></b></div>
                                <div class="input-comment">
                                    <input type="text" name="content_comment" placeholder="  Write a comment..." class="add-comment">
                                    <input type="hidden" value="<%=p.getPostID()%>" name="postID">
                                </div>
                            </form>
                        </div>
                    </center>
                </div>
            </div>  
            <div class="fix-detail-post"></div>
        </div>
        <%
        } else {
        %>        
        <jsp:include page="signup.jsp"></jsp:include>
        <% }%>
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
            http.open("POST", "http://localhost:8080/TravellingFood/sublike.jsp", true);
            http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            var params = "param1=" + a;
            http.send(params);
            http.onload;
        } else
        {
            document.getElementById(imgLike).style.backgroundColor = "white";
            document.getElementById(btnLike).value = 0;
            var http = new XMLHttpRequest();
            http.open("POST", "http://localhost:8080/TravellingFood/dislike.jsp", true);
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
    
    function showEditComment(a){
        var btnEdit = "formComment"+a;
        var btnComment = "comment"+a;
        document.getElementById(btnEdit).style.display = "block";
        document.getElementById(btnComment).style.display = "none";
    }
    
    function closeEditCMT(a){
        var btnEdit = "formComment"+a;
        var btnComment = "comment"+a;
        document.getElementById(btnEdit).style.display = "none";
        document.getElementById(btnComment).style.display = "block";
    }
</script>

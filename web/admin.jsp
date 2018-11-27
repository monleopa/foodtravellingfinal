<%-- 
    Document   : admin
    Created on : Nov 26, 2018, 2:32:14 PM
    Author     : User
--%>

<%@page import="model.Post"%>
<%@page import="DAO.PostDao"%>
<%@page import="DAO.UserDao"%>
<%@page import="model.Report"%>
<%@page import="DAO.ReportDao"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/admin.css" rel="stylesheet" type="text/css" media="all" />
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        <%
            User user = null;
            if (session.getAttribute("user") != null) {
                user = (User) session.getAttribute("user");
            }
            if (user == null) {
        %>
        <jsp:include page="signup.jsp"></jsp:include>
        <%
        } else {
            if (user.getAdmin() == 1) {
                String numberRP = ReportDao.countReport();
        %>
        <br><br><br><br>
    <center>
        <button class="btnadmin btn-posts" onclick="showPost()"><b>Posts Management</b></button>
        <button class="btnadmin btn-users" onclick="showUser()"><b>Users Management</b></button>
        <button class="btnadmin btn-reports" onclick="showReport()"><b>Reports Management (<%=numberRP%>)</b></button>
    </center>
    <br>

    <center>    
        <div class="posts" id="posts">
            <h2>Posts Management</h2> <br>
            <table>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Location</th>
                    <th>Content</th>
                    <th>Category</th>
                    <th>Link</th>
                    <th></th>
                </tr>
                <%
                    String param = "full";
                    int k = 0;
                    PostDao pd = new PostDao();
                    for (Post p : pd.getListPost(param, user.getUserID())) {
                        k++;
                %>

                <tr>
                    <td><%=k%></td>
                    <td><%= p.getPostName()%></td>
                    <td><%= p.getPostLocation()%></td>
                    <td><%= p.getPostContent()%></td>
                    <% if (p.getPostCategory() == 1) { %>
                    <td>Food</td>
                    <% } else {%>
                    <td>Travelling</td>
                    <% }%>
                    <td><a href="DetailUpload.jsp?postID=<%=p.getPostID()%>">link</a></td>
                    <td>
                        <form action="DeletePostServlet" method="POST">
                            <input type="hidden" name="btnDelete" value="<%=p.getPostID()%>">
                            <input type="submit" value="delete" class="btnDeleteRP">
                        </form>
                    </td>
                </tr>
                <% } %>
            </table>
        </div>    
    </center>

    <center>    
        <div class="users" id="users">
            <h2>Users Management</h2> <br>
            <table>
                <tr>
                    <th>#</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Link User</th>
                    <th></th>
                </tr>

                <% UserDao ud = new UserDao(); %>
                <%
                    int j = 0;
                    for (User u : ud.getListUser()) {
                        j++;
                %>
                <tr>
                    <td><%=j%></td>
                    <td> <a href="home.jsp?userID=<%=u.getUserID()%>"><%=u.getUsername()%></a> </td>
                    <td> <%= u.getEmail()%> </td>
                    <td> <a href="home.jsp?userID=<%=u.getUserID()%>">link</a> </td>
                    <td>
                        <form id="<%="btnDeleteUser" + u.getUserID()%>" action="DeleteUserServlet" method="POST">
                            <input type="hidden" name="btnDeleteUser" value="<%=u.getUserID()%>">
                            <input type="submit" value="delete" class="btnDeleteRP" onclick="showUser()">
                        </form>
                    </td>
                </tr>
                <% } %>
            </table>
        </div>    
    </center>

    <center>
        <div class="reports" id="reports">
            <h2> Reports Management </h2> <br>
            <table>
                <tr>
                    <th>#</th>
                    <th>User Report</th>
                    <th>Content Report</th>
                    <th>Link Post</th>
                    <th></th>
                    <th></th>
                </tr>
                <%
                    int i = 0;
                    ReportDao rpd = new ReportDao();
                    for (Report rp : rpd.getListReport()) {
                        i++;
                %>    
                <tr>
                    <td><%=i%></td>
                    <td> <a href="home.jsp?userID=<%=rp.getUserID()%>"><%=rp.getUserName()%></a> </td>
                    <td><%=rp.getReportContent()%></td>
                    <td> <a href="DetailUpload.jsp?postID=<%=rp.getPostID()%>"> link </a> </td>
                    <td>
                        <form id="<%="btnDeleteReport" + rp.getReportID()%>" action="DeletePostServlet" method="POST">
                            <input type="hidden" name="btnDelete" value="<%=rp.getPostID()%>">
                            <input type="submit" value="delete" class="btnDeleteRP">
                        </form>
                    </td>
                    <td>
                        <form id="<%="btnOKReport" + rp.getReportID()%>" action="OkReportServlet" method="POST">
                            <input type="hidden" name="btnOKReport" value="<%=rp.getPostID()%>">
                            <input type="submit" value="OK" class="btnOK">
                        </form>
                    </td>
                </tr>    
                <% } %>
            </table>
        </div>
        <center>    

            <% } else { %>
            <jsp:include page="index.jsp"></jsp:include>
            <% }
            }%>
    </body>
</html>

<script type="text/javascript">
    function showPost() {
        document.getElementById("posts").style.display = 'block';
        document.getElementById("users").style.display = 'none';
        document.getElementById("reports").style.display = 'none';
    }

    function showUser() {
        document.getElementById("posts").style.display = 'none';
        document.getElementById("users").style.display = 'block';
        document.getElementById("reports").style.display = 'none';
    }

    function showReport() {
        document.getElementById("posts").style.display = 'none';
        document.getElementById("users").style.display = 'none';
        document.getElementById("reports").style.display = 'block';
    }
</script>

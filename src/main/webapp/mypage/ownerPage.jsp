<%@ page import="study.postvote.domain.User" %>
<%@ page import="study.postvote.service.UserService" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-06-02
  Time: 오후 7:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <style>
        .my-page {
            text-align: center;
            padding: 20px;
            background-color: #f2f2f2;
        }

        .greeting {
            text-align: right;
            margin-right: 80px;
        }
        .button {
            display: inline-block;
            text-decoration: none;
            background-color: #4CAF50;
            color: #fff;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }


    </style>
</head>
<%
    Long userid = (Long)session.getAttribute("userId");
    System.out.println("Username: " + userid);
    UserService userService = new UserService();
    User user = userService.findById(userid);
%>

<body>
<div class="my-page">
    <h1>마이페이지</h1>
</div>

<div class="greeting">
    <form method="post" action="update.jsp">
        <h3 ><%= user.getName()%>님 안녕하세요.</h3>
        <input class="button" type="submit" value="개인정보 수정">
    </form>
</div>

<div class ="container">
    <div>

    </div>

</div>


</body>
</html>

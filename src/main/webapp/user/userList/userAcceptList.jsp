<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="study.postvote.domain.User, study.postvote.service.UserService" %>
<%@ page import="java.util.List" %>
<%@ page import="study.postvote.domain.type.Status" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>유저 목록</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
        }

        .user {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f9f9f9;
        }

        .user-info {
            display: flex;
            align-items: center;
            flex-grow: 1;
        }

        .user-name {
            font-size: 16px;
            font-weight: bold;
            margin-right: 10px;
        }

        .user-age,
        .user-gender,
        .user-email {
            font-size: 14px;
            color: #888;
            margin-right: 10px;
        }

        .action-buttons {
            display: flex;
            align-items: center;
        }

        .exileUserButton {
            margin-left: 10px;
            padding: 8px 12px;
            background-color: #ff0606;
            border: none;
            color: white;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            cursor: pointer;
            border-radius: 4px;
        }

        .back-button {
            text-align: center;
            display: block;
            margin: 20px auto 0 auto;
            background-color: #ccc;
            border: none;
            color: #333;
            text-decoration: none;
            font-size: 14px;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 4px;
        }
        .back-button:hover{
            background-color: #0033ff;
            color: white;
            transition: 0.3s ease-in;
        }
    </style>
    <script>
        function exileUser(userId) {
            location.href = "../userExileProcess.jsp?userId=" + userId;
        }
    </script>
</head>
<body>
<%@include file="../../header.jsp" %>
<div class="container">
    <h1>유저 목록</h1>
    <%
        request.setCharacterEncoding("utf-8");
        Status status = (Status) session.getAttribute("status");
        Long orgId = (Long) session.getAttribute("orgId");

        if (Status.ACCEPT.equals(status)) {
            UserService userService = new UserService();
            List<User> userList = userService.findUserOfOrgByOrgIdAndStatus(orgId);

            if (userList.isEmpty()) {
    %>
    <p class="no-users">가입된 유저가 없습니다.</p>
    <%
    } else {
        for (User user : userList) {
    %>
    <div class="user">
        <div class="user-info">
            <span class="user-name">이름: <%= user.getName() %> </span>
            <span class="user-age">나이: <%= user.getAge() %></span>
            <span class="user-gender">성별: <%= user.getGender() == 0 ? "남자" : "여자" %></span>
            <span class="user-email">이메일: <%= user.getEmail() %></span>
        </div>
        <div class="action-buttons">
            <button class="exileUserButton" onclick="exileUser(<%= user.getUserId() %>)">추방</button>
        </div>
    </div>
    <%
            }
        }
    %>
    <button class="back-button" onclick="location.href='../../post/list.jsp?page=1'">뒤로 가기</button>
</div>
<%
    }
%>
</body>
</html>
<%@ page import="study.postvote.domain.type.Role" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>투브</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        /*.container {*/
        /*    max-width: 600px;*/
        /*    margin: 0 auto;*/
        /*    padding: 40px;*/
        /*    text-align: center;*/
        /*    display: flex;*/
        /*    flex-direction: column;*/
        /*    justify-content: center;*/
        /*    align-items: center;*/
        /*    height: 100vh;*/
        /*    */
        /*}*/
        .container {
            width: 400px;
            margin: 0 auto;
            padding: 40px;
            text-align: center;
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        h1 {
            color: #333;
            font-size: 32px;
            margin-bottom: 30px;
        }

        .button-wrapper {
            display: flex;
            gap: 10px;
        }

        .button {
            display: inline-block;
            padding: 12px 20px;
            font-size: 16px;
            text-align: center;
            text-decoration: none;
            background-color: #4CAF50;
            color: #fff;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<%
    Role role = (Role) session.getAttribute("role");
    if (role != null) {
        if (role.equals(Role.ADMIN))
            response.sendRedirect("/adminView/adminPage.jsp");
        else
            response.sendRedirect("/post/list.jsp");
    }
%>
<div class="container">
    <h1>VoteHub</h1>
    <p style="font-size: 18px; margin-bottom: 30px;">보트 허브에 오신 것을 환영합니다!</p>
    <div class="button-wrapper">
        <a class="button" href="user/login.jsp">로그인</a>
        <a class="button" href="user/signup.jsp">조직 생성</a>
    </div>
</div>
</body>
</html>

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

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 40px;
            text-align: center;
        }

        h1 {
            color: #333;
            font-size: 32px;
            margin-bottom: 30px;
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
    Long orgId = (Long) session.getAttribute("orgId");
    if (orgId != null) {
        response.sendRedirect("/post/list.jsp");
    }
%>
<div class="container">
    <h1>VoteHub</h1>
    <p style="font-size: 18px; margin-bottom: 30px;">보트 허브에 오신 것을 환영합니다!</p>
    <a class="button" href="user/login.jsp">로그인</a>
    <a class="button" href="user/signup.jsp">조직 생성</a>
</div>
</body>
</html>

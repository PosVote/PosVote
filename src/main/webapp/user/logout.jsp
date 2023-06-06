<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<head>
    <meta charset="UTF-8">
    <title>로그아웃</title>
    <script>
        alert('로그아웃되었습니다');
        location.href = "../index.jsp";
    </script>
</head>
<body>
<%
    // 세션 무효화
    session.invalidate();
//    out.println("<script>alert('로그아웃되었습니다');</script>");
//    // index.jsp로 리다이렉트
//    response.sendRedirect("../index.jsp");
%>
</body>
</html>
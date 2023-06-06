<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // 세션 무효화
    session.invalidate();
    out.println("<script>alert('로그아웃되었습니다');</script>");
    // index.jsp로 리다이렉트
    response.sendRedirect("../index.jsp");
%>
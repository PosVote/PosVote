<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page
        import="study.postvote.domain.User, study.postvote.service.UserService" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    UserService userService = new UserService();
    User user = userService.login(email, password);

    if (user != null) {
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("status", user.getStatus());
        session.setAttribute("role", user.getRole());
        session.setAttribute("orgId", user.getOrgId());
        response.sendRedirect("../post/list.jsp");
    } else {
        String errorMessage = "유효하지 않은 이메일 또는 비밀번호입니다.";
        request.setAttribute("errorMessage", errorMessage);
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }
%>
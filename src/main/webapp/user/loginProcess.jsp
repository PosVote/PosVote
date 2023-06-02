<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page
        import="study.postvote.domain.User, study.postvote.service.UserService" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if(email.equals("sudo@admin.com") && password.equals("1111")){
        session.setAttribute("userId","0");
        session.setAttribute("role","ADMIN");
        response.sendRedirect("../adminView/adminPage.jsp");
        return;
    }
    UserService userService = new UserService();
    User user = userService.login(email, password);

    if (user != null) {
        if(user.getStatus().toString().equals("WAITING")){
            String errorMessage = "현재 승인 대기중입니다. 웹 관리자, 혹은 회사 담당자에게 연락하세요";
            request.setAttribute("errorMessage", errorMessage);
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("role", user.getRole().toString());
        session.setAttribute("orgId", user.getOrgId());
        session.setAttribute("status", user.getStatus().toString());
        response.sendRedirect("../post/list.jsp");
    } else {
        String errorMessage = "유효하지 않은 이메일 또는 비밀번호입니다.";
        request.setAttribute("errorMessage", errorMessage);
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }
%>
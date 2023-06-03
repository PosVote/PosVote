<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page
        import="study.postvote.domain.User, study.postvote.service.UserService" %>
<%@ page import="study.postvote.util.StaticStr" %>
<%@ page import="study.postvote.domain.type.Role" %>
<%@ page import="study.postvote.domain.type.City" %>
<%@ page import="study.postvote.domain.type.Mbti" %>
<%@ page import="study.postvote.domain.type.Status" %>
<%@ page import="study.postvote.service.OrganizationService" %>
<%@ page import="study.postvote.domain.Organization" %>

<%
    session = request.getSession(false);
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    UserService userService = new UserService();
    OrganizationService organizationService = new OrganizationService();

    //admin 계정 생성
    if (email.equals(StaticStr.ADMIN_EMAIL) && password.equals(StaticStr.ADMIN_PASSWORD)) {
        if (userService.findByEmail(email) == null) {
            try {
                Long orgId = organizationService.save(new Organization("Admin"));
                userService.save(new User("Admin", 99, 0, City.SEOUL, StaticStr.ADMIN_EMAIL, StaticStr.ADMIN_PASSWORD, Mbti.ESTJ, Role.ADMIN, orgId, Status.ACCEPT));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    User user = userService.login(email, password);

    try {
        if (user.getRole().equals(Role.ADMIN)) {
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("role", user.getRole());
            response.sendRedirect("../adminView/adminPage.jsp");
            return;
        }

        if (user != null) {
            if (user.getStatus().toString().equals("WAITING")) {
                String errorMessage = "현재 승인 대기중입니다. 웹 관리자, 혹은 회사 담당자에게 연락하세요";
                request.setAttribute("errorMessage", errorMessage);
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            }
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
    } catch (Exception e) {
        e.printStackTrace();
        String errorMessage = "유효하지 않은 이메일 또는 비밀번호입니다.";
        request.setAttribute("errorMessage", errorMessage);
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }
%>
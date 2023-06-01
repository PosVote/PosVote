<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page
        import="study.postvote.domain.User, study.postvote.domain.type.City, study.postvote.domain.type.Mbti, study.postvote.domain.type.Role, study.postvote.service.UserService" %>

<%
    String name = request.getParameter("name");
    int age = Integer.parseInt(request.getParameter("age"));
    boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
    City city = City.valueOf(request.getParameter("city"));
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    Mbti mbti = Mbti.valueOf(request.getParameter("mbti"));
    Role role = Role.valueOf(request.getParameter("role"));
    long orgId = Integer.parseInt(request.getParameter("orgId"));

    User user = new User(name, age, gender, city, email, password, mbti, role, orgId);

    UserService userService = new UserService();
    try {
        userService.save(user);

        response.sendRedirect("../index.jsp");
    } catch (Exception e) {
        String errorMessage = "이미 중복되는 이메일이 있습니다.";
        request.setAttribute("errorMessage", errorMessage);
        RequestDispatcher dispatcher = request.getRequestDispatcher("signup.jsp");
        dispatcher.forward(request, response);
    }
%>
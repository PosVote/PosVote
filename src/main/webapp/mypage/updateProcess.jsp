<%@ page import="study.postvote.domain.type.City" %>
<%@ page import="study.postvote.domain.type.Mbti" %>
<%@ page import="study.postvote.service.UserService" %>
<%@ page import="study.postvote.domain.User" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-06-02
  Time: 오후 5:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    String name = request.getParameter("name");
    int age = Integer.parseInt(request.getParameter("age"));
    int gender = Integer.parseInt(request.getParameter("gender"));
    City city = City.valueOf(request.getParameter("city"));
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    Mbti mbti = Mbti.valueOf(request.getParameter("mbti"));



    UserService userService = new UserService();
    try {
        userService.save(user);
        response.sendRedirect("/user/login.jsp");
    } catch (Exception e) {
        String errorMessage = "이미 중복되는 이메일이 있습니다.";
        request.setAttribute("errorMessage", errorMessage);
        RequestDispatcher dispatcher = request.getRequestDispatcher("signup.jsp");
        dispatcher.forward(request, response);
    }
%>>

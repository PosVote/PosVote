<%@ page import="study.postvote.domain.type.Status" %>
<%@ page import="study.postvote.domain.type.Role" %>
<%@ page import="study.postvote.domain.type.Mbti" %>
<%@ page import="study.postvote.domain.type.City" %>
<%@ page import="study.postvote.domain.User" %>
<%@ page import="study.postvote.service.UserService" %><%--
  Created by IntelliJ IDEA.
  User: FastPc
  Date: 2023-06-05
  Time: 오후 3:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
  request.setCharacterEncoding("UTF8");
  Long userId = (Long)session.getAttribute("userId");
  String name = request.getParameter("name");
  int age = Integer.parseInt(request.getParameter("age"));
  int gender = Integer.parseInt(request.getParameter("gender"));
  City city = City.valueOf(request.getParameter("city"));
  String email = request.getParameter("email");
  String password = request.getParameter("password");
  Mbti mbti = Mbti.valueOf(request.getParameter("mbti"));
  Role role = Role.valueOf(request.getParameter("role"));
  Long orgId = Long.parseLong(request.getParameter("orgId"));
  Status status = Status.ACCEPT;

  UserService userService = new UserService();

  User user = new User(userId,name, age, gender, city, email, password, mbti, role, orgId, status);

  try {
    userService.updateUser(user);
    response.sendRedirect("/mypage/myPage.jsp");
  } catch (Exception e) {
    e.printStackTrace();
    System.out.println(email);
    out.println("    <script>\n" +
            "        window.alert(\"이미 존재하는 이메일입니다\");\n" +
            "        location.href= \"/user/editUser.jsp\";\n" +
            "    </script>");
  }

%>
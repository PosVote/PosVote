<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page
        import="study.postvote.domain.User, study.postvote.domain.type.City, study.postvote.domain.type.Mbti, study.postvote.domain.type.Role, study.postvote.service.UserService" %>
<%@ page import="study.postvote.domain.type.Status" %>
<%@ page import="study.postvote.domain.Organization" %>
<%@ page import="study.postvote.service.OrganizationService" %>

<%
    request.setCharacterEncoding("UTF8");
    String name = request.getParameter("name");
    int age = Integer.parseInt(request.getParameter("age"));
    int gender = Integer.parseInt(request.getParameter("gender"));
    City city = City.valueOf(request.getParameter("city"));
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    Mbti mbti = Mbti.valueOf(request.getParameter("mbti"));
    Role role = Role.valueOf(request.getParameter("role"));
    Long orgId = Long.parseLong(request.getParameter("orgId"));
    Status status = Status.WAITING;

    OrganizationService organizationService = new OrganizationService();

    if (orgId == -1) {
        Organization organization = new Organization(request.getParameter("orgName"));
        orgId = organizationService.save(organization);
    }

    User user = new User(name, age, gender, city, email, password, mbti, role, orgId, status);

    UserService userService = new UserService();
    try {
        userService.save(user);
        response.sendRedirect("/user/login.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println(email);
        String errorMessage = "이미 중복되는 이메일이 있습니다.";
        request.setAttribute("errorMessage", errorMessage);
        RequestDispatcher dispatcher = request.getRequestDispatcher("signup.jsp");
        dispatcher.forward(request, response);

        e.printStackTrace();
    }
%>
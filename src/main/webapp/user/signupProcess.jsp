<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page
        import="study.postvote.domain.User, study.postvote.domain.type.City, study.postvote.domain.type.Mbti, study.postvote.domain.type.Role, study.postvote.service.UserService" %>
<%@ page import="study.postvote.domain.type.Status" %>
<%@ page import="study.postvote.domain.Organization" %>
<%@ page import="study.postvote.service.OrganizationService" %>

<%
    String name = request.getParameter("name");
    int age = Integer.parseInt(request.getParameter("age"));
    int gender = Integer.parseInt(request.getParameter("gender"));
    City city = City.valueOf(request.getParameter("city"));
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    Mbti mbti = Mbti.valueOf(request.getParameter("mbti"));
    Role role = Role.OWNER;
    Status status = Status.WAITING;

    Organization organization = new Organization(request.getParameter("orgName"));
    OrganizationService organizationService = new OrganizationService();
    Long orgId = organizationService.save(organization);

    User user = new User(name, age, gender, city, email, password, mbti, role, orgId, status);

    UserService userService = new UserService();
    try {
        userService.save(user);
        response.sendRedirect("/user/login.jsp");
    } catch (Exception e) {
        System.out.println(e.getMessage());
        String errorMessage = "이미 중복되는 이메일이 있습니다.";
        request.setAttribute("errorMessage", errorMessage);
        RequestDispatcher dispatcher = request.getRequestDispatcher("signup.jsp");
        dispatcher.forward(request, response);

        organizationService.deleteById(orgId);
    }
%>
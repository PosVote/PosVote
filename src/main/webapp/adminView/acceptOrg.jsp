<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page
        import="study.postvote.domain.User, study.postvote.service.UserService" %>
<%@ page import="study.postvote.domain.type.Status" %>
<%@ page import="study.postvote.service.OrganizationService" %>

<%
    Long userId = Long.valueOf(request.getParameter("userId"));
    Long orgId = Long.valueOf(request.getParameter("orgId"));
    String type = request.getParameter("type");
    UserService userService = new UserService();
    OrganizationService organizationService = new OrganizationService();

    User user = userService.findById(userId);

    if (type.equals("accept")) {
        userService.updateStatus(user, Status.ACCEPT);
    } else {
        userService.deleteById(user.getUserId());
        organizationService.deleteById(orgId);
    }
    String redirectUrl = request.getHeader("referer");

    response.sendRedirect(redirectUrl);
%>
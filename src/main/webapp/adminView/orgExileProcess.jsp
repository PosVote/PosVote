<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page
        import="study.postvote.domain.User, study.postvote.service.UserService" %>
<%@ page import="study.postvote.domain.type.Status" %>
<%@ page import="study.postvote.service.OrganizationService" %>

<%
    Long orgId = Long.valueOf(request.getParameter("orgId"));
    UserService userService = new UserService();
    OrganizationService organizationService = new OrganizationService();

    userService.deleteByOrdId(orgId);
    organizationService.deleteById(orgId);

    String redirectUrl = request.getHeader("referer");

    response.sendRedirect(redirectUrl);
%>
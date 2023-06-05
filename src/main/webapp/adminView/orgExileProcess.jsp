<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page
        import="study.postvote.domain.User, study.postvote.service.UserService" %>
<%@ page import="study.postvote.domain.type.Status" %>
<%@ page import="study.postvote.service.OrganizationService" %>

<%
    System.out.println("ExileProcess Start");

    Long orgId = Long.valueOf(request.getParameter("orgId"));
    OrganizationService organizationService = new OrganizationService();

    //CASCADE 조건으로 묶여져 있다면, 부모 데이터가 삭제되었을 때 자동적으로 자식의 데이터도 삭제된다.
    // organization만 삭제해줘도, 그와 관련된 데이터는 삭제가 가능.
    organizationService.deleteById(orgId);// .
    String redirectUrl = request.getHeader("referer");
    response.sendRedirect(redirectUrl);
%>
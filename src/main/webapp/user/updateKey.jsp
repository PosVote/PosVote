<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="study.postvote.service.OrganizationKeyService" %>
<%@ page import="study.postvote.util.StaticStr" %>
<%
    request.setCharacterEncoding("utf-8");
    Long orgId = Long.parseLong(request.getParameter("orgId"));

    OrganizationKeyService organizationKeyService = new OrganizationKeyService();
    organizationKeyService.updateKey(orgId);
    String orgKey = organizationKeyService.findByOrgId(orgId).getOrgKey();

    response.setContentType("text/plain; charset=UTF-8");
    response.getWriter().write(orgKey);
%>
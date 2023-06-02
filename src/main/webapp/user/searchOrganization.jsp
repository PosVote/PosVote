<%@ page contentType="application/json" %><%@ page import="com.google.gson.Gson"%><%@ page import="study.postvote.service.OrganizationService"%><%@ page import="study.postvote.domain.Organization"%>

<%
    String id = request.getParameter("id");
    System.out.println("searchOrganizationId: " + id);

    // 입력된 id 값으로 조직 검색
    OrganizationService organizationService = new OrganizationService();
    Organization organization = organizationService.findById(Long.parseLong(id));

    // 검색 결과를 JSON 형식으로 반환
    if (organization != null) {
        response.getWriter().write(new Gson().toJson(organization));
    } else {
        response.getWriter().write("");
    }
%>
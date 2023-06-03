<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="study.postvote.domain.User, study.postvote.service.UserService" %>
<%@ page import="java.util.List" %>
<%@ page import="study.postvote.domain.type.Status" %>
<%@ page import="study.postvote.domain.type.Role" %>
<%@ page import="study.postvote.service.OrganizationService" %>
<%@ page import="study.postvote.dto.organization.response.OrganizationAdminViewResponse" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>조직 목록</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
        }

        .org {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f9f9f9;
        }

        .org-info {
            display: flex;
            align-items: center;
        }

        .org-name {
            font-size: 16px;
            font-weight: bold;
            margin-right: 10px;
        }

        .action-buttons {
            display: flex;
            align-items: center;
        }

        .exileUserButton {
            margin-left: 10px;
            padding: 8px 12px;
            background-color: #ff0606;
            border: none;
            color: white;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            cursor: pointer;
            border-radius: 4px;
        }

        .back-button {
            margin-top: 20px;
            background-color: #ccc;
            border: none;
            color: #333;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 4px;
        }

        .orgWaitingButton {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 8px 12px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            cursor: pointer;
            border-radius: 4px;
        }
    </style>
    <script>
        function orgWaiting() {
            location.href = "./orgWaitingList.jsp";
        }

        function exileOrg(orgId) {
            location.href = "./orgExileProcess.jsp?orgId=" + orgId;
        }
    </script>
</head>
<body>
<div class="container">
    <h1>조직 목록</h1>
    <button class='orgWaitingButton' onclick='orgWaiting()'>대기 조직 목록</button>
    <%
        request.setCharacterEncoding("utf-8");
        Long userId = (Long) session.getAttribute("userId");
        Role role = (Role) session.getAttribute("role");

        if (role == null || !role.equals(Role.ADMIN)) {
            response.sendRedirect("../index.jsp");
        }

        OrganizationService organizationService = new OrganizationService();
        List<OrganizationAdminViewResponse> orgList = organizationService.findAllOrgAdminView();
        if (orgList.isEmpty()) {
    %>
    <p class="no-users">가입된 조직이 없습니다.</p>
    <%
    } else {
        for (OrganizationAdminViewResponse org : orgList) {
    %>
    <div class="org">
        <div class="org-info">
            <span class="org-name">조직 이름: <%= org.getOrgName() %> </span>
            <span class="org-name">조직장: <%= org.getOwnerId() %></span>
            <span class="org-name">이메일: <%= org.getEmail() %></span>
            <span class="org-name">인원: <%= org.getOrgMemberCount() %>명</span>
        </div>
        <div class="action-buttons">
            <button class="exileUserButton" onclick="exileOrg(<%= org.getOrgId() %>)">추방</button>
        </div>
    </div>
    <%
            }
        }
    %>
</div>
</body>
</html>
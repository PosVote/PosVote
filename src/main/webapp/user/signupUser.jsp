<%@ page import="study.postvote.domain.Organization" %>
<%@ page import="java.util.List" %>
<%@ page import="study.postvote.service.OrganizationService" %>
<%@ page import="study.postvote.domain.type.Role" %>
<%@ page import="java.util.Objects" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>조직 생성</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 40px;
            text-align: center;
        }

        h1 {
            color: #333;
            font-size: 32px;
            margin-bottom: 30px;
        }

        form {
            text-align: left;
            margin-top: 20px;
        }

        label {
            display: block;
            margin-bottom: 10px;
        }

        input[type="text"],
        input[type="number"],
        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 4px;
            border: 1px solid #ccc;
            margin-bottom: 15px;
        }

        .checkbox-group {
            margin-bottom: 15px;
        }

        .checkbox-group label {
            display: inline-block;
            margin-right: 10px;
        }

        .submit-button {
            background-color: #4CAF50;
            color: #fff;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .submit-button:hover {
            background-color: #45a049;
        }

        .organization-search-button {
            background-color: #3f51b5;
            color: #fff;
            border: none;
            padding: 10px 15px;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .organization-search-button:hover {
            background-color: #3949ab;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 4px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }

        .organization-list {
            list-style: none;
            padding: 0;
        }

        .organization-list-item {
            margin-bottom: 10px;
            padding: 10px;
            background-color: #f2f2f2;
            border-radius: 4px;
        }

        .organization-list-item:hover {
            background-color: #e0e0e0;
        }

        .create-organization-button {
            background-color: #f44336;
            color: #fff;
            border: none;
            padding: 10px 15px;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .create-organization-button:hover {
            background-color: #d32f2f;
        }

        .disabled-input {
            background-color: #f2f2f2;
            color: #888;
        }
    </style>
</head>
<body>

<%
    Long orgId = Long.parseLong(request.getParameter("orgId"));
    OrganizationService organizationService = new OrganizationService();
    Organization organization = organizationService.findById(orgId);

    if (organization == null) {
        response.sendRedirect("../post/list.jsp");
    }
%>

<div class="container">
    <h1>조직 생성</h1>
    <form method="post" action="signupProcess.jsp">
        <label for="email">이메일:</label>
        <input type="email" id="email" name="email" required><br>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
        <p class="error-message"><%= errorMessage %>
        </p>
        <% } %>

        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password" required><br>

        <label for="name">이름:</label>
        <input type="text" id="name" name="name" required><br>

        <label for="age">나이:</label>
        <input type="number" id="age" name="age" required><br>

        <div class="checkbox-group">
            <label>성별:</label>
            <label>
                <input type="radio" name="gender" value="0" checked> 남자
            </label>
            <label>
                <input type="radio" name="gender" value="1"> 여자
            </label>
        </div>

        <label for="city">거주지:</label>
        <select id="city" name="city" required>
            <option value="SEOUL">서울</option>
            <option value="GYEONGGI">경기</option>
            <option value="INCHEON">인천</option>
            <option value="GANGWON">강원</option>
            <option value="SEJONG">세종</option>
            <option value="DAEJEON">대전</option>
            <option value="GYEONGBOOK">경북</option>
            <option value="GYEONGNAM">경남</option>
            <option value="BUSAN">부산</option>
            <option value="JEONBOOK">전북</option>
            <option value="JEONNAM">전남</option>
            <option value="GWANGJU">광주</option>
            <option value="JEJU">제주</option>
        </select>

        <label for="mbti">MBTI:</label>
        <select id="mbti" name="mbti" required>
            <option value="ISTJ">ISTJ</option>
            <option value="ISFJ">ISFJ</option>
            <option value="INFJ">INFJ</option>
            <option value="INTJ">INTJ</option>
            <option value="ISTP">ISTP</option>
            <option value="ISFP">ISFP</option>
            <option value="INFP">INFP</option>
            <option value="INTP">INTP</option>
            <option value="ESTP">ESTP</option>
            <option value="ESFP">ESFP</option>
            <option value="ENFP">ENFP</option>
            <option value="ENTP">ENTP</option>
            <option value="ESTJ">ESTJ</option>
            <option value="ESFJ">ESFJ</option>
            <option value="ENFJ">ENFJ</option>
            <option value="ENTJ">ENTJ</option>
        </select>

        <div>
            <label for="orgName">조직 이름: </label>
            <input type="text" id="orgName" name="orgName"
                   value="<%=organization == null ? "" : organization.getOrgName()%>"
                   disabled>
        </div>

        <input type="hidden" id="orgId" name="orgId" value="<%=organization == null ? "" : organization.getOrgId()%>">

        <input type="hidden" id="role" name="role" value=<%=Role.USER%>>

        <input type="submit" class="submit-button" value="신청">
    </form>
</div>
</body>
</html>
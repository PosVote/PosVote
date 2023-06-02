<%@ page import="study.postvote.service.UserService" %>
<%@ page import="study.postvote.domain.User" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-06-02
  Time: 오후 5:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
  <style>
    .my-page {
      text-align: center;
      padding: 20px;
      background-color: #f2f2f2;
    }
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
  </style>
</head>
<%
  Long userid = (Long)session.getAttribute("userId");
  System.out.println("Username: " + userid);
  UserService userService = new UserService();
  User user= userService.findById(userid);
%>
<body>
<div class="my-page">
  <h1>개인정보 수정</h1>
</div>
<div class="container">
  <form method="post" action="signupProcess.jsp">
    <label for="email">이메일:</label>
    <input type="email"  value="<%= user.getEmail() %>" id="email" name="email"><br>

    <label for="password">비밀번호:</label>
    <input type="password" value="<%= user.getPassword() %>" id="password" name="password"><br>

    <label for="name">이름:</label>
    <input type="text" value="<%= user.getName()%>" id="name" name="name"><br>

    <label for="age">나이:</label>
    <input type="number" value="<%= user.getAge()%>" id="age" name="age"><br>

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

    <input type="submit" class="submit-button" value="수정">
  </form>

</div>


</body>
</html>

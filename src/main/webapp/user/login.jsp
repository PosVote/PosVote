<%@ page import="study.postvote.domain.type.Role" %>
<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <style>
        @font-face {
            font-family: 'KIMM_Bold';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2212@1.0/KIMM_Bold.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }
        body {
            font-family: "KIMM_Bold", sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 400px;
            margin: 0 auto;
            padding: 40px;
            text-align: center;
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }


        h1 {
            color: #333;
            font-size: 24px;
            margin-bottom: 30px;
        }

        label {
            display: block;
            font-size: 16px;
            margin-bottom: 10px;
            text-align: left;
        }

        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 4px;
            border: 1px solid #ccc;
            margin-bottom: 20px;
        }

        .button {
            font-family: "KIMM_Bold", sans-serif;
            display: inline-block;
            padding: 12px 20px;
            font-size: 16px;
            text-align: center;
            text-decoration: none;
            background-color: #4CAF50;
            color: #fff;
            border-radius: 4px;
            transition: background-color 0.3s ease;
            border: none;
        }

        .button:hover {
            background-color: #2f7c33;
            cursor: pointer;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }

        .form-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .form-row label {
            width: 30%;
        }

        .form-row input[type="email"],
        .form-row input[type="password"] {
            width: 70%;
            margin-left: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>로그인</h1>
    <form method="post" action="loginProcess.jsp">
        <div class="form-row">
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-row">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" required>
        </div>

        <input type="submit" value="로그인" class="button">

        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
        <p class="error-message"><%= errorMessage %>
        </p>
        <% } %>
    </form>
</div>
</body>
</html>
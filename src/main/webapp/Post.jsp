<%@ page import="study.postvote.domain.User" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-06-01
  Time: 오후 8:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>글쓰기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            padding: 20px;
        }

        .container {
            max-width: 500px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            margin-top: 0;
        }

        label {
            font-weight: bold;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>글쓰기</h1>

    <br action="" method="post">
    <div>
        <label for="title">제목:</label>
        <input type="text" id="title" name="title" required>
    </div>
    <div>
        <label for="content">내용:</label>
        <textarea id="content" name="content" rows="5" required></textarea>
    </div>

    <div>
        <label for="title">투표항목:</label>
        <input type="text" name="row1" required>
        <input type="text" name="row2" required>
        <input type="text" name="row3" required>
        <input type="text" name="row4" required>
    </div>

    <input type="radio" name="type" value="0">익명
    <input type="radio" name="type" value="1">NO익명 </br>

    <div>
        <input type="submit" value="글쓰기">
    </div>

    </form>
</div>
</body>
</html>
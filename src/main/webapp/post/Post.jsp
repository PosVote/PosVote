<%@ page import="study.postvote.domain.User" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
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
    <script>
        const add_textBox = ()=>{
            const box = document.getElementById("textSet");
            const newTextField =  document.createElement('p');
            newTextField.innerHTML = "<input type='text' name='labels' + i><input type='button' value='삭제' onclick='remove(this)'>"
            box.appendChild(newTextField);

        }
        const remove = (obj) =>{
            document.getElementById('textSet').removeChild(obj.parentNode);
        }
    </script>

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
<div class="container">
    <h1>글쓰기</h1>

    <form action="CreatePostProcess.jsp" method="post">
    <div>
        <label for="title">제목:</label>
        <input type="text" id="title" name="title" required>
        <% Date date = new Date();
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            System.out.println(simpleDateFormat.format(date));
        %>
        <input type="date" min="<%=simpleDateFormat.format(date)%>" name="end_time">
    </div>
    <div>
        <label for="description">내용:</label>
        <textarea id="description" name="description" rows="5" required></textarea>
    </div>

    <div id="textSet">
        <label for="title">투표항목:</label>
        <input type="text" name="labels" required>
        <input type="text" name="labels" required>
        <input type="text" name="labels" required>
        <input type="text" name="labels" required>
    </div>
    <input type="button" value="필드 추가하기" onclick="add_textBox()"></br>
    <input type="radio" name="isAnonymous" value="0">익명
    <input type="radio" name="isAnonymous" value="1">NO익명 </br>
    <input type="radio" name="inputType" value="checkbox">다중선택 가능
    <input type="radio" name="inputType" value="radio">단일 선택</br>
    <div>
        <input type="submit" value="글쓰기">
    </div>

    </form>
</div>
</body>
</html>
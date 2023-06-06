<%@ page import="study.postvote.domain.User" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <script>
        const add_textBox = () => {
            const box = document.getElementById("textSet");
            const newTextField = document.createElement('p');
            newTextField.innerHTML = "<input type='text' name='labels' + i><input type='button' value='삭제' onclick='remove(this)'>"
            box.appendChild(newTextField);
        }

        const remove = (obj) => {
            document.getElementById('textSet').removeChild(obj.parentNode);
        }

        const validateForm = () => {
            const isAnonymousSelected = document.querySelector('input[name="isAnonymous"]:checked');
            const inputTypeSelected = document.querySelector('input[name="inputType"]:checked');

            if (!isAnonymousSelected || !inputTypeSelected) {
                alert("익명/NO익명과 다중 선택/단일 선택을 선택해야 합니다.");
                return false;
            }
        }
    </script>

    <title>투표 생성</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            /*padding: 20px;*/
            margin: 0;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative;

            /*display: flex;*/
            /*flex-direction: column;*/
            /*gap: 20px;*/
            /*max-width: 800px;*/
            /*margin: 20px auto;*/
            /*background-color: #fff;*/
            /*padding: 20px;*/
            /*border-radius: 5px;*/
            /*box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);*/
        }

        .container div {
            /*margin: 10px;*/
        }

        h1 {
            text-align: center;
            margin-top: 0;
        }

        label {
            font-weight: bold;
            margin-bottom: 15px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            resize: none;
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

        .button {
            margin: auto;
        }
    </style>
</head>
<body>
<%@include file="../header.jsp" %>
<div class="container">
    <h1>투표 생성</h1>

    <form action="createPostProcess.jsp" method="post" onsubmit="return validateForm()">
        <div>
            <label for="title">제목</label>
            <input type="text" id="title" name="title" required>
            <%
                Date date = new Date();
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            %>
        </div>
        <div>
            <label for="end_day">마감 기한</label><br/>
            <input type="datetime-local" id="end_day" min="<%=simpleDateFormat.format(date)%>" name="end_time">
        </div>
        <div>
            <label for="description">내용</label>
            <textarea id="description" name="description" rows="5" required></textarea>
        </div>

        <div id="textSet">
            <label for="title">투표 항목</label>
            <p><input type='text' name='labels'><input type='button' value='삭제' onclick='remove(this)'></p>
            <p><input type='text' name='labels'><input type='button' value='삭제' onclick='remove(this)'></p>
            <p><input type='text' name='labels'><input type='button' value='삭제' onclick='remove(this)'></p>
            <p><input type='text' name='labels'><input type='button' value='삭제' onclick='remove(this)'></p>
        </div>
        <input type="button" value="항목 추가하기" onclick="add_textBox()"><br/>

        <input type="radio" name="isAnonymous" value="0">익명
        <input type="radio" name="isAnonymous" value="1">NO익명<br/>

        <input type="radio" name="inputType" value="checkbox">다중선택 가능
        <input type="radio" name="inputType" value="radio">단일 선택<br/>
        <div class="button">
            <input type="submit" value="생성하기">
        </div>
    </form>
</div>
</body>
</html>
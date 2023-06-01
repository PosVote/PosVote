<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>회원가입</title>
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
<div class="container">
    <h1>Sign Up</h1>
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
                <input type="radio" name="gender" value="false" checked> 남자
            </label>
            <label>
                <input type="radio" name="gender" value="true"> 여자
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
            <label for="role">역할:</label>
            <select id="role" name="role" required>
                <option value="USER">User</option>
                <option value="OWNER">Owner</option>
            </select>
        </div>

        <div>
            <label for="organization">조직:</label>
            <input type="text" id="organization" name="organization" class="disabled-input" readonly>
            <button type="button" class="organization-search-button" onclick="openModal()">조직 찾기</button>
            <button type="button" class="create-organization-button" onclick="openCreateModal()" style="display: none;">조직 생성</button>
        </div>

        <input type="submit" class="submit-button" value="회원가입">
    </form>
</div>

<!-- Organization Search Modal -->
<div id="organizationSearchModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>조직 찾기</h2>
        <ul class="organization-list">
            <li class="organization-list-item">조직 1</li>
            <li class="organization-list-item">조직 2</li>
            <li class="organization-list-item">조직 3</li>
            <!-- Add more organization items here -->
        </ul>
    </div>
</div>

<!-- Organization Create Modal -->
<div id="organizationCreateModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeCreateModal()">&times;</span>
        <h2>조직 생성</h2>
        <!-- Add organization creation form here -->
    </div>
</div>

<script>
    function openModal() {
        document.getElementById("organizationSearchModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("organizationSearchModal").style.display = "none";
    }

    function openCreateModal() {
        document.getElementById("organizationCreateModal").style.display = "block";
    }

    function closeCreateModal() {
        document.getElementById("organizationCreateModal").style.display = "none";
    }
</script>
</body>
</html>
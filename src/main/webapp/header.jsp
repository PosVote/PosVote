<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="study.postvote.domain.type.Status" %>
<%@ page import="study.postvote.domain.type.Role" %>
<html>
<head>
    <title>header</title>
    <style>
        ul {
            list-style: none;
        }

        a {
            text-decoration: none;
            outline: none;
            color: black;
        }
        a:hover{
            transition: 0.3s ease-in;
            color: #0033ff;
        }
        .logout:hover{
            color: red;
        }
        .page {
            max-width: 1440px;
            margin: 0 auto 70px auto;
            padding: 0 20px;
            border-bottom: 2px solid black;
        }

        header {
            width: 90%;
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        header > h2 {
            margin-left: 20px;
        }

        header > nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-grow: 0.2;
            /*width: fit-content;*/
        }

        header ul {
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: space-between;
        }

        header ul > li {
            font-size: 16px;
            height: 100%;
            display: flex;
            align-items: center;
            padding: 10px;
        }
        .copy-button{
            padding: 10px;
        }
        .copy-button:hover{
            background-color: #0033ff;
            color: white;
            border: none;
            border-radius: 10px;
            transition: 0.3s ease-in;
            cursor: pointer;
        }
        @media (max-width: 600px) {
            header > h2 {
                font-size: 24px;
            }

            header ul > li {
                font-size: 14px;
            }
        }
    </style>
    <script>
        function copyText() {
            const myTextarea = document.getElementById("copyText");

            window.navigator.clipboard.writeText(myTextarea.value).then(() => {
                alert("초대 코드가 성공적으로 복사되었습니다");
            })
        }
    </script>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    Status status1 = (Status) session.getAttribute("status");
    Role role1 = (Role) session.getAttribute("role");

    if (Status.ACCEPT.equals(status1)) {

%>
<div class="page">
    <header>
        <a href="/post/list.jsp?page=1"><h2>VoteHub</h2></a>
        <nav>
            <ul>
                <%
                    if (Role.OWNER.equals(role1)) {
                %>
                <li><a href="/post/post.jsp">투표 생성</a></li>
                <li><a href="/user/userList/userAcceptList.jsp">유저 목록</a></li>
                <li><a href="/user/userList/userWaitingList.jsp">가입 신청 목록</a></li>
                <%
                    }
                %>
                <li><a href="/mypage/myPage.jsp">마이페이지</a></li>
                <li><a href="/user/logout.jsp" class="logout">로그아웃</a></li>
                <%
                    if (Role.OWNER.equals(role1)) {
                %>
                    <button class="copy-button" onclick="copyText()">초대 코드 복사</button>
                <%
                    }
                %>

            </ul>
        </nav>
    </header>
</div>
<%
    }
%>
</body>
</html>

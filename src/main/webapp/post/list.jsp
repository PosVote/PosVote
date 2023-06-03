<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="study.postvote.domain.Post, study.postvote.service.PostService" %>
<%@ page import="java.util.List" %>
<%@ page import="study.postvote.dto.post.response.PostListResponse" %>
<%@ page import="static study.postvote.util.StaticStr.SERVER_IP" %>
<%@ page import="study.postvote.domain.type.Status" %>
<%@ page import="study.postvote.domain.type.Role" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="study.postvote.service.VoteService" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
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
            position: relative;
        }

        h1 {
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
        }

        .post {
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f9f9f9;
        }

        .post-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .post-content {
            font-size: 14px;
            margin-bottom: 10px;
        }

        .post-meta {
            font-size: 12px;
            color: #888;
        }

        .no-posts {
            text-align: center;
            color: #888;
        }

        .header {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin-bottom: 20px;
        }

        .header button {
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
            margin-left: 10px;
        }

        .header .copy-button {
            background-color: #0033ff;
        }

        .header .logout-button {
            background-color: #ff3333;
        }

        .search-form {
            text-align: right;
        }

        .search-input {
            display: inline-block;
            width: 200px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-right: 10px;
        }

        .search-button {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 6px 12px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            cursor: pointer;
            border-radius: 4px;
        }
    </style>
    <script>
        function copyText() {
            const myTextarea = document.getElementById("copyText");

            window.navigator.clipboard.writeText(myTextarea.value).then(() => {
                alert("초대 코드 복사 완료");
            })
        }

        const makeVote = () => {
            window.location.href = "/post/post.jsp";
        }

        const logout = () => {
            window.location.href = "/user/logout.jsp";
        }
    </script>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    Status status = (Status) session.getAttribute("status");
    Long orgId = (Long) session.getAttribute("orgId");
    Role role = (Role) session.getAttribute("role");


    if (Status.ACCEPT.equals(status)) {
%>
<div class="header">
    <%
        if (Role.OWNER.equals(role)) {
    %>
    <button onclick="location.href='/user/userList/userAcceptList.jsp'">유저 목록</button>
    <button onclick="location.href='/user/userList/userWaitingList.jsp'">가입 신청 목록</button>
    <button onclick="makeVote()">투표 생성하기</button>
    <button class="copy-button" onclick="copyText()">초대 코드 복사</button>
    <%
        }
    %>
    <button class="logout-button" onclick="logout()">로그아웃</button>
</div>
<%
    }

%>
<div class="container">
    <h1>투표 게시판</h1>

    <%
        if (Status.ACCEPT.equals(status)) {
            PostService postService = new PostService();
            List<PostListResponse> postList = postService.findAllPostListResponse();
            //        int count = new VoteService().countVote();
            if (postList.isEmpty()) {
    %>
    <p class="no-posts">등록된 게시물이 없습니다.</p>
    <%
    } else {
    %>
    <div class="search-form">
        <form action="searchedPost.jsp" method="get">
            <input type="text" name="title" class="search-input" placeholder="제목을 입력하세요">
            <input type="submit" value="검색" class="search-button">
        </form>
    </div>
    <%
        for (PostListResponse post : postList) {
    %>
    <div class="post">
        <a class="post-title" href="postView.jsp?id=<%=post.getPostId()%>"><%=post.getTitle()%>
        </a>
        <p class="post-meta">
            작성자: <%=post.getName()%>
            작성일: <%=post.getDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))%>
            총 투표 수: <%=new VoteService().countVote(post.getPostId())%>
        </p>
    </div>
    <%
            }
        }

    %>
    <input type='text' style='display: none;' id='copyText' value='<%=SERVER_IP%>/user/signupUser.jsp?orgId=<%=orgId%>'
           readonly>
    <%
    } else {
    %>
    <p class="no-posts">승인되지 않거나 권한이 없습니다.</p>
    <%
        }
    %>
</div>
</body>
</html>
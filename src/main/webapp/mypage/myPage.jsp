<%@ page import="study.postvote.domain.User" %>
<%@ page import="study.postvote.service.PostService" %>
<%@ page import="study.postvote.domain.Post" %>
<%@ page import="study.postvote.service.VoteUserService" %>
<%@ page import="study.postvote.domain.Vote" %>
<%@ page import="study.postvote.service.UserService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="study.postvote.service.VoteService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>마이페이지</title>
    <style>
        body {
            background-color: #f2f2f2;
        }

        .my-page {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative;
            text-align: center;
            /*padding: 20px;*/
            /*background-color: #f2f2f2;*/
        }

        .greeting {
            text-align: right;
            margin-right: 80px;
        }

        .button {
            display: inline-block;
            text-decoration: none;
            background-color: #4CAF50;
            color: #fff;
            border-radius: 4px;
            transition: background-color 0.3s ease;
            margin-bottom: 30px;
        }

        .button:hover {
            background-color: #2d7e31;
            transition: 0.3s ease-in;
        }

        .post-box {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 10px;
        }

        .post-title {
            font-size: 18px;
            font-weight: bold;
        }

        .post-description {
            font-size: 14px;
        }
        .post {
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f9f9f9;
        }
        .post-meta {
            font-size: 12px;
            color: #888;
        }

    </style>
</head>
<%
    Long userid = (Long) session.getAttribute("userId");
    System.out.println("Username: " + userid);
    UserService userService = new UserService();
    User user = userService.findById(userid);

    PostService postService = new PostService();
    List<Post> postList = postService.findByMyVote(userid);
%>

<body>
<%@include file="../header.jsp" %>
<div class="my-page">
    <h1>마이페이지</h1>
    <div class="greeting">
        <form method="post" action="update.jsp">
            <h3><%= user.getName()%>님 안녕하세요</h3>
            <input class="button" type="submit" value="개인정보 수정">
        </form>
    </div>
    <h2>내가 투표한 글</h2>
    <% for (Post post : postList) {
    %>
    <div class="post">
        <a class="post-title" href="postView.jsp?id=<%=post.getPostId()%>"><%=post.getTitle()%>
        </a>
        <p class="post-meta">
            작성일: <%=post.getDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))%>
            총 투표 수: <%=new VoteService().countVote(post.getPostId())%>
        </p>
    </div>
<%--    <div class="post-box">--%>
<%--        <h3 class="post-title"> 제목 : <%= post.getTitle() %>--%>
<%--        </h3>--%>
<%--        <p class="post-description"> 내용 : <%= post.getDescription() %>--%>
<%--        </p>--%>
<%--    </div>--%>

    <%
        }
    %>
</div>
</body>
</html>
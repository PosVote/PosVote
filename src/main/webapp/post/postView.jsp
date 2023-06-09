<%@ page import="study.postvote.service.PostService" %>
<%@ page import="study.postvote.domain.Post" %>
<%@ page import="study.postvote.domain.type.Role" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>투표 상세 페이지</title>
    <style>
        @font-face {
            font-family: 'KIMM_Bold';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2212@1.0/KIMM_Bold.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }
        body {
            font-family: "KIMM_Bold", sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border: 1px solid #cccccc;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .contents_container, .contents {
            text-align: center;
        }

        .contents {
            border: 1px solid #cccccc;
            border-radius: 4px;
            margin-bottom: 50px;
        }

        .contents p {
            padding: 50px;
        }

        h3 {
            color: #333333;
            margin-top: 0;
        }

        p {
            color: #666666;
            margin-top: 0;
        }

        .post-info {
            margin-bottom: 20px;
            text-align: right;
        }

        .post-info span {
            font-weight: bold;
            margin-right: 10px;
        }

        .error-message {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
<%
    Long postId = Long.parseLong(request.getParameter("id"));
    PostService postService = new PostService();
    Post post = postService.findByPostId(postId).get(0);
    Role role = (Role) session.getAttribute("role");
%>
<%@include file="../header.jsp" %>
<div class="container">
    <div class="contents_container">
        <h2><%=post.getTitle()%>
        </h2>
    </div>
    <div class="post-info">
        <p>
            <%=post.getDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))%>
        </p>
    </div>
    <div class="contents">
        <p>
            <%=post.getDescription()%>
        </p>
    </div>
    <div class="vote-container">
        <%@include file="/vote/vote.jsp" %>
    </div>
</div>
</body>
</html>
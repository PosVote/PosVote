<%@ page import="study.postvote.service.PostService" %>
<%@ page import="study.postvote.domain.Post" %>
<%@ page import="study.postvote.domain.type.Role" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>글 상세 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
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
        }

        .contents_container, .contents {
            text-align: center;
        }

        .contents {
            border: 1px solid #cccccc;
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
            float: right;
        }

        .post-info span {
            font-weight: bold;
            margin-right: 10px;
        }

        .vote-container {
            margin-top: 20px;
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
<div class="container">
    <div class="contents_container">
        <h2><%=post.getTitle()%>
        </h2>
    </div>
    <div class="post-info">
        <p><%=post.getDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))%>
        </p>
    </div>
    <div class="contents">
        <p><%=post.getDescription()%>
        </p>
    </div>
    <div class="vote-container">
        <%@include file="/vote/vote.jsp" %>
    </div>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="study.postvote.domain.Post, study.postvote.service.PostService" %>
<%@ page import="java.util.List" %>
<%@ page import="study.postvote.dto.post.response.PostListResponse" %>

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
    </style>
</head>
<body>
<div class="container">
    <h1>게시판</h1>
    <%
        PostService postService = new PostService();
        List<PostListResponse> postList = postService.findAllPostListResponse();

        if (postList.isEmpty()) {
            out.println("<p class=\"no-posts\">등록된 게시물이 없습니다.</p>");
        } else {
            for (PostListResponse post : postList) {
    %>
    <div class="post">
        <h2 class="post-title"><%= post.getTitle() %>
        </h2>
        <p class="post-meta">작성자: <%= post.getName() %>, 작성일: <%= post.getDate() %>
        </p>
    </div>
    <%
            }
        }
    %>
</div>
</body>
</html>




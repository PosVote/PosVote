<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="study.postvote.domain.Post, study.postvote.service.PostService" %>
<%@ page import="java.util.List" %>
<%@ page import="study.postvote.dto.post.response.PostListResponse" %>
<%@ page import="static study.postvote.util.StaticStr.SERVER_IP" %>
<%@ page import="study.postvote.domain.type.Status" %>
<%@ page import="study.postvote.domain.type.Role" %>

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

        .copy-button {
            position: absolute;
            top: 10px;
            right: 10px;
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
        }
    </style>
    <script>
        function copyText() {
            const myTextarea = document.getElementById("copyText");

            window.navigator.clipboard.writeText(myTextarea.value).then(() => {
                alert("초대 코드 복사 완료");
            })
        }
    </script>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    String role = (String) session.getAttribute("role");
    Long orgId = (Long) session.getAttribute("orgId");
    String status = (String) session.getAttribute("status");

    if (role.equals(Role.OWNER.toString())) {
        out.println("<button class='copy-button' onclick='copyText()'>초대 코드 복사</button>");
    }

    out.println("<div class=\"container\">");
    out.println("<h1>게시판</h1>");

    if (status.equals(Status.ACCEPT.toString())) {
        PostService postService = new PostService();
        List<PostListResponse> postList = postService.findAllPostListResponse();

        if (postList.isEmpty()) {
            out.println("<p class=\"no-posts\">등록된 게시물이 없습니다.</p>");
        } else {
            for (PostListResponse post : postList) {
                out.println("<div class=\"post\">");
                out.println("<a class=\"post-title\" href=\"postView.jsp?id=" + post.getPostId() + "\">" + post.getTitle() + "</a>");
                out.println("<p class=\"post-meta\">작성자: " + post.getName() + ", 작성일: " + post.getDate() + "</p>");
                out.println("</div>");
            }
        }

        out.println("<input type='text' style='display: none;' id='copyText' value='" + SERVER_IP + "/user/signupUser.jsp?orgId=" + orgId + "' readonly>");
    } else {
        out.println("<p class=\"no-posts\">승인되지 않거나 권한이 없습니다.</p>");
    }
%>
</body>
</html>
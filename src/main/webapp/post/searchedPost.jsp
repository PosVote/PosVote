<%@ page import="study.postvote.dto.post.response.PostListResponse" %>
<%@ page import="java.util.List" %>
<%@ page import="study.postvote.service.PostService" %>
<%@ page import="study.postvote.domain.type.Status" %>
<%@ page import="study.postvote.domain.type.Role" %>
<%@ page import="study.postvote.domain.Post" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="study.postvote.service.VoteService" %>
<%@ page import="static study.postvote.util.StaticStr.SERVER_IP" %><%--
  Created by IntelliJ IDEA.
  User: FastPc
  Date: 2023-06-03
  Time: 오전 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>

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


    .copyButton, .make-button {
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

    .make-button {
        right: 300px;
        top: 50px;
        background-color: #0033ff;
    }

    .requestListButton {
        position: absolute;
        top: 10px;
        right: 130px;
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

    .userListButton {
        position: absolute;
        top: 10px;
        right: 250px;
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
<body>
<%
    request.setCharacterEncoding("utf-8");
    Status status = (Status) session.getAttribute("status");
    Long orgId = (Long) session.getAttribute("orgId");
    Role role = (Role) session.getAttribute("role");
    String searchTitle = request.getParameter("title");
    out.println("<div class=\"container\">");
    out.println("<h1>투표 게시판</h1>");

    if (Status.ACCEPT.equals(status)) {
        PostService postService = new PostService();
        List<Post> postList = postService.findByTitle(searchTitle);
        if (postList.isEmpty()) {
            out.println("<p class=\"no-posts\">등록된 게시물이 없습니다.</p>");
        } else {
            out.println("<div class=\"search-form\">");
            out.println("<form action=\"searchedPost.jsp\" method=\"get\">");
            out.println("<input type=\"text\" name=\"title\" class=\"search-input\" placeholder=\"제목을 입력하세요\">");
            out.println("<input type=\"submit\" value=\"검색\" class=\"search-button\">");
            out.println("</form>");
            out.println("</div>");
            for (Post post : postList) {
                out.println("<div class=\"post\">");
                out.println("<a class=\"post-title\" href=\"postView.jsp?id=" + post.getPostId() + "\">" + post.getTitle() + "</a>");
                out.println("<p class=\"post-meta\">작성자: " + post.getTitle() +
                        " 작성일: " + post.getDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) +
                        " 총 투표 수: " + new VoteService().countVote(post.getPostId()) +
                        "</p>");
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
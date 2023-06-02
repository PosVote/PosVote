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
    </script>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    Status status = (Status) session.getAttribute("status");
    Long orgId = (Long) session.getAttribute("orgId");
    Role role = (Role) session.getAttribute("role");


    if (Status.ACCEPT.equals(status) && Role.OWNER.equals(role)) {
        out.println("<button class='copyButton' onclick='copyText()'>초대 코드 복사</button>"
                + "<button class='userListButton' onclick=\"location.href='/user/userList/userAcceptList.jsp'\">유저 목록</button>"
                + "<button class='requestListButton' onclick=\"location.href='/user/userWaitingList.jsp'\">가입 신청 목록</button>"
                + "<button class='make-button' onclick='makeVote()'>투표 생성하기</button>");
    }

    out.println("<div class=\"container\">");
    out.println("<h1>투표 게시판</h1>");

    if (Status.ACCEPT.equals(status)) {
        PostService postService = new PostService();
        List<PostListResponse> postList = postService.findAllPostListResponse();
//        int count = new VoteService().countVote();
        if (postList.isEmpty()) {
            out.println("<p class=\"no-posts\">등록된 게시물이 없습니다.</p>");
        } else {
            for (PostListResponse post : postList) {
                out.println("<div class=\"post\">");
                out.println("<a class=\"post-title\" href=\"postView.jsp?id=" + post.getPostId() + "\">" + post.getTitle() + "</a>");
                out.println("<p class=\"post-meta\">작성자: " + post.getName() +
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
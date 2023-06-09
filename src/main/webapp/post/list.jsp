<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="study.postvote.dto.post.response.PostListResponse" %>
<%@ page import="static study.postvote.util.StaticStr.SERVER_IP" %>
<%@ page import="study.postvote.domain.type.Status" %>
<%@ page import="study.postvote.domain.type.Role" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="static study.postvote.util.StaticStr.POSTPERPAGE" %>
<%@ page import="study.postvote.service.*" %>
<%@ page import="study.postvote.service.UserService" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="study.postvote.dto.voteResult.response.VoteResult" %>
<%@ page import="study.postvote.domain.*" %>
<%@ page import="java.util.Objects" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <style>
        @font-face {
            font-family: 'KIMM_Bold';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2212@1.0/KIMM_Bold.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }

        body {
            font-family: "KIMM_Bold", sans-serif;
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

        input[type="submit"] {
            font-family: "KIMM_Bold", sans-serif;
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

        .post-meta-noJoin {
            font-size: 12px;
            color: red;
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

        .header .editUser-button {
            background-color: #4CAF50;
        }

        .search-form {
            text-align: right;
            margin-bottom: 20px;
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

        .pagination {
            margin-top: 20px;
        }

        .pagination ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
        }

        .pagination li {
            display: inline-block;
            margin-right: 5px;
        }

        .pagination a, .pagination strong {
            display: block;
            padding: 5px 10px;
            text-decoration: none;
            background-color: #f2f2f2;
            border: 1px solid #ccc;
            color: #333;
        }

        .pagination a:hover {
            background-color: #ddd;
        }

        .pagination strong {
            background-color: #999;
            color: #fff;
        }
    </style>

</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    Status status = (Status) session.getAttribute("status");
    Long orgId = (Long) session.getAttribute("orgId");
    Role role = (Role) session.getAttribute("role");
    Long userId = (Long) session.getAttribute("userId");


//    if (Status.ACCEPT.equals(status)) {

%>

<%@include file="../header.jsp" %>
<div class="container">
    <h1>투표 목록</h1>

    <%
        System.out.println(status);
        if (Status.ACCEPT.equals(status)) {
            int currentPage = Integer.parseInt(request.getParameter("page"));
            String searchKeyword = request.getParameter("title");
            PostService postService = new PostService();
            List<PostListResponse> postList;
            if(Objects.isNull(searchKeyword))
                postList = postService.findAllPostListResponse(orgId, currentPage);
            else{
                postList = postService.findByTitle(searchKeyword, orgId, currentPage);
                System.out.println(postList);
               }
            if (postList.isEmpty()) {
    %>
    <p class="no-posts">등록된 게시물이 없습니다.</p>
    <%
    } else {
        int totalPost = postService.findAllPostCount(orgId);
        int lastPage = totalPost / POSTPERPAGE + 1;

        if (totalPost % POSTPERPAGE == 0) lastPage--;

    %>
    <div class="search-form">
        <form action="list.jsp" method="get">
            <input type="text" name="title" class="search-input" placeholder="제목을 입력하세요">
            <input type="hidden" name="page" class="search-input" value="1">
            <input type="submit" value="검색" class="search-button">
        </form>
    </div>
    <%
        for (PostListResponse post : postList) {
            int countVote = new VoteService().countVote(post.getPostId());
            int countByOrg = new UserService().countByOrgId(orgId);
            String per = String.format("%.1f", (double) countVote / countByOrg * 100);
    %>
    <div class="post">
        <a class="post-title"
           href="postView.jsp?id=<%=post.getPostId()%>"><%=post.getTitle()%>&nbsp;
        </a>
        <%
            VoteService voteService = new VoteService();
            Vote vote = voteService.findByPostId(post.getPostId());
            VoteUserService voteUserService = new VoteUserService();
            Long result = voteUserService.findDistinctVoteUserByVoteIdAndUserId(vote.getVoteId(), userId);
            boolean join = !Objects.isNull(result);
            if (vote.getEndTime().isBefore(LocalDateTime.now())) {
        %>
        <a style="color: red; font-size: small">마감</a>
        <%
        } else {
        %>
        <a style="color: green; font-size: small">진행 중</a>
        <%
            }
        %>
        <p class="post-meta">
            작성자: <%=post.getName()%><br/>
            작성일: <%=post.getDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))%><br/>
            총 투표 수: <%=countVote%> / <%=countByOrg%>, 참여율: <%=per%>%<br/>
            <%
                if (join) {
                    out.println("<p class=\"post-meta\">참여 완료</p>");
                } else {
                    out.println("<p class=\"post-meta-noJoin\">미참여</p>");
                }
            %>
        </p>
    </div>
    <%
        }%>
    <div class="pagination">
        <ul>
            <!-- 이전 페이지 링크 -->
            <li><a href="/post/list.jsp?page=<%=currentPage - 1%>">이전</a></li>

            <!-- 페이지 번호 링크 -->
            <% for (int i = 1; i <= lastPage; i++) { %>
            <% if (i == currentPage) { %>
            <li><strong><%=i%>
            </strong></li> <!-- 현재 페이지 강조 -->
            <% } else { %>
            <li><a href="/post/list.jsp?page=<%=i%>"><%=i%>
            </a></li>
            <% } %>
            <% } %>

            <!-- 다음 페이지 링크 -->
            <li><a href="/post/list.jsp?page=<%=currentPage + 1%>">다음</a></li>
        </ul>
    </div>

    <% }

    %>
    <%--    <input type='text' style='display: none;' id='copyText' readonly>--%>
    <%
    } else {
    %>
    <p class="no-posts">승인되지 않거나 권한이 없습니다.</p>
    <script>
        window.location.herf = "/index.jsp";
    </script>
    <%

        }
    %>
</div>

</body>

<script>
    const makeVote = () => {
        window.location.href = "/post/post.jsp";
    }

    const logout = () => {
        window.location.href = "/user/logout.jsp";
    }

    const editUser = () => {
        window.location.href = "/user/editUser.jsp";
    }

    const mypage = () => {
        window.location.href = "/mypage/myPage.jsp";
    }

</script>
</html>
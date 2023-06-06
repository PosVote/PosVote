<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="study.postvote.domain.Post, study.postvote.service.PostService" %>
<%@ page import="java.util.List" %>
<%@ page import="study.postvote.dto.post.response.PostListResponse" %>
<%@ page import="static study.postvote.util.StaticStr.SERVER_IP" %>
<%@ page import="study.postvote.domain.type.Status" %>
<%@ page import="study.postvote.domain.type.Role" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="study.postvote.service.VoteService" %>
<%@ page import="static study.postvote.util.StaticStr.POSTPERPAGE" %>
<%@ page import="study.postvote.service.OrganizationKeyService" %>

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


//    if (Status.ACCEPT.equals(status)) {

%>
<%--<div class="header">--%>
<%--    <%--%>
<%--        if (Role.OWNER.equals(role)) {--%>
<%--    %>--%>
<%--    <button onclick="location.href='/user/userList/userAcceptList.jsp'">유저 목록</button>--%>
<%--    <button onclick="location.href='/user/userList/userWaitingList.jsp'">가입 신청 목록</button>--%>
<%--    <button onclick="makeVote()">투표 생성하기</button>--%>
<%--    <button class="copy-button" onclick="copyText()">초대 코드 복사</button>--%>
<%--    <%--%>
<%--        }--%>
<%--    %>--%>
<%--    <button class="editUser-button" onclick="mypage()">마이페이지</button>--%>
<%--    <button class="editUser-button" onclick="editUser()">내 정보 수정하기</button>--%>
<%--    <button class="logout-button" onclick="logout()">로그아웃</button>--%>
<%--</div>--%>
<%--<%--%>
<%--    }--%>

<%--%>--%>
<%@include file="../header.jsp" %>
<div class="container">
    <h1>투표 목록</h1>

    <%
        if (Status.ACCEPT.equals(status)) {
            int currentPage = Integer.parseInt(request.getParameter("page"));
            PostService postService = new PostService();
            List<PostListResponse> postList = postService.findAllPostListResponse(orgId, currentPage);
            //        int count = new VoteService().countVote();
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
<%--    function copyText() {--%>
<%--        <%--%>
<%--//        new OrganizationKeyService().updateKey(orgId);--%>
<%--        %>--%>

<%--        window.navigator.clipboard.writeText('<%=SERVER_IP%>/user/signupUser.jsp?orgKey=' + <%=new OrganizationKeyService().findByOrgId(orgId).getOrgKey()%>).then(() => {--%>
<%--            alert("초대 코드 복사 완료");--%>
<%--        })--%>
<%--    }--%>

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
<%@ page import="study.postvote.service.PostService" %>
<%@ page import="study.postvote.domain.Post" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>글 상세 페이지</title>
</head>
<body>
  <%
    Long postId = Long.parseLong(request.getRequestURI().substring(1));
    out.println(postId);
    out.print(request.getRequestURI());
    PostService postService = new PostService();
    Post post = postService.findByPostId(postId);
  %>
  <div class="container">
    <div>

      <h3>제목: <%=post.getTitle()%></h3>
    </div>
    <div>
      <p>내용: <%=post.getDescription()%></p>
    </div>
    <div>
      <p>작성일: <%=post.getDate()%></p>
    </div>
    <div>
      <%@include file="/vote/vote.jsp" %>
    </div>

  </div>

</body>
</html>

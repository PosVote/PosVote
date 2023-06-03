<%@ page import="study.postvote.service.VoteService" %>
<%@ page import="study.postvote.domain.Vote" %>
<%@ page import="study.postvote.domain.type.Role" %>
<%@ page import="study.postvote.service.PostService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Role role = (Role) session.getAttribute("role");
  Long voteId = Long.parseLong(request.getParameter("voteId"));
  Long postId = Long.parseLong(request.getParameter("postId"));

  if (role.equals(Role.OWNER)) {
    PostService postService = new PostService();
    postService.deleteById(postId, voteId);
  }

  response.setHeader("Refresh", "0; URL=../post/list.jsp");
%>
<%@ page import="study.postvote.service.VoteService" %>
<%@ page import="study.postvote.domain.Vote" %>
<%@ page import="study.postvote.domain.type.Role" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    Role role = (Role) session.getAttribute("role");
    Long voteId = Long.parseLong(request.getParameter("voteId"));

    if (role.equals(Role.OWNER)) {
        VoteService voteService = new VoteService();
        Vote vote = voteService.findByVoteId(voteId);
        voteService.setVoteEnd(vote.getVoteId());
    }

    String referer = request.getHeader("Referer");
    response.sendRedirect(referer);
%>
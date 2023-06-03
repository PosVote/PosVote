<%@ page import="study.postvote.service.VoteService" %>
<%@ page import="study.postvote.domain.Vote" %>
<%@ page import="study.postvote.service.OptionService" %>
<%@ page import="study.postvote.domain.Option" %>
<%@ page import="study.postvote.service.VoteUserService" %>
<%@ page import="study.postvote.domain.VoteUser" %>
<%@ page import="java.util.List" %>
<%@ page import="study.postvote.domain.type.Role" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Role role = (Role) session.getAttribute("role");
    Long voteId = Long.parseLong(request.getParameter("voteId"));

    if (role.equals(Role.OWNER)) {
        VoteService voteService = new VoteService();
        Vote vote = voteService.findByVoteId(voteId);
        voteService.setVoteEnd(vote.getVoteId());
    }

    response.setHeader("Refresh", "0; URL=../post/list.jsp");
%>
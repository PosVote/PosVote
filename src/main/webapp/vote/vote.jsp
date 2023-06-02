<%@ page import="study.postvote.respository.VoteRepository" %>
<%@ page import="study.postvote.service.VoteService" %>
<%@ page import="study.postvote.domain.Vote" %>
<%@ page import="study.postvote.service.OptionService" %>
<%@ page import="study.postvote.domain.Option" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>투표 보여주는 창</title>
</head>
<body>
<%
    VoteService voteService = new VoteService();
    OptionService optionService = new OptionService();
//    Long postId = Long.parseLong(request.getParameter("postId"));
    Long postId = Long.parseLong(request.getRequestURI().substring(1));

    Vote v = voteService.findByPostId(postId);

    List<Option> optionList = optionService.findByVoteId(v.getVoteId());
    String type = v.getInputType();
%>

<h1>투표하는 창</h1>
<form action="voteOk.jsp" onsubmit="post">

    <%
        for (Option option: optionList) {
    %>
    <input type="<%=type%>" name="option" value="<%=option.getOptionId()%>"/><%=option.getLabel()%>
    <br/>
    <%
        }
    %>
    <input type="hidden" name="voteId" value="<%=v.getVoteId()%>"/>
    <input type="submit" value="투표하기">
</form>
</body>
</html>

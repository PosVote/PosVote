<%@ page import="study.postvote.respository.VoteRepository" %>
<%@ page import="study.postvote.service.VoteService" %>
<%@ page import="study.postvote.domain.Vote" %>
<%@ page import="study.postvote.service.OptionService" %>
<%@ page import="study.postvote.domain.Option" %>
<%@ page import="java.util.List" %>
<%@ page import="study.postvote.service.UserService" %>
<%@ page import="study.postvote.domain.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>투표 보여주는 창</title>
</head>
<body>
<%
    VoteService voteService = new VoteService();
    OptionService optionService = new OptionService();
    Long postId1 = Long.parseLong(request.getParameter("id"));
    System.out.println("postId: " + postId1);

    Vote v = voteService.findByPostId(postId1);
    System.out.println(v.toString());
    List<Option> optionList = optionService.findByVoteId(v.getVoteId());
    String type = v.getInputType();

    Long userId = Long.parseLong((String)session.getAttribute("userId"));

%>

<h1>투표하는 창</h1>
<%
    if(new UserService().findById(userId) == null){
%>
        <h3>!로그인이 필요합니다!</h3>
<%
    }else{
%>

<form action="voteOk.jsp" onsubmit="post">
    <p>투표 마감: <%=v.getEndTime()%></p>
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
<%}%>
</body>
</html>

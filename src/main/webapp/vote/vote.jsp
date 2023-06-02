<%@ page import="study.postvote.respository.VoteRepository" %>
<%@ page import="study.postvote.service.VoteService" %>
<%@ page import="study.postvote.domain.Vote" %>
<%@ page import="study.postvote.service.OptionService" %>
<%@ page import="study.postvote.domain.Option" %>
<%@ page import="java.util.List" %>
<%@ page import="study.postvote.service.UserService" %>
<%@ page import="study.postvote.domain.User" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>투표하는 창</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border: 1px solid #cccccc;
        }

        h1 {
            color: #333333;
            text-align: center;
        }

        form {
            margin-top: 20px;
        }

        p {
            font-size: 14px;
            color: #666666;
            margin-bottom: 10px;
        }

        input[type="submit"] {
            padding: 10px 20px;
            background-color: #4CAF50;
            border: none;
            color: #ffffff;
            font-weight: bold;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #117115;
        }

        .error-message {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <%
        VoteService voteService = new VoteService();
        OptionService optionService = new OptionService();
        Long postId1 = Long.parseLong(request.getParameter("id"));

        Vote v = voteService.findByPostId(postId1);
        List<Option> optionList = optionService.findByVoteId(v.getVoteId());
        String type = v.getInputType();
        Object userObject = session.getAttribute("userId");

        System.out.println("session userId: " + userObject);

        String s = userObject.toString();
        Long userId = Long.parseLong(s);

        System.out.println("long change userId: " + userId);
    %>

    <%
        if(new UserService().findById(userId) == null){
    %>
    <h3 class="error-message">!로그인이 필요합니다!</h3>
    <%
    } else {
    %>

    <form action="/vote/voteOk.jsp" method="post">
        <p>투표 마감: <%=v.getEndTime().format(DateTimeFormatter.ofPattern("yyyy-mm-dd"))%></p>
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
</div>
</body>
</html>

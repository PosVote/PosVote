<%@ page import="study.postvote.respository.VoteRepository" %>
<%@ page import="study.postvote.service.VoteService" %>
<%@ page import="study.postvote.domain.Vote" %>
<%@ page import="study.postvote.service.OptionService" %>
<%@ page import="study.postvote.domain.Option" %>
<%@ page import="java.util.List" %>
<%@ page import="study.postvote.service.UserService" %>
<%@ page import="study.postvote.domain.User" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="study.postvote.service.VoteUserService" %>
<%@ page import="study.postvote.domain.VoteUser" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>투표하는 창</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            height: 100vh;
        }

        .container {
            margin: auto;
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
            margin: 20px auto 0 auto;
        }

        input[type="submit"]:hover {
            background-color: #117115;
            transition: 0.3s ease-in;
        }

        .error-message {
            color: red;
            text-align: center;
        }

        .input_vote {
            padding: 10px;
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

        String s = userObject.toString();
        Long userId = Long.parseLong(s);

        Boolean voteAble = true;
        List<VoteUser> voteUsers = new VoteUserService().findVoteUserByUserId(userId);
        if (!voteUsers.isEmpty()) {
            for (VoteUser voteUser : voteUsers) {
                Long voteId = voteUser.getVoteId();
                if (v.getVoteId().equals(voteId)) {
                    voteAble = false;
                    break;
                }
            }
        }

    %>

    <%
        if (new UserService().findById(userId) == null) {
    %>
    <h3 class="error-message">!로그인이 필요합니다!</h3>
    <%
    } else {
    %>

    <form action="/vote/voteOk.jsp" method="post">
        <p>투표 마감: <%=v.getEndTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))%>
        </p>
        <%
            for (Option option : optionList) {
        %>
        <div class="vote_contents">
            <input
                    type="<%=type%>"
                    name="option"
                    value="<%=option.getOptionId()%>"
                    class="input_vote"
            /><%=option.getLabel()%>
            <br/>
            <%
                }
            %>
            <input type="hidden" name="voteId" value="<%=v.getVoteId()%>"/>
            <%
                if (!voteAble) {
            %>
            <p>이미 투표하셨습니다</p>
            <%
            } else {
            %>
            <input type="submit" value="투표하기">
            <%}%>
        </div>
    </form>

    <a href="../vote/voteStatistics.jsp?postId=<%=v.getPostId()%>">결과 보기</a>

    <% if (role.equals(Role.OWNER) && v.getEndTime().isAfter(LocalDateTime.now())) { %>
    <a href="../vote/voteEndProcess.jsp?voteId=<%=v.getVoteId()%>">투표 마감하기</a>
    <% } %>

    <%}%>
</div>
</body>
</html>


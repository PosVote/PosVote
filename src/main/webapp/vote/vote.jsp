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
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>투표하는 창</title>
    <style>
        @font-face {
            font-family: 'KIMM_Bold';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2212@1.0/KIMM_Bold.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }
        body {
            font-family: "KIMM_Bold", sans-serif;
            background-color: #f0f0f0;
            height: 100vh;
        }

        .container {
            margin: auto;
            padding: 20px;
            background-color: #ffffff;
            border: 1px solid #cccccc;
            border-radius: 4px;
            text-align: center;
        }

        h1 {
            color: #333333;
            text-align: center;
        }

        form {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        p {
            font-size: 14px;
            color: #666666;
            margin-bottom: 10px;
        }
        h4{
            text-align: center;
        }
        .vote_contents {
            display: block;
            margin: auto;
            text-align: left;
        }

        .vote_contents > form > p {
            text-align: center;
        }

        .vote_contents > form > div {
            display: block;
            margin: auto;
            /*border: 1px solid red;*/
        }
        input[type="submit"] {
            font-family: "KIMM_Bold", sans-serif;
            padding: 10px 20px;
            background-color: #4CAF50;
            border: none;
            border-radius: 8px;
            color: #ffffff;
            font-weight: bold;
            cursor: pointer;
            margin: 20px auto 0 auto;
        }

        input[type="submit"]:hover {
            background-color: #117115;
            transition: 0.3s ease-in;
        }
        .vote-btn{
            text-align: center;
        }
        .error-message {
            color: red;
            text-align: center;
        }

        .input_vote {
            padding: 10px;
            margin: 10px;
        }

        .a-button {
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-content: center;
            text-align: center;
        }
        .a-button > a{
            padding: 10px;
            border-radius: 8px;
            color: white;
            margin: 20px 10px;
            font-size: 15px;
        }

        .result {
            background-color: #2d7e31;
        }

        .delete {
            background-color: red;
        }

        .end {
            background-color: #0033ff;
        }
    </style>
</head>

<script>
    function validateCheckboxes() {
        var checkboxes = document.querySelectorAll('input[type="checkbox"]');
        var checked = false;

        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                checked = true;
                break;
            }
        }

        if (!checked) {
            alert('하나 이상의 옵션을 선택해주세요.');
            return false;
        }
    }

    function validateRadioBoxes() {
        var radioBox = document.querySelectorAll('input[type="radio"]');
        var checked = false;

        for (var i = 0; i < radioBox.length; i++) {
            if (radioBox[i].checked) {
                checked = true;
                break;
            }
        }

        if (!checked) {
            alert('하나 이상을 체크하세요!');
            return false;
        }
    }
</script>
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
    <div class="vote_contents">
        <form action="/vote/voteOk.jsp" method="post">
            <p>투표 마감: <%=v.getEndTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))%>
            </p>
            <%
                for (Option option : optionList) {
            %>
            <div>
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
                <h4>이미 투표하셨습니다</h4>
                <%
                } else {
                    if (v.getEndTime().isAfter(LocalDateTime.now())) {
                        String checkFunction = type.equals("radio") ? "return validateRadioBoxes()" : "return validateCheckboxes()";
                %>
                <div class="vote-btn"><input type="submit" value="투표하기" onclick="<%=checkFunction%>"></div>
                <%
                        }
                    }
                %>
            </div>
        </form>
    </div>

    <div class="a-button">
        <a href="../vote/voteStatistics.jsp?postId=<%=v.getPostId()%>"
           class="result">
            결과 보기
        </a>

        <% if (role.equals(Role.OWNER)) { %>
        <a href="../vote/voteDeleteProcess.jsp?voteId=<%=v.getVoteId()%>&postId=<%=post.getPostId()%>"
           class="delete">
            투표 삭제하기
        </a>
        <%
            if (v.getEndTime().isAfter(LocalDateTime.now().plusMinutes(1))) {
        %>
        <a href="../vote/voteEndProcess.jsp?voteId=<%=v.getVoteId()%>" class="end">
            투표 마감하기
        </a>
    </div>
    <%
        }
    %>
    <% } else if (v.getEndTime().isBefore(LocalDateTime.now())) {
    %>
    <h4>투표가 마감되었습니다</h4>
    <%
            }
        }
    %>
</div>
</body>
</html>


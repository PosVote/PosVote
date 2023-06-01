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


    <h1>투표하는 창</h1>
    <form action="vote_ok.jsp" method="post">

        <input type="checkbox" name="vote" value="불"/>불
        <input type="checkbox" name="vote" value="협"/>협
        <input type="checkbox" name="vote" value="화"/>화
        <input type="checkbox" name="vote" value="음"/>음

        <input type="submit" value="투표하기">
    </form>
</body>
</html>

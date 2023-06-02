<%@ page import="study.postvote.service.VoteUserService" %>
<%@ page import="study.postvote.domain.VoteUser" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>투표완료창</title>
</head>
<body>
    <%
        request.setCharacterEncoding("utf-8");
    %>
    <%
        String[] options = request.getParameterValues("option"); // optionId 값들
        String voteId = request.getParameter("voteId");
        VoteUserService voteUserService = new VoteUserService();

        for(String i: options){
            voteUserService.save(new VoteUser(
                    Long.parseLong(voteId),
                    Long.parseLong(session.getAttribute("userId").toString()),
                    Long.parseLong(i)));
        }
    %>

    <p>투표가 완료됐습니다</p>
    <a class="button" href="../index.jsp">메인으로</a>
</body>
</html>

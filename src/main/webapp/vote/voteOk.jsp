<%@ page import="study.postvote.service.VoteUserService" %>
<%@ page import="study.postvote.domain.VoteUser" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>투표완료창</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
        }

        .container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background-color: #ffffff;
            border: 1px solid #cccccc;
            text-align: center;
            margin-top: 100px;
        }

        p {
            font-size: 18px;
            color: #333333;
            margin-bottom: 20px;
        }

        .button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: #ffffff;
            text-decoration: none;
            font-weight: bold;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        .button:hover {
            background-color: #117115;
        }
    </style>
</head>
<body>
<div class="container">
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

    <p>투표가 완료되었습니다.</p>
    <a class="button" href="/post/list.jsp">메인으로</a>
</div>
</body>
</html>

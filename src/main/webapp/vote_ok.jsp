<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Vote</title>
</head>
<body>
    <%
        request.setCharacterEncoding("utf-8");
    %>
    <%
        String[] votes = request.getParameterValues("vote");
        for(String i: votes){
            out.println(i+ "<br/>");
        }
    %>

    <p>투표가 완료됐습니다</p>
    <a class="button" href="user/index.jsp">메인으로</a>
</body>
</html>

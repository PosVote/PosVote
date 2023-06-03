<%@ page import="java.util.List" %>
<%@ page import="study.postvote.service.VoteUserService" %>
<%@ page import="study.postvote.dto.voteResult.response.CityStatistics" %>
<%@ page import="study.postvote.dto.voteResult.response.MBTIStatistics" %>
<%@ page import="study.postvote.dto.voteResult.response.UserSelection" %>
<%@ page import="study.postvote.dto.voteResult.response.VoteResult" %>
<%@ page import="study.postvote.service.PostService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>투표 통계</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        h1 {
            text-align: center;
        }

        h2 {
            margin-top: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
<%
    VoteUserService voteUserService = new VoteUserService();
    Long postId = Long.parseLong(request.getParameter("postId"));

    List<CityStatistics> cityStatistics = voteUserService.findCityStatistics(postId);
    List<MBTIStatistics> mbtiStatistics = voteUserService.findMbtiStatistics(postId);
    List<UserSelection> userSelection = voteUserService.findUserSelection(postId);
    List<VoteResult> voteResult = voteUserService.findVoteResult(postId);
%>

<h1>투표 통계</h1>

<h2>투표 결과</h2>
<table>
    <tr>
        <th>투표 옵션</th>
        <th>투표 수</th>
    </tr>
    <% for (VoteResult result : voteResult) { %>
    <tr>
        <td><%= result.getLabel() %>
        </td>
        <td><%= result.getCount() %>
        </td>
    </tr>
    <% } %>
</table>

<details>
    <summary>도시별 통계</summary>
    <h2>도시별 통계</h2>
    <table>
        <tr>
            <th>도시</th>
            <th>투표 옵션</th>
            <th>투표 수</th>
        </tr>
        <% for (CityStatistics cityStat : cityStatistics) { %>
        <tr>
            <td><%= cityStat.getCity().getDescription() %>
            </td>
            <td><%= cityStat.getLabel() %>
            </td>
            <td><%= cityStat.getCount() %>
            </td>
        </tr>
        <% } %>
    </table>
</details>

<details>
    <summary>MBTI 통계</summary>
    <h2>MBTI 통계</h2>
    <table>
        <tr>
            <th>MBTI</th>
            <th>투표 옵션</th>
            <th>투표 수</th>
        </tr>
        <% for (MBTIStatistics mbtiStat : mbtiStatistics) { %>
        <tr>
            <td><%= mbtiStat.getMbti().toString() %>
            </td>
            <td><%= mbtiStat.getLabel() %>
            </td>
            <td><%= mbtiStat.getCount() %>
            </td>
        </tr>
        <% } %>
    </table>
</details>

<%
    PostService postService = new PostService();
    if (postService.isAnonymous(postId) == 1) {
%>
<details>
    <summary>사용자 선택 결과</summary>
    <h2>사용자 선택 결과</h2>
    <table>
        <tr>
            <th>이메일</th>
            <th>이름</th>
            <th>투표 옵션</th>
        </tr>
        <% for (UserSelection userSel : userSelection) { %>
        <tr>
            <td><%= userSel.getEmail() %>
            </td>
            <td><%= userSel.getName() %>
            </td>
            <td><%= userSel.getLabel() %>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</details>

</body>
</html>
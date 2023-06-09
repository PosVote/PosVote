<%@ page import="java.util.List" %>
<%@ page import="study.postvote.service.VoteUserService" %>
<%@ page import="study.postvote.dto.voteResult.response.CityStatistics" %>
<%@ page import="study.postvote.dto.voteResult.response.MBTIStatistics" %>
<%@ page import="study.postvote.dto.voteResult.response.UserSelection" %>
<%@ page import="study.postvote.dto.voteResult.response.VoteResult" %>
<%@ page import="study.postvote.service.PostService" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>투표 통계</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>
    <style>
        @font-face {
            font-family: 'KIMM_Bold';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2212@1.0/KIMM_Bold.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }

        body {
            font-family: "KIMM_Bold", sans-serif;
            margin: 20px;
            background-color: #f2f2f2;
        }

        .container {
            display: flex;
            flex-direction: column;
            gap: 15px;
            max-width: 500px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            font-size: 24px;
        }

        h3 {
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
<%@include file="../header.jsp" %>
<div class="container">
    <h1>투표 통계</h1>
    <h3>투표 결과</h3>
    <%
        if (voteResult.size() > 0) {
    %>
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

    <canvas id="voteResultChart"></canvas>

    <script>
        // 투표 결과 데이터
        let voteResults = [
            <% for (VoteResult result : voteResult) { %>
            {
                label: '<%= result.getLabel() %>',
                count: <%= result.getCount() %>
            },
            <% } %>
        ];

        function getRandomColor() {
            let letters = '0123456789ABCDEF';
            let color = '#';
            for (let i = 0; i < 6; i++) {
                color += letters[Math.floor(Math.random() * 16)];
            }
            return color;
        }

        let voteResultChart = document.getElementById('voteResultChart').getContext('2d');

        let chart = new Chart(voteResultChart, {
            type: 'pie',
            data: {
                labels: voteResults.map(function (result) {
                    return result.label;
                }),
                datasets: [{
                    data: voteResults.map(function (result) {
                        return result.count;
                    }),
                    backgroundColor: voteResults.map(function (result) {
                        return getRandomColor();
                    })
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: true, // 범례 표시 설정
                        position: 'bottom'
                    },
                    tooltip: {
                        callbacks: {
                            // 툴팁 설정
                        }
                    }
                }
            }
        });
    </script>

    <%
        } else {
            out.println("<h4>아직 투표 내역이 없습니다.</h4>");
        }
    %>

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
</div>
</body>
</html>
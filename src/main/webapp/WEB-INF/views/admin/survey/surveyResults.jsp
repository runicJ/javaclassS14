<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <title>설문 결과</title>

    <jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />

    <style>
        h2, h3 {
            margin: 20px 0;
        }
        .result-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .result-table th, .result-table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .result-table th {
            background-color: #6C757D;
            color: white;
            text-align: center;
        }
        .chart-container {
            width: 100%;
            max-width: 600px;
            margin: 30px auto;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
<jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />

<div class="container">
    <h2><i class="fa-solid fa-chart-bar"></i> 설문 결과</h2>

    <table class="result-table">
        <tr>
            <th>설문 제목</th>
            <td>${survey.surveyTitle}</td>
        </tr>
        <tr>
            <th>등록 날짜</th>
            <td>${survey.createDate}</td>
            <th>수정 날짜</th>
            <td>${survey.modDate}</td>
        </tr>
        <tr>
            <th colspan="4">설문 설명</th>
        </tr>
        <tr>
            <td colspan="4">
                <c:choose>
                    <c:when test="${not empty survey.surveyDesc}">
                        ${survey.surveyDesc}
                    </c:when>
                    <c:otherwise>[설명 없음]</c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>

    <h3>📊 응답 결과</h3>

    <c:forEach var="question" items="${survey.questList}">
        <div class="question-container">
            <h4>${question.questContent}</h4>

            <c:choose>
                <c:when test="${question.questType == 'long'}">
                    <table class="result-table">
                        <tr>
                            <th>응답 내용</th>
                        </tr>
                        <c:forEach var="answer" items="${question.answerList}">
                            <tr>
                                <td>${answer.answLong}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>

                <c:when test="${question.questType == 'short'}">
                    <table class="result-table">
                        <tr>
                            <th>응답 내용</th>
                            <th>응답 횟수</th>
                        </tr>
                        <c:forEach var="answer" items="${question.answerList}">
                            <tr>
                                <td>${answer.answCont}</td>
                                <td>${answer.count}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>

                <c:otherwise>
                    <div class="chart-container">
                        <canvas id="chart-${question.questIdx}"></canvas>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </c:forEach>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        let questions = ${fn:escapeXml(questListJson)};

        questions.forEach(question => {
            if (question.questType !== 'long' && question.questType !== 'short') {
                let ctx = document.getElementById("chart-" + question.questIdx).getContext('2d');
                let labels = question.answerList.map(answ => answ.answCont);
                let data = question.answerList.map(answ => answ.count);

                new Chart(ctx, {
                    type: question.questType === 'check' ? 'bar' : 'pie',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: question.questContent,
                            data: data,
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.4)',
                                'rgba(54, 162, 235, 0.4)',
                                'rgba(255, 206, 86, 0.4)',
                                'rgba(75, 192, 192, 0.4)',
                                'rgba(153, 102, 255, 0.4)',
                                'rgba(255, 159, 64, 0.4)',
                                'rgba(201, 203, 207, 0.4)'
                            ],
                            borderColor: [
                                'rgba(255, 99, 132)',
                                'rgba(54, 162, 235)',
                                'rgba(255, 206, 86)',
                                'rgba(75, 192, 192)',
                                'rgba(153, 102, 255)',
                                'rgba(255, 159, 64)',
                                'rgb(201, 203, 207)'
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: question.questType === 'check' ? {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value) { if (value % 1 === 0) { return value; } }
                                }
                            }
                        } : {},
                        plugins: {
                            legend: {
                                position: 'right',
                            }
                        }
                    }
                });
            }
        });
    });
</script>

<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />

</body>
</html>
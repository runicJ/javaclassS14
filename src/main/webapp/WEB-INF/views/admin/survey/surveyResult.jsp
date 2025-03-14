<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>surveyResult</title>

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
        .question-container {
		    margin-top: 30px;  /* 질문과 표 사이 간격 */
		    padding-bottom: 20px; /* 표 아래 여백 */
		    border-bottom: 1px solid #ddd; /* 질문 간 구분선 */
		}
		.chart-container {
		    width: 100%;
		    max-width: 600px;
		    height: 300px;  /* 높이 추가 */
		    margin: 30px auto;
		    text-align: center;
		}
		
		canvas {
		    width: 100% !important;
		    height: 100% !important;
		}
    </style>
</head>
<body>
<div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
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

				<c:when test="${question.questType ne 'long'}">
                    <table class="result-table">
                        <tr>
                            <th>응답 내용</th>
                            <th>응답 횟수</th>
                            <th>비율(%)</th>
                        </tr>

                        <c:set var="totalResponses" value="0" />
                        
	                    <!-- 전체 응답 수 계산 -->
	                    <c:forEach var="answer" items="${question.answerList}">
	                        <c:if test="${answer.questIdx == question.questIdx}">
	                            <c:set var="totalResponses" value="${totalResponses + answer.responseCount}" />
	                        </c:if>
	                    </c:forEach>

	                    <!-- 응답 목록 출력 -->
	                    <c:forEach var="answer" items="${question.answerList}">
	                        <c:if test="${answer.questIdx == question.questIdx}">
	                            <tr>
	                                <td>${answer.answerContent}</td>  
	                                <td>${answer.responseCount}</td>  
	                                <td>
	                                    <c:choose>
	                                        <c:when test="${totalResponses > 0}">
	                                            <fmt:formatNumber value="${(answer.responseCount * 100.0) / totalResponses}" pattern="0.0" />%
	                                        </c:when>
	                                        <c:otherwise>0.0%</c:otherwise>
	                                    </c:choose>
	                                </td>
	                            </tr>
	                        </c:if>
	                    </c:forEach>

                        <!-- 응답 데이터가 없는 경우 -->
                        <c:if test="${empty question.answerList}">
                            <tr>
                                <td colspan="3">응답 데이터가 없습니다.</td>
                            </tr>
                        </c:if>
                    </table>
                    
                    <!-- 여기에 차트 추가 -->
	                <div class="chart-container">
	                    <canvas id="chart-${question.questIdx}"></canvas>
	                </div>
                </c:when>
            </c:choose>
        </div>
    </c:forEach>
</div>

<!-- Chart.js 그래프 생성 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function () {
    console.log("🚀 JavaScript 실행됨!");

    let rawData = `${questListJson}`; // JSP에서 전달된 JSON 문자열

    if (!rawData || rawData.trim() === '') {
        console.error("❌ JSON 데이터가 없습니다.");
        return;
    }

    let questions;
    try {
        questions = JSON.parse(rawData);
        console.log("📌 로드된 질문 목록:", questions);
    } catch (e) {
        console.error("❌ JSON 파싱 오류:", e);
        return;
    }

    questions.forEach(question => {
        let canvas = document.getElementById("chart-" + question.questIdx);
        let ctx = canvas?.getContext('2d');

        console.log(`📌 차트 생성 확인 - 질문 ID ${question.questIdx}:`, ctx); // canvas 존재 여부 확인

        if (!ctx) return;

        let filteredAnswers = question.answerList.filter(answ => answ.questIdx == question.questIdx);

        if (filteredAnswers.length === 0) return;

        let labels = filteredAnswers.map(answ => answ.answerContent);
        let data = filteredAnswers.map(answ => answ.count);
        let totalResponses = data.reduce((sum, count) => sum + count, 0);
        let percentageData = data.map(count => ((count / totalResponses) * 100).toFixed(1));

        new Chart(ctx, {
            type: 'pie',  // 파이 차트로 고정
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
                responsive: true,  // 차트 크기 자동 조정
                plugins: {
                    tooltip: {
                        callbacks: {
                            label: function(tooltipItem) {
                                let index = tooltipItem.dataIndex;
                                return `${labels[index]}: ${data[index]}명 (${percentageData[index]}%)`;
                            }
                        }
                    },
                    legend: {
                        position: 'top',
                    }
                }
            }
        });
    });
});
</script>

<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</div>
</body>
</html>
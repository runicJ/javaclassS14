<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.8.0/chart.min.js"></script>
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <title>설문 결과</title>
    <jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        h2, h3 {
            margin: 20px 0;
        }
        #survInfo, #rslt {
            width: 100%;
            padding: 20px;
            border-collapse: collapse;
        }
        #survInfo th, #survInfo td, #rslt th, #rslt td {
            padding: 10px;
            border-bottom: 2px solid #EEEEEE;
        }
        #survInfo th, #rslt th {
            text-align: center;
            background-color: #EEEEEE;
        }
        .descNull {
            color: grey;
            text-align: center;
            font-style: italic;
        }
        .survdesc, .answLong, .answShort {
            overflow: auto;
            max-height: 300px;
        }
        #rslt .canvas {
            max-height: 500px;
            padding: 30px;
        }
        button {
            margin: 10px;
            padding: 0.5rem 1rem;
            font-size: 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: black;
            color: white;
        }
    </style>
</head>
<body>
    <h2>📋 설문 결과</h2>
    <div class="body">
        <table id="survInfo">
            <tr>
                <th>설문 제목</th>
                <td colspan="5" class="survtitle">${survey.survTitle}</td>
            </tr>
            <tr>
                <th>등록 날짜</th>
                <td class="regdate">${survey.regDate}</td>
                <th>수정 날짜</th>
                <td class="moddate">${survey.modDate}</td>
                <th>사용 여부</th>
                <td class="useYn">
                    <c:choose>
                        <c:when test="${survey.useYn == 'Y'}">사용중</c:when>
                        <c:otherwise>사용 안함</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th colspan="6">설문 설명</th>
            </tr>
            <tr>
                <td colspan="6">
                    <c:choose>
                        <c:when test="${survey.survDesc != null}">
                            <div class="survdesc">${survey.survDesc}</div>
                        </c:when>
                        <c:otherwise class="descNull">[설문 설명 없음]</c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </table>
        <div style="float:right;">
            <button id="list" onclick="goList(${pagination.currentPage}, ${pagination.cntPerPage}, ${pagination.pageSize}, '${pagination.srchTyp}', '${pagination.keyword}')">목록 보기</button>
        </div>
        <br>
        <h3>📊 응답 결과</h3>
        <table id="rslt">
            <c:forEach var="qust" items="${survey.survqustList}">
                <tr>
                    <th>${qust.qustCont}</th>
                </tr>
                <c:choose>
                    <c:when test="${qust.qustType == 'long'}">
                        <tr>
                            <td>응답 ${fn:length(qust.answerList)}개</td>
                        </tr>
                        <tr>
                            <td>
                                <div class="answLong">
                                    <c:forEach var="answ" items="${qust.answerList}">
                                        <p>${answ.answLong}</p>
                                    </c:forEach>
                                </div>
                            </td>
                        </tr>
                    </c:when>
                    <c:when test="${qust.qustType == 'short'}">
                        <tr>
                            <td>응답 <span id="${qust.qustNo}total"></span>개</td>
                        </tr>
                        <tr>
                            <td>
                                <div class="answShort">
                                    <c:forEach var="answ" items="${qust.answerList}">
                                        <p>
                                            ${answ.answCont} (${answ.count})
                                        </p>
                                    </c:forEach>
                                </div>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td>응답 <span id="${qust.qustNo}total"></span>개</td>
                        </tr>
                        <tr>
                            <td>
                                <canvas id="${qust.qustNo}" class="canvas"></canvas>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </table>
    </div>
    
    <!-- JavaScript to handle Chart.js integration -->
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
            // Assuming 'qustList' is populated in a format compatible with JavaScript
            const qustList = ${fn:escapeXml(qustListJson)};

            qustList.forEach(qust => {
                const total = qust.answerList.reduce((acc, answ) => acc + answ.count, 0);
                if (qust.qustType !== 'long') {
                    document.getElementById(qust.qustNo + "total").innerText = total;
                }

                if (qust.qustType !== 'long' && qust.qustType !== 'short' && total !== 0) {
                    const ctx = document.getElementById(qust.qustNo).getContext('2d');
                    const labels = qust.answerList.map(answ => answ.answCont);
                    const data = qust.answerList.map(answ => answ.count);

                    const chartType = qust.qustType === 'check' ? 'bar' : 'pie';
                    new Chart(ctx, {
                        type: chartType,
                        data: {
                            labels: labels,
                            datasets: [{
                                label: qust.qustCont,
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
                            scales: chartType === 'bar' ? {
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

        function goList(currentPage, cntPerPage, pageSize, srchTyp, keyword) {
            let url = `${ctp}/myList?currentPage=${currentPage}&cntPerPage=${cntPerPage}&pageSize=${pageSize}&srchTyp=${srchTyp}&keyword=${keyword}`;
            location.href = url;
        }
    </script>
</body>
</html>

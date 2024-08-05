<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>병원 목록</title>
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
    <style>
        .region-card {
            display: inline-block;
            width: 200px;
            height: 100px;
            margin: 10px;
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 8px;
            text-align: center;
            line-height: 100px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .region-card:hover {
            background-color: #e2e6ea;
        }
        .search-bar {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }
        .search-bar input, .search-bar button {
            height: 40px;
            margin-right: 5px;
        }
        .waiting-time-slider {
            width: 300px;
            margin: 20px auto;
        }
    </style>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<section class="page">
<div class="container">
    <h2>병원 검색</h2>
    <div class="search-bar">
        <form action="${ctp}/community/hospitalList" method="get">
            <select name="key">
                <option value="hospitalName">병원명</option>
                <option value="hospitalCategory">전문분야</option>
                <option value="hospitalRegion">지역</option>
            </select>
            <input type="text" name="keyword" placeholder="검색어를 입력하세요">
            <button type="submit">검색</button>
        </form>
    </div>
    <h3>대기시간 필터</h3>
    <div class="waiting-time-slider">
        <label for="waiting-time">대기시간: <span id="waiting-time-display">0 - 60</span> 분</label>
        <div id="waiting-time-slider"></div>
    </div>
    <button onclick="applyWaitingTimeFilter()">필터 적용</button>
    <h3>병원 목록</h3>
    <ul>
        <c:forEach var="hospital" items="${hospitals}">
            <li>
                <a href="${ctp}/community/hospitalComment?hospitalIdx=${hospital.hospitalIdx}">
                    ${hospital.hospitalName} - ${hospital.hospitalCategory} - ${hospital.hospitalRegion}
                </a>
            </li>
        </c:forEach>
    </ul>
</div>
</section>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />

<script>
$(document).ready(function() {
    $("#waiting-time-slider").slider({
        range: true,
        min: 0,
        max: 60,
        values: [0, 60],
        slide: function(event, ui) {
            $("#waiting-time-display").text(ui.values[0] + " - " + ui.values[1]);
        }
    });
});

function applyWaitingTimeFilter() {
    let waitingTime = $("#waiting-time-slider").slider("values");
    let minTime = waitingTime[0];
    let maxTime = waitingTime[1];
    // 대기시간 필터 적용 후, 서버로 전송하거나 화면을 갱신하는 로직 구현
    location.href = '${ctp}/community/hospitalList?minWaitingTime=' + minTime + '&maxWaitingTime=' + maxTime;
}
</script>
</body>
</html>

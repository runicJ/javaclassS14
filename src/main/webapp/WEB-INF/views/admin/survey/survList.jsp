<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
   	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <title>설문 리스트</title>
    <style>
        h2 {
            margin: 20px 0;
        }
        .table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #6C757D;
            color: white;
        }
        .right {
            float: right;
        }
        .right select {
            width: 100px;
        }
        button {
            appearance: none;
            margin: 10px;
            padding: 0.5rem 1rem;
            font-size: 1rem;
            font-weight: 400;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            width: auto;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: black;
            color: white;
        }
        .paginate {
            text-align: center;
            margin: 20px 0;
        }
        .paginate .paging a {
            margin: 0 2px;
            padding: 5px;
            color: #999;
            text-decoration: none;
        }
        .paginate .paging a:hover, .paginate .paging strong {
            color: black;
            font-weight: bold;
        }
    </style>
    <script>
        function changeSelectBox(currentPage, pageSize) {
            const selectValue = $("#cntSelectBox").val();
            movePage(currentPage, selectValue, pageSize);
        }

        function movePage(currentPage, cntPerPage, pageSize) {
            const srchTyp = $('#srchTyp').val();
            const keyword = $('#keyword').val().trim();

            let url = "/survList";
            url += "?currentPage=" + currentPage;
            url += "&cntPerPage=" + cntPerPage;
            url += "&pageSize=" + pageSize;

            if (keyword) {
                url += "&srchTyp=" + srchTyp;
                url += "&keyword=" + keyword;
            }

            location.href = url;
        }

        function searchKw() {
            const srchTyp = $('#srchTyp').val();
            const keyword = $('#keyword').val().trim();
            const selectValue = $("#cntSelectBox").val();

            let url = "/survList";
            url += "?srchTyp=" + srchTyp;
            url += "&keyword=" + keyword;
            url += "&cntPerPage=" + selectValue;

            location.href = url;
        }

        function searchReset() {
            location.href = "/survList";
        }

        function goSurvInfo(survNo, currentPage, pageSize) {
            const srchTyp = $('#srchTyp').val();
            const keyword = $('#keyword').val().trim();
            const selectValue = $("#cntSelectBox").val();

            let url = "/survInfo";
            url += "?survNo=" + survNo;
            url += "&srchTyp=" + srchTyp;
            url += "&keyword=" + keyword;
            url += "&cntPerPage=" + selectValue;
            url += "&currentPage=" + currentPage;
            url += "&pageSize=" + pageSize;

            location.href = url;
        }
    </script>
</head>
<body>
<div class="body">
    <h2>📃 설문 리스트</h2>
    <br>

    <!-- SearchForm -->
    <form id="searchForm">
        <div id="search_list">
            <select id="srchTyp" style="border:2px solid #6C757D">
                <option value="all">전체</option>
                <option value="title">제목</option>
                <option value="regid">등록자</option>
                <option value="survNo">설문 번호</option>
            </select>
            <input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요" style="width: 300px; border:2px solid #6C757D">
            <button type="button" id="srchBtn" onclick="searchKw();">검색 🔍</button>
            <button type="button" id="reset" onclick="searchReset();">초기화 ♻️</button>
        </div>
    </form>

    <span style="font-weight:bold;">총 설문 수: <span th:text="${total}"></span></span>
    <div class="right">
        <select id="cntSelectBox" name="cntSelectBox" onchange="changeSelectBox(${pagination.currentPage}, ${pagination.pageSize});">
            <option value="10">10개씩</option>
            <option value="20">20개씩</option>
            <option value="30">30개씩</option>
        </select>
    </div>

    <div class="table">
        <table>
            <thead>
                <tr>
                    <th>설문 번호</th>
                    <th>설문 제목</th>
                    <th>등록자</th>
                    <th>등록 날짜</th>
                    <th>최종 수정 날짜</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty survList}">
                    <c:forEach var="surv" items="${survList}">
                        <tr>
                            <td class="survno" th:text="${surv.survNo}"></td>
                            <td class="survtitle"><a th:text="${surv.survTitle}" href="#" onclick="goSurvInfo(${surv.survNo}, ${pagination.currentPage}, ${pagination.pageSize});"></a></td>
                            <td class="memNick" th:text="${surv.memNick}"></td>
                            <td class="regdate" th:text="${#dates.format(surv.regDate, 'yyyy-MM-dd HH:mm')}"></td>
                            <td class="moddate" th:text="${#dates.format(surv.modDate, 'yyyy-MM-dd HH:mm')}"></td>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty survList}">
                    <tr>
                        <td colspan="5" style="text-align:center;">조회된 설문이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- Paginate -->
    <c:if test="${not empty survList}">
        <div class="paginate">
            <div class="paging">
                <c:if test="${pagination.hasPreviousPage}">
                    <a class="direction prev" href="#" onclick="movePage(1, ${pagination.cntPerPage}, ${pagination.pageSize})">&lt;&lt;</a>
                    <a class="direction prev" href="#" onclick="movePage(${pagination.currentPage - 1}, ${pagination.cntPerPage}, ${pagination.pageSize})">&lt;</a>
                </c:if>
                <c:forEach var="idx" begin="${pagination.firstPage}" end="${pagination.lastPage}">
                    <c:choose>
                        <c:when test="${pagination.currentPage == idx}">
                            <a href="#" style="background-color:#EEEEEE; font-weight:700; color:black; font-size: large;" th:text="${idx}"></a>
                        </c:when>
                        <c:otherwise>
                            <a href="#" onclick="movePage(${idx}, ${pagination.cntPerPage}, ${pagination.pageSize})" th:text="${idx}"></a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${pagination.hasNextPage}">
                    <a class="direction next" href="#" onclick="movePage(${pagination.currentPage + 1}, ${pagination.cntPerPage}, ${pagination.pageSize})">&gt;</a>
                    <a class="direction next" href="#" onclick="movePage(${pagination.totalRecordCount}, ${pagination.cntPerPage}, ${pagination.pageSize})">&gt;&gt;</a>
                </c:if>
            </div>
        </div>
    </c:if>
    <!-- /Paginate -->

</div>
</body>
</html>

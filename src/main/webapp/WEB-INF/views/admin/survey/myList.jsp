<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
   	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <title>Admin Survey Management</title>
    <jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
    <style>
        h2 {
            margin: 20px 0;
        }
        table {
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
        .survtitle a {
            color: black;
            text-decoration: none;
        }
        .survtitle a:hover {
            color: pink;
        }
        .right {
            float: right;
        }
        .right select {
            width: 100px;
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
        #searchForm {
            margin-bottom: 20px;
        }
        #search_list select, #search_list input {
            padding: 10px;
            font-size: 15px;
            border: 2px solid #6C757D;
        }
        #srchBtn, #reset {
            background-color: #6C757D;
            color: white;
        }
        #srchBtn:hover, #reset:hover {
            background-color: black;
        }
    </style>
    <script>
        function changeSelectBox(currentPage, pageSize) {
            const selectValue = $("#cntSelectBox").val();
            movePage(currentPage, selectValue, pageSize);
        }

        function movePage(currentPage, cntPerPage, pageSize) {
            const url = new URL(window.location.href);
            url.searchParams.set('currentPage', currentPage);
            url.searchParams.set('cntPerPage', cntPerPage);
            url.searchParams.set('pageSize', pageSize);

            const keyword = $('#keyword').val().trim();
            const srchTyp = $('#srchTyp').val();

            if (keyword) {
                url.searchParams.set('srchTyp', srchTyp);
                url.searchParams.set('keyword', keyword);
            }

            location.href = url.toString();
        }

        function searchKw() {
            const srchTyp = $('#srchTyp').val();
            const keyword = $('#keyword').val().trim();
            const cntPerPage = $("#cntSelectBox").val();

            const url = new URL(window.location.href);
            url.searchParams.set('srchTyp', srchTyp);
            url.searchParams.set('keyword', keyword);
            url.searchParams.set('cntPerPage', cntPerPage);

            location.href = url.toString();
        }

        function searchReset() {
            location.href = '/admin/surveyList';
        }

        function viewRslt(survNo, currentPage, pageSize) {
            const url = new URL('/admin/surveyResult', window.location.origin);
            url.searchParams.set('survNo', survNo);
            url.searchParams.set('currentPage', currentPage);
            url.searchParams.set('pageSize', pageSize);
            url.searchParams.set('cntPerPage', $("#cntSelectBox").val());
            url.searchParams.set('srchTyp', $('#srchTyp').val());
            url.searchParams.set('keyword', $('#keyword').val().trim());

            location.href = url.toString();
        }

        function editSurv(survNo, currentPage, pageSize) {
            const url = new URL('/admin/editSurvey', window.location.origin);
            url.searchParams.set('survNo', survNo);
            url.searchParams.set('currentPage', currentPage);
            url.searchParams.set('pageSize', pageSize);
            url.searchParams.set('cntPerPage', $("#cntSelectBox").val());
            url.searchParams.set('srchTyp', $('#srchTyp').val());
            url.searchParams.set('keyword', $('#keyword').val().trim());

            location.href = url.toString();
        }

        function deleteSurv(survNo, currentPage, pageSize) {
            if (confirm('정말로 이 설문을 삭제하시겠습니까?')) {
                const url = new URL('/admin/deleteSurvey', window.location.origin);
                url.searchParams.set('survNo', survNo);
                url.searchParams.set('currentPage', currentPage);
                url.searchParams.set('pageSize', pageSize);
                url.searchParams.set('cntPerPage', $("#cntSelectBox").val());
                url.searchParams.set('srchTyp', $('#srchTyp').val());
                url.searchParams.set('keyword', $('#keyword').val().trim());

                location.href = url.toString();
            }
        }
    </script>
</head>
<body>
    <div class="body">
        <h2>📑 설문 관리</h2>
        <br>
        <form id="searchForm">
            <div id="search_list">
                <select id="srchTyp">
                    <option value="all">전체</option>
                    <option value="useY">사용중</option>
                    <option value="useN">사용 안함</option>
                </select>
                <input type="text" id="keyword" name="keyword" placeholder="설문 제목을 입력하세요" style="width: 300px;">
                <button type="button" id="srchBtn" onclick="searchKw();">검색 🔍</button>
                <button type="button" id="reset" onclick="searchReset();">초기화 ♻️</button>
            </div>
        </form>
        <span style="font-weight: bold;">전체 설문 수: <span th:text="${total}"></span></span>
        <div class="right">
            <select id="cntSelectBox" onchange="changeSelectBox(${pagination.currentPage}, ${pagination.pageSize});">
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
                        <th>사용 여부</th>
                        <th>등록 날짜</th>
                        <th>최종 수정 날짜</th>
                        <th>결과</th>
                        <th>수정</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty survList}">
                        <c:forEach var="surv" items="${survList}">
                            <tr>
                                <td class="survno" th:text="${surv.survNo}"></td>
                                <td class="survtitle">
                                    <a th:text="${surv.survTitle}" href="#" th:onclick="editSurv(${surv.survNo}, ${pagination.currentPage}, ${pagination.pageSize});"></a>
                                </td>
                                <td class="useYn">
                                    <c:choose>
                                        <c:when test="${surv.useYn == 'Y'}">사용중</c:when>
                                        <c:otherwise>사용 안함</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="regdate" th:text="${#dates.format(surv.regDate, 'yyyy-MM-dd HH:mm')}"></td>
                                <td class="moddate" th:text="${#dates.format(surv.modDate, 'yyyy-MM-dd HH:mm')}"></td>
                                <td class="result">
                                    <button th:onclick="viewRslt(${surv.survNo}, ${pagination.currentPage}, ${pagination.pageSize});">결과 보기</button>
                                </td>
                                <td class="edit">
                                    <button th:onclick="editSurv(${surv.survNo}, ${pagination.currentPage}, ${pagination.pageSize});">수정</button>
                                </td>
                                <td class="delete">
                                    <button th:onclick="deleteSurv(${surv.survNo}, ${pagination.currentPage}, ${pagination.pageSize});">삭제</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty survList}">
                        <tr>
                            <td colspan="8" style="text-align: center;">등록된 설문이 없습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        <div class="paginate">
            <div class="paging">
                <c:if test="${pagination.hasPreviousPage}">
                    <a class="direction prev" href="#" onclick="movePage(1, ${pagination.cntPerPage}, ${pagination.pageSize})">&lt;&lt;</a>
                    <a class="direction prev" href="#" onclick="movePage(${pagination.currentPage - 1}, ${pagination.cntPerPage}, ${pagination.pageSize})">&lt;</a>
                </c:if>
                <c:forEach var="idx" begin="${pagination.firstPage}" end="${pagination.lastPage}">
                    <c:choose>
                        <c:when test="${pagination.currentPage == idx}">
                            <a href="#" style="background-color: #EEEEEE; font-weight: 700; color: black; font-size: large;" th:text="${idx}"></a>
                        </c:when>
                        <c:otherwise>
                            <a href="#" th:attr="onclick=|movePage(${idx}, ${pagination.cntPerPage}, ${pagination.pageSize})|" th:text="${idx}"></a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${pagination.hasNextPage}">
                    <a class="direction next" href="#" onclick="movePage(${pagination.currentPage + 1}, ${pagination.cntPerPage}, ${pagination.pageSize})">&gt;</a>
                    <a class="direction next" href="#" onclick="movePage(${pagination.totalRecordCount}, ${pagination.cntPerPage}, ${pagination.pageSize})">&gt;&gt;</a>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설문 목록</title>

    <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />

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
        .search-bar {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .search-bar select, .search-bar input {
            padding: 5px;
            font-size: 14px;
        }
        .paginate {
            text-align: center;
            margin: 20px 0;
        }
        .paginate .paging a {
            margin: 0 5px;
            padding: 5px;
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }
        .paginate .paging a:hover, .paginate .paging strong {
            color: black;
        }
    </style>

    <script>
        function movePage(currentPage) {
            const srchTyp = $('#srchTyp').val();
            const keyword = $('#keyword').val().trim();
            let url = "/survey/surveyEventList?currentPage=" + currentPage;

            if (keyword) {
                url += "&srchTyp=" + srchTyp + "&keyword=" + keyword;
            }

            location.href = url;
        }

        function searchSurvey() {
            movePage(1);
        }

        function resetSearch() {
            $('#srchTyp').val("all");
            $('#keyword').val("");
            movePage(1);
        }
    </script>
</head>
<body>

<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />

<section class="page">
    <div class="container">
        <h2><i class="fa-solid fa-list-check"></i> 설문 목록</h2>

        <div class="search-bar">
            <div>
                <select id="srchTyp">
                    <option value="all">전체</option>
                    <option value="surveyTitle">제목</option>
                    <option value="userId">등록자</option>
                </select>
                <input type="text" id="keyword" placeholder="검색어를 입력하세요">
                <button type="button" onclick="searchSurvey()">검색</button>
                <button type="button" onclick="resetSearch()">초기화</button>
            </div>
            <div>
                <strong>총 설문 수:</strong> <c:out value="${surveyCnt}" />
            </div>
        </div>

        <table class="table">
            <thead>
                <tr>
                    <th>설문 번호</th>
                    <th>설문 제목</th>
                    <th>등록자</th>
                    <th>등록 날짜</th>
                    <th>참여</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty surveyVOS}">
                        <c:forEach var="surveyVO" items="${surveyVOS}">
                            <tr>
                                <td>${surveyVO.surveyIdx}</td>
                                <td>${surveyVO.surveyTitle}</td>
                                <td>${surveyVO.userId}</td>
                                <td>${fn:substring(surveyVO.createDate, 0, 10)}</td>
                                <td>
                                    <a href="${ctp}/survey/surveyAnswer?surveyIdx=${surveyVO.surveyIdx}" class="btn btn-primary">설문 참여</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5">등록된 설문이 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <c:if test="${not empty pagination}">
            <div class="paginate">
                <div class="paging">
                    <c:if test="${pagination.hasPreviousPage}">
                        <a href="#" onclick="movePage(1)">&lt;&lt;</a>
                        <a href="#" onclick="movePage(${pagination.currentPage - 1})">&lt;</a>
                    </c:if>

                    <c:forEach var="idx" begin="${pagination.firstPage}" end="${pagination.lastPage}">
                        <c:choose>
                            <c:when test="${pagination.currentPage == idx}">
                                <strong>${idx}</strong>
                            </c:when>
                            <c:otherwise>
                                <a href="#" onclick="movePage(${idx})">${idx}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${pagination.hasNextPage}">
                        <a href="#" onclick="movePage(${pagination.currentPage + 1})">&gt;</a>
                        <a href="#" onclick="movePage(${pagination.totalRecordCount})">&gt;&gt;</a>
                    </c:if>
                </div>
            </div>
        </c:if>
    </div>
</section>

<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />

</body>
</html>
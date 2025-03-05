<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>surveyEventList</title>

    <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />

    <style>
        /* 전체 스타일 */
        h2 {
            margin: 20px 0;
        }

        /* 검색창 스타일 */
        .search-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .search-bar select, .search-bar input, .search-bar button {
            padding: 8px;
            font-size: 14px;
            margin-right: 5px;
        }

        /* 카드 스타일 */
        .survey-card {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .survey-card:hover {
            transform: translateY(-5px);
            box-shadow: 4px 4px 15px rgba(0, 0, 0, 0.2);
        }

        .survey-card img {
            height: 150px;
            object-fit: cover;
        }

        .survey-card .card-body {
            padding: 10px;
            text-align: center;
        }

        .survey-card h6 {
            font-size: 14px;
            font-weight: bold;
            color: #333;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .survey-card .btn {
            width: 80%;
            margin-top: 5px;
            font-size: 13px;
        }

        /* 페이지네이션 스타일 */
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
            const srchTyp = document.getElementById('srchTyp').value;
            const keyword = document.getElementById('keyword').value.trim();
            let url = "${ctp}/survey/surveyEventList?currentPage=" + currentPage;

            if (keyword) {
                url += "&srchTyp=" + srchTyp + "&keyword=" + encodeURIComponent(keyword);
            }

            location.href = url;
        }

        function searchSurvey() {
            movePage(1);
        }

        function resetSearch() {
            document.getElementById('srchTyp').value = "all";
            document.getElementById('keyword').value = "";
            movePage(1);
        }
    </script>
</head>
<body>

<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />

<section class="page">
    <div class="container">
        <h2 class="mb-4 text-center">설문 목록</h2>

        <div class="search-bar">
            <div>
                <select id="srchTyp">
                    <option value="all">전체</option>
                    <option value="surveyTitle">제목</option>
                    <option value="userId">등록자</option>
                </select>
                <input type="text" id="keyword" placeholder="검색어를 입력하세요">
                <button type="button" onclick="searchSurvey()" class="btn btn-sm btn-secondary">검색</button>
                <button type="button" onclick="resetSearch()" class="btn btn-sm btn-outline-secondary">초기화</button>
            </div>
            <div>
                <strong>총 설문 수:</strong> <c:out value="${surveyCnt}" />
            </div>
        </div>

        <div class="row">
            <c:choose>
                <c:when test="${not empty surveyList}">
                    <c:forEach var="survey" items="${surveyList}">
                        <div class="col-lg-3 col-md-4 col-sm-6 col-6 mb-3">
                            <div class="card survey-card">
                                <img src="${ctp}/survey/${survey.surveyThumb}" class="card-img-top" alt="설문 이미지"
                                     onerror="this.src='${ctp}/images/default.jpg';">

                                <div class="card-body">
                                    <h6 title="${survey.surveyTitle}">${survey.surveyTitle}</h6>
                                    <a href="${ctp}/survey/surveyAnswer?surveyIdx=${survey.surveyIdx}" class="btn btn-sm btn-primary">참여하기</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="text-center w-100">등록된 설문이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 📌 페이지네이션 -->
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
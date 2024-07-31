<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>surveyEventList</title>
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
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
        .hidden {
            display: none;
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

        function goSurvInfo(survNo) {
            $(".survey-detail").removeClass("hidden");
            $(".survey-list").addClass("hidden");

            // Fetch survey detail data using AJAX and populate the detail section
            $.ajax({
                type: 'get',
                url: '/getSurveyDetail',
                data: { survNo: survNo },
                success: function(data) {
                    $("#survTitle").text(data.survTitle);
                    $("#memNick").text(data.memNick);
                    $("#regDate").text(data.regDate);
                    $("#modDate").text(data.modDate);
                    $("#survDesc").html(data.survDesc || "[설문 설명 없음]");
                },
                error: function() {
                    alert("에러가 발생했습니다.");
                }
            });
        }

        function goList() {
            $(".survey-detail").addClass("hidden");
            $(".survey-list").removeClass("hidden");
        }
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
	<section class="page">
<div class="container">
    <div class="survey-list">
        <h2>📃 설문 리스트</h2>
        <br>
        <form id="searchForm">
            <div id="search_list">
                <select id="srchTyp" style="border:2px solid #6C757D">
                    <option value="all">전체</option>
                    <option value="surveyTitle">제목</option>
                    <option value="userId">등록자</option>
                    <option value="surveyIndex">설문 번호</option>
                </select>
                <input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요" style="width: 300px; border:2px solid #6C757D">
                <button type="button" id="srchBtn" onclick="searchKw();">검색 🔍</button>
                <button type="button" id="reset" onclick="searchReset();">초기화 ♻️</button>
            </div>
        </form>

        <span style="font-weight:bold;">총 설문 수: <c:out value="${surveyCnt}" /></span>
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
                                <td class="survno"><c:out value="${surv.survNo}" /></td>
                                <td class="survtitle"><a href="#" onclick="goSurvInfo(${surv.survNo});"><c:out value="${surv.survTitle}" /></a></td>
                                <td class="memNick"><c:out value="${surv.memNick}" /></td>
                                <td class="regdate"><c:out value="${surv.regDate}" /></td>
                                <td class="moddate"><c:out value="${surv.modDate}" /></td>
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
                                <a href="#" style="background-color:#EEEEEE; font-weight:700; color:black; font-size: large;"><c:out value="${idx}" /></a>
                            </c:when>
                            <c:otherwise>
                                <a href="#" onclick="movePage(${idx}, ${pagination.cntPerPage}, ${pagination.pageSize})"><c:out value="${idx}" /></a>
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
    </div>

    <div class="survey-detail hidden">
        <h2><i class="fa-solid fa-eye"></i> 설문 상세</h2>
        <br>

        <div class="table">
            <table id="survInfo">
                <tr>
                    <th>설문 제목</th>
                    <td colspan="3" class="survtitle" id="survTitle"></td>
                </tr>
                <tr>
                    <th>등록자</th>
                    <td colspan="3" class="survtitle" id="memNick"></td>
                </tr>
                <tr>
                    <th>등록 날짜</th>
                    <td class="regdate" id="regDate"></td>
                    <th>수정 날짜</th>
                    <td class="moddate" id="modDate"></td>
                </tr>
                <tr>
                    <th colspan="4">설문 설명</th>
                </tr>
                <tr>
                    <td colspan="4">
                        <div class="survdesc" id="survDesc"></div>
                    </td>
                </tr>
            </table>
        </div>
        <div id="btn">
            <button onclick="resForm()">응답 하기</button>
            <button onclick="goList()">목록 보기</button>
        </div>
    </div>
</div>
	</section>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>

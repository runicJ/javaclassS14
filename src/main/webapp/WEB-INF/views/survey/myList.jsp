<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
  	<head>
  		<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	    <link rel="stylesheet" type="text/css" href="./css/survList.css">
	    <script type="text/javascript" src="./js/myList.js"></script>
		<title>My Survey</title>
		<style>
		@charset "UTF-8";

h2 {
	margin-top:5px;
	margin-bottom:20px;
}

table {
	width: 100%;
	margin-top: 20px;
}

th, .survno, .regdate, .moddate, .useYn, .result {
	text-align: center;
}

.survno {
	width:100px;
}

th {
	background-color: #6C757D;
	color:white;
}

.survtitle {
	width: 50%;
}

.survtitle a {
	color:black;
}

.survtitle a:hover {
	text-decoration:none;
	color:pink;
}

.right {
	float:right;
}

.right select {
	width: 100px;
}


/* paginate */
.paginate {
    padding: 0;
    line-height: normal;
    text-align: center;
    position: relative;
    margin: 20px 0 20px 0;
    z-index: 1;
}
 
.paginate .paging {
    text-align: center;
}
 
.paginate .paging a, .paginate .paging strong {
    margin: 0;
    padding: 0;
    width: 20px;
    height: 24px;
    line-height: 24px;
    text-align: center;
    color: #848484;
    display: inline-block;
    vertical-align: middle;
    text-align: center;
    font-size: 12px;
}
 
.paginate .paging a:hover, .paginate .paging strong {
    color: #DAA520;
    font-weight: 600;
    font-weight: normal;
}
 
.paginate .paging .direction {
    z-index: 3;
    vertical-align: middle;
    background-color: none;
    margin: 0 2px;
    border: 1px solid #777;
    border-radius: 2px;
    width: 28px;
}
 
.paginate .paging .direction:hover {
    border: 1px solid #C40639;
}
 
.paginate .paging .direction.prev {
    margin-right: 4px;
}
 
.paginate .paging .direction.next {
    margin-left: 4px;
    cursor: pointer;
}
 
.paginate .paging img {
    vertical-align: middle;
}
 
.paginate .right {
    position: absolute;
    top: 0;
    right: 0;
}
 
.bottom-left, .bottom-right {
    position: relative;
    z-index: 5;
}
 
.paginate ~ .bottom {
    margin-top: -50px;
}
 
 
.bottom select {
    background: transparent;
    color: #aaa;
    cursor: pointer;
}
 
 
/* paginate */
.paginate {
    padding: 0;
    line-height: normal;
    text-align: center;
    position: relative;
    margin: 20px 0 20px 0;
    width:80%;
}
 
.paginate .paging {
    text-align: center;
}
 
.paginate .paging a, .paginate .paging strong {
    margin: 0;
    padding: 5px;
    width: 20px;
    height: 28px;
    line-height: 28px;
    text-align: center;
    color: #999;
    display: inline-block;
    vertical-align: middle;
    text-align: center;
    font-size: 14px;
}
 
.paginate .paging a:hover, .paginate .paging strong {
    color: black;
    font-weight: 600;
    font-weight: normal;
}
 
.paginate .paging .direction {
    z-index: 3;
    vertical-align: middle;
    background-color: none;
    margin: 0 2px;
}
 
.paginate .paging .direction:hover {
    background-color: transparent;
}
 
.paginate .paging .direction.prev {
    margin-right: 4px;
}
 
.paginate .paging .direction.next {
    margin-left: 4px;
}
 
.paginate .paging img {
    vertical-align: middle;
}
 
.paginate .right {
    position: absolute;
    top: 0;
    right: 0;
}

.paginate a:hover {
	/* background-color:#EEEEEE; */
	color: black;
	font-size: large;
	text-decoration: none;
}

/* Page Css 끝*/

#searchForm {
	margin-bottom:20px;
}

.body button {
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  
  margin:10px;
  padding: 0.5rem 1rem;

  font-size: 1rem;
  font-weight: 400;
  text-align: center;
  text-decoration: none;

  display: inline-block;
  width: auto;

  border: none;
  border-radius: 4px;
  
}
  
.body button:hover {
	background-color:black;
	color:white;
}

#search_list select {
	padding : 10px;
	font-size: 15px;
}

#search_list input {
	padding : 10px;
	font-size: 15px;
}

#srchBtn {
	background-color:#6C757D;
	color: white;
	height: 40px;
}

#srchBtn:hover {
	background-color: black;
	
}

.result button {
	margin:0;
	padding: 3px;

	font-size: small;
}
		</style>
		<script>
		//10,20,30개씩 selectBox 클릭 이벤트
		function changeSelectBox(currentPage, pageSize){
		    var selectValue = $("#cntSelectBox").children("option:selected").val();
		    movePage(currentPage, selectValue, pageSize); 
		}

		//페이지 이동
		function movePage(currentPage, cntPerPage, pageSize){
		    
		    let url = "/myList";
		    url = url + "?currentPage="+currentPage;
		    url = url + "&cntPerPage="+cntPerPage;
		    url = url + "&pageSize="+pageSize;
		    
			let keyword = $('#keyword').val().trim();
			let srchTyp = $('#srchTyp').val();
		 
		    if(keyword != null) {
		    	url = url + "&srchTyp=" + srchTyp;
		   	 	url = url + "&keyword=" + keyword;
		    }
		    
		    location.href=url;
		}

		function searchKw() {
			let srchTyp = $('#srchTyp').val();
			let keyword = $('#keyword').val().trim();
			let selectValue = $("#cntSelectBox").children("option:selected").val();
			
			 let url = "/myList";
			 url = url + "?srchTyp=" + srchTyp;
			 url = url + "&keyword=" + keyword;
			 url = url + "&cntPerPage=" + selectValue;
			 
			 location.href=url;
		}

		function searchReset() {
			location.href="/myList";
		}

		function viewRslt(survNo, currentPage, pageSize) {
			let srchTyp = $('#srchTyp').val();
			let keyword = $('#keyword').val().trim();
			let cntPerPage = $("#cntSelectBox").children("option:selected").val();
			
			let url = "/survRslt";
			url = url + "?survNo=" + survNo;
			url = url + "&currentPage="+currentPage;
			url = url + "&cntPerPage=" + cntPerPage;
		    url = url + "&pageSize=" + pageSize;
			url = url + "&srchTyp=" + srchTyp;
			url = url + "&keyword=" + keyword;
			
			location.href = url;
		}

		function editSurv(survNo, currentPage, pageSize) {
			let srchTyp = $('#srchTyp').val();
			let keyword = $('#keyword').val().trim();
			let cntPerPage = $("#cntSelectBox").children("option:selected").val();
			
			 let url = "/modSurvForm";
			 url = url + "?currentPage="+currentPage;
		     url = url + "&cntPerPage="+cntPerPage;
		     url = url + "&pageSize="+pageSize;
			 url = url + "&srchTyp=" + srchTyp;
			 url = url + "&keyword=" + keyword;
			 url = url + "&survNo=" + survNo;
			 
			 location.href=url;
		}
		</script>
  </head>
  <th:block layout:fragment="contents">
	<body>
	<div class="body">
	<h2>📑 My Survey</h2>
	<br>
	
	<!-- SearchForm -->
    <form id="searchForm">
	    <div id="search_list">
	    <select id="srchTyp" style="border:2px solid #6C757D" th:value="${pagination.srchTyp}" th:field="${pagination.srchTyp}">
                <option th:value="'useYN'">전체</option>
                <option th:value="'useY'">사용중</option>
                <option th:value="'useN'">사용 안함</option>
            </select>
            <input type="text" id="keyword" name="keyword" placeholder="설문 제목을 입력하세요" th:value="${pagination?.keyword}" style="width: 300px; border:2px solid #6C757D">
            <button type="button" id="srchBtn" onclick="searchKw();">검색 🔍</button>
            <button type="button" id="reset" onclick="searchReset();">초기화 ♻️</button>
		</div>
    </form>
	
	<span style="font-weight:bold;">나의 설문 수 : <span th:text="${total}"></span></span>
	<div class="right">
	<select id="cntSelectBox" name="cntSelectBox"
		th:onchange="changeSelectBox([[${pagination.currentPage}]],[[${pagination.pageSize}]]);"
		th:value="${pagination.cntPerPage}" th:field="${pagination.cntPerPage}">
		<option th:value="10">10개씩</option>
		<option th:value="20">20개씩</option>
		<option th:value="30">30개씩</option>
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
				</tr>
			</thead>
			<tbody>
			<th:block th:if="${survList} != null">
			<tr th:each="surv : ${survList}">
					<td class="survno" th:text="${surv.survNo}"></td>
					<td class="survtitle"><a th:text="${surv.survTitle}" href="#" th:onclick="editSurv([[${surv.survNo}]], [[${pagination.currentPage}]], [[${pagination.pageSize}]]);"></a></td>
					<td class="useYn">
						<span th:if="${#strings.equals(surv.useYn, 'Y')}">사용중</span>
						<span th:unless="${#strings.equals(surv.useYn, 'Y')}">사용 안함</span>
					</td>
					<td class="regdate" th:text="${#dates.format(surv.regDate, 'yyyy-MM-dd HH:mm')}"></td>
					<td class="moddate" th:text="${#dates.format(surv.modDate, 'yyyy-MM-dd HH:mm')}"></td>
					<td class="result"><button th:onclick="viewRslt([[${surv.survNo}]], [[${pagination.currentPage}]], [[${pagination.pageSize}]]);">결과 보기</button></td>
				</tr>
			</th:block>
			<th:block th:unless="${survList} != null">
				<tr>
					<td colspan="5" style="text-align:center;">회원님이 생성한 설문이 없습니다.</td>
				</tr>
			</th:block>
			</tbody>
		</table>
	</div>
	
	<!--paginate -->
	<th:block th:if="${survList} != null">
    <div class="paginate">
        <div class="paging">
        <!-- 이전 표시 -->
        <th:block th:if="${pagination.hasPreviousPage == true}">
        <a class="direction prev" href="#"
        	th:attr="onclick=|movePage(1, '${pagination.cntPerPage}', '${pagination.pageSize}')|">&lt;&lt;</a>
        <a class="direction prev" href="#"
        	th:attr="onclick=|movePage('${pagination.currentPage - 1}', '${pagination.cntPerPage}', '${pagination.pageSize}')|">&lt;</a>
        </th:block>
        
        <!-- 페이지 번호 -->
        <th:block th:each="idx : ${#numbers.sequence(pagination.firstPage, pagination.lastPage)}">
       		<th:block th:if="${pagination.currentPage == idx}">
		        <a href="#"
		        	style="background-color:#EEEEEE; font-weight:700; color:black; font-size: large;"
		        	th:text="${idx}"></a>
	        </th:block>
	        <th:block th:unless="${pagination.currentPage == idx}">
		        <a href="#"
		        	th:attr="onclick=|movePage('${idx}', '${pagination.cntPerPage}', '${pagination.pageSize}')|"
		        	th:text="${idx}"></a>
	        </th:block>
        </th:block>
        
        <!-- 다음 표시 -->
        <th:block th:if="${pagination.hasNextPage == true}">
        <a class="direction next" href="#"
        	th:attr="onclick=|movePage('${pagination.currentPage + 1}', '${pagination.cntPerPage}', '${pagination.pageSize}')|">&gt;</a>
        <a class="direction next" href="#"
        	th:attr="onclick=|movePage('${pagination.totalRecordCount}', '${pagination.cntPerPage}', '${pagination.pageSize}')|">&gt;&gt;</a>
        </th:block>
        </div>
    </div>
	</th:block>
	<!-- /paginate -->
	
	</div>
	</body>
  </th:block>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
  	<head>
  		<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	    <link rel="stylesheet" type="text/css" href="./css/survList.css">
	    <script type="text/javascript" src="./js/survList.js"></script>
		<title>설문 리스트</title>
		<script>
		//10,20,30개씩 selectBox 클릭 이벤트
		function changeSelectBox(currentPage, pageSize){
		    var selectValue = $("#cntSelectBox").children("option:selected").val();
		    movePage(currentPage, selectValue, pageSize); 
		}

		//페이지 이동
		function movePage(currentPage, cntPerPage, pageSize){
		    
		    let url = "/survList";
		    url = url + "?currentPage="+currentPage;
		    url = url + "&cntPerPage="+cntPerPage;
		    url = url + "&pageSize="+pageSize;
		    
		    let srchTyp = $('#srchTyp').val();
			let keyword = $('#keyword').val().trim();
		 
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
			
			 let url = "/survList";
			 url = url + "?srchTyp=" + srchTyp;
			 url = url + "&keyword=" + keyword;
			 url = url + "&cntPerPage=" + selectValue;
			 
			 location.href=url;
		}

		function searchReset() {
			location.href="/survList";
		}

		function goSurvInfo(survNo, currentPage, pageSize) {
			let srchTyp = $('#srchTyp').val();
			let keyword = $('#keyword').val().trim();
			let selectValue = $("#cntSelectBox").children("option:selected").val();
			
			let url = "/survInfo";
				url = url + "?survNo=" + survNo;
				url = url + "&srchTyp=" + srchTyp;
				url = url + "&keyword=" + keyword;
				url = url + "&cntPerPage=" + selectValue;
				url = url + "&currentPage=" + currentPage;
				url = url + "&pageSize=" + pageSize;
		 
			 location.href=url;
		}
		</script>
  </head>
  <th:block layout:fragment="contents">
	<body>
	<div class="body">
	<h2>📃 설문 리스트</h2>
	<br>
	
	<!-- SearchForm -->
    <form id="searchForm">
	    <div id="search_list">
            <select id="srchTyp" style="border:2px solid #6C757D" th:value="${pagination.srchTyp}" th:field="${pagination.srchTyp}">
                <option th:value="'all'">전체</option>
                <option th:value="'title'">제목</option>
                <option th:value="'regid'">등록자</option>
                <option th:value="'survNo'">설문 번호</option>
            </select>
            <input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요" th:value="${pagination.keyword}" style="width: 300px; border:2px solid #6C757D">
            <button type="button" id="srchBtn" onclick="searchKw();">검색 🔍</button>
            <button type="button" id="reset" onclick="searchReset();">초기화 ♻️</button>
		</div>
    </form>
	
	<span style="font-weight:bold;">총 설문 수 : <span th:text="${total}"></span></span>
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
					<th>등록자</th>
					<th>등록 날짜</th>
					<th>최종 수정 날짜</th>
				</tr>
			</thead>
			<tbody>
			<th:block th:if="${survList} != null">
			<tr th:each="surv : ${survList}">
					<td class="survno" th:text="${surv.survNo}"></td>
					<td class="survtitle"><a th:text="${surv.survTitle}" href="#" th:onclick="goSurvInfo([[${surv.survNo}]],[[${pagination.currentPage}]],[[${pagination.pageSize}]])"></a></td>
					<td class="memNick" th:text="${surv.memNick}"></td>
					<td class="regdate" th:text="${#dates.format(surv.regDate, 'yyyy-MM-dd HH:mm')}"></td>
					<td class="moddate" th:text="${#dates.format(surv.modDate, 'yyyy-MM-dd HH:mm')}"></td>
				</tr>
			</th:block>
			<th:block th:unless="${survList} != null">
				<tr>
					<td colspan="5" style="text-align:center;">조회된 설문이 없습니다.</td>
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

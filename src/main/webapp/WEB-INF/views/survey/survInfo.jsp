<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
  	<head>
  		<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	    <script type="text/javascript" src="./js/survInfo.js"></script>
	    <script th:inline="javascript">
		    let memId =  /*[[${memId}]]*/ null;
		    let survNo = /*[[${survey.survNo}]]*/ null;
		    let currentPage = /*[[${pagination.currentPage}]]*/ 1;
		    let pageSize = /*[[${pagination.pageSize}]]*/ 10;
		    let cntPerPage = /*[[${pagination.cntPerPage}]]*/ 10;
		    let srchTyp = /*[[${pagination.srchTyp}]]*/ null;
		    let keyword = /*[[${pagination.keyword}]]*/ null;
		</script>
		<title>설문 리스트</title>
		<script>
		/*작성자 : Bonnie 리스트 응답 폼 보여주기 */
		/* 
		 * 수정자 : Jetty
		 * 수정 내용 : 접속 회원의 해당 설문 응답 여부 확인 후 응답 페이지로 이동
		 */
		function resForm(){
			
			// spring security 토큰/헤더
			let token = $("meta[name='_csrf']").attr("content");
			let header = $("meta[name='_csrf_header']").attr("content");
			
			$.ajax({		
				type:'post',
				url:'/checkRes',
				data:{
						"memId" : memId,
						"survNo" : survNo
					},
				beforeSend : function(xhr){
					xhr.setRequestHeader(header, token);
				},
				success:function(cnt){ //컨트롤러에서 넘어온 cnt값을 받는다 
					 if(cnt != 0){ //cnt가 0이 아니라면 이미 응답한 설문
						alert("이미 응답한 설문입니다.");
					 } else { // cnt가 0일 경우 페이징 정보를 가지고 설문 응답 페이지로 이동
						let url = "/resForm";
						url += "?survNo="+survNo;
						url += "&currentPage="+currentPage;
						url += "&cntPerPage="+cntPerPage;
						url += "&pageSize="+pageSize;
						url += "&srchTyp="+srchTyp;
						url += "&keyword="+keyword;
						
						location.href = url;
		            }
				console.log("cnt >> " + cnt);
		        },
		        error:function(){
		            alert("에러입니다");
		        }
			})

		}

		function goList() {
			let url = "/survList";
			url = url + "?currentPage=" + currentPage;
			url = url + "&cntPerPage=" + cntPerPage;
			url = url + "&pageSize=" + pageSize;
		    url = url + "&srchTyp=" + srchTyp;
		 	url = url + "&keyword=" + keyword;
			 	
			location.href=url;
		}
		</script>
  </head>
  <th:block layout:fragment="contents">
	<body>
	<div class="body">
	<h2>👀 설문 상세</h2>
	<br>

	<div class="table">
		<table id="survInfo">
		<tr>
			<th>설문 제목</th>
			<td colspan="3" class="survtitle" th:text="${survey.survTitle}"></td>
		</tr>
		<tr>
			<th>등록자</th>
			<td colspan="3" class="survtitle" th:text="${survey.memNick}"></td>
		</tr>
		<tr>
			<th>등록 날짜</th>
			<td class="regdate" th:text="${#dates.format(survey.regDate, 'yyyy-MM-dd HH:mm')}"></td>
			<th>수정 날짜</th>
			<td class="moddate" th:text="${#dates.format(survey.modDate, 'yyyy-MM-dd HH:mm')}"></td>
		</tr>
		<tr>
			<th colspan="4">설문 설명</th>
		</tr>
		<tr>
			<td colspan="4" th:if="${survey.survDesc} != null" >
			<div class="survdesc">
			<span th:utext="${survey.survDesc}"></span>
			</div>
			</td>
			<td colspan="4" class="descNull" th:unless="${survey.survDesc} != null">[설문 설명 없음]</td>
		</tr>
		</table>
	</div>
	<div id="btn">
	<button onclick="resForm()">응답 하기</button>
	<button onclick="goList()">목록 보기</button>
	</div>
	
	</div>
	</body>
  </th:block>
</html>

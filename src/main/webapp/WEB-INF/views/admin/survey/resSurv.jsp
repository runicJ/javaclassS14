<html lang="ko"
		  xmlns="http://www.w3.org/1999/xhtml"
		  xmlns:th="http://www.thymeleaf.org"
		  xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
		  layout:decorate="~{layout/main_layout}">
  	<head>
	    <meta name="_csrf" th:content="${_csrf.token}">
	    <meta name="_csrf_header" th:content="${_csrf.headerName}">
	    <link rel="stylesheet" type="text/css" href="./css/survForm.css">
	    <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	   <!--  <script type="text/javascript" src="./js/regSurv.js"></script> -->
	   <style>
		  button {
			  -webkit-appearance: none;
			  -moz-appearance: none;
			  appearance: none;
			  
			  margin:10px;
			  margin-left:0;
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
		  
		button:hover {
			background-color:black;
			color:white;
		}
	   </style>
	   <script type="text/javascript"  th:inline="javascript">
	   let url = "/survList";
				let currentPage = /*[[${currentPage}]]*/ null;
				let cntPerPage = /*[[${cntPerPage}]]*/ null;
				let pageSize = /*[[${pageSize}]]*/ null;
				let keyword = /*[[${keyword}]]*/ null;
				let srchTyp = /*[[${srchTyp}]]*/ null;
				
				url += "?currentPage=" +  currentPage
					+ "&cntPerPage=" + cntPerPage
					+ "&pageSize=" + pageSize
					+ "&keyword=" + keyword
					+ "&srchTyp=" + srchTyp;
					
	   		function response(){
				let memId = $("#memId").val(); // 응답한 회원 ID
				let qustList =  /*[[${surveyDto.survqustList}]]*/ null;
				let empty = false;
				
	   			let answerList = []; //응답 모아 놓을 곳
				
				for(let idx in qustList) {
		   			let answerObj = {};
					let qust = qustList[idx];
					let qustType = qust.qustType;
					
					answerObj = {
						qustNo : qust.qustNo,
						memId : memId,
						answCont : "",
						answLong : ""
					};
					
					if(qustType == "long") {
						const answLong = document.getElementById(qust.qustNo);
						if(answLong.value.trim() == "") {
							empty = true;
						}
						answerObj.answLong = answLong.value.trim();
						answerList.push(answerObj);
					} else if (qustType == "check" || qustType == "radio") {
						let count = 0;
						const check = document.getElementsByName(qust.qustNo);
						for(i=0;i<check.length;i++) {
							if(check[i].checked == true) {
								let obj = {
									qustNo : qust.qustNo,
									memId : memId,
									answCont : "",
									answLong : ""
								};
								obj.answCont = check[i].value;
								answerList.push(obj);
								count++;
							}
						}
						if(count == 0) {
							empty = true;
						}
					} else if (qustType == "short") {
						answerObj.answCont = document.getElementById(qust.qustNo).value.trim();
						if(answerObj.answCont == "") {
							empty = true;
						}
						answerList.push(answerObj);
					} else if (qustType == "select") {
						const drop = document.getElementById(qust.qustNo);
						answerObj.answCont = drop.options[drop.selectedIndex].value;
						answerList.push(answerObj);
					}
					
				} // qustList for문
				
				console.log(answerList);
				
				if(empty) {
					alert("모든 문항에 응답 바랍니다.");
					return;
				}
				
				let header = $("meta[name='_csrf_header']").attr('content');
				let token = $("meta[name='_csrf']").attr('content');
				
				let param = {};
				param.answerList = answerList;
				
				$.ajax({
					url:"/resSurv",
					type:"POST",
					contentType : "application/json; charset=utf-8",
					data: JSON.stringify(param),
					beforeSend: function(xhr){
			        xhr.setRequestHeader(header, token);
				},
				success: function() {
					alert('등록 완료');
					location.href = url;
				},
				error: function(e) {
					alert("등록 실패!!");
					console.log(e);
				}
				
				});		
	   		}
	   		
	   		function backList(){
	   			location.href = url;
	   			
	   		}
	   
	   </script>
    </head>
    <th:block layout:fragment="contents">
	    <body>
	    	<h2>📝 설문 응답하기</h2>
			
	      		<input type="hidden"  name="${_csrf.parameterName }" value="${_csrf.token }"/>
	      		<input type="hidden"  id="memId" th:value="${memId}"/>
	      		<div class="surv-container">
		    	<!-- 설문 기본정보 START -->
				<div class="form-table-title-continer">
					<table class="form-tbl">
				       <tr>
				           <td class="form-tbl-col">제목</td>
				           <td  th:text=${surveyDto.survTitle}><input name="survTitle" id="survTitle" size="80" maxlength="100" /></td>
				       </tr>
				       <tr>
				       <td class="form-tbl-col" >등록자</td>
				           <td th:text="${surveyDto.memNick}"></td>
				       </tr>
				   </table>
				</div>
			<!-- 설문 기본정보 END -->
			
			<!-- 설문지 소개 START -->
			<div class="form-table-intro-container">
			<input type="hidden" >
				<table id="quest-table" class="form-tbl">
				   <tr>
				       <td class="form-tbl-col">소개</td>
				       <td id="survDesc" style="width:80%;" th:utext=${surveyDto.survDesc} ></td>
				   </tr>
				</table>
			</div>
			
			<!-- 설문지 소개 END -->
			<div>
			<table id="surv_quests_tbl" class="form-tbl">
			<thead>		
				<tr>
				    <th class="form-tbl-col">질문</th>
				 </tr>
			</thead>
		    <tbody>
		         <tr th:each="qust : ${surveyDto.survqustList}">
	            	
	            	<!-- 단답형 -->
	            	<td th:if="${qust.qustType}=='short'" th:classappend="${qust.qustType}">
	            	 	<div class="surv_opt_box">
		            		<span>📌 </span><span class="qustCont" th:text=${qust.qustCont}></span>
		            		<br/>
		            		<br/>
		            		<input th:name="${qust.qustNo}" th:id="${qust.qustNo}" size="137" >
	            		</div>
	            	</td>
	            	
	            	<!-- 장문형 -->
		            <td th:if="${qust.qustType}=='long'" >
		                <div class="surv_opt_box">
		                	<span>📌 </span><span class="qustCont" th:text=${qust.qustCont}></span>
		                	<br/>
		                	<br/>
		                	<textarea th:id="${qust.qustNo}" th:name="${qust.qustNo}" cols="140" rows="7" style="resize:none"></textarea>
		                </div>
		            </td>
		            
		            <!-- 셀릭트 형 -->
	            	<td th:if="${qust.qustType}=='select'">
		                <div class="surv_opt_box">		
		                <span>📌 </span><span class="qustCont" th:text=${qust.qustCont}></span>       
		                <br/>
		                 <br/>
		                <select th:id="${qust.qustNo}" th:name="${qust.qustNo}" style="min-width:100px;">
							<option th:each="opt : ${qust.qustoptList}" th:value=${opt.optCont} th:utext=${opt.optCont}></option>					
						</select>
		                </div>
	            	</td>
	            	
	            	<!-- 라디오 -->
		            <td th:if="${qust.qustType}=='radio'">
		                <div class="surv_opt_box">
		                	<span>📌 </span><span class="qustCont" th:text=${qust.qustCont}></span>
		                	<br/>
		                	<br/>
		                	<th:block th:id="${qust.qustNo}" th:each="opt : ${qust.qustoptList}">
		                    	<input type="radio" th:name="${qust.qustNo}" th:value=${opt.optCont} th:utext=${opt.optCont} style="margin-right:10px;"></input>  
		                    <br>
		                	</th:block>	
		                </div>
		            </td>
		            
		            <!-- 체크박스 -->
		            <td th:if="${qust.qustType}=='check'">
		                <div class="surv_opt_box">
		                	<span>📌 </span><span class="qustCont" th:text=${qust.qustCont}></span>
		                	<br/>
		                	<br/>
		                	<th:block th:id="${qust.qustNo}" th:each="opt : ${qust.qustoptList}">
		                		<input type="checkbox" th:name="${qust.qustNo}" th:value=${opt.optCont} th:utext=${opt.optCont} style="margin-right:10px;" />
		                		<br>
		                	</th:block>
		                </div>
		            </td>
		         </tr>
		         
		       </tbody>
		    </table>
		    </div>
			</div>
			<br>
			<!-- <button type="submit" class="btn btn-dark " >제출하기</button> -->
			

			<!-- currentPage, cntPerPage, pageSize, srchTyp, keyword -->
			  <button onclick="response()">제출하기</button>
			  <button onclick="backList()">목록 보기</button>
			  <!-- <a th:href="@{/survList(currentPage=${current)}"><button>목록</button></a> -->
			  <!-- <a th:href="@{/survList(currentPage=${currentPage}, srchTyp=${srchTyp}, keyword=${keyword}))"><button>목록</button></a> -->
			<!-- 설문지 질문 END -->
	    </body>
    </th:block>
</html>
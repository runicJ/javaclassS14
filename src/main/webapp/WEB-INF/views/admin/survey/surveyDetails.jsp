<html lang="ko"
		  xmlns="http://www.w3.org/1999/xhtml"
		  xmlns:th="http://www.thymeleaf.org"
		  xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
		  layout:decorate="~{layout/main_layout}">
	<head>
  		<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
  		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.8.0/chart.min.js"></script>
  		<script type="text/javascript" src="./js/survRslt.js"></script>
  		<link rel="stylesheet" type="text/css" href="./css/survRslt.css">
		<title>설문 결과</title>
		<style>
		@charset "UTF-8";

			h2 {
				margin-top:5px;
				margin-bottom:20px;
			}
			
			h3 {
				margin-top: 30px;
				margin-bottom: 20px;
			}
			
			#survInfo {
				width:100%;
				padding: 20px;
				border-top: 2px solid #EEEEEE;
			    border-collapse: collapse;
			}
			
			#survInfo th, #survInfo td {
			    border-bottom: 2px solid #EEEEEE;
			    padding: 10px;
			}
			
			#survInfo th {
				text-align: center;
				background-color: #EEEEEE;
			}
			
			.regdate, .moddate, .uesYn {
				text-align: center;
			}
			
			.descNull {
				color : grey;
				text-align: center;
				font-style: italic;
			}
			
			.survdesc {
				overflow:auto;
				max-height:100px;
			}
			
			.answLong, .answShort {
				overflow:auto;
				max-height:300px;
			}
			
			#rslt {
				width:100%;
				padding: 20px;
				border-top: 2px solid #EEEEEE;
			    border-collapse: collapse;
			}
			
			#rslt th {
				width:100%;
				/* border-top: 2px solid #EEEEEE; */
				border-bottom: 2px solid #6C757D;
			    padding: 10px;
			    background-color:#EEEEEE;
			}
			
			#rslt td {
			    padding: 10px;
			}
			
			#rslt p {
				/* border-bottom: 1px solid #EEEEEE; */
				background-color: #f4f4f4;
				padding:15px;
				border-radius:8px;
			}
			
			#rslt .count {
				float:right;
				margin-right:15px;
				border-radius:50%;
				background-color:pink;
				width:25px;
				height:25px;
				text-align:center;
			}
			
			#rslt .canvas {
				max-height: 500px;
				padding: 30px;
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
			
			.body #btn {
				text-align:center;
			}
		</style>
		<script type="text/javascript">
		$(document).ready(function(){
			for(let idx in qustList) {
				
				let qust = qustList[idx];
				let qustType = qust.qustType;
				
				// 응답 수
				let total = 0;
				
				if(qustType != "long") {
					for(let answ in qust.answerList) {
						total += qust.answerList[answ].count;
					}
					const count = document.getElementById(qust.qustNo + "total");
					count.innerHTML = total;
				}
				
				// 차트 그리기
				if(qustType != "long" && qustType != "short" && total != 0) {
					const ctx = document.getElementById(qust.qustNo).getContext('2d');
					
					let labels = [];
					let data = [];
					
					for(let answ in qust.answerList) {
						labels.push(qust.answerList[answ].answCont);
						data.push(qust.answerList[answ].count);
					}
					
					// 체크박스일 경우 막대그래프
					if(qustType == "check") {
						const barChart = new Chart(ctx, {
						    type: 'bar',
						    data: {
						        labels: labels,
						        datasets: [{
						            label: qust.qustCont,
						            data: data,
						            backgroundColor: [
						                'rgba(255, 99, 132, 0.4)',
						                'rgba(54, 162, 235, 0.4)',
						                'rgba(255, 206, 86, 0.4)',
						                'rgba(75, 192, 192, 0.4)',
						                'rgba(153, 102, 255, 0.4)',
						                'rgba(255, 159, 64, 0.4)',
						                'rgba(201, 203, 207, 0.4)'
						            ],
						            borderColor: [
						                'rgba(255, 99, 132)',
						                'rgba(54, 162, 235)',
						                'rgba(255, 206, 86)',
						                'rgba(75, 192, 192)',
						                'rgba(153, 102, 255)',
						                'rgba(255, 159, 64)',
						                'rgb(201, 203, 207)'
						            ],
						            borderWidth: 1
						        }]
						    },
						    options: {
						        scales: {
						            y: {
						                beginAtZero: true,
						                ticks: {
						                	/*stepSize : 1,*/
						                	// y축 간격을 정수로
						                	callback: function(value) {if (value % 1 === 0) {return value;}}
										}
						            },
						        }
						    }
						});
						
					// 드롭다운 / 라디오(객관식)일 경우 파이 그래프 
					} else if(qustType == "select" || qustType == "radio") {
						const pieChart = new Chart(ctx, {
						    type: 'pie',
						    data: {
						        labels: labels,
						        datasets: [{
						            data: data,
						            backgroundColor: [
						            	'rgba(255, 99, 132, 0.4)',
						                'rgba(54, 162, 235, 0.4)',
						                'rgba(255, 206, 86, 0.4)',
						                'rgba(75, 192, 192, 0.4)',
						                'rgba(153, 102, 255, 0.4)',
						                'rgba(255, 159, 64, 0.4)',
						                'rgba(201, 203, 207, 0.4)'
						            ],
						            borderColor: [
						                'rgba(255, 99, 132)',
						                'rgba(54, 162, 235)',
						                'rgba(255, 206, 86)',
						                'rgba(75, 192, 192)',
						                'rgba(153, 102, 255)',
						                'rgba(255, 159, 64)',
						                'rgb(201, 203, 207)'
						            ],
						            borderWidth: 1,
						            hoverOffset: 4
						        }]
						    },
						    options: {
						    	legend: {
						            position: 'right',
						            display: true
						        },
						        plugins: {
						            legend: {
						                position: 'right',
						            }
						        }
						    }
						});
						
					} // 질문 유형에 따라 chart 그리는 if문
				} // 장문/단답 확인용 if문
			} // qustList
		}); // $(document).ready

		function goList(currentPage, cntPerPage, pageSize, srchTyp, keyword) {
			let url = "/myList";
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
	<script th:inline="javascript">
		    let qustList =  /*[[${survey.survqustList}]]*/ null;
	</script>
	<body>
	<h2>📋 설문 결과</h2>
	<br>
	<div class="body">
	<table id="survInfo">
		<tr>
			<th>설문 제목</th>
			<td colspan="5" class="survtitle" th:text="${survey.survTitle}"></td>
		</tr>
		<tr>
			<th>등록 날짜</th>
			<td class="regdate" th:text="${#dates.format(survey.regDate, 'yyyy-MM-dd HH:mm')}"></td>
			<th>수정 날짜</th>
			<td class="moddate" th:text="${#dates.format(survey.modDate, 'yyyy-MM-dd HH:mm')}"></td>
			<th>사용 여부</th>
			<td class="uesYn">
				<span th:if="${#strings.equals(survey.useYn, 'Y')}">사용중</span>
				<span th:unless="${#strings.equals(survey.useYn, 'Y')}">사용 안함</span>
			</td>
		</tr>
		<tr>
			<th colspan="6">설문 설명</th>
		</tr>
		<tr>
			<td colspan="6" th:if="${survey.survDesc} != null" >
			<div class="survdesc">
			<span th:utext="${survey.survDesc}"></span>
			</div>
			</td>
			<td colspan="6" class="descNull" th:unless="${survey.survDesc} != null">[설문 설명 없음]</td>
		</tr>
	</table>
	<div style="float:right;">
	<button id="list" th:onclick="goList([[${pagination.currentPage}]], [[${pagination.cntPerPage}]],[[${pagination.pageSize}]],
		[[${pagination.srchTyp}]], [[${pagination.keyword}]])">목록 보기</button>
	</div>
	<br>
	<h3>📊 응답 결과</h3>
	
	<table id="rslt">
		<th:block th:each="qust : ${survey.survqustList}">
			<tr>
				<th th:text="${qust.qustCont}"></th>
			</tr>
			<th:block th:if="${#strings.equals(qust.qustType, 'long')}">
			<tr>
				<td>응답 <span th:text="${#lists.size(qust.answerList)}"></span>개</td>
			</tr>
			<tr>
				<td>
					<div class="answLong">
					<th:block th:each="answ : ${qust.answerList}">
					<p th:utext="${answ?.answLong}"></p>
					</th:block>
					</div>
				</td>
			</tr>
			</th:block>
			<th:block th:if="${#strings.equals(qust.qustType, 'short')}">
			<tr>
				<td>응답 <span th:id="${qust.qustNo}+total"></span>개</td>
			</tr>
			<tr>
				<td>
					<div class="answShort">
					<th:block th:each="answ : ${qust.answerList}">
					<p>
						<span th:text="${answ?.answCont}"></span>
						<span class="count" th:text="${answ.count}"></span>
					</p>
					</th:block>
					</div>
				</td>
			</tr>
			</th:block>
			<th:block th:unless="${#strings.equals(qust.qustType, 'long')} or ${#strings.equals(qust.qustType, 'short')} ">
			<tr>
				<td>응답 <span th:id="${qust.qustNo}+total"></span>개</td>
			</tr>
			<tr>
				<td>
					<canvas th:id="${qust.qustNo}" class="canvas"></canvas>
				</td>
			</tr>
			</th:block>
		</th:block>
	</table>
	</div>
	</body>
  </th:block>
</html>

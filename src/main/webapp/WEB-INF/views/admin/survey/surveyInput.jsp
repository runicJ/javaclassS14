<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
    <meta name="_csrf" th:content="${_csrf.token}">
    <meta name="_csrf_header" th:content="${_csrf.headerName}">
	<title>설문 만들기</title>
	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
	<style>
		h2 {
			margin-top:5px;
			margin-bottom:30px;
		}
		table,th,td {
			border: 2px solid #d4d2d2;
			border-collapse: collapse;
			padding: 10px;
		}
		.form-table-title-continer .form-tbl-col{
			width:15%;
		}
		.form-table-title-continer td {
			width:40%;
		}
		.form-table-intro-container .form-tbl-col{
			width:15%;
		}
		#survTitle, #useYn{
			width:97%;
		}
		
		/*설문 기본정보 테이블 caption*/
		.surv-container body{
			font-size:small;
		}
		.form-tbl-caption {
			caption-side: top;
		}
		.form-tbl-caption span{
		    font-weight:bold;
		}
		.form-tbl-caption button {
			width:7%;
			float:right;
			border-width: 1px;
			margin:0;
			font-size: small;
		}
		/*설문 기본정보 테이블*/
		.form-tbl {
			margin-top: 20px;
			width:100%;
			padding: 20px;
		    border-collapse: collapse;
		}
		/*설문 기본정보 테이블 td*/
		.form-tbl td {
		    padding: 2px;
		    cellpadding:7px;
		}
		/*설문 기본정보 테이블 컬럼*/
		.form-tbl-col {
		    text-align: center;
		    background-color: #EEEEEE;
		    font-weight:bold;
		   
		}
		.form-tbl textarea {
			overflow:auto;
			max-height:100px;
		}
		[class*='item'] td:nth-child(1) {
			text-align:center;
			width:5%;
		}
		[class*='item'] td:nth-child(2) {
			width:15%;
		}
		[class*='item'] td:nth-child(3) {
			width:25%;
		}
		[class*='item'] td:nth-child(4) {
			width:50%;
		}
		[class*='item'] select{
			box-sizing:content-box;
			width:97%;
		}
		[class*='item'] #qustCont{
			box-sizing:content-box;
			width:97%;
			margin-bottom:3%;
		}
		/*질문내용 td 안 내용*/
		.surv_opt_box {
			vertical-align: middle;
			padding: 5px;
			width: 200;
		}
		/*질문번호 컬럼*/
		.questNo {
			text-align:center;
		}
		[name=multi-opt] {
			width:85%;
		}
		[name=opt_delete] {
			padding-left:6%;
		
		}
		
		#addQuestRow, #regSurvBtn, #uptSurvBtn, #delSurvBtn{
		 	height:7%;
		 	width:10%;
		 	border: 2px solid #d4d2d2;
			border-collapse: collapse;
			font-size: small;
			font-weight: bold;
			margin-right:5px;
		}
		.surv-container button:hover {
			background-color:black;
			color:white;
		}
		#delQuestRow {
		  -webkit-appearance: none;
		  -moz-appearance: none;
		  appearance: none;
		  background-color: transparent; 
		  border: none;
		  font-size:large;
		  
		}
		/*설문 소개보 테이블의 div
		.form-table-intro-container{
		
		}*/
		
		.qustCont {
			font-weight: bold;
		}
	</style>
	<script>
		$(function () {
			
			var header = $("meta[name='_csrf_header']").attr('content');
			var token = $("meta[name='_csrf']").attr('content');
			
			
			$(".surv_opt_box").each(function(index,item) {
				let qustType = $(item).find("ol").attr("id");
				
				let optNum = $(item).find("li").length;
				
				if(qustType!=undefined && (qustType.startsWith("select") || qustType.startsWith("check")) && optNum > 1) {
					$(item).find($("span[name=opt_delete]")).css("display","");
				} else if (qustType!=undefined && qustType.startsWith("radio") && optNum > 2){
					$(item).find($("span[name=opt_delete]")).css("display","");
				}
			})
			
			$("#regDate").text(getToday());

		  $("#addQuestRow").click(function() {
		    //var lastItemNo = $("#surv_quests_tbl tr:last").attr("class").replace("item","");
		    //var newItemNo = parseInt(lastItemNo)+1;
		    let newItemNo = ($('#surv_quests_tbl>tbody tr').length) + 1;

		    let defaultHtml = '<tr class="item'+newItemNo+'">';
		    defaultHtml += '      <td style="text-align:center;">';
		    defaultHtml += '          <button id="delQuestRow" onclick="delQuest(this);">🗑️</button>';
		    defaultHtml += '      </td>';
		    defaultHtml += '      <td class="questNo">질문'
		    defaultHtml +=		  newItemNo
		    defaultHtml += '      </td>';
		    defaultHtml += '      <td>';
		    defaultHtml += '          <select name="qustType" id="qustType" onchange="showQuest(this)">';
		    defaultHtml += '              <option value="short">단답형</option>';
		    defaultHtml += '              <option value="long">장문형</option>';
		    defaultHtml += '              <option value="select">드롭다운형</option>';
		    defaultHtml += '              <option value="radio">라디오버튼형</option>';
		    defaultHtml += '              <option value="check">체크박스형</option>';
		    defaultHtml += '          </select>';
		    defaultHtml += '      </td>';
		    defaultHtml += '      <td>';
		    defaultHtml += '          <div class="surv_opt_box">';
		    defaultHtml += '              <input id="qustCont" placeholder="질문을 입력해주세요">';
		    defaultHtml += '          </div>';
		    defaultHtml += '      </td>';
		    defaultHtml += '  </tr>';


		    $("#surv_quests_tbl").append(defaultHtml);
		    
		    });
		    
		    let isSubmitted=false; //ajax 전송 상태
		    let changed = false; //내용 변화 상태
		    let oldParam;
		    
		    $(document).on("propertychange change keyup paste input","input, textarea", function(){
				changed=true;
				isSubmitted=false;
				$("#regSurvBtn").removeAttr('disabled');
				console.log("changed => "+changed);
			});
			
			$("#useYn").on("change",function() {
				changed=true;
				isSubmitted=false;
				$("#regSurvBtn").removeAttr('disabled');
			});
			
			if ($("#useYn").val()=='N') {
				$("#uptSurvBtn").attr('disabled','disabled');
				alert('수정할 수 없는 설문입니다!');
			}

		    $("#regSurvBtn").click(function() {
				
				let chkValidate = chkFields()==true? true:false;
			
				if(chkValidate) {
					if (!isSubmitted && changed) {
						isSubmitted = true;
						console.log("isSubmitted => "+isSubmitted);                  
						$("#regSurvBtn").attr('disabled','disabled');
						
						let survqustList=[]; //질문1개 1개 모아놓은 거
						
						$("#surv_quests_tbl>tbody tr").each(function() {
							let survQustObj = new Object (); //질문1개
							let qustOptArr = [];
							
							let qustType = $(this).find("td:eq(2) select option:selected").val();
							survQustObj.qustSeq = $(this).find("td:eq(1)").text().substr(2);
							survQustObj.qustType = qustType;
							
							if(qustType=='short') {				
							survQustObj.qustCont = $(this).find("td:eq(3) input").val().trim();
							} else if(qustType=="long") {
							survQustObj.qustCont = $(this).find("td:eq(3) textarea").val().trim();
							} else {
								survQustObj.qustCont = $(this).find("td:eq(3) input").val().trim();
								
								$(this).find('ol[name="multi-opt"] li').each(function(index, item) {
									let optObj = new Object(); //옵션 1개의 객체
									
									optObj.optSeq = index+1;
									optObj.optCont = $(item).find("input").val();
									qustOptArr.push(optObj);
								});
								survQustObj.qustoptList = qustOptArr;
							}
							survqustList.push(survQustObj);
							
						});
						
						let param = {
								"survTitle" : $("#survTitle").val(),
								"regDate" : $("#regDate").text(),
								"useYn" : $("#useYn").val(),		
								"survDesc" : $("#survDesc").val(),
								"survqustList" : survqustList,
							};
							
						console.log("param ==> " + JSON.stringify(param));
						
						let chkChangedRslt = chkChanged(oldParam)==true?true:false;
						
						if(chkChangedRslt) {
						
						    $.ajax({
								url:'/admin/survey/surveyInputOk',
								type: 'POST',
								contentType : "application/json; charset=utf-8",
								data: JSON.stringify(param),
								beforeSend: function(xhr){
						        xhr.setRequestHeader(header, token);
						    },	
								success: function() {
									alert('등록 완료');
									oldParam = param;
									
									if(confirm("My Survey에서 확인할까요?")) {
		  					 			location.href = "myList?";
									}
								},
								error: function(e) {
									alert("등록 실패!!");
									console.log("isSubmitted => "+isSubmitted);
									console.log(e);
								},
								complete: function() {
									isSubmitted = false;
								}
							});
						} else {
							alert("이미 등록된 설문입니다.");
						}
					}
				} else {
					alert("값을 입력해주세요!!");
				}
		  });
		  
		  $("#uptSurvBtn").click(function() {
			if(confirm("정말 수정하시겠습니까?")) {
				
				let chkValidate = chkFields()==true? true:false;
			
				if(chkValidate) {
					let survNo = new URL(location.href).searchParams.get('survNo');
					let survqustList=[]; //질문1개 1개 모아놓은 거
					
					$("#surv_quests_tbl>tbody tr").each(function() {
						let survQustObj = new Object (); //질문1개
						let qustOptArr = [];
						
						let qustType = $(this).find("td:eq(2) select option:selected").val();
						survQustObj.qustSeq = $(this).find("td:eq(1)").text().substr(2);
						survQustObj.qustType = qustType;
						
						if(qustType=='short') {				
						survQustObj.qustCont = $(this).find("td:eq(3) input").val().trim();
						} else if(qustType=="long") {
						survQustObj.qustCont = $(this).find("td:eq(3) textarea").val().trim();
						} else {
							survQustObj.qustCont = $(this).find("td:eq(3) input").val().trim();
							
							$(this).find('ol[name="multi-opt"] li').each(function(index, item) {
								let optObj = new Object(); //옵션 1개의 객체
								
								optObj.optSeq = index+1;
								optObj.optCont = $(item).find("input").val();
								qustOptArr.push(optObj);
							});
							survQustObj.qustoptList = qustOptArr;
						}
						survqustList.push(survQustObj);
						
					});
					
					 var param = {
							"survNo" : survNo,
							"survTitle" : $("#survTitle").val().trim(),
							"regDate" : $("#regDate").text(),
							"useYn" : $("#useYn").val(),		
							"survDesc" : $("#survDesc").val().trim(),
							"survqustList" : survqustList,
						};
						
					console.log("param ==> " + JSON.stringify(param));
					
				    $.ajax({
						url:'/admin/survey/updateSurv',
						type: 'POST',
						contentType : "application/json; charset=utf-8",
						data: JSON.stringify(param),
						beforeSend: function(xhr){
				        xhr.setRequestHeader(header, token);
				    },
						success: function() {
							alert('수정 완료!!');
							let query = window.location.search;
		  					 let param = new URLSearchParams(query);

		 					 param.delete("survNo");
		  					 location.href = "myList?" + param;
						},
						error: function(e) {
							alert("수정 실패!!");
							console.log(e);
						}
					});
				} else {
					alert("값을 입력해주세요!!");
				}
				
			} else {
				return false;
			}
		});
		  
		  
		  $("#delSurvBtn").click(function() {
				if(confirm("정말 삭제하시겠습니까?")) {
					
					let survNo = new URL(location.href).searchParams.get('survNo');
					let currentPage = new URL(location.href).searchParams.get('currentPage');
					console.log("삭제할 survNo : "+survNo, "  currentPage : "+currentPage);
							
					$.ajax({
						url:'/admin/survey/delSurv',
						type: 'POST',
						data: {
							"survNo" : survNo
						},
						beforeSend: function(xhr){
				        xhr.setRequestHeader(header, token);
				        },
				        success: function() {
							alert('삭제 완료');
							 let query = window.location.search;
		  					 let param = new URLSearchParams(query);

		 					 param.delete("survNo");
		  					 location.href = "myList?" + param;
						},
						error: function(e) {
							alert("삭제 실패!!");
							console.log(e);
						}
					});
				} else {
					return false;
				}
		  });
		    
		});

		function delQuest(data) {
			let rownum = $('#surv_quests_tbl>tbody tr').length;
			var idx = $(data).parent().parent().index();

			if (rownum < 2) {
				alert("질문의 개소는 최소 1개 이상입니다.");
				return;
			} 
			$(data).parent().parent().remove();
			rownum = $('#surv_quests_tbl>tbody tr').length; //마지막번호

			for(var i=idx; i<rownum; i++) {
				$("#surv_quests_tbl>tbody").find("tr:eq("+i+")").find(".questNo").text("질문"+(i+1));
				$("#surv_quests_tbl>tbody").find("tr:eq("+i+")").attr("class","item"+(i+1));
			}
		}

		function showQuest(type) {
		  let qustType = type.value;
		  let rownum = $(type).closest('tr').prevAll().length;

		  $('.surv_opt_box').eq(rownum).empty();

		  if (qustType=='short') {
		    $('.surv_opt_box').eq(rownum).append(
		            '<input id="qustCont" type="text"  placeholder="질문을 입력해주세요">'
		     );
		  } else if (qustType=='long') {
		    $('.surv_opt_box').eq(rownum).append(
		            '<textarea id="qustCont" type="text"  placeholder="질문을 입력해주세요"></textarea>'
		     );
		  } else if (qustType=='select') {
		    $('.surv_opt_box').eq(rownum).append(
					 '<input id="qustCont" type="text"  placeholder="질문을 입력해주세요">'
		           + '<ol id="select-multi-opt" name="multi-opt" style="list-style-type:decimal" start="1">'
		           + '	<li id="opt1">'
		           + '		<input name="multi-opt" placeholder="옵션" ></input>'
		           + '		<span name="opt_delete" style="display:none;" onclick="deleteOpt(\'select\',this);">❌<br></span>'
		           + '	</li>'
		           + '</ol>'
		           + '<span name="addOptionBtn" style="text-decoration:underline;" onclick="addOption(\'select\',this);">옵션추가</span>'
		     );
		  } else if (qustType=='radio') {
			$('.surv_opt_box').eq(rownum).append(
					 '<input id="qustCont" type="text"  placeholder="질문을 입력해주세요">'
		           + '<ol id="radio-multi-opt" name="multi-opt" style="list-style-type:decimal" start="1">'
		           + '	<li id="opt1">'
		           + '		<input name="multi-opt" placeholder="옵션" ></input>'
		           + '		<span name="opt_delete" style="display:none;" onclick="deleteOpt(\'radio\',this);">❌<br></span>'
		           + '	</li>'
		           + '</ol>'
		           + '<span name="addOptionBtn" style="text-decoration:underline;" onclick="addOption(\'radio\',this);">옵션추가</span>'
		     );
			} else if (qustType=='check') {
			$('.surv_opt_box').eq(rownum).append(
					 '<input id="qustCont" type="text"  placeholder="질문을 입력해주세요">'
		           + '<ol id="check-multi-opt" name="multi-opt" style="list-style-type:decimal" start="1">'
		           + '	<li id="opt1">'
		           + '		<input name="multi-opt" placeholder="옵션" ></input>'
		           + '		<span name="opt_delete" style="display:none;" onclick="deleteOpt(\'check\',this);">❌<br></span>'
		           + '	</li>'
		           + '</ol>'
		           + '<span name="addOptionBtn" style="text-decoration:underline;" onclick="addOption(\'check\',this);">옵션추가</span>'
		     );	
			}
		}

		function addOption(optType, data) {
			var idx = $(data).parent().parent().parent().index();
			let optCnt;
			
		  if (optType=='select') {
		   $("#surv_quests_tbl>tbody").find("tr:eq("+idx+")").find("#select-multi-opt").append(
		              '<li>'
		            + '<input type="text"  name="multi-opt" placeholder="옵션" ></input>'
		            + '<span name="opt_delete" style="display:none;" onclick="deleteOpt(\'select\',this);">❌<br></span>'
		            + '</li>'
		     );
		  } else if (optType=='radio') {
			$("#surv_quests_tbl>tbody").find("tr:eq("+idx+")").find("#radio-multi-opt").append(
		              '<li>'
		            + '<input type="text"  name="multi-opt" placeholder="옵션" ></input>'
		            + '<span name="opt_delete" style="display:none;" onclick="deleteOpt(\'radio\',this);">❌<br></span>'
		            + '</li>'
		     );
			} else if (optType=='check') {
				
			$("#surv_quests_tbl>tbody").find("tr:eq("+idx+")").find("#check-multi-opt").append(
		              '<li>'
		            + '<input type="text"  name="multi-opt" placeholder="옵션" ></input>'
		            + '<span name="opt_delete" style="display:none;" onclick="deleteOpt(\'check\',this);">❌<br></span>'
		            + '</li>'
		     );	
		     
			}
			
			optCnt = $(data).siblings('ol').find("li").length;

		     if (((optType=='select' || optType=='check') && optCnt>1) || (optType=='radio' && optCnt>2)) {
				$("#surv_quests_tbl>tbody").find("tr:eq("+idx+")").find($("span[name=opt_delete]")).css("display","");
				}

		}

		function deleteOpt(optType, data) {
		 changed=true;
		 isSubmitted=false;
		 $("#regSurvBtn").removeAttr('disabled');
		  var idx = $(data).closest('tr').index();
		  let optCnt = $(data).closest('ol').find("li").length;

		  if (optType=='select' || optType=='check') {
			
		    if(optCnt > 1) {
				$(data).parent().remove();
		    } 
			
		  } else if (optType=='radio') {
			 if(optCnt > 2) {
		      $(data).parent().remove();
		    } 	
		  }
		  showDelBtn(optType, idx);
		  
		}

		function showDelBtn(optType, idx) {
			let optCnt = $("#surv_quests_tbl>tbody").find("tr:eq("+idx+")").find("li").length;
			
			if (((optType=='select' || optType=='check') && optCnt==1) || (optType=='radio' && optCnt<=2)) {
				$("#surv_quests_tbl>tbody").find("tr:eq("+idx+")").find($("span[name=opt_delete]")).css("display","none");
			}

		}

		function getToday() {
			var date = new Date();
			var year = date.getFullYear();
			 var month = ("0" + (1 + date.getMonth())).slice(-2);
		    var day = ("0" + date.getDate()).slice(-2);

		    return year + "-" + month + "-" + day;
		}

		function chkFields() {
			let result = true;
			$('input[type=text]').each(function(index,item) {
					let txt = $(item).val().trim();
					
					if (""==txt || null==txt) {
						console.log("index: "+index+"  item: "+item);
						result=false;
						return false;
					} 				
					
			});
			$('textarea').each(function(index,item) {
				let txt = $(item).val().trim();
					
					if (""==txt || null==txt) {
						result=false;
						return false;
					}
			});
			if (result) {
				return true;
			} else {
				return false;
			}
		}

		function chkChanged(oldParam) {
			let newParam;
			let survqustList=[]; //질문1개 1개 모아놓은 거
						
						$("#surv_quests_tbl>tbody tr").each(function() {
							let survQustObj = new Object (); //질문1개
							let qustOptArr = [];
							
							let qustType = $(this).find("td:eq(2) select option:selected").val();
							survQustObj.qustSeq = $(this).find("td:eq(1)").text().substr(2);
							survQustObj.qustType = qustType;
							
							if(qustType=='short') {				
							survQustObj.qustCont = $(this).find("td:eq(3) input").val().trim();
							} else if(qustType=="long") {
							survQustObj.qustCont = $(this).find("td:eq(3) textarea").val().trim();
							} else {
								survQustObj.qustCont = $(this).find("td:eq(3) input").val().trim();
								
								$(this).find('ol[name="multi-opt"] li').each(function(index, item) {
									let optObj = new Object(); //옵션 1개의 객체
									
									optObj.optSeq = index+1;
									optObj.optCont = $(item).find("input").val();
									qustOptArr.push(optObj);
								});
								survQustObj.qustoptList = qustOptArr;
							}
							survqustList.push(survQustObj);
							
						});
						
						  newParam = {
								"survTitle" : $("#survTitle").val().trim(),
								"regDate" : $("#regDate").text(),
								"useYn" : $("#useYn").val(),		
								"survDesc" : $("#survDesc").val().trim(),
								"survqustList" : survqustList,
							};
							
			console.log("oldParam => "+JSON.stringify(oldParam));
			console.log("newParam => "+JSON.stringify(newParam));
			if (JSON.stringify(oldParam) === JSON.stringify(newParam)) {
				console.log("oldParam === newParam");
				return false;
			} else {
				console.log("oldParam != newParam");
				return true;
			}
		}

	</script>
</head>
<body>
	<div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
        <jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
		<jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
        <div class="page-wrapper">
	  <h2>✏️ 설문 만들기</h2>
	  <div class="surv-container">
	    <!-- 설문 기본정보 START -->
		<div class="form-table-title-continer">
		   <table class="form-tbl">
		   <caption class="form-tbl-caption">
		   	  <span>설문 기본정보</span>
		   	  <button id="regSurvBtn">등록</button>
		   </caption>
		   <input type="hidden"  name="${_csrf.parameterName }" value="${_csrf.token }"/>
		       <tr>
		           <td class="form-tbl-col">제목</td>
		           <td><input id="survTitle" type="text" placeholder="제목을 입력해주세요(최대30자)"/></td>
		           <td class="form-tbl-col">등록자</td>
		           <td th:text="${nickName}"></td>
		       </tr>
		       <tr>
	               <td class="form-tbl-col">등록일자</td>
	               <td><span id="regDate"></span></td>
	               <td class="form-tbl-col">사용여부</td>
	               <td>
						<select id="useYn">
							<option value="Y">예</option>
							<option value="N">아니오</option>
						</select>
				   </td>
	           </tr>
		   </table>
		</div>
		<!-- 설문 기본정보 END -->
		

		<!-- 설문지 소개 START -->
		<div class="form-table-intro-container">
		<table id="quest-table" class="form-tbl">
		   <caption class="form-tbl-caption"><span>설문지 소개</span></caption>
		   <tr>
		       <td class="form-tbl-col">소개</td>
		       <td><textarea id="survDesc" style="width:100%;"></textarea></td>
		   </tr>
		</table>
		</div>
		<!-- 설문지 소개 END -->
		<!-- 설문지 질문 START -->
		<div>
		<table id="surv_quests_tbl" class="form-tbl">
	       <caption class="form-tbl-caption">
	       		<span>설문지 질문</span>
	       		<button id="addQuestRow">추가</button>
	       </caption>
	       
	       <thead>
	            <th class="form-tbl-col"></th>
	            <th class="form-tbl-col">질문번호</th>
	            <th class="form-tbl-col">질문유형</th>
	            <th class="form-tbl-col">질문내용</th>
	       </thead>
	       <tbody>
	         <tr class="item1">
	            <td style="text-align:center;">
	                <button id="delQuestRow" onclick="delQuest(this);">🗑️</button>
	            </td>
	            <td id="qustNo" class="questNo">질문1</td>
	            <td> 
	                <select name="qustType" id="qustType" onchange="showQuest(this)">
	                    <option value="short">단답형</option>
	                    <option value="long">장문형</option>
	                    <option value="select">드롭다운형</option>
	                    <option value="radio">라디오버튼형</option>
	                    <option value="check">체크박스형</option>
	                </select>
	            </td>
	            <td>
	                <div class="surv_opt_box">
	                    <input id="qustCont" type="text" placeholder="질문을 입력해주세요">
	                </div>
	            </td>
	         </tr>
	       </tbody>
	    </table>
	    </div>
		</div>
		<!-- 설문지 질문 END -->
	  </div>
	</div>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>

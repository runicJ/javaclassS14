<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>surveyInput</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
	<style>
		h2 {
			margin-top:5px;
			margin-bottom:30px;
		}
		table, th, td {
			border: 2px solid #c1b6a3;
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
		#survTitle, #useFlag{
			width:97%;
		}
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
		.form-tbl {
			margin-top: 20px;
			width:100%;
			padding: 20px;
		    border-collapse: collapse;
		}
		.form-tbl td {
		    padding: 2px;
		    cellpadding:7px;
		}
		.form-tbl-col {
		    text-align: center;
		    background-color: #efe7da;
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
		[class*='item'] #questContent{
			box-sizing:content-box;
			width:97%;
			margin-bottom:3%;
		}
		.surv_opt_box {
			vertical-align: middle;
			padding: 5px;
			width: 200;
		}
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
		.questContent {
			font-weight: bold;
		}
	</style>
	<script>
	$(function () {
		$(".surv_opt_box").each(function(index, item) {
			let questType = $(item).find("ol").attr("id");
			let optNum = $(item).find("li").length;
			if (questType != undefined && (questType.startsWith("select") || questType.startsWith("check")) && optNum > 1) {
				$(item).find($("span[name=opt_delete]")).css("display", "");
			} else if (questType != undefined && questType.startsWith("radio") && optNum > 2) {
				$(item).find($("span[name=opt_delete]")).css("display", "");
			}
		});

		$("#regDate").text(getToday());

		$("#addQuestRow").click(function() {
			let newItemNo = ($('#surv_quests_tbl>tbody tr').length) + 1;

			let str = '<tr class="item' + newItemNo + '">';
			str += '      <td style="text-align:center;">';
			str += '          <button id="delQuestRow" onclick="delQuest(this);"><i class="fa-solid fa-trash-can"></i></button>';
			str += '      </td>';
			str += '      <td class="questNo">질문' + newItemNo + '</td>';
			str += '      <td>';
			str += '          <select name="questType" id="questType" onchange="showQuest(this)">';
			str += '              <option value="short">단답형</option>';
			str += '              <option value="long">장문형</option>';
			str += '              <option value="select">드롭다운형</option>';
			str += '              <option value="radio">라디오버튼형</option>';
			str += '              <option value="check">체크박스형</option>';
			str += '          </select>';
			str += '      </td>';
			str += '      <td>';
			str += '          <div class="surv_opt_box">';
			str += '              <input id="questContent" placeholder="질문을 입력해주세요">';
			str += '          </div>';
			str += '      </td>';
			str += '  </tr>';
			$("#surv_quests_tbl").append(str);
		});
		
		let isSubmitted = false; //ajax 전송 상태
		let changed = false; //내용 변화 상태
		let oldParam;
		
		$(document).on("propertychange change keyup paste input", "input, textarea", function() {
			changed = true;
			isSubmitted = false;
			$("#regSurvBtn").removeAttr('disabled');
			console.log("changed => " + changed);
		});
		
		$("#useFlag").on("change", function() {
			changed = true;
			isSubmitted = false;
			$("#regSurvBtn").removeAttr('disabled');
		});
		
		if ($("#useFlag").val() == 'n') {
			$("#uptSurvBtn").attr('disabled', 'disabled');
			alert('수정할 수 없는 설문입니다!');
		}

		$("#regSurvBtn").click(function() {
			let chkValidate = chkFields() == true ? true : false;
			if (chkValidate) {
				if (!isSubmitted && changed) {
					isSubmitted = true;
					console.log("isSubmitted => " + isSubmitted);                  
					$("#regSurvBtn").attr('disabled', 'disabled');
					
					let survQustList = [];
					
					$("#surv_quests_tbl>tbody tr").each(function(index) { // 각 질문의 순서에 맞게 index 사용
						let survQustObj = new Object(); //질문1개
						let qustOptArr = [];
						
						let questType = $(this).find("td:eq(2) select option:selected").val();
						survQustObj.questIdx = $(this).find("td:eq(1)").text().substr(2);
						survQustObj.questOrder = index + 1; // 질문 순서 저장
						survQustObj.questType = questType;
						survQustObj.surveyIdx = $("#surveyIdx").val();
						
						if (questType == 'short') {                
							survQustObj.questContent = $(this).find("td:eq(3) input").val().trim();
						} else if (questType == "long") {
							survQustObj.questContent = $(this).find("td:eq(3) textarea").val().trim();
						} else {
							survQustObj.questContent = $(this).find("td:eq(3) input").val().trim();
							$(this).find('ol[name="multi-opt"] li').each(function(optIndex, item) {
								let optObj = new Object(); //옵션 1개의 객체
								optObj.optionIdx = optIndex + 1;
								optObj.optContent = $(item).find("input").val();
								optObj.optOrder = optIndex + 1; // 옵션 순서 저장
								qustOptArr.push(optObj);
							});
							survQustObj.options = qustOptArr; // 옵션 리스트 저장
						}
						survQustList.push(survQustObj);
					});
					
					let query = {
						surveyTitle: $("#survTitle").val(),
						surveyDesc: $("#survDesc").val(),
						useFlag: $("#useFlag").val(),        
						createDate: $("#regDate").text(),
						questList: survQustList
					}
					
					$.ajax({
						url: '${ctp}/admin/survey/surveyInput',
						type: 'POST',
						contentType: "application/json; charset=utf-8",
						data: JSON.stringify(query),
						success: function(res) {
							if(res != 0) {
								alert('등록 완료');
								oldParam = query;
								if (confirm("설문목록에서 확인할까요?")) {
									location.href = "${ctp}/admin/survey/surveyList";
								}
							}
							else alert("등록 실패!")
						},
						error: function(e) {
							alert("전송 오류!");
							console.log(e);
						},
						complete: function() {
							isSubmitted = false;
						}
					});
				} 
				else {
					alert("이미 등록된 설문입니다.");
				}
			} 
			else {
				alert("빈칸을 입력해주세요!!");
			}
		});
		  
		  $("#uptSurvBtn").click(function() {
			if (confirm("정말 수정하시겠습니까?")) {
				let chkValidate = chkFields() == true ? true : false;
				if (chkValidate) {
					let survNo = new URL(location.href).searchParams.get('survNo');
					let survQustList = [];
					
					$("#surv_quests_tbl>tbody tr").each(function() {
						let survQustObj = new Object(); //질문1개
						let qustOptArr = [];
						
						let questType = $(this).find("td:eq(2) select option:selected").val();
						survQustObj.qustSeq = $(this).find("td:eq(1)").text().substr(2);
						survQustObj.questType = questType;
						
						if (questType == 'short') {				
							survQustObj.questContent = $(this).find("td:eq(3) input").val().trim();
						} else if (questType == "long") {
							survQustObj.questContent = $(this).find("td:eq(3) textarea").val().trim();
						} else {
							survQustObj.questContent = $(this).find("td:eq(3) input").val().trim();
							$(this).find('ol[name="multi-opt"] li').each(function(index, item) {
								let optObj = new Object(); //옵션 1개의 객체
								optObj.optionIdx = index + 1;
								optObj.optContent = $(item).find("input").val();
								qustOptArr.push(optObj);
							});
							survQustObj.qustoptList = qustOptArr;
						}
						survQustList.push(survQustObj);
					});
					
					var param = {
						"survNo": survNo,
						"survTitle": $("#survTitle").val().trim(),
						"regDate": $("#regDate").text(),
						"useFlag": $("#useFlag").val(),		
						"survDesc": $("#survDesc").val().trim(),
						"questList": survQustList,
					};
						
					//console.log("param ==> " + JSON.stringify(param));
					
					$.ajax({
						url: '${ctp}/admin/survey/updateSurv',
						type: 'POST',
						contentType: "application/json; charset=utf-8",
						data: JSON.stringify(param),
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
			if (confirm("정말 삭제하시겠습니까?")) {
				let survNo = new URL(location.href).searchParams.get('survNo');
				let currentPage = new URL(location.href).searchParams.get('currentPage');
				console.log("삭제할 survNo : " + survNo + "  currentPage : " + currentPage);
							
				$.ajax({
					url: '${ctp}/admin/survey/delSurv',
					type: 'POST',
					data: {
						"survNo": survNo
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
			alert("질문의 갯수는 최소 1개 이상입니다.");
			return;
		} 
		$(data).parent().parent().remove();
		rownum = $('#surv_quests_tbl>tbody tr').length; //마지막번호

		for(var i = idx; i < rownum; i++) {
			$("#surv_quests_tbl>tbody").find("tr:eq(" + i + ")").find(".questNo").text("질문" + (i + 1));
			$("#surv_quests_tbl>tbody").find("tr:eq(" + i + ")").attr("class", "item" + (i + 1));
		}
	}

	function showQuest(type) {
		let questType = type.value;
		let rownum = $(type).closest('tr').prevAll().length;

		$('.surv_opt_box').eq(rownum).empty();

		if (questType == 'short') {
			$('.surv_opt_box').eq(rownum).append('<input id="questContent" type="text" placeholder="질문을 입력해주세요">');
		} else if (questType == 'long') {
			$('.surv_opt_box').eq(rownum).append('<textarea id="questContent" type="text" placeholder="질문을 입력해주세요"></textarea>');
		} else if (questType == 'select') {
			$('.surv_opt_box').eq(rownum).append(
				'<input id="questContent" type="text" placeholder="질문을 입력해주세요">'
		        + '<ol id="select-multi-opt" name="multi-opt" style="list-style-type:decimal" start="1">'
		        + '	<li id="opt1">'
		        + '		<input name="multi-opt" placeholder="옵션" ></input>'
		        + '		<span name="opt_delete" style="display:none;" onclick="deleteOpt(\'select\',this);"><i class="fa-solid fa-xmark"></i><br></span>'
		        + '	</li>'
		        + '</ol>'
		        + '<span name="addOptionBtn" style="text-decoration:underline;" onclick="addOption(\'select\',this);">옵션추가</span>'
		    );
		} else if (questType == 'radio') {
			$('.surv_opt_box').eq(rownum).append(
				'<input id="questContent" type="text" placeholder="질문을 입력해주세요">'
		        + '<ol id="radio-multi-opt" name="multi-opt" style="list-style-type:decimal" start="1">'
		        + '	<li id="opt1">'
		        + '		<input name="multi-opt" placeholder="옵션" ></input>'
		        + '		<span name="opt_delete" style="display:none;" onclick="deleteOpt(\'radio\',this);"><i class="fa-solid fa-xmark"></i><br></span>'
		        + '	</li>'
		        + '</ol>'
		        + '<span name="addOptionBtn" style="text-decoration:underline;" onclick="addOption(\'radio\',this);">옵션추가</span>'
		    );
		} else if (questType == 'check') {
			$('.surv_opt_box').eq(rownum).append(
				'<input id="questContent" type="text" placeholder="질문을 입력해주세요">'
		        + '<ol id="check-multi-opt" name="multi-opt" style="list-style-type:decimal" start="1">'
		        + '	<li id="opt1">'
		        + '		<input name="multi-opt" placeholder="옵션" ></input>'
		        + '		<span name="opt_delete" style="display:none;" onclick="deleteOpt(\'check\',this);"><i class="fa-solid fa-xmark"></i><br></span>'
		        + '	</li>'
		        + '</ol>'
		        + '<span name="addOptionBtn" style="text-decoration:underline;" onclick="addOption(\'check\',this);">옵션추가</span>'
		    );	
		}
	}

	function addOption(optType, data) {
		var idx = $(data).parent().parent().parent().index();
		let optCnt;
		
		if (optType == 'select') {
			$("#surv_quests_tbl>tbody").find("tr:eq(" + idx + ")").find("#select-multi-opt").append(
				'<li>'
				+ '<input type="text"  name="multi-opt" placeholder="옵션" ></input>'
				+ '<span name="opt_delete" style="display:none;" onclick="deleteOpt(\'select\',this);"><i class="fa-solid fa-xmark"></i><br></span>'
				+ '</li>'
		    );
		} else if (optType == 'radio') {
			$("#surv_quests_tbl>tbody").find("tr:eq(" + idx + ")").find("#radio-multi-opt").append(
				'<li>'
				+ '<input type="text"  name="multi-opt" placeholder="옵션" ></input>'
				+ '<span name="opt_delete" style="display:none;" onclick="deleteOpt(\'radio\',this);"><i class="fa-solid fa-xmark"></i><br></span>'
				+ '</li>'
		    );
		} else if (optType == 'check') {
			$("#surv_quests_tbl>tbody").find("tr:eq(" + idx + ")").find("#check-multi-opt").append(
				'<li>'
				+ '<input type="text"  name="multi-opt" placeholder="옵션" ></input>'
				+ '<span name="opt_delete" style="display:none;" onclick="deleteOpt(\'check\',this);"><i class="fa-solid fa-xmark"></i><br></span>'
				+ '</li>'
		    );	
		}
		
		optCnt = $(data).siblings('ol').find("li").length;

		if (((optType == 'select' || optType == 'check') && optCnt > 1) || (optType == 'radio' && optCnt > 2)) {
			$("#surv_quests_tbl>tbody").find("tr:eq(" + idx + ")").find($("span[name=opt_delete]")).css("display", "");
		}
	}

	function deleteOpt(optType, data) {
		changed = true;
		isSubmitted = false;
		$("#regSurvBtn").removeAttr('disabled');
		var idx = $(data).closest('tr').index();
		let optCnt = $(data).closest('ol').find("li").length;

		if (optType == 'select' || optType == 'check') {
			if (optCnt > 1) {
				$(data).parent().remove();
			} 
		} else if (optType == 'radio') {
			if (optCnt > 2) {
				$(data).parent().remove();
			} 	
		}
		showDelBtn(optType, idx);
	}

	function showDelBtn(optType, idx) {
		let optCnt = $("#surv_quests_tbl>tbody").find("tr:eq(" + idx + ")").find("li").length;
		if (((optType == 'select' || optType == 'check') && optCnt == 1) || (optType == 'radio' && optCnt <= 2)) {
			$("#surv_quests_tbl>tbody").find("tr:eq(" + idx + ")").find($("span[name=opt_delete]")).css("display", "none");
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
		$('input[type=text]').each(function(index, item) {
			let txt = $(item).val().trim();
			if ("" == txt || null == txt) {
				console.log("index: " + index + "  item: " + item);
				result = false;
				return false;
			} 				
		});
		$('textarea').each(function(index, item) {
			let txt = $(item).val().trim();
			if ("" == txt || null == txt) {
				result = false;
				return false;
			}
		});
		return result;
	}

	function chkChanged(oldParam) {
		// oldParam이 undefined인 경우 빈 객체로 초기화
		if (typeof oldParam === 'undefined') {
			oldParam = {};
		}
		
		let newParam;
		let survQustList = [];
					
		$("#surv_quests_tbl>tbody tr").each(function() {
			let survQustObj = new Object(); //질문1개
			let qustOptArr = [];
			
			let questType = $(this).find("td:eq(2) select option:selected").val();
			survQustObj.qustSeq = $(this).find("td:eq(1)").text().substr(2);
			survQustObj.questType = questType;
			
			if (questType == 'short') {				
				survQustObj.questContent = $(this).find("td:eq(3) input").val().trim();
			} else if (questType == "long") {
				survQustObj.questContent = $(this).find("td:eq(3) textarea").val().trim();
			} else {
				survQustObj.questContent = $(this).find("td:eq(3) input").val().trim();
				$(this).find('ol[name="multi-opt"] li').each(function(index, item) {
					let optObj = new Object(); //옵션 1개의 객체
					optObj.optionIdx = index + 1;
					optObj.optContent = $(item).find("input").val();
					qustOptArr.push(optObj);
				});
				survQustObj.qustoptList = qustOptArr;
			}
			survQustList.push(survQustObj);
		});
		
		newParam = {
			"surveyTitle": $("#survTitle").val().trim(),
			"createDate": $("#regDate").text(),
			"useFlag": $("#useFlag").val(),		
			"surveyDesc": $("#survDesc").val().trim(),
			"questList": survQustList
		};
							
		//console.log("oldParam => " + JSON.stringify(oldParam));
		//console.log("newParam => " + JSON.stringify(newParam));
		return JSON.stringify(oldParam) !== JSON.stringify(newParam);
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
        <div class="card p-5">
			<h2><i class="fa-solid fa-pencil"></i> 설문 만들기</h2>
			<div class="surv-container">
				<!-- 설문 기본정보 START -->
				<div class="form-table-title-continer">
					<table class="form-tbl">
						<caption class="form-tbl-caption">
							<span>설문 기본정보</span>
							<button id="regSurvBtn">등록</button>
						</caption>
						<tr>
							<td class="form-tbl-col">제목</td>
							<td><input id="survTitle" type="text" placeholder="제목을 입력해주세요(최대30자)" /></td>
							<td class="form-tbl-col">등록자</td>
							<td>${sNickName}</td>
						</tr>
						<tr>
							<td class="form-tbl-col">등록일자</td>
							<td><span id="regDate"></span></td>
							<td class="form-tbl-col">사용여부</td>
							<td>
								<select id="useFlag">
									<option value="y">예</option>
									<option value="n">아니오</option>
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
							<tr>
								<th class="form-tbl-col">삭제</th>
								<th class="form-tbl-col">질문번호</th>
								<th class="form-tbl-col">질문유형</th>
								<th class="form-tbl-col">질문내용</th>
							</tr>
						</thead>
						<tbody>
							<tr class="item1">
								<td style="text-align:center;">
									<button id="delQuestRow" onclick="delQuest(this);"><i class="fa-solid fa-trash-can"></i></button>
								</td>
								<td id="qustNo" class="questNo">질문1</td>
								<td> 
									<select name="questType" id="questType" onchange="showQuest(this)">
										<option value="short">단답형</option>
										<option value="long">장문형</option>
										<option value="select">드롭다운형</option>
										<option value="radio">라디오버튼형</option>
										<option value="check">체크박스형</option>
									</select>
								</td>
								<td>
									<div class="surv_opt_box">
										<input id="questContent" type="text" placeholder="질문을 입력해주세요">
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- 설문지 질문 END -->
			</div>
		</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>surveyInput</title>
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
    <style>
        h2 {
            margin-top: 5px;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #c1b6a3;
            border-radius: 5px;
        }
		.question-container {
		    border: 2px solid #c1b6a3;
		    padding: 15px;
		    margin-bottom: 20px;
		    border-radius: 10px;
		    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
		    background-color: #fafafa;
		}
		.btn-action { background-color: #007bff; color: white; border: none; border-radius: 5px; padding: 8px 12px; font-size: 14px; cursor: pointer; }
        .btn-action:hover { background-color: #0056b3; }
    </style>
    <script>
	    $(document).ready(function () {
	        $(document).on("click", "#addQuestionBtn", addQuestion);
	        $(document).on("click", "#submitSurveyBtn", function (event) { event.preventDefault(); submitSurvey(); });
	        $(document).on("click", ".remove-question-btn", function () { removeQuestion(this); });
	        $(document).on("click", ".move-up-btn", function () { moveQuestionUp(this); });
	        $(document).on("click", ".move-down-btn", function () { moveQuestionDown(this); });
	        $(document).on("click", ".add-option-btn", function () { addOption(this); });
	        $(document).on("click", ".remove-option-btn", function () { removeOption(this); });
	    });
	
	    function addQuestion() {
	        let questionNumber = $(".question-container").length + 1;
	        let questionHtml = `
	        <div class="question-container">
	            <div class="form-group">
	                <span class="questionNo">질문 ${questionNumber}</span>
	                <button type="button" class="move-up-btn btn-action">⬆ 위로</button>
	                <button type="button" class="move-down-btn btn-action">⬇ 아래로</button>
	                <button type="button" class="remove-question-btn btn-action">❌ 삭제</button>
	            </div>
	            <div class="form-group">
	                <label for="questionType_${questionNumber}">질문 유형</label>
	                <select id="questionType_${questionNumber}" name="questionType" class="questionType" onchange="updateQuestionInput(this)">
	                    <option value="short">단답형</option>
	                    <option value="long">장문형</option>
	                    <option value="select">드롭다운형</option>
	                    <option value="radio">라디오버튼형</option>
	                    <option value="check">체크박스형</option>
	                </select>
	            </div>
	            <div class="form-group">
	                <label for="questionContent_${questionNumber}">질문 내용</label>
	                <input type="text" name="questionContent" placeholder="질문을 입력해주세요">
	                <div class="options-container"></div>
	            </div>
	        </div>`;
	
	        $("#questionnaire").append(questionHtml);
	    }
	
	    function updateQuestionInput(selectElement) {
	        let container = $(selectElement).closest(".question-container").find(".options-container");
	        container.empty();
	        let type = $(selectElement).val();

	        if (type === "select" || type === "radio" || type === "check") {
	            let optionHtml = `
	                <button type="button" class="add-option-btn">➕ 옵션 추가</button>
	                <ul class="options-list"></ul>
	            `;
	            container.append(optionHtml);
	        }
	    }
	
	    $(document).on("click", ".add-option-btn", function () {
	        let optionsList = $(this).siblings(".options-list");

	        let optionHtml = `
	            <li>
	                <input type="text" name="options[]" placeholder="옵션 입력">
	                <button type="button" class="remove-option-btn">❌</button>
	            </li>
	        `;
	        optionsList.append(optionHtml);
	    });

	    $(document).on("click", ".remove-option-btn", function () {
	        $(this).closest("li").remove();
	    });
	
	    function removeOption(button) { $(button).closest("li").remove(); }
	    function removeQuestion(element) { $(element).closest('.question-container').remove(); updateQuestionNumbers(); }
	    function moveQuestionUp(element) { let question = $(element).closest(".question-container"); question.prev().before(question); updateQuestionNumbers(); }
	    function moveQuestionDown(element) { let question = $(element).closest(".question-container"); question.next().after(question); updateQuestionNumbers(); }
	
	    function updateQuestionNumbers() {
	        $('.question-container').each(function (index) { $(this).find('.questionNo').text('질문 ' + (index + 1)); });
	    }
	
	    function submitSurvey() {
	        let formData = new FormData();
	        let surveyTitle = $("#surveyTitle").val().trim();
	        let surveyDesc = $("#surveyDescription").val().trim(); 
	        
	        let fileInput = $("#surveyImage")[0].files[0];
	
	        if (!surveyTitle) { alert("설문 제목을 입력하세요."); $("#surveyTitle").focus(); return; }
	        if (!fileInput) { 
	            alert("설문 대표 이미지를 등록하세요."); 
	            return; 
	        }

	        let allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;
	        if (!allowedExtensions.exec(fileInput.name)) {
	            alert("이미지 파일(PNG, JPG)만 업로드 가능합니다.");
	            $("#surveyImage").val("");  
	            return;
	        }
	        
	        formData.append("fName", fileInput);
	        formData.append("surveyData", JSON.stringify({
	            surveyTitle: surveyTitle,
	            surveyDesc: surveyDesc,
	            useFlag: "Y",  // 여기서 기본값 설정
	            questList: $(".question-container").map((i, q) => ({
	                questIdx: i + 1,
	                questType: $(q).find(".questionType").val(),
	                questContent: $(q).find("input[name='questionContent']").val().trim(),
	                options: $(q).find(".options-list li input").map((_, opt) => {
	                    let optContent = $(opt).val().trim();
	                    return optContent ? { optContent: optContent } : null;
	                }).get().filter(opt => opt !== null)
	            })).get()
	        }));
	        
	        $.ajax({
	            url: '${ctp}/admin/survey/surveyInput', 
	            type: 'POST', 
	            data: formData, 
	            processData: false, 
	            contentType: false, 
	            success: function () { 
	                alert("설문 등록 성공!"); 
	                location.href = '${ctp}/admin/survey/surveyList'; 
	            }, 
	            error: function () { 
	                alert("등록 실패!"); 
	            } 
	        });
	    }
    </script>
</head>
<body>
<div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
    <jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
    <jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
    <div class="page-wrapper">
        <div class="card p-5">
            <h2>설문 등록</h2>
            <form id="surveyForm" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="surveyTitle">설문 제목</label>
                    <input id="surveyTitle" name="title" type="text" placeholder="제목을 입력해주세요" required />
                </div>
                <div class="form-group">
                    <label for="surveyImage">설문 대표 이미지</label>
                    <input type="file" name="fName" id="surveyImage" required />
                </div>
                <div class="form-group">
                    <label for="surveyDescription">설문 설명</label>
                    <textarea id="surveyDescription" name="description"></textarea>
                </div>
                <div id="questionnaire"></div> 
                <button id="addQuestionBtn" type="button">질문 추가</button>
                <button id="submitSurveyBtn" type="submit">등록</button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
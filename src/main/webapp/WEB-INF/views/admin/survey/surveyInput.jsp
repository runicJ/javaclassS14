<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설문 등록</title>
    <link rel="icon" type="image/png" href="${contextPath}/images/favicon-mark.png">
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
        .form-group input[type="text"], .form-group textarea, .form-group select, .form-group input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #c1b6a3;
            border-radius: 5px;
        }
		#addQuestionBtn, #submitSurveyBtn {
		    background-color: #007bff;
		    color: white;
		    border: none;
		    border-radius: 5px;
		    padding: 10px 20px;
		    font-size: 14px;
		    font-weight: bold;
		    cursor: pointer;
		}
		#addQuestionBtn:hover, #submitSurveyBtn:hover {
		    background-color: #0056b3;
		}
        .survey-container button:hover {
            background-color: black;
            color: white;
        }
	.question-container {
	    border: 2px solid #c1b6a3;
	    padding: 15px;
	    margin-bottom: 20px;
	    border-radius: 10px;
	    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
	    background-color: #fafafa;
	}

    </style>
    <script>
    $(function () {
        $("#registrationDate").text(getCurrentDate());
        $("#addQuestionBtn").click(function() {
            addQuestion();
        });
    });

    function getCurrentDate() {
        let today = new Date();
        return today.getFullYear() + "-" + ("0" + (today.getMonth() + 1)).slice(-2) + "-" + ("0" + today.getDate()).slice(-2);
    }

    function addQuestion() {
        let questionNumber = $(".question-container").length + 1;
        let questionHtml = `
        <div class="question-container">
            <div class="form-group">
                <span class="questionNo">질문 \${questionNumber}</span>
                <button type="button" onclick="removeQuestion(this)">삭제</button>
            </div>
            <div class="form-group">
                <label for="questionType">질문 유형</label>
                <select name="questionType" class="questionType" onchange="updateQuestionInput(this)">
                    <option value="short">단답형</option>
                    <option value="long">장문형</option>
                    <option value="select">드롭다운형</option>
                    <option value="radio">라디오버튼형</option>
                    <option value="check">체크박스형</option>
                </select>
            </div>
            <div class="form-group">
                <label for="questionContent">질문 내용</label>
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
            container.append(`<button type="button" onclick="addOption(this)">옵션 추가</button>
                              <ul class="options-list"></ul>`);
        }
    }

    function addOption(button) {
        $(button).siblings(".options-list").append(`<li><input type="text" name="options[]" placeholder="옵션 입력"><button type="button" onclick="removeOption(this)">삭제</button></li>`);
    }

    function removeOption(button) {
        $(button).closest("li").remove();
    }

    function removeQuestion(element) {
        $(element).closest('.question-container').remove();
        updateQuestionNumbers();
    }

    function updateQuestionNumbers() {
        $('.question-container').each(function(index) {
            $(this).find('.questionNo').text('질문 ' + (index + 1));
        });
    }
    
    $(function () {
        $("#submitSurveyBtn").click(function(event) {
            event.preventDefault(); // 기본 제출 방지
            submitSurvey();
        });
    });

    function submitSurvey() {
        let formData = new FormData();
        let surveyTitle = $("#surveyTitle").val().trim();
        let surveyDesc = $("#surveyDescription").val().trim();
        let fileInput = $("#surveyImage")[0].files[0];

        if (!surveyTitle) {
            alert("설문 제목을 입력하세요.");
            return;
        }
        if (!fileInput) {
            alert("설문 대표 이미지를 등록하세요.");
            return;
        }

        // JSON 데이터 구성
        let surveyData = {
            surveyTitle: surveyTitle,
            surveyDesc: surveyDesc,
            useFlag: "y", // 기본값
            questList: []
        };

        $(".question-container").each(function(index) {
            let questType = $(this).find(".questionType").val();
            let questContent = $(this).find("input[name='questionContent']").val().trim();
            let options = [];

            if (questType === "select" || questType === "radio" || questType === "check") {
                $(this).find(".options-list li").each(function(optIndex) {
                    let optContent = $(this).find("input").val().trim();
                    if (optContent) {
                        options.push({
                            optionIdx: optIndex + 1,
                            optContent: optContent
                        });
                    }
                });
            }

            surveyData.questList.push({
                questIdx: index + 1,
                questType: questType,
                questContent: questContent,
                options: options
            });
        });

        // JSON 데이터 출력 (콘솔에서 확인)
        console.log("보낼 데이터:", JSON.stringify(surveyData));

        formData.append("fName", fileInput);
        formData.append("surveyVOJson", JSON.stringify(surveyData));

        $.ajax({
            url: '${contextPath}/admin/survey/surveyInput',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                if (response !== "0") {
                    alert("설문이 성공적으로 등록되었습니다.");
                    location.href = '${contextPath}/admin/survey/surveyList';
                } else {
                    alert("등록 실패!");
                }
            },
            error: function() {
                alert("설문 등록 중 오류 발생!");
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
                    <input id="surveyTitle" name="title" type="text" placeholder="제목을 입력해주세요(최대30자)" required />
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
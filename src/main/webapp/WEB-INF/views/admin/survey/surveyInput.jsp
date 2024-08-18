<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Survey Input</title>
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
        .form-group input[type="text"], .form-group textarea, .form-group select, .form-group input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #c1b6a3;
            border-radius: 5px;
        }
        #addQuestRow, #regSurvBtn {
            height: 40px;
            width: 120px;
            border: 2px solid #d4d2d2;
            font-size: 14px;
            font-weight: bold;
            margin-right: 5px;
            cursor: pointer;
        }
        .surv-container button:hover {
            background-color: black;
            color: white;
        }
        .quest-container {
            border: 2px solid #c1b6a3;
            padding: 15px;
            margin-bottom: 20px;
        }
        .questNo {
            font-weight: bold;
            margin-bottom: 10px;
        }
        .quest-options {
            margin-top: 10px;
        }
        .quest-options li {
            list-style-type: decimal;
            margin-bottom: 5px;
        }
        .quest-options input[type="text"] {
            width: 90%;
            display: inline-block;
        }
        .quest-options span {
            cursor: pointer;
            color: red;
            font-weight: bold;
        }
    </style>
    <script>
    $(function () {
        $("#regDate").text(getToday());

        $("#addQuestRow").click(function() {
            addNewQuestion();
        });

        $("#regSurvBtn").click(function() {
            registerSurvey();
        });

        $(document).on("propertychange change keyup paste input", "input, textarea", function() {
            $("#regSurvBtn").removeAttr('disabled');
        });

        $("#useFlag").on("change", function() {
            $("#regSurvBtn").removeAttr('disabled');
        });

        if ($("#useFlag").val() == 'n') {
            $("#regSurvBtn").attr('disabled', 'disabled');
            alert('수정할 수 없는 설문입니다!');
        }
    });

    function addNewQuestion() {
        var newItemNo = $('.quest-container').length + 1;

        var str = '';

        str += '<div class="quest-container">';
        str += '    <div class="quest-header">';
        str += '        <span class="questNo">질문 ' + newItemNo + '</span>';
        str += '        <button type="button" onclick="delQuest(this)">삭제</button>';
        str += '    </div>';
        str += '    <div class="form-group">';
        str += '        <label for="questType">질문유형</label>';
        str += '        <select name="questType" class="questType" onchange="showQuest(this)">';
        str += '            <option value="short">단답형</option>';
        str += '            <option value="long">장문형</option>';
        str += '            <option value="select">드롭다운형</option>';
        str += '            <option value="radio">라디오버튼형</option>';
        str += '            <option value="check">체크박스형</option>';
        str += '        </select>';
        str += '    </div>';
        str += '    <div class="form-group">';
        str += '        <label for="questContent">질문 내용</label>';
        str += '        <div class="surv-opt-box">';
        str += '            <input type="text" name="questContent" placeholder="질문을 입력해주세요">';
        str += '        </div>';
        str += '    </div>';
        str += '</div>';

        // 문자열로 생성된 HTML을 DOM에 추가
        $(".questionnaire").append(str);
    }

    function showQuest(type) {
        var questType = type.value;
        var container = $(type).closest('.quest-container').find('.surv-opt-box');
        container.empty();

        if (questType == 'short' || questType == 'long') {
            container.append('<input id="questContent" type="text" placeholder="질문을 입력해주세요">');
        } else if (questType == 'select' || questType == 'radio' || questType == 'check') {
            addOptionBox(container, questType);
        }
    }

    function addOptionBox(container, questType) {
        var listId = questType + '-multi-opt';
        var optionHtml = '';

        optionHtml += '<input id="questContent" type="text" placeholder="질문을 입력해주세요">';
        optionHtml += '<ul class="quest-options" id="' + listId + '">';
        optionHtml += '    <li><input name="multi-opt" type="text" placeholder="옵션"><span onclick="deleteOpt(this)"> ×</span></li>';
        optionHtml += '</ul>';
        optionHtml += '<button type="button" onclick="addOption(\'' + questType + '\', this)">옵션 추가</button>';

        container.append(optionHtml);
    }

    function addOption(optType, data) {
        var container = $(data).siblings('.quest-options');
        container.append('<li><input name="multi-opt" type="text" placeholder="옵션"><span onclick="deleteOpt(this)"> ×</span></li>');
    }

    function deleteOpt(data) {
        $(data).closest('li').remove();
    }

    function delQuest(data) {
        if ($('.quest-container').length > 1) {
            $(data).closest('.quest-container').remove();
            updateQuestionNumbers();
        } else {
            alert("질문의 갯수는 최소 1개 이상입니다.");
        }
    }

    function updateQuestionNumbers() {
        $('.quest-container').each(function(index) {
            $(this).find('.questNo').text('질문 ' + (index + 1));
        });
    }

    function getToday() {
        var date = new Date();
        var year = date.getFullYear();
        var month = ("0" + (date.getMonth() + 1)).slice(-2);
        var day = ("0" + date.getDate()).slice(-2);
        return year + "-" + month + "-" + day;
    }

    function registerSurvey() {
        let surveyTitle = $("#survTitle").val().trim();
        let useFlag = $("#useFlag").val();
        let surveyDesc = $("#surveyDesc").val().trim();

        if (!surveyTitle) {
            alert("설문 제목을 입력하세요.");
            return;
        }

        let fileInput = document.getElementById("file");
        let file = fileInput.files[0];
        if (!file) {
            alert("설문 대표 이미지를 등록하세요.");
            return;
        }

        let ext = file.name.split('.').pop().toUpperCase();
        if (!["JPG", "GIF", "PNG", "JPEG"].includes(ext)) {
            alert("업로드 가능한 파일이 아닙니다.");
            return;
        }

        let survQustList = [];
        $(".quest-container").each(function(index) {
            let survQustObj = {
                questIdx: index + 1,
                questType: $(this).find(".questType").val(),
                questContent: $(this).find(".surv-opt-box input").val().trim()
            };

            if (survQustObj.questType !== 'short' && survQustObj.questType !== 'long') {
                let qustOptArr = [];
                $(this).find('.quest-options li').each(function(optIndex) {
                    let optObj = {
                        optionIdx: optIndex + 1,
                        optContent: $(this).find("input").val()
                    };
                    qustOptArr.push(optObj);
                });
                survQustObj.options = qustOptArr;
            }

            survQustList.push(survQustObj);
        });

        let formData = new FormData();
        formData.append("fName", file);
        formData.append("surveyVOJson", JSON.stringify({
            surveyTitle: surveyTitle,
            useFlag: useFlag,
            surveyDesc: surveyDesc,
            questList: survQustList
        }));

        $.ajax({
            url: '${ctp}/admin/survey/surveyInput',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(res) {
            	alert("res");
            	if(res != "0") {
	                alert('설문이 등록되었습니다.');
	                location.href = '${ctp}/admin/survey/surveyList';
            	}
            	else alert("등록 실패!");
            },
            error: function() {
                alert('전송오류!');
            }
        });
    }


    function chkFields() {
        var result = true;
        $('input[type=text]').each(function(index, item) {
            if (!$(item).val().trim()) {
                result = false;
                return false;
            }
        });
        $('textarea').each(function(index, item) {
            if (!$(item).val().trim()) {
                result = false;
                return false;
            }
        });
        return result;
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
                <!-- Form 시작 -->
<form id="surveyForm" method="post" action="${ctp}/admin/survey/surveyInput" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="survTitle">제목</label>
                        <input id="survTitle" name="surveyTitle" type="text" placeholder="제목을 입력해주세요(최대30자)" required />
                    </div>
                    <div class="form-group">
                        <label for="sNickName">등록자</label>
                        <div>${sNickName}</div>
                    </div>
                    <div class="form-group">
                        <label for="regDate">등록일자</label>
                        <span id="regDate"></span>
                    </div>
                    <div class="form-group">
                        <label for="useFlag">사용여부</label>
                        <select id="useFlag" name="useFlag">
                            <option value="y">예</option>
                            <option value="n">아니오</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="file">설문대표이미지</label>
                        <input type="file" name="fName" id="file" required />
                    </div>

                    <!-- 설문지 소개 START -->
                    <div class="form-group">
                        <label for="surveyDesc">설문지 소개</label>
                        <textarea id="surveyDesc" name="surveyDesc"></textarea>
                    </div>
                    <!-- 설문지 소개 END -->

                    <!-- 설문지 질문 START -->
                    <div class="questionnaire">
                        <div class="quest-container">
                            <div class="form-group">
                                <span class="questNo">질문1</span>
                            </div>
                            <div class="form-group">
                                <label for="questType">질문유형</label>
                                <select name="questType" class="questType" onchange="showQuest(this)">
                                    <option value="short">단답형</option>
                                    <option value="long">장문형</option>
                                    <option value="select">드롭다운형</option>
                                    <option value="radio">라디오버튼형</option>
                                    <option value="check">체크박스형</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="questContent">질문 내용</label>
                                <div class="surv-opt-box">
                                    <input type="text" name="questContent" placeholder="질문을 입력해주세요">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 설문지 질문 END -->

                    <button id="addQuestRow" type="button">추가</button>
                    <button id="regSurvBtn" type="submit">등록</button>
                </form>
                <!-- Form 끝 -->
            </div>
        </div>
    </div>
</div>
    <jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
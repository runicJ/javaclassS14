<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설문 수정하기</title>

    <jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />

    <style>
        h2 {
            margin: 20px 0;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #c1b6a3;
            border-radius: 5px;
        }
        .quest-container {
            border: 2px solid #c1b6a3;
            padding: 15px;
            margin-bottom: 20px;
        }
    </style>

    <script>
    $(function () {
        $("#updateSurvBtn").click(function() {
            updateSurvey();
        });

        function updateSurvey() {
            let surveyTitle = $("#survTitle").val().trim();
            let useFlag = $("#useFlag").val();
            let surveyDesc = $("#surveyDesc").val().trim();

            if (!surveyTitle) {
                alert("설문 제목을 입력하세요.");
                return;
            }

            let survQustList = [];
            $(".quest-container").each(function(index) {
                let survQustObj = {
                    questIdx: $(this).attr("data-id"),
                    questType: $(this).find(".questType").val(),
                    questContent: $(this).find(".surv-opt-box input").val().trim()
                };
                survQustList.push(survQustObj);
            });

            let formData = new FormData();
            formData.append("surveyVOJson", JSON.stringify({
                surveyIdx: ${survey.surveyIdx},
                surveyTitle: surveyTitle,
                useFlag: useFlag,
                surveyDesc: surveyDesc,
                questList: survQustList
            }));

            $.ajax({
                url: '${ctp}/admin/survey/updateSurvey',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(res) {
                    if (res != "0") {
                        alert('설문이 수정되었습니다.');
                        location.href = '${ctp}/admin/survey/surveyList';
                    } else {
                        alert("수정 실패!");
                    }
                },
                error: function() {
                    alert('전송 오류!');
                }
            });
        }
    });
    </script>
</head>
<body>

<div id="main-wrapper">
    <jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
    <jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />

    <div class="page-wrapper">
        <div class="card p-5">
            <h2><i class="fa-solid fa-pencil"></i> 설문 수정하기</h2>
            <div class="surv-container">
                <form id="surveyForm" method="post" action="${ctp}/admin/survey/updateSurvey">
                    <input type="hidden" name="surveyIdx" value="${survey.surveyIdx}" />

                    <div class="form-group">
                        <label>제목</label>
                        <input id="survTitle" name="surveyTitle" type="text" value="${survey.surveyTitle}">
                    </div>
                    <div class="form-group">
                        <label>사용 여부</label>
                        <select id="useFlag" name="useFlag">
                            <option value="y" ${survey.useFlag == 'y' ? 'selected' : ''}>예</option>
                            <option value="n" ${survey.useFlag == 'n' ? 'selected' : ''}>아니오</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>설문지 소개</label>
                        <textarea id="surveyDesc" name="surveyDesc">${survey.surveyDesc}</textarea>
                    </div>

                    <div class="questionnaire">
                        <c:forEach var="question" items="${survey.questList}">
                            <div class="quest-container" data-id="${question.questIdx}">
                                <div class="form-group">
                                    <span class="questNo">질문 ${question.questIdx}</span>
                                </div>
                                <div class="form-group">
                                    <label>질문 유형</label>
                                    <select name="questType" class="questType">
                                        <option value="short" ${question.questType == 'short' ? 'selected' : ''}>단답형</option>
                                        <option value="long" ${question.questType == 'long' ? 'selected' : ''}>장문형</option>
                                        <option value="select" ${question.questType == 'select' ? 'selected' : ''}>드롭다운형</option>
                                        <option value="radio" ${question.questType == 'radio' ? 'selected' : ''}>라디오버튼형</option>
                                        <option value="check" ${question.questType == 'check' ? 'selected' : ''}>체크박스형</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>질문 내용</label>
                                    <div class="surv-opt-box">
                                        <input type="text" name="questContent" value="${question.questContent}">
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <button id="updateSurvBtn" type="button">수정</button>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설문 응답하기</title>
    <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        'use strict';

        function submitAnswer() {
            let userIdx = $("#userIdx").val();
            let answerList = [];
            let errors = [];

            // 설문 데이터를 수집
            $('#surv_quests_tbl tbody tr').each(function() {
                let $input = $(this).find('input, textarea, select');
                let questionId = $input.attr('id') || $input.attr('name'); 
                let questionType = $(this).data('type'); 
                let answerObj = { qustNo: questionId, userIdx: userIdx, answCont: "", answLong: "" };

                if (questionType === 'long') {
                    let answLong = $(this).find('textarea').val().trim();
                    if (!answLong) errors.push(`질문 ${questionId}에 응답이 없습니다.`);
                    answerObj.answLong = answLong;
                } else if (['check', 'radio'].includes(questionType)) {
                    let checkedOptions = $(this).find('input:checked');
                    if (checkedOptions.length === 0) errors.push(`질문 ${questionId}에 체크된 옵션이 없습니다.`);
                    checkedOptions.each(function() {
                        let optionAnswer = { ...answerObj, answCont: $(this).val() };
                        answerList.push(optionAnswer);
                    });
                } else if (questionType === 'short') {
                    let answCont = $(this).find('input').val().trim();
                    if (!answCont) errors.push(`질문 ${questionId}에 응답이 없습니다.`);
                    answerObj.answCont = answCont;
                } else if (questionType === 'select') {
                    let selectedValue = $(this).find('select').val();
                    if (!selectedValue) errors.push(`질문 ${questionId}에서 선택된 값이 없습니다.`);
                    answerObj.answCont = selectedValue;
                }

                answerList.push(answerObj);
            });

            if (errors.length > 0) {
                alert(errors.join("\n"));
                return;
            }

            // 서버로 데이터 전송
            $.ajax({
                url: '/survey/surveyAnswer',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ answerList }),
                success: function(response) {
                    if (response === "이미 응답한 설문입니다.") {
                        alert(response);
                        return;
                    }
                    alert('설문 응답이 성공적으로 제출되었습니다.');
                    window.location.href = '/survey/surveyEventList';
                },
                error: function() {
                    alert('응답 제출 중 오류가 발생했습니다.');
                }
            });
        }
    </script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/user/header.jsp" />
    <jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
    <section class="page">
        <div class="container">
            <h2><i class="fa-solid fa-comment-dots"></i> 설문 응답하기</h2>
            <input type="hidden" id="userIdx" value="${surveyVO.userId}"/>
            <div class="surv-container">
                <!-- 설문 기본정보 -->
                <div class="form-table-title-container">
                    <table class="form-tbl">
                        <tr>
                            <td class="form-tbl-col">제목</td>
                            <td>${surveyVO.surveyTitle}</td>
                        </tr>
                        <tr>
                            <td class="form-tbl-col">등록자</td>
                            <td>${surveyVO.userId}</td>
                        </tr>
                    </table>
                </div>

                <!-- 설문지 소개 -->
                <div class="form-table-intro-container">
                    <table class="form-tbl">
                        <tr>
                            <td class="form-tbl-col">소개</td>
                            <td id="survDesc">${surveyVO.surveyDesc}</td>
                        </tr>
                    </table>
                </div>

                <!-- 설문지 질문 -->
                <table id="surv_quests_tbl" class="form-tbl">
                    <thead>
                        <tr><th class="form-tbl-col">질문</th></tr>
                    </thead>
                    <tbody>
                        <c:forEach var="quest" items="${surveyVO.questList}">
                            <tr data-type="${quest.questType}">
                                <td>
                                    <span><i class="fa-solid fa-map-pin"></i> </span><span>${quest.questContent}</span>
                                    <br/><br/>
                                    <c:choose>
                                        <c:when test="${quest.questType == 'short'}">
                                            <input id="${quest.questIdx}" name="${quest.questIdx}" type="text" size="137"/>
                                        </c:when>
                                        <c:when test="${quest.questType == 'long'}">
                                            <textarea id="${quest.questIdx}" name="${quest.questIdx}" cols="140" rows="7"></textarea>
                                        </c:when>
                                        <c:when test="${quest.questType == 'select'}">
                                            <select id="${quest.questIdx}" name="${quest.questIdx}">
                                                <c:forEach var="opt" items="${quest.options}">
                                                    <option value="${opt.optContent}">${opt.optContent}</option>
                                                </c:forEach>
                                            </select>
                                        </c:when>
                                        <c:when test="${quest.questType == 'radio'}">
                                            <c:forEach var="opt" items="${quest.options}">
                                                <input type="radio" name="${quest.questIdx}" value="${opt.optContent}"/> ${opt.optContent}<br/>
                                            </c:forEach>
                                        </c:when>
                                        <c:when test="${quest.questType == 'check'}">
                                            <c:forEach var="opt" items="${quest.options}">
                                                <input type="checkbox" name="${quest.questIdx}" value="${opt.optContent}"/> ${opt.optContent}<br/>
                                            </c:forEach>
                                        </c:when>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <br/>
            <input type="button" class="btn btn-success" onclick="submitAnswer()" value="제출하기" />
            <input type="button" onclick="location.href='/survey/surveyEventList';" value="목록보기" class="btn btn-warning">
        </div>
    </section>
    <jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
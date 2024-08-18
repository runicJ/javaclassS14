<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Survey Answer</title>
    <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
    <script>
        'use strict';

        function submitAnswer() {
            let userIdx = $("#userIdx").val();
            let empty = false;
            let answerList = [];

            // 설문 데이터를 수집
            $('#surv_quests_tbl tbody tr').each(function() {
                let questionId = $(this).find('input, textarea, select').attr('id');
                let questionType = $(this).data('type'); // 질문의 유형을 data-type에서 가져옴
                let answerObj = { qustNo: questionId, userIdx: userIdx, answCont: "", answLong: "" };

                if (questionType === 'long') {
                    let answLong = $(this).find('textarea').val().trim();
                    if (!answLong) {
                        empty = true;
                        alert('질문 번호 ' + questionId + '에 응답이 없습니다.');
                        return false; // loop exit
                    }
                    answerObj.answLong = answLong;
                } else if (['check', 'radio'].includes(questionType)) {
                    let checkedOptions = $(this).find('input:checked');
                    if (checkedOptions.length === 0) {
                        empty = true;
                        alert('질문 번호 ' + questionId + '에 체크된 옵션이 없습니다.');
                        return false; // loop exit
                    }
                    checkedOptions.each(function() {
                        let optionAnswer = $.extend({}, answerObj, { answCont: $(this).val() });
                        answerList.push(optionAnswer);
                    });
                } else if (questionType === 'short') {
                    let answCont = $(this).find('input').val().trim();
                    if (!answCont) {
                        empty = true;
                        alert('질문 번호 ' + questionId + '에 응답이 없습니다.');
                        return false; // loop exit
                    }
                    answerObj.answCont = answCont;
                } else if (questionType === 'select') {
                    let selectedValue = $(this).find('select').val();
                    if (!selectedValue) {
                        empty = true;
                        alert('질문 번호 ' + questionId + '에서 선택된 값이 없습니다.');
                        return false; // loop exit
                    }
                    answerObj.answCont = selectedValue;
                }
                answerList.push(answerObj);
            });

            if (empty) {
                return; // 모든 문항에 응답을 받지 못한 경우
            }

            // 서버로 데이터 전송
            $.ajax({
                url: '/survey/surveyAnswer', // 서버의 URL을 설정합니다
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ answerList: answerList }),
                success: function(response) {
                    alert('등록 완료');
                    window.location.href = '/survey/surveyEventList'; // 리디렉션 URL 설정
                },
                error: function(xhr, status, error) {
                    alert('전송 오류!');
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
                <!-- 설문 기본정보 START -->
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
                <!-- 설문 기본정보 END -->

                <!-- 설문지 소개 START -->
                <div class="form-table-intro-container">
                    <table class="form-tbl">
                        <tr>
                            <td class="form-tbl-col">소개</td>
                            <td id="survDesc">${surveyVO.surveyDesc}</td>
                        </tr>
                    </table>
                </div>
                <!-- 설문지 소개 END -->

                <!-- 설문지 질문 START -->
                <table id="surv_quests_tbl" class="form-tbl">
                    <thead>
                        <tr>
                            <th class="form-tbl-col">질문</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="quest" items="${surveyVO.questList}">
                            <tr>
                                <td>
                                    <!-- 단답형 -->
                                    <c:if test="${quest.questType == 'short'}">
                                        <div class="surv_opt_box">
                                            <span><i class="fa-solid fa-map-pin"></i> </span><span>${quest.questContent}</span>
                                            <br/><br/>
                                            <input id="${quest.questIdx}" size="137"/>
                                        </div>
                                    </c:if>
                                    <!-- 장문형 -->
                                    <c:if test="${quest.questType == 'long'}">
                                        <div class="surv_opt_box">
                                            <span><i class="fa-solid fa-map-pin"></i> </span><span>${quest.questContent}</span>
                                            <br/><br/>
                                            <textarea id="${quest.questIdx}" cols="140" rows="7" style="resize:none"></textarea>
                                        </div>
                                    </c:if>
                                    <!-- 셀렉트형 -->
                                    <c:if test="${quest.questType == 'select'}">
                                        <div class="surv_opt_box">
                                            <span><i class="fa-solid fa-map-pin"></i> </span><span>${quest.questContent}</span>
                                            <br/><br/>
                                            <select id="${quest.questIdx}">
                                                <c:forEach var="opt" items="${quest.options}">
                                                    <option value="${opt.optContent}">${opt.optContent}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </c:if>
                                    <!-- 라디오 -->
                                    <c:if test="${quest.questType == 'radio'}">
                                        <div class="surv_opt_box">
                                            <span><i class="fa-solid fa-map-pin"></i> </span><span>${quest.questContent}</span>
                                            <br/><br/>
                                            <c:forEach var="opt" items="${quest.options}">
                                                <input type="radio" name="${quest.questIdx}" value="${opt.optContent}"/> ${opt.optContent}<br/>
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                    <!-- 체크박스 -->
                                    <c:if test="${quest.questType == 'check'}">
                                        <div class="surv_opt_box">
                                            <span><i class="fa-solid fa-map-pin"></i> </span><span>${quest.questContent}</span>
                                            <br/><br/>
                                            <c:forEach var="opt" items="${quest.options}">
                                                <input type="checkbox" name="${quest.questIdx}" value="${opt.optContent}"/> ${opt.optContent}<br/>
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <!-- 설문지 질문 END -->
            </div>
            <br/>
            <input type="button" class="btn btn-success mr-3" onclick="submitAnswer()" value="제출하기" />
            <input type="button" onclick="location.href='${ctp}/survey/surveyEventList';" value="목록보기" class="btn btn-warning">
        </div>
    </section>
    <jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>surveyAnswer</title>
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
    <style>
        button {
            appearance: none;
            margin: 10px;
            margin-left: 0;
            padding: 0.5rem 1rem;
            font-size: 1rem;
            font-weight: 400;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            width: auto;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: black;
            color: white;
        }
    </style>
    <script>
        'use strict';

        function submit() {
            let userId = $("#userId").val();
            let questList = ${surveyVO.questList};
            questList = JSON.parse('${surveyVO.questList}');
            let empty = false;
            let answerList = [];

            questList.forEach(qust => {
                let answerObj = {
                    qustNo: qust.qustNo,
                    userId: userI
                };

                if (qust.questType == "long") {
                    let answLong = document.getElementById(qust.qustNo).value.trim();
                    if (!answLong) empty = true;
                    answerObj.answLong = answLong;
                    answerList.push(answerObj);
                } else if (["check", "radio"].includes(qust.questType)) {
                    let checkedOptions = [...document.getElementsByName(qust.qustNo)].filter(opt => opt.checked);
                    if (checkedOptions.length == 0) empty = true;
                    checkedOptions.forEach(opt => {
                        let optionAnswer = { ...answerObj, answCont: opt.value };
                        answerList.push(optionAnswer);
                    });
                } else if (qust.questType == "short") {
                    let answCont = document.getElementById(qust.qustNo).value.trim();
                    if (!answCont) empty = true;
                    answerObj.answCont = answCont;
                    answerList.push(answerObj);
                } else if (qust.questType == "select") {
                    answerObj.answCont = document.getElementById(qust.qustNo).value;
                    answerList.push(answerObj);
                }
            });

            if (empty) {
                alert("모든 문항에 응답 바랍니다.");
                return;
            }

            $.ajax({
                url: "${ctp}/survey/surveyAnswer",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ answerList }),
                success: () => {
                    alert('등록 완료');
                    location.href = url;
                },
				error: function() {
                	alert("전송오류!");
                }
            });
        }

        function backList() {
            location.href = url;
        }
    </script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/user/header.jsp" />
    <jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
    <section class="page">
    <div class="container">
        <h2><i class="fa-solid fa-comment-dots"></i> 설문 응답하기</h2>
        <input type="hidden" id="userId" value="${sUid}"/>
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
        <a href="javascript:void(0)" onclick="submit()">제출하기</a>
        <a href="${ctp}/survey/surveyEventList">목록 보기</a>
        </div>
    </section>
    <jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>

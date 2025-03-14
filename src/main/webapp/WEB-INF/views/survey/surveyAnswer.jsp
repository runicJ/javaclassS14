<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>surveyAnswer</title>
    <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />

    <style>
        /* 전체 레이아웃 조정 */
        .domain {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        /* 테이블 스타일 */
        .form-tbl {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .form-tbl th, .form-tbl td {
            padding: 10px;
            border: 1px solid #ddd;
        }

        .form-tbl th {
            background-color: #f8f9fa;
            font-weight: bold;
        }

        .form-tbl td {
            background-color: #fff;
        }

        /* 입력 필드 스타일 */
        input[type="text"], textarea, select {
            width: 100%;
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        textarea {
            resize: none;
        }

        /* 질문 디자인 */
        .survey-question {
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .survey-question h6 {
            margin-bottom: 10px;
            font-weight: bold;
        }

        /* 버튼 스타일 */
		.btn-container {
		    text-align: center;
		    margin-top: 20px;
		}
		
		.btn {
		    padding: 12px 20px;
		    font-size: 16px;
		    border-radius: 6px;
		    font-weight: bold;
		    transition: all 0.3s ease-in-out;
		}
		
		.btn-success {
		    background-color: #28a745;
		    color: white;
		    border: none;
		}
		
		.btn-warning {
		    background-color: #ffc107;
		    color: black;
		    border: none;
		}
		
		.btn:hover {
		    transform: scale(1.05);
		}
    </style>

    <script>
	    function submitAnswer() {
	        let userIdx = $("#userIdx").val();
	        let surveyIdx = ${surveyVO.surveyIdx}; // 현재 설문 ID 가져오기
            let answerList = [];
            let errors = [];
	
	        // 사용자 응답 여부 확인
	        $.get('${ctp}/survey/checkUserSurveyAnswered?surveyIdx=' + surveyIdx, function(response) {
	            if (response) {
	                alert("이미 응답한 설문입니다.");
	                return;
	            }
	
	            $(".survey-question").each(function() {
	                let questionType = $(this).data("type");
	                let questionId = $(this).data("quest-id");  // 정확한 질문 ID 추출
	                let answerObj = { questIdx: questionId, userIdx: userIdx, surveyIdx: surveyIdx, answerContent: "", answerLong: "" };

	                if (questionType === "long") {
	                    let answLong = $(this).find("textarea").val().trim();
	                    if (!answLong) errors.push("질문 " + questionId + "에 응답이 없습니다.");
	                    answerObj.answerLong = answLong;
	                } else if (questionType === "short") {
	                    let answCont = $(this).find("input").val().trim();
	                    if (!answCont) errors.push("질문 " + questionId + "에 응답이 없습니다.");
	                    answerObj.answerContent = answCont;
	                } else if (questionType === "select") {
	                    let selectedValue = $(this).find("select").val();
	                    if (!selectedValue) errors.push("질문 " + questionId + "에서 선택된 값이 없습니다.");
	                    answerObj.answerContent = selectedValue;
	                } else if (questionType === "radio") {
	                    let selectedRadio = $(this).find("input:checked");
	                    if (selectedRadio.length === 0) {
	                        errors.push("질문 " + questionId + "에 체크된 옵션이 없습니다.");
	                    } else {
	                        answerObj.answerContent = selectedRadio.val();
	                    }
	                } else if (questionType === "check") {
	                    let checkedOptions = $(this).find("input:checked").map(function() {
	                        return $(this).val();
	                    }).get();
	                    if (checkedOptions.length === 0) {
	                        errors.push("질문 " + questionId + "에 체크된 옵션이 없습니다.");
	                    } else {
	                        answerObj.answerContent = checkedOptions.join(",");
	                    }
	                }

	                answerList.push(answerObj);
	            });
	
	            if (errors.length > 0) {
	                alert(errors.join("\n"));
	                return;
	            }
	
	            $.ajax({
	                url: '${ctp}/survey/surveyAnswer',
	                type: 'POST',
	                contentType: 'application/json; charset=utf-8',
	                data: JSON.stringify(answerList),
	                success: function(response) {
	                    alert("응답이 성공적으로 제출되었습니다!");
	                    window.location.href = '${ctp}/survey/surveyEventList';
	                },
	                error: function(xhr, status, error) {
	                    alert('응답 제출 중 오류가 발생했습니다.');
	                }
	            });
	        });
	    }
	    
	     // 사용자 응답 여부 확인 함수 (비동기 처리)
	     function checkUserSurveyAnswered(surveyIdx, callback) {
	         $.get('${ctp}/survey/checkUserSurveyAnswered?surveyIdx=' + surveyIdx, function(response) {
	             callback(response);  // 응답 결과를 callback 함수로 전달
	         });
	     }
    </script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/user/header.jsp" />
    <jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
    <section class="page">
        <div class="domain">
            <h2><i class="fa-solid fa-comment-dots"></i> 설문 응답하기</h2>
            <input type="hidden" id="userIdx" value="${surveyVO.userId}"/>

            <!-- 설문 기본정보 -->
            <table class="form-tbl">
                <tr><th>제목</th><td>${surveyVO.surveyTitle}</td></tr>
                <tr><th>설명</th><td>${surveyVO.surveyDesc}</td></tr>
            </table>

            <!-- 설문 질문 -->
            <div>
			<c:forEach var="quest" items="${surveyVO.questList}">
			    <div class="survey-question" data-type="${quest.questType}" data-quest-id="${quest.questIdx}">
			        <h6><i class="fa-solid fa-map-pin"></i> ${quest.questContent}</h6>
			        
			        <c:choose>
			            <c:when test="${quest.questType == 'short'}">
			                <input id="${quest.questIdx}" name="${quest.questIdx}" type="text"/>
			            </c:when>
			
			            <c:when test="${quest.questType == 'long'}">
			                <textarea id="${quest.questIdx}" name="${quest.questIdx}" rows="5"></textarea>
			            </c:when>
			
			            <c:when test="${quest.questType == 'select'}">
			                <select id="${quest.questIdx}" name="${quest.questIdx}">
			                    <c:if test="${empty quest.options}">
			                        <option value="">옵션이 없습니다.</option>
			                    </c:if>
			                    <c:forEach var="opt" items="${quest.options}">
			                        <option value="${opt.optContent}">${opt.optContent}</option>
			                    </c:forEach>
			                </select>
			            </c:when>
			
			            <c:when test="${quest.questType == 'radio'}">
			                <c:forEach var="opt" items="${quest.options}">
			                    <label>
			                        <input type="radio" name="${quest.questIdx}" value="${opt.optContent}"/> ${opt.optContent}
			                    </label><br/>
			                </c:forEach>
			            </c:when>
			
			            <c:when test="${quest.questType == 'check'}">
			                <c:forEach var="opt" items="${quest.options}">
			                    <label>
			                        <input type="checkbox" name="${quest.questIdx}" value="${opt.optContent}"/> ${opt.optContent}
			                    </label><br/>
			                </c:forEach>
			            </c:when>
			        </c:choose>
			    </div>
			</c:forEach>
            </div>

            <!-- 버튼 -->
            <div class="btn-container">
                <input type="button" class="btn btn-success" onclick="submitAnswer()" value="제출하기" />
                <input type="button" onclick="location.href='${ctp}/survey/surveyEventList';" value="목록보기" class="btn btn-warning">
            </div>
        </div>
    </section>
    <jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>adminSurveyInput</title>

    <jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />

    <style>
	    .page-wrapper {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    min-height: 100vh;
		}
		
		.container-fluid {
		    max-width: 1200px; /* 최대 너비 조정 */
		}
		
		.card {
		    background-color: #ffffff;
		    padding: 30px;
		    border-radius: 10px;
		    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
		}
		
		.surv-container {
		    width: 100%;
		    max-width: 800px;
		    margin: auto;
		}
    
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
        #addQuestRow, #regSurvBtn {
            height: 40px;
            width: 120px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }
        .quest-container {
            border: 2px solid #c1b6a3;
            padding: 15px;
            margin-bottom: 20px;
        }
        .quest-options {
            margin-top: 10px;
        }
        .quest-options li {
            list-style-type: decimal;
            margin-bottom: 5px;
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

        function getToday() {
            let date = new Date();
            return date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
        }

        function addNewQuestion() {
            let newItemNo = $('.quest-container').length + 1;

            let str = `
            <div class="quest-container">
                <div class="form-group">
                    <span class="questNo">질문 ${newItemNo}</span>
                </div>
                <div class="form-group">
                    <label>질문 유형</label>
                    <select name="questType" class="questType" onchange="showQuest(this)">
                        <option value="short">단답형</option>
                        <option value="long">장문형</option>
                        <option value="select">드롭다운형</option>
                        <option value="radio">라디오버튼형</option>
                        <option value="check">체크박스형</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>질문 내용</label>
                    <div class="surv-opt-box">
                        <input type="text" name="questContent" placeholder="질문을 입력해주세요">
                    </div>
                </div>
            </div>`;

            $(".questionnaire").append(str);
        }

        function registerSurvey() {
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
                    questIdx: index + 1,
                    questType: $(this).find(".questType").val(),
                    questContent: $(this).find(".surv-opt-box input").val().trim()
                };

                survQustList.push(survQustObj);
            });

            let formData = new FormData();
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
                    if (res != "0") {
                        alert('설문이 등록되었습니다.');
                        location.href = '${ctp}/admin/survey/surveyList';
                    } else {
                        alert("등록 실패!");
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

<div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
    <jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
    <div class="page-wrapper">
        <div class="container-fluid">
        <div class="row">
        <div class="col-md-10 offset-md-1">
        <div class="card p-5">
            <h2><i class="fa-solid fa-pencil"></i> 설문 만들기</h2>
            <div class="surv-container">
                <form id="surveyForm" method="post" action="${ctp}/admin/survey/surveyInput">
                    <div class="form-group">
                        <label>제목</label>
                        <input id="survTitle" name="surveyTitle" type="text" placeholder="제목을 입력해주세요">
                    </div>
                    <div class="form-group">
                        <label>등록일자</label>
                        <span id="regDate"></span>
                    </div>
                    <div class="form-group">
                        <label>사용 여부</label>
                        <select id="useFlag" name="useFlag">
                            <option value="y">예</option>
                            <option value="n">아니오</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>설문지 소개</label>
                        <textarea id="surveyDesc" name="surveyDesc"></textarea>
                    </div>

                    <div class="questionnaire">
                        <div class="quest-container">
                            <div class="form-group">
                                <span class="questNo">질문 1</span>
                            </div>
                            <div class="form-group">
                                <label>질문 유형</label>
                                <select name="questType" class="questType">
                                    <option value="short">단답형</option>
                                    <option value="long">장문형</option>
                                    <option value="select">드롭다운형</option>
                                    <option value="radio">라디오버튼형</option>
                                    <option value="check">체크박스형</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>질문 내용</label>
                                <div class="surv-opt-box">
                                    <input type="text" name="questContent" placeholder="질문을 입력해주세요">
                                </div>
                            </div>
                        </div>
                    </div>

                    <button id="addQuestRow" type="button">질문 추가</button>
                    <button id="regSurvBtn" type="submit">등록</button>
                </form>
            </div>
        </div>
    </div>
    </div>
    </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1:1 문의</title>
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
    <style>
        .required {
            color: red;
        }
    </style>
    <script>
        'use Strict';

        function etcShow(value) {
            if (value === '기타') {
                document.getElementById("complaintTxt").style.display = 'block';
            } else {
                document.getElementById("complaintTxt").style.display = 'none';
            }
        }

        function qnaCheck() {
            const userId = document.getElementById("userId").value.trim();
            const qnaTitle = document.getElementById("qnaTitle").value.trim();
            const qnaContent = document.getElementById("qnaContent").value.trim();
            const qnaCategory = document.querySelector("select[name=qnaCategory]").value;
            const complaintTxt = document.getElementById("complaintTxt").value.trim();
            const email = document.getElementById("email") ? document.getElementById("email").value.trim() : "";

            if (userId == "") {
                alert("신청하시는 분의 ID를 입력하세요");
                return false;
            }

            if (email == "" && document.getElementById("email")) {
                alert("비회원이실 경우 이메일 입력은 필수사항입니다!");
                return false;
            }

            if (qnaTitle == "") {
                alert("문의 제목을 입력하세요");
                return false;
            }

            if (qnaContent == "") {
                alert("문의 내용을 입력해주세요!");
                return false;
            }

            if (qnaCategory == '기타' && complaintTxt == "") {
                alert("기타 사유를 입력해 주세요.");
                return false;
            }

            document.getElementById("contact-form").submit();
        }
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<section class="page">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="page-title text-center mb-2">문의하기</h1>
                <p class="page-subtitle text-center mt-2">'괄호 안 쉼표'에서는 회원님의 목소리에<br>항상 귀 기울이고 있습니다.</p>
                <div class="line thin"></div>
                <div class="page-description">
                    <div class="row">
                        <div class="col-md-6 col-sm-6">
                            <h3>괄호 안 쉼표</h3>
                            <h5>Pause In Parentheses</h5>
                            <p>문의하신 내용은 마이페이지에서 답변 확인 가능합니다.</p>
                            <p>
                                연락처 <br>
                                <span class="bold">043 - 225 - 2111</span>
                                <br>
                                이용가능시간 <br>
                                <span class="bold">평일 09:00 ~ 22:30 | 토요일 09:00 ~ 18:30</span>
                                <br><br>
                                주소 <br>
                                <span class="bold">충청북도 청주시 서원구 사직대로 109, 4,5층</span>
                            </p>
							<div id="kakao-talk-channel-chat-button"></div>
                        </div>
                        <div class="col-md-6 col-sm-6">
                            <form class="qnaForm" id="contact-form" action="${ctp}/cswork/qna/qnaInput" method="post">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <c:choose>
                                            <c:when test="${!empty sUid}">
		                                        <label>신청자 ID <span class="required">*</span></label>
                                                <input type="text" class="form-control" id="userId" name="userId" value="${sUid}" readonly>
                                            </c:when>
                                            <c:otherwise>
		                                        <label>신청자 이름 <span class="required">*</span></label>
                                                <input type="text" class="form-control" id="userId" name="userId" required>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <c:if test="${empty sUid}">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>이메일 <span class="required">*</span></label>
                                            <input type="email" class="form-control" id="email" name="email" required>
                                        </div>
                                    </div>
                                </c:if>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>문의 제목 <span class="required">*</span></label>
                                        <input type="text" class="form-control" id="qnaTitle" name="qnaTitle" required>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>문의유형 </label>
										<select name="qnaCategory" onchange="etcShow(this.value)">
										    <option>알레르기 정보</option>
										    <option>상품 관련</option>
										    <option>불편 신고</option>
										    <option value="기타">기타</option>
										</select>
										<div id="etc">
										    <textarea rows="2" id="complaintTxt" class="form-control" style="display:none"></textarea>
										</div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>문의내용 <span class="required">*</span></label>
                                        <textarea class="form-control" id="qnaContent" rows=5 name="qnaContent" required></textarea>
                                    </div>
                                </div>
                                <div class="col-md-12 mt-3 text-center">
                                    <button type="button" class="btn btn-primary mr-2" onclick="qnaCheck()">문의 신청하기</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
<script type="text/javascript">
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    if (!Kakao.isInitialized()) {
        Kakao.init('3fe3ad77eb298aac7a938386f756b9b1');
    }
    // 채널 1:1 채팅 버튼을 생성합니다.
    Kakao.Channel.createChatButton({
        container: '#kakao-talk-channel-chat-button',
        channelPublicId: '_YjzgG',
        title: 'question',
        size: 'small',
        color: 'yellow',
        shape: 'pc',
        supportMultipleDensities: true,
    });
</script>
</body>
</html>
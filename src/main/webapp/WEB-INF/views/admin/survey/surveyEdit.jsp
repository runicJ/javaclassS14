<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
    <title>설문조사지 수정하기</title>
   	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
    <style>
        .form-tbl { width: 100%; margin-bottom: 20px; }
        .form-tbl th, .form-tbl td { padding: 10px; text-align: left; }
        .form-tbl-col { width: 20%; }
        .form-tbl-caption { font-size: 1.5em; margin-bottom: 10px; display: flex; justify-content: space-between; align-items: center; }
        .form-tbl input, .form-tbl textarea, .form-tbl select { width: 100%; }
        .surv-container { margin: 20px 0; }
        .quest-controls { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; }
        .quest-controls button { margin-left: 10px; }
    </style>
    <script>
        $(document).ready(function() {
            $("#uptSurvBtn").click(function() {
                // 수정 로직 추가
                alert("수정 기능이 호출되었습니다.");
            });

            $("#delSurvBtn").click(function() {
                if (confirm("정말로 이 설문을 삭제하시겠습니까?")) {
                    // 삭제 로직 추가
                    alert("삭제 기능이 호출되었습니다.");
                }
            });

            $("#addQuestRow").click(function() {
                const newRow = `
                <tr>
                    <td style="text-align:center;">
                        <button onclick="delQuest(this);">🗑️</button>
                    </td>
                    <td class="questNo">질문</td>
                    <td>
                        <select name="qustType" onchange="showQuest(this)">
                            <option value="short">단답형</option>
                            <option value="long">장문형</option>
                            <option value="select">드롭다운형</option>
                            <option value="radio">라디오버튼형</option>
                            <option value="check">체크박스형</option>
                        </select>
                    </td>
                    <td class="questContent">
                        <input type="text" placeholder="질문을 입력해주세요">
                    </td>
                </tr>`;
                $("#surv_quests_tbl tbody").append(newRow);
            });
        });

        function delQuest(button) {
            $(button).closest("tr").remove();
        }

        function showQuest(select) {
            const row = $(select).closest("tr");
            const questType = $(select).val();
            const questContent = row.find(".questContent");

            let inputHtml = '';
            if (questType === 'short' || questType === 'long') {
                inputHtml = questType === 'short' ? 
                    '<input type="text" placeholder="질문을 입력해주세요">' : 
                    '<textarea placeholder="질문을 입력해주세요"></textarea>';
            } else {
                inputHtml = `
                <div>
                    <input type="text" placeholder="질문을 입력해주세요">
                    <ol style="list-style-type:decimal" start="1">
                        <li><input name="multi-opt" placeholder="옵션"></li>
                    </ol>
                    <span style="text-decoration:underline; cursor:pointer;" onclick="addOption(this);">옵션추가</span>
                </div>`;
            }
            questContent.html(inputHtml);
        }

        function addOption(span) {
            const ol = $(span).prev("ol");
            const newOption = '<li><input name="multi-opt" placeholder="옵션"></li>';
            ol.append(newOption);
        }
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br></p>
<div class="container">
    <h2>✏️ 설문 수정하기</h2>
    <div class="surv-container">
        <!-- 설문 기본정보 START -->
        <div class="form-table-title-continer">
            <table class="form-tbl">
                <caption class="form-tbl-caption">
                    <span>설문 기본정보</span>
                    <div>
                        <button id="uptSurvBtn">수정하기</button>
                        <button id="delSurvBtn">삭제하기</button>
                    </div>
                </caption>
                <tr>
                    <td class="form-tbl-col">제목</td>
                    <td><input id="survTitle" type="text" placeholder="제목을 입력해주세요(최대30자)" value="${surveyDto.survTitle}"/></td>
                    <td class="form-tbl-col">등록자</td>
                    <td>${surveyDto.memNick}</td>
                </tr>
                <tr>
                    <td class="form-tbl-col">등록일자</td>
                    <td><span id="regDate">${surveyDto.regDate}</span></td>
                    <td class="form-tbl-col">사용여부</td>
                    <td>
                        <select id="useYn">
                            <option value="Y" ${surveyDto.useYn == 'Y' ? 'selected' : ''}>예</option>
                            <option value="N" ${surveyDto.useYn == 'N' ? 'selected' : ''}>아니오</option>
                        </select>
                    </td>
                </tr>
            </table>
        </div>
        <!-- 설문 기본정보 END -->

        <!-- 설문지 소개 START -->
        <div class="form-table-intro-container">
            <table class="form-tbl">
                <caption class="form-tbl-caption">
                    <span>설문지 소개</span>
                </caption>
                <tr>
                    <td class="form-tbl-col">소개</td>
                    <td><textarea id="survDesc" style="width:100%;">${surveyDto.survDesc}</textarea></td>
                </tr>
            </table>
        </div>
        <!-- 설문지 소개 END -->

        <!-- 설문지 질문 START -->
        <div>
            <table id="surv_quests_tbl" class="form-tbl">
                <caption class="form-tbl-caption">
                    <span>설문지 질문</span>
                    <button id="addQuestRow">추가</button>
                </caption>
                <thead>
                    <tr>
                        <th class="form-tbl-col"></th>
                        <th class="form-tbl-col">질문번호</th>
                        <th class="form-tbl-col">질문유형</th>
                        <th class="form-tbl-col">질문내용</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="qust" items="${surveyDto.survqustList}">
                        <tr>
                            <td style="text-align:center;">
                                <button onclick="delQuest(this);">🗑️</button>
                            </td>
                            <td class="questNo">질문${qust.qustSeq}</td>
                            <td>
                                <select name="qustType" onchange="showQuest(this)">
                                    <option value="short" ${qust.qustType == 'short' ? 'selected' : ''}>단답형</option>
                                    <option value="long" ${qust.qustType == 'long' ? 'selected' : ''}>장문형</option>
                                    <option value="select" ${qust.qustType == 'select' ? 'selected' : ''}>드롭다운형</option>
                                    <option value="radio" ${qust.qustType == 'radio' ? 'selected' : ''}>라디오버튼형</option>
                                    <option value="check" ${qust.qustType == 'check' ? 'selected' : ''}>체크박스형</option>
                                </select>
                            </td>
                            <td class="questContent">
                                <c:choose>
                                    <c:when test="${qust.qustType == 'short'}">
                                        <input type="text" value="${qust.qustCont}" placeholder="질문을 입력해주세요">
                                    </c:when>
                                    <c:when test="${qust.qustType == 'long'}">
                                        <textarea placeholder="질문을 입력해주세요">${qust.qustCont}</textarea>
                                    </c:when>
                                    <c:otherwise>
                                        <div>
                                            <input type="text" value="${qust.qustCont}" placeholder="질문을 입력해주세요">
                                            <ol style="list-style-type:decimal" start="1">
                                                <c:forEach var="opt" items="${qust.qustoptList}">
                                                    <li><input name="multi-opt" value="${opt.optCont}" placeholder="옵션"></li>
                                                </c:forEach>
                                            </ol>
                                            <span style="text-decoration:underline; cursor:pointer;" onclick="addOption(this);">옵션추가</span>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <!-- 설문지 질문 END -->
    </div>
</div>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>

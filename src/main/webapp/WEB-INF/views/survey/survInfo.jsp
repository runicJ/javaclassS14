<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
    <title>설문 상세</title>
    <style>
        h2 {
            margin: 20px 0;
        }
        .table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #6C757D;
            color: white;
        }
        .survtitle, .regdate, .moddate {
            text-align: left;
        }
        .survdesc {
            overflow: auto;
            max-height: 100px;
        }
        button {
            appearance: none;
            margin: 10px;
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
        let memId = /*[[${memId}]]*/ null;
        let survNo = /*[[${survey.survNo}]]*/ null;
        let currentPage = /*[[${pagination.currentPage}]]*/ 1;
        let pageSize = /*[[${pagination.pageSize}]]*/ 10;
        let cntPerPage = /*[[${pagination.cntPerPage}]]*/ 10;
        let srchTyp = /*[[${pagination.srchTyp}]]*/ null;
        let keyword = /*[[${pagination.keyword}]]*/ null;

        function resForm() {

            $.ajax({
                type: 'post',
                url: '/checkRes',
                data: {
                    "memId": memId,
                    "survNo": survNo
                },
                success: function(cnt) {
                    if (cnt != 0) {
                        alert("이미 응답한 설문입니다.");
                    } else {
                        let url = "/resForm";
                        url += "?survNo=" + survNo;
                        url += "&currentPage=" + currentPage;
                        url += "&cntPerPage=" + cntPerPage;
                        url += "&pageSize=" + pageSize;
                        url += "&srchTyp=" + srchTyp;
                        url += "&keyword=" + keyword;
                        location.href = url;
                    }
                },
                error: function() {
                    alert("에러입니다");
                }
            });
        }

        function goList() {
            let url = "/survList";
            url += "?currentPage=" + currentPage;
            url += "&cntPerPage=" + cntPerPage;
            url += "&pageSize=" + pageSize;
            url += "&srchTyp=" + srchTyp;
            url += "&keyword=" + keyword;
            location.href = url;
        }
    </script>
</head>
<body>
    <div class="body">
        <h2>👀 설문 상세</h2>
        <br>

        <div class="table">
            <table id="survInfo">
                <tr>
                    <th>설문 제목</th>
                    <td colspan="3" class="survtitle" th:text="${survey.survTitle}"></td>
                </tr>
                <tr>
                    <th>등록자</th>
                    <td colspan="3" class="survtitle" th:text="${survey.memNick}"></td>
                </tr>
                <tr>
                    <th>등록 날짜</th>
                    <td class="regdate" th:text="${#dates.format(survey.regDate, 'yyyy-MM-dd HH:mm')}"></td>
                    <th>수정 날짜</th>
                    <td class="moddate" th:text="${#dates.format(survey.modDate, 'yyyy-MM-dd HH:mm')}"></td>
                </tr>
                <tr>
                    <th colspan="4">설문 설명</th>
                </tr>
                <tr>
                    <td colspan="4" th:if="${survey.survDesc != null}">
                        <div class="survdesc">
                            <span th:utext="${survey.survDesc}"></span>
                        </div>
                    </td>
                    <td colspan="4" class="descNull" th:unless="${survey.survDesc != null}">[설문 설명 없음]</td>
                </tr>
            </table>
        </div>
        <div id="btn">
            <button onclick="resForm()">응답 하기</button>
            <button onclick="goList()">목록 보기</button>
        </div>
    </div>
</body>
</html>

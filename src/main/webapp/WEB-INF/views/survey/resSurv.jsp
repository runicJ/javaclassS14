<html lang="ko"
      xmlns="http://www.w3.org/1999/xhtml"
      xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
      layout:decorate="~{layout/main_layout}">
    <head>
        <link rel="stylesheet" type="text/css" href="./css/survForm.css">
        <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
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
        <script type="text/javascript" th:inline="javascript">
            const url = "/survList?currentPage=" + /*[[${currentPage}]]*/ 1
                        + "&cntPerPage=" + /*[[${cntPerPage}]]*/ 10
                        + "&pageSize=" + /*[[${pageSize}]]*/ 10
                        + "&keyword=" + /*[[${keyword}]]*/ ""
                        + "&srchTyp=" + /*[[${srchTyp}]]*/ "";

            function response() {
                const memId = $("#memId").val();
                const qustList = /*[[${surveyDto.survqustList}]]*/ null;
                let empty = false;

                const answerList = qustList.map(qust => {
                    const answerObj = {
                        qustNo: qust.qustNo,
                        memId: memId,
                        answCont: "",
                        answLong: ""
                    };

                    if (qust.qustType === "long") {
                        const answLong = document.getElementById(qust.qustNo).value.trim();
                        if (!answLong) empty = true;
                        answerObj.answLong = answLong;
                    } else if (["check", "radio"].includes(qust.qustType)) {
                        const checkedOptions = [...document.getElementsByName(qust.qustNo)].filter(opt => opt.checked);
                        if (checkedOptions.length === 0) empty = true;
                        checkedOptions.forEach(opt => {
                            answerList.push({ ...answerObj, answCont: opt.value });
                        });
                        return null; // Skip adding original answerObj
                    } else if (qust.qustType === "short") {
                        const answCont = document.getElementById(qust.qustNo).value.trim();
                        if (!answCont) empty = true;
                        answerObj.answCont = answCont;
                    } else if (qust.qustType === "select") {
                        answerObj.answCont = document.getElementById(qust.qustNo).value;
                    }

                    return answerObj;
                }).filter(Boolean); // Remove nulls

                if (empty) {
                    alert("모든 문항에 응답 바랍니다.");
                    return;
                }

                const header = $("meta[name='_csrf_header']").attr('content');
                const token = $("meta[name='_csrf']").attr('content');

                $.ajax({
                    url: "/resSurv",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ answerList }),
                    beforeSend: xhr => xhr.setRequestHeader(header, token),
                    success: () => {
                        alert('등록 완료');
                        location.href = url;
                    },
                    error: e => {
                        alert("등록 실패!!");
                        console.log(e);
                    }
                });
            }

            function backList() {
                location.href = url;
            }
        </script>
    </head>
    <th:block layout:fragment="contents">
        <body>
            <h2>📝 설문 응답하기</h2>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" id="memId" th:value="${memId}"/>
            <div class="surv-container">
                <!-- 설문 기본정보 START -->
                <div class="form-table-title-container">
                    <table class="form-tbl">
                        <tr>
                            <td class="form-tbl-col">제목</td>
                            <td th:text="${surveyDto.survTitle}"></td>
                        </tr>
                        <tr>
                            <td class="form-tbl-col">등록자</td>
                            <td th:text="${surveyDto.memNick}"></td>
                        </tr>
                    </table>
                </div>
                <!-- 설문 기본정보 END -->

                <!-- 설문지 소개 START -->
                <div class="form-table-intro-container">
                    <table class="form-tbl">
                        <tr>
                            <td class="form-tbl-col">소개</td>
                            <td id="survDesc" th:utext="${surveyDto.survDesc}"></td>
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
                        <tr th:each="qust : ${surveyDto.survqustList}">
                            <td th:switch="${qust.qustType}">
                                <!-- 단답형 -->
                                <div th:case="'short'" class="surv_opt_box">
                                    <span>📌 </span><span th:text="${qust.qustCont}"></span>
                                    <br/><br/>
                                    <input th:id="${qust.qustNo}" size="137"/>
                                </div>
                                <!-- 장문형 -->
                                <div th:case="'long'" class="surv_opt_box">
                                    <span>📌 </span><span th:text="${qust.qustCont}"></span>
                                    <br/><br/>
                                    <textarea th:id="${qust.qustNo}" cols="140" rows="7" style="resize:none"></textarea>
                                </div>
                                <!-- 셀렉트형 -->
                                <div th:case="'select'" class="surv_opt_box">
                                    <span>📌 </span><span th:text="${qust.qustCont}"></span>
                                    <br/><br/>
                                    <select th:id="${qust.qustNo}">
                                        <option th:each="opt : ${qust.qustoptList}" th:value="${opt.optCont}" th:utext="${opt.optCont}"></option>
                                    </select>
                                </div>
                                <!-- 라디오 -->
                                <div th:case="'radio'" class="surv_opt_box">
                                    <span>📌 </span><span th:text="${qust.qustCont}"></span>
                                    <br/><br/>
                                    <th:block th:each="opt : ${qust.qustoptList}">
                                        <input type="radio" th:name="${qust.qustNo}" th:value="${opt.optCont}" th:utext="${opt.optCont}"/> <br/>
                                    </th:block>
                                </div>
                                <!-- 체크박스 -->
                                <div th:case="'check'" class="surv_opt_box">
                                    <span>📌 </span><span th:text="${qust.qustCont}"></span>
                                    <br/><br/>
                                    <th:block th:each="opt : ${qust.qustoptList}">
                                        <input type="checkbox" th:name="${qust.qustNo}" th:value="${opt.optCont}" th:utext="${opt.optCont}"/> <br/>
                                    </th:block>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <!-- 설문지 질문 END -->
            </div>
            <br/>
            <button onclick="response()">제출하기</button>
            <button onclick="backList()">목록 보기</button>
        </body>
    </th:block>
</html>

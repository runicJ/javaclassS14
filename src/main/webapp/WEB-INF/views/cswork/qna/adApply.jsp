<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>adApply</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
  	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
    <style>
        /* 기본 스타일 */
        body {
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }
        
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        
        .popup {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
            overflow: hidden;
            transition: all 0.3s ease-in-out;
        }

        .popHead {
            background-color: #FF4500;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .popHead h3 {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
        }

        .popCont {
            padding: 20px;
        }

        .section {
            margin-bottom: 30px;
        }

        .section h4 {
            font-size: 18px;
            color: #333;
            margin-bottom: 15px;
            border-bottom: 2px solid #FF4500;
            display: inline-block;
            padding-bottom: 5px;
        }

        .noti {
            font-size: 14px;
            color: #888;
            margin-bottom: 10px;
        }

        .tblWrap table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 10px;
        }

        .tblWrap th, .tblWrap td {
            padding: 10px;
            text-align: left;
            vertical-align: top;
            border-bottom: 1px solid #ddd;
        }

        .tblWrap th {
            width: 200px;
            color: #555;
            font-weight: normal;
        }

        .tblWrap td {
            color: #666;
        }

        .tblWrap input[type="text"], .tblWrap textarea, .tblWrap input[type="file"] {
            width: calc(100% - 20px);
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ddd;
            transition: border-color 0.3s ease;
            outline: none;
        }

        .tblWrap input[type="text"]:focus, .tblWrap textarea:focus, .tblWrap input[type="file"]:focus {
            border-color: #FF4500;
        }

        .tblWrap .selectbox {
            position: relative;
        }

        .tblWrap .selectbox p {
            background-color: #fff;
            cursor: pointer;
            padding: 8px;
            margin: 0;
            border-radius: 4px;
            border: 1px solid #ddd;
            transition: border-color 0.3s ease;
        }

        .tblWrap .selectbox:hover p {
            border-color: #FF4500;
        }

        .tblWrap .selectbox ul {
            position: absolute;
            background-color: #fff;
            width: 100%;
            max-height: 200px;
            overflow-y: auto;
            border-radius: 4px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: none;
            z-index: 10;
        }

        .tblWrap .selectbox ul li {
            padding: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .tblWrap .selectbox ul li:hover {
            background-color: #f0f0f0;
        }

        .tblWrap .selectbox ul li:active {
            background-color: #ddd;
        }

        .tblWrap .selectbox.active ul {
            display: block;
        }

        .private {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 4px;
            border: 1px solid #ddd;
            font-size: 14px;
            color: #555;
        }

        .btnGroup {
            text-align: center;
        }

        .btnGroup .btn {
            background-color: #FF4500;
            color: #fff;
            padding: 10px 20px;
            margin: 5px;
            border-radius: 4px;
            text-decoration: none;
            transition: background-color 0.3s ease;
            display: inline-block;
        }

        .btnGroup .btn:hover {
            background-color: #e63946;
        }

        .btnGroup .btn.btnBdr4 {
            background-color: transparent;
            color: #FF4500;
            border: 2px solid #FF4500;
        }

        .btnGroup .btn.btnBdr4:hover {
            background-color: #FF4500;
            color: #fff;
        }

        .agree {
            margin-top: 20px;
            padding: 10px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            display: flex;
            align-items: center;
            font-size: 14px;
            color: #555;
        }

        .agree span {
            display: flex;
            align-items: center;
        }

        .agree i {
            width: 20px;
            height: 20px;
            border: 2px solid #FF4500;
            border-radius: 50%;
            margin-right: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: background-color 0.3s ease;
        }

        .agree.checked i {
            background-color: #FF4500;
        }

        .agree.checked i::before {
            content: '✔';
            color: white;
            font-size: 12px;
        }
    </style>
    <script>
        // 이메일 입력 관련 함수
        function NewEmailChecker(domain) {
            const emailInput = document.getElementById('selfemail');
            const emailServiceInput = document.getElementById('txEmail2');
            const emailFullInput = document.getElementById('email');
            
            if (domain === 'etc') {
                emailInput.style.display = 'inline-block';
                emailServiceInput.value = '';
                emailFullInput.value = '';
            } else {
                emailInput.style.display = 'none';
                emailServiceInput.value = domain;
                emailFullInput.value = emailServiceInput.previousElementSibling.value + domain;
            }
        }

        // 폼 체크
        function checkForm(form) {
            // 필수 입력 필드 체크
            const requiredFields = ['companyname', 'address', 'chargename', 'txEmail1', 'hp1', 'hp2', 'hp3'];
            for (let field of requiredFields) {
                if (!form[field].value.trim()) {
                    alert('필수 입력 필드를 모두 채워주세요.');
                    form[field].focus();
                    return false;
                }
            }
            if (document.getElementById('agreechk').value !== '1') {
                alert('개인정보 수집 및 이용에 동의해주세요.');
                return false;
            }
            form.submit();
        }

        // 폼 리셋
        function resetForm(form) {
            form.reset();
            document.getElementById('agreechk').value = '0';
            document.querySelector('.agree').classList.remove('checked');
            return false;
        }

        // 개인정보 수집 동의 체크
        function fnagreechk() {
            const agreeCheckbox = document.getElementById('agreechk');
            agreeCheckbox.value = agreeCheckbox.value === '0' ? '1' : '0';
            document.querySelector('.agree').classList.toggle('checked');
        }

        // 파일 체크
        function CheckFile(input) {
            const allowedExtensions = ['gif', 'jpeg', 'png', 'zip'];
            const fileExtension = input.value.split('.').pop().toLowerCase();
            if (!allowedExtensions.includes(fileExtension)) {
                alert('유효한 파일 형식이 아닙니다. GIF, JPEG, PNG, ZIP 파일만 첨부 가능합니다.');
                input.value = '';
                return false;
            }
            return true;
        }

        // 셀렉트 박스 토글
        document.addEventListener('click', function(e) {
            const selectBox = e.target.closest('.selectbox');
            if (selectBox) {
                selectBox.classList.toggle('active');
            } else {
                document.querySelectorAll('.selectbox.active').forEach(box => box.classList.remove('active'));
            }
        });

    </script>
</head>
<body>
    <section class="page">
        <div class="container">
            <div class="popup partner alliance">
                <div class="popHead">
                    <h3>제휴/광고 제안</h3>
                </div>

                <div class="popCont">
                    <form name="frmInquiry" method="POST" action="https://upload.10x10.co.kr/linkweb/company/docorequest.asp" enctype="multipart/form-data">
                        <input type="hidden" name="mode" value="write">
                        <input type="hidden" name="reqcd" value="02">

                        <!-- 회사 정보 -->
                        <div class="section">
                            <h4>회사 정보</h4>
                            <p class="noti">* 표시는 필수 입력정보입니다</p>
                            <div class="tblWrap">
                                <table>
                                    <caption>회사 정보 입력</caption>
                                    <colgroup>
                                        <col style="width:200px;"> <col style="width:*;">
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th>제휴 종류 <span class="essential">*</span></th>
                                            <td>
                                                <ul class="formList">
                                                    <li><input type="radio" id="kind1" name="sellgubun" value="1" checked="checked"> <label for="kind1">공급 제휴</label></li>
                                                    <li><input type="radio" id="kind2" name="sellgubun" value="2"> <label for="kind2">컨텐츠 제휴</label></li>
                                                    <li><input type="radio" id="kind3" name="sellgubun" value="3"> <label for="kind3">공동마케팅 및 프로모션 제휴</label></li>
                                                    <li><input type="radio" id="kind4" name="sellgubun" value="4"> <label for="kind4">문화 이벤트 제휴</label></li>
                                                    <li><input type="radio" id="kind5" name="sellgubun" value="5"> <label for="kind5">기술 및 솔루션 관련 제휴</label></li>
                                                    <li><input type="radio" id="kind6" name="sellgubun" value="6"> <label for="kind6">광고 문의</label></li>
                                                </ul>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><label for="compName">회사명</label> <span class="essential">*</span></th>
                                            <td><input type="text" id="compName" name="companyname" class="txtInp" style="width:370px;" placeholder="예) 괄호 안 쉼표"></td>
                                        </tr>
                                        <tr>
                                            <th><label for="compAddr">회사 주소</label> <span class="essential">*</span></th>
                                            <td><input type="text" id="compAddr" name="address" class="txtInp" style="width:370px;" placeholder="예) 충청북도 청주시 서원구 사직대로 109, 4,5층"></td>
                                        </tr>
                                        <tr>
                                            <th><label for="compUrl">회사 페이지 URL</label></th>
                                            <td><input type="text" id="compUrl" name="companyurl" class="txtInp" style="width:370px;" placeholder="예) http://49.142.159.251:9090/javaclassS14/main"></td>
                                        </tr>
                                        <tr>
                                            <th><label for="compIntro">회사소개서</label></th>
                                            <td>
                                                <input type="file" id="compIntro" name="attachfile2" onblur="return CheckFile(this);" class="txtInp" style="width:370px;">
                                                <p class="tip">*참고할 수 있는 파일을 1MB 용량 이하의  GIF, JPEG, PNG, ZIP 파일형태로 첨부해주세요.</p>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!--// 회사 정보 -->

                        <!-- 제휴/광고 내용 -->
                        <div class="section">
                            <h4>제휴/광고 내용</h4>
                            <div class="tblWrap">
                                <table>
                                    <caption>제휴/광고 내용 입력</caption>
                                    <colgroup>
                                        <col style="width:205px;"> <col style="width:*;">
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th style="padding-top:0;"><label for="suggest">광고 및 제휴 <span class="essential">*</span><br>제안 내용</label></th>
                                            <td>
                                                <input type="file" id="suggest" name="attachfile" onblur="return CheckFile(this);" class="txtInp" style="width:370px;">
                                                <p class="tip">*참고할 수 있는 파일을 1MB 용량 이하의  GIF, JPEG, PNG, ZIP 파일형태로 첨부해주세요.</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><label for="comment">기타 코멘트</label></th>
                                            <td>
                                                <textarea cols="30" rows="8" id="comment" name="companycomments" maxlength="300" class="txtInp" style="height:168px;"></textarea>
                                                <p class="count" id="counter">0/300</p>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!--// 제휴/광고 내용 -->

                        <!-- 담당자 정보 -->
                        <div class="section">
                            <h4>담당자 정보</h4>
                            <div class="tblWrap">
                                <table>
                                    <caption>담당자 정보 입력</caption>
                                    <colgroup>
                                        <col style="width:205px;"> <col style="width:*;">
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th><label for="chName">담당자 명</label> <span class="essential">*</span></th>
                                            <td><input type="text" id="chName" name="chargename" class="txtInp" style="width:370px;" placeholder="홍길동"></td>
                                        </tr>
                                        <tr>
                                            <th><label for="chMail">이메일 주소 <span class="essential">*</span></label></th>
                                            <td>
                                                <input type="text" id="chMail" name="txEmail1" class="txtInp" onkeydown="keyCodeCheckEmail(event);" onkeyup="jsChkEmail();" onclick="jsChkEmail();" style="width:175px;" placeholder="tentenkim" maxlength="32">
                                                <span class="pad">@</span>
                                                <input type="text" name="selfemail" id="selfemail" title="이메일 직접 입력" maxlength="48" class="txtInp" style="display:none; width:120px;ime-mode:disabled;" onkeydown="keyCodeCheckEmail(event);" onkeyup="jsChkEmail();" onblur="DuplicateEmailCheck();" onclick="jsChkEmail();">
                                                <div class="selectbox" style="width:160px;">
                                                    <input type="hidden" id="txEmail2" name="txEmail2" value="">
                                                    <input type="hidden" id="email" name="email" value="">
                                                    <p>이메일 서비스 선택</p>
                                                    <ul>
                                                        <li onclick="NewEmailChecker('@hanmail.net');">hanmail.net</li>
                                                        <li onclick="NewEmailChecker('@naver.com');">naver.com</li>
                                                        <li onclick="NewEmailChecker('@nate.com');">nate.com</li>
                                                        <li onclick="NewEmailChecker('@gmail.com');">gmail.com</li>
                                                        <li onclick="NewEmailChecker('@hotmail.com');">hotmail.com</li>
                                                        <li onclick="NewEmailChecker('@yahoo.co.kr');">yahoo.co.kr</li>
                                                        <li onclick="NewEmailChecker('@hanmir.com');">hanmir.com</li>
                                                        <li onclick="NewEmailChecker('@korea.com');">korea.com</li>
                                                        <li onclick="NewEmailChecker('@lycos.co.kr');">lycos.co.kr</li>
                                                        <li onclick="NewEmailChecker('@dreamwiz.com');">dreamwiz.com</li>
                                                        <li onclick="NewEmailChecker('@empal.com');">empal.com</li>
                                                        <li onclick="NewEmailChecker('@netian.com');">netian.com</li>
                                                        <li onclick="NewEmailChecker('@freechal.com');">freechal.com</li>
                                                        <li onclick="NewEmailChecker('@paran.com');">paran.com</li>
                                                        <li onclick="NewEmailChecker('etc');">직접입력</li>
                                                    </ul>
                                                </div>
                                                <p class="tip" id="checkMsgEmail"></p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>연락처 <span class="essential">*</span></th>
                                            <td>
                                                <div class="selectbox" style="width:80px;">
                                                    <input type="hidden" value="" name="hp1" id="hp1">
                                                    <p>선택</p>
                                                    <ul>
                                                        <li onclick="fnhpnb('010');">010</li>
                                                    </ul>
                                                </div>
                                                <span class="pad">-</span>
                                                <input type="text" class="txtInp" name="hp2" maxlength="4" style="width:80px;" placeholder="1234">
                                                <span class="pad">-</span>
                                                <input type="text" class="txtInp" name="hp3" maxlength="4" style="width:80px;" placeholder="5678">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!--// 담당자 정보 -->

                        <!-- 개인정보 수집 및 이용 동의 -->
                        <div class="section">
                            <h4>개인정보 수집 및 이용 동의</h4>
                            <div class="private">
                                <p>사업제휴 광고문의를 위한 정보수집 및 이용동의<br><br>{ , }(이하 “회사”라 함)는 개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 관련 법령상의 개인정보보호 규정을 준수하며, 파트너의 개인정보 보호에 최선을 다하고 있습니다.</p>
                                <p></p>
                                <ol>
                                    <li>1.&nbsp;개인정보 수집 및 이용주체<br>제휴문의 및 상담신청을 통해 제공하신 정보는 “회사”가 직접 접수하고 관리합니다.</li>
                                    <li>2. 동의를 거부할 권리 및 동의 거부에 따른 불이익<br>신청자는 개인정보제공 등에 관해 동의하지 않을 권리가 있습니다.(이 경우 제휴문의 및 상담신청이 불가능합니다.)</li>
                                    <li>3. 수집하는 개인정보 항목<br>필수항목: 담당자명, 담당자 이메일 주소, 담당자 휴대전화번호<br>선택항목: 담당자 전화번호</li>
                                    <li>4. 수집 및 이용목적<br>제휴사 검토, 제휴사 관리시스템의 운용, 공지사항의 전달 등</li>
                                    <li>5. 보유기간 및 이용기간<br>수집된 정보는 <span style="text-decoration: underline;font-weight: bold;">등록 시점으로 부터 1년간</span> 보관됩니다.</li>
                                </ol>
                            </div>
                            <input type="hidden" name="agreechk" value="0" id="agreechk">
                            <p class="agree" onclick="fnagreechk();"><span><i></i>사업제휴 광고문의를 위한 개인정보 수집에 동의합니다</span></p>
                        </div>
                        <!--// 개인정보 수집 및 이용 동의 -->
                        <div class="btnGroup">
                            <a href="" onclick="checkForm(frmInquiry); return false;" class="btn btnM btnRed">제휴/광고 제안</a>
                            <a href="" onclick="resetForm(frmInquiry); return false;" class="btn btnM btnBdr4">취소</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
<p><br/></p>
</body>
</html>
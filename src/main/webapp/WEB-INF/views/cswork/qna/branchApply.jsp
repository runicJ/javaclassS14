<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Branch Apply</title>
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />

    <!-- Adding CSS for styling -->
    <style>
        body {
            background-color: #f9f9f9;
            font-family: Arial, sans-serif;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 800px;
            margin: 30px auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .popHead {
            text-align: center;
            margin-bottom: 20px;
        }

        .popHead h3 {
            margin: 0;
            font-size: 1.8em;
            color: #555;
        }

        .section {
            margin-bottom: 20px;
        }

        .section h4 {
            font-size: 1.4em;
            color: #444;
            border-bottom: 2px solid #f1f1f1;
            padding-bottom: 5px;
            margin-bottom: 10px;
        }

        .tblWrap table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 10px;
        }

        .tblWrap th, .tblWrap td {
            padding: 8px 10px;
            border-bottom: 1px solid #f1f1f1;
        }

        .tblWrap th {
            width: 200px;
            text-align: left;
            vertical-align: top;
        }

        .txtInp {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            transition: border-color 0.3s;
        }

        .txtInp:focus {
            border-color: #007BFF;
        }

        .formList {
            list-style: none;
            padding: 0;
        }

        .formList li {
            margin-bottom: 5px;
        }

        .formList input {
            margin-right: 8px;
        }

        .formList label {
            font-weight: normal;
            cursor: pointer;
        }

        .tip {
            font-size: 0.85em;
            color: #888;
            margin-top: 4px;
        }

        .agree {
            margin-top: 20px;
            cursor: pointer;
            display: flex;
            align-items: center;
        }

        .agree span {
            display: flex;
            align-items: center;
        }

        .agree i {
            display: inline-block;
            width: 16px;
            height: 16px;
            border: 1px solid #ddd;
            margin-right: 8px;
            position: relative;
        }

        .btnGroup {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 1em;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
        }

        .btnRed {
            background-color: #d9534f;
            color: #fff;
            border: 1px solid #d9534f;
        }

        .btnRed:hover {
            background-color: #c9302c;
        }

        .btnBdr4 {
            background-color: #f9f9f9;
            color: #555;
            border: 1px solid #ddd;
        }

        .btnBdr4:hover {
            background-color: #eee;
        }

        .count {
            font-size: 0.9em;
            text-align: right;
            color: #777;
            margin-top: 4px;
        }
    </style>

    <!-- Adding JavaScript for interactions -->
    <script>
        function CheckFile(input) {
            const allowedExtensions = ['gif', 'jpeg', 'jpg', 'png', 'zip'];
            const fileExtension = input.value.split('.').pop().toLowerCase();
            if (!allowedExtensions.includes(fileExtension)) {
                alert('유효한 파일 형식이 아닙니다. GIF, JPEG, PNG, ZIP 파일만 첨부 가능합니다.');
                input.value = '';
                return false;
            }
            return true;
        }

        function fnagreechk() {
            const agreechk = document.getElementById('agreechk');
            if (agreechk.value === '0') {
                agreechk.value = '1';
                document.querySelector('.agree i').style.backgroundColor = '#d9534f';
            } else {
                agreechk.value = '0';
                document.querySelector('.agree i').style.backgroundColor = '#fff';
            }
        }
    </script>
</head>
<body>
<p><br></p>
<section class="page">
<div class="container">
<!--  입점 신청 등록-->
<div class="popup partner store step2">
    <div class="popHead">
        <h3>입점 신청 등록</h3>
    </div>
    <div class="popCont">
        <div class="inner">
        <form name="frmInquiry" method="POST" action="https://upload.10x10.co.kr/linkweb/company/docorequest.asp" enctype="multipart/form-data">
        <input type="hidden" name="mode" value="write">
        <input type="hidden" name="reqcd" value="01">
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
                                <th><label for="compName">회사명 <span class="essential">*</span></label></th>
                                <td><input type="text" name="companyname" maxlength="64" id="compName" class="txtInp" placeholder="(주)텐바이텐"></td>
                            </tr>
                            <tr>
                                <th><label for="compNum">사업자 등록번호 <span class="essential">*</span></label></th>
                                <td>
                                    <input type="hidden" name="license_no" id="license_no">
                                    <input type="text" name="license_no1" id="license_no1" maxlength="3" class="txtInp" style="width:88px;" placeholder="123">
                                    <span class="pad">-</span>
                                    <input type="text" class="txtInp" name="license_no2" id="license_no2" maxlength="2" style="width:86px;" placeholder="45">
                                    <span class="pad">-</span>
                                    <input type="text" class="txtInp" name="license_no3" id="license_no3" maxlength="5" style="width:88px;" placeholder="67890">
                                </td>
                            </tr>
                            <tr>
                                <th style="padding-top:0;"><label for="compUrl">홈페이지/<br>판매처 URL</label></th>
                                <td><input type="text" id="compUrl" name="companyurl" maxlength="64" class="txtInp" placeholder=" 예) http://www.10x10.co.kr"></td>
                            </tr>
                            <tr>
                                <th><label for="compIntro">회사소개 <span class="essential">*</span></label></th>
                                <td>
                                    <textarea cols="30" rows="8" name="companycomments" id="compIntro" class="txtInp" maxlength="300" style="height:168px;" placeholder="참고할 수 있는 회사에 대한 소개를 300자 이내로 입력해주세요"></textarea>
                                    <p class="count" id="counter1">0/300</p>
                                </td>
                            </tr>
                        </tbody></table>
                </div>
            </div>
            <!--// 회사 정보 -->

            <!-- 상품 정보 -->
            <div class="section">
                <h4>상품 정보</h4>
                <div class="tblWrap">
                    <table>
                        <caption>상품 정보 입력</caption>
                        <colgroup>
                            <col style="width:200px;"> <col style="width:*;">
                        </colgroup>
                        <tbody><tr>
                            <th><label for="brdName">상품 브랜드명 <span class="essential">*</span></label></th>
                            <td><input type="text" name="reqcomment1" maxlength="30" id="brdName" class="txtInp" placeholder="예) 텐바이텐 문구 (15자 이내)"></td>
                        </tr>
                        <tr>
                            <th><label for="ct1" id="catecode_a">대표 카테고리 <span class="essential">*</span></label></th>
                            <td>
                                <select class="formList">
                                    <option name="catecode_a" id="ct1" value="101">자인문구</option>
                                    <option name="catecode_a" id="ct2" value="102">지털/핸드폰</option>
                                    <option name="catecode_a" id="ct3" value="103">핑</option>
                                    <option name="catecode_a" id="ct4" value="104">이/취미</option>
                                    <option name="catecode_a" id="ct5" value="124">자인가전</option>
                                    <option name="catecode_a" id="ct6" value="121">구/수납</option>
                                    <option name="catecode_a" id="ct7" value="122">코/조명</option>
                                    <option name="catecode_a" id="ct8" value="120">브릭/생활</option>
                                    <option name="catecode_a" id="ct9" value="112">친</option>
                                    <option name="catecode_a" id="ct10" value="119">푸드</option>
                                    <option name="catecode_a" id="ct11" value="117">패션의류</option>
                                    <option name="catecode_a" id="ct12" value="116">패션잡화</option>
                                    <option name="catecode_a" id="ct13" value="125">주얼리/시계</option>
                                    <option name="catecode_a" id="ct14" value="118">뷰티</option>
                                    <option name="catecode_a" id="ct15" value="110">Cat &amp; Dog</option>
                                    <option name="catecode_a" id="ct16" value="123">클리어런스</option>
                                </select>
                                <p class="tip">* 상품 분류를 선택해주시면 담당 MD가 1주일 안에 연락드립니다. (한 개의 분류만 선택 가능)</p>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="itemIntro">상품소개 <span class="essential">*</span></label></th>
                            <td>
                                <textarea cols="30" rows="8" id="itemIntro" name="reqcomment3" class="txtInp" style="height:168px;" maxlength="300" placeholder="참고할 수 있는 회사에 대한 소개를 300자 이내로 입력해주세요"></textarea>
                                <p class="count" id="counter2">0/300</p>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="addFile">첨부파일</label></th>
                            <td>
                                <input type="file" id="addFile" name="attachfile" onblur="return CheckFile(this);" class="txtInp">
                                <p class="tip">* 참고할 수 있는 파일을 1MB 용량 이하의  GIF, JPEG, PNG, ZIP 파일형태로 첨부해주세요.<br>첨부 파일 관련 URL주소가 있을 경우 상품소개에 정보를 같이 입력해주세요.</p>
                            </td>
                        </tr>
                        <tr>
                            <th style="padding-top:0;"><label for="ch1" id="sellgubun">입점희망 채널 <span class="essential">*</span></label></th>
                            <td>
                                <ul class="formList">
                                    <li><input type="radio" name="sellgubun" id="ch1" value="Y" checked> <label for="ch1">온·오프라인</label></li>
                                    <li><input type="radio" name="sellgubun" id="ch2" value="N"> <label for="ch2">온라인</label></li>
                                    <li><input type="radio" name="sellgubun" id="ch3" value="F"> <label for="ch3">오프라인</label></li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <th style="padding-top:0;"><label for="sale1" id="reqcomment2">판매 형태 <span class="essential">*</span></label></th>
                            <td>
                                <ul class="formList">
                                    <li><input type="checkbox" id="sale1" name="reqcomment2" value="2"> <label for="sale1">수입</label></li>
                                    <li><input type="checkbox" id="sale2" name="reqcomment2" value="2"> <label for="sale2">제조</label></li>
                                    <li><input type="checkbox" id="sale3" name="reqcomment2" value="1"> <label for="sale3">유통</label></li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="mall">현재 입점몰 <span class="essential">*</span></label></th>
                            <td><input type="text" id="mall" name="manufacturing_name" maxlength="200" class="txtInp" placeholder="예) 텐바이텐, GS  Shop 등 현재 입점몰을 입력해주세요."></td>
                        </tr>
                    </tbody></table>
                </div>
            </div>
            <!--// 상품 정보 -->

            <!-- 담당자 정보 -->
            <div class="section">
                <h4>담당자 정보</h4>
                <div class="tblWrap">
                    <table>
                        <caption>담당자 정보 입력</caption>
                        <colgroup>
                            <col style="width:205px;"> <col style="width:*;">
                        </colgroup>
                        <tbody><tr>
                            <th><label for="chName">담당자 명</label> <span class="essential">*</span></th>
                            <td><input type="text" id="chName" name="chargename" maxlength="64" class="txtInp" placeholder="김텐텐"></td>
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
                                    <select>
                                        <option>naver.com</option>
                                        <option>gmail.com</option>
                                        <option>hanmail.net</option>
                                        <option>직접입력</option>
                                    </select>
                                </div>
                            <p class="tip" id="checkMsgEmail"></p>
                            </td>
                        </tr>
                        <tr>
                            <th>연락처 <span class="essential">*</span></th>
                            <td>
                                <input type="text" class="txtInp" name="hp1" maxlength="4" style="width:80px;" placeholder="010">
                                <span class="pad">-</span>
                                <input type="text" class="txtInp" name="hp2" maxlength="4" style="width:80px;" placeholder="1234">
                                <span class="pad">-</span>
                                <input type="text" class="txtInp" name="hp3" maxlength="4" style="width:80px;" placeholder="5678">
                            </td>
                        </tr>
                    </tbody></table>
                </div>
            </div>
            <!--// 담당자 정보 -->

            <!-- 개인정보 수집 및 이용 동의 -->
            <div class="section">
                <h4>개인정보 수집 및 이용 동의</h4>
                <div class="private">
                    <p>신규입점 문의를 위한 정보수집 및 이용동의<br><br>㈜텐바이텐(이하 “회사”라 함)는 개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 관련 법령상의 개인정보보호 규정을 준수하며, 파트너의 개인정보 보호에 최선을 다하고 있습니다.</p>
                    <p></p>
                    <ol>
                        <li>1.&nbsp;개인정보 수집 및 이용주체<br>입점 신청을 통해 제공하신 정보는 “회사”가 직접 접수하고 관리합니다.</li>
                        <li>2. 동의를 거부할 권리 및 동의 거부에 따른 불이익<br>신청자는 개인정보제공 등에 관해 동의하지 않을 권리가 있습니다.(이 경우 입점신청이 불가능합니다.)</li>
                        <li>3. 수집하는 개인정보 항목<br>필수항목: 담당자명, 담당자 이메일 주소, 담당자 휴대전화번호<br>선택항목: 담당자 전화번호</li>
                        <li>4. 수집 및 이용목적<br>입점 검토, 입점 관리시스템의 운용, 공지사항의 전달 등</li>
                        <li>5. 보유기간 및 이용기간<br>수집된 정보는 <span style="text-decoration: underline;font-weight: bold;">등록 시점으로 부터 1년간</span> 보관됩니다.</li>
                    </ol>
                </div>
                <input type="hidden" name="agreechk" value="0" id="agreechk">
                <p class="agree" onclick="fnagreechk();"><span><i></i>신규입점 제안을 위한 개인정보 수집에 동의합니다</span></p>
            </div>
            <!--// 개인정보 수집 및 이용 동의 -->

            <div class="btnGroup">
                <a href="" onclick="checkForm(frmInquiry); return false;" class="btn btnM btnRed">입점 신청</a>
                <a href="" onclick="resetForm(frmInquiry); return false;" class="btn btnM btnBdr4">취소</a>
            </div>
        </form>
        </div>
    </div>
</div>
</div>
</section>
<p><br></p>
</body>
</html>

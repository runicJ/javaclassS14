<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 탈퇴</title>
    <%@ include file="/WEB-INF/views/include/user/bs4.jsp" %>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
        }
        
        .box {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            transition: 0.3s;
            background-color: #fff;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .box:hover {
            background-color: #fef4db;
        }
        
        .box-body {
            padding: 20px;
        }
        
        .guide {
            list-style: none;
            padding: 0;
            font-size: 0.9em;
        }
        
        .guide li {
            margin-bottom: 10px;
        }
        
        .guide li span {
            font-weight: bold;
            font-size: 1em;
            color: #333;
        }
        
        .mySection {
            margin-top: 30px;
        }
        
        .alert {
            font-size: 0.9em;
            margin-bottom: 20px;
        }
        
        .form-control, select, textarea {
            font-size: 16px;
        }
        
        .text-center {
            text-align: center;
        }
        
        .btn {
            padding: 10px 20px;
            font-size: 16px;
        }
        
        .docForm th {
            text-align: left;
            vertical-align: top;
            padding-top: 10px;
        }
        
        .docForm td {
            padding-bottom: 10px;
        }
    </style>
    <script>
        'use strict';
        
        function deleteCheck() {
            let userPwd = $("#userPwd").val().trim();
            if (userPwd === "") {
                alert("현재 비밀번호를 입력하세요!");
                $("#userPwd").focus();
            } else {
                let ans = confirm("회원 탈퇴 신청을 하시겠습니까?");
                if (ans) {
                    ans = confirm("회원 탈퇴하시면 1개월간 같은 아이디 및 이메일로 가입하실 수 없습니다.\n계속 진행하시겠습니까?");
                    if (ans) myForm.submit();
                }
            }
        }
    </script>
</head>
<body>
    <%@ include file="/WEB-INF/views/include/user/header.jsp" %>
    <%@ include file="/WEB-INF/views/include/user/nav.jsp" %>
    <section class="userDelete" style="padding-top: 245.125px;">
        <div class="container">
            <div class="row">
                <jsp:include page="/WEB-INF/views/include/user/sidebar.jsp" />
                <div class="col-xs-12 col-md-8">
                    <div class="box">
                        <div class="box-body">
                            <div class="titleSection subTitle withdrawal">
                                <h4 class="text-center mb-3">- 회원탈퇴 안내 -</h4>
                                <ol class="guide alert alert-light">
                                    <li><span>1. </span>회원님의 정보는 전자상거래 등에서의 소비자 보호에 관한 법률에 따라 관리됩니다.</li>
                                    <li><span>2. </span>회원님의 쿠폰 및 포인트는 모두 삭제되며 환급은 불가능합니다.</li>
                                    <li><span>3. </span>탈퇴한 아이디 및 이메일은 1개월 동안 사용 불가합니다.</li>
                                    <li><span>4. </span>주문정보 및 게시글은 보관될 수 있습니다.</li>
                                    <li><span>5. </span>회원탈퇴는 신청일 후 7일 이후에 삭제되며, 중간에 접속하시면 취소 가능합니다.</li>
                                </ol>
                            </div>
                            <div class="mySection">
                                <div class="myTopic">
                                    <div class="alert alert-danger">
                                        현재 회원님의 사용가능 마일리지는 <strong>${vo.point}</strong> point 입니다.
                                    </div>
                                </div>
                                <form name="myForm" method="post" action="${ctp}/users/userDelete">
                                    <fieldset>
                                        <table class="baseTable rowTable docForm">
                                            <colgroup>
                                                <col width="140">
                                                <col width="">
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th scope="row" class="ct"><label for="reason01">탈퇴사유</label></th>
                                                    <td>
                                                        <div class="itemField">
                                                            <ul class="row">
                                                                <div class="col-6">
                                                                    <li><input type="radio" name="deleteReason" value="상품품질 불만" id="reason01"> <label for="reason01">상품품질 불만</label></li>
                                                                    <li><input type="radio" name="deleteReason" value="이용빈도 낮음" id="reason02"> <label for="reason02">이용빈도 낮음</label></li>
                                                                    <li><input type="radio" name="deleteReason" value="개인정보유출 우려" id="reason03"> <label for="reason03">개인정보유출 우려</label></li>
                                                                    <li><input type="radio" name="deleteReason" value="배송지연" id="reason04"> <label for="reason04">배송지연</label></li>
                                                                </div>
                                                                <div class="col-6">
                                                                    <li><input type="radio" name="deleteReason" value="교환/환불/품질 불만" id="reason05"> <label for="reason05">교환/환불/품질 불만</label></li>
                                                                    <li><input type="radio" name="deleteReason" value="A/S 불만" id="reason06"> <label for="reason06">A/S 불만</label></li>
                                                                    <li><input type="radio" name="deleteReason" value="기타" id="reason07"> <label for="reason07">기타</label></li>
                                                                </div>
                                                            </ul>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row" class="ct"><label for="wdEtc">기타</label></th>
                                                    <td>
                                                        <textarea id="wdEtc" name="deleteReason" cols="60" rows="5" placeholder="기타 불편사항 및 사이트에 대한 회원님의 충고를 부탁 드립니다."></textarea>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </fieldset>

                                    <h5 class="text-center">- 본인확인 -</h5>
                                    <fieldset>
                                        <table class="baseTable rowTable docForm">
                                            <colgroup>
                                                <col width="140">
                                                <col width="">
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th scope="row" class="ct mb-2">아이디</th>
                                                    <td><strong>${vo.userId}</strong></td>
                                                </tr>
                                                <tr>
                                                    <th scope="row" class="fw"><label for="inpPw">비밀번호</label></th>
                                                    <td>
                                                        <input type="password" name="userPwd" id="userPwd" class="form-control mb-2">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row" class="ct"><label for="certificate">본인확인</label></th>
                                                    <td>
                                                        <div class="form-group">
                                                            <div class="input-group">
                                                                <input type="text" id="email1" name="email1" class="form-control mr-2" placeholder="이메일 주소를 입력하세요." required />
                                                                <span>@</span>
                                                                <select id="email2" name="email2" class="ml-2" style="width:120px;">
                                                                    <option value="naver.com" selected>naver.com</option>
                                                                    <option value="gmail.com">gmail.com</option>
                                                                    <option value="daum.net">daum.net</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </fieldset>
                                    <div class="text-center mt-5">
                                        <input type="button" onclick="deleteCheck();" class="btn btn-danger mr-3" value="탈퇴하기">
                                        <input type="button" onclick="location.href='${ctp}/users/userMain';" value="취소하기" class="btn btn-warning">
                                    </div>
                                    <input type="hidden" name="userId" value="${vo.userId}" />
                                    <input type="hidden" name="email" value="${vo.email}" />
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <p><br /></p>
    <%@ include file="/WEB-INF/views/include/user/footer.jsp" %>
</body>
</html>

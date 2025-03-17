<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order</title>
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <link rel="stylesheet" href="${ctp}/css/shop/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/nice-select.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/style.css" type="text/css">
    <jsp:include page="/WEB-INF/views/include/user/bs4.jsp"/>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="${ctp}/js/woo.js"></script>
    <script>
        $(document).ready(function(){
            $(".nav-tabs a").click(function(){
                $(this).tab('show');
            });
            $('.nav-tabs a').on('shown.bs.tab', function(event){
                var x = $(event.target).text();         // active tab
                var y = $(event.relatedTarget).text();  // previous tab
            });
        });

     	// 결제하기 버튼 클릭 시 주소 입력 검증 및 결제 처리
        function payment() {
            // 주소 입력 필드 값 가져오기
            var postcode = document.getElementById("sample6_postcode").value;
            var roadAddress = document.getElementById("sample6_address").value;
            var detailAddress = document.getElementById("sample6_detailAddress").value;
            var extraAddress = document.getElementById("sample6_extraAddress").value;

            // 주소 입력 여부 검증
            if (!postcode || !roadAddress || !detailAddress) {
                alert("주소를 모두 입력하세요.");
                return false;
            }
            
		    var combinedAddress = postcode + " / " + roadAddress + " / " + detailAddress;
		    if (extraAddress) {
		        combinedAddress += " / " + extraAddress;
		    }
		    document.getElementById("buyer_addr").value = combinedAddress;

		    // 결제 방식 및 결제 정보 검증
            var paymentCard = document.getElementById("paymentCard").value;
            var payMethodCard = document.getElementById("payMethodCard").value;
            var paymentBank = document.getElementById("paymentBank").value;
            var payMethodBank = document.getElementById("payMethodBank").value;

            if (paymentCard == "" && paymentBank == "") {
                alert("결제방식과 결제번호를 입력하세요.");
                return false;
            }
            if (paymentCard != "" && payMethodCard == "") {
                alert("카드번호를 입력하세요.");
                document.getElementById("payMethodCard").focus();
                return false;
            } 
            else if (paymentBank != "" && payMethodBank == "") {
                alert("입금자명을 입력하세요.");
                return false;
            }

            var ans = confirm("결제하시겠습니까?");
            if (ans) {
                if (paymentCard != "" && payMethodCard != "") {
                    document.getElementById("payment").value = "C" + paymentCard;
                    document.getElementById("payMethod").value = payMethodCard;
                } else {
                    document.getElementById("payment").value = "B" + paymentBank;
                    document.getElementById("payMethod").value = payMethodBank;
                }
                // 폼 제출
                document.myform.action = "${ctp}/order/payment";
                document.myform.submit();
            }
        }
    </script>
    <style>
        td, th { padding: 5px; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/user/header.jsp"/>
    <jsp:include page="/WEB-INF/views/include/user/nav.jsp"/>
    <p><br/></p>
	<section>
    <div class="container">
        <div id="preloder">
            <div class="loader"></div>
        </div>
        <section class="breadcrumb-option">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb__text">
                            <h4>주문-결제</h4>
                            <div class="breadcrumb__links">
                                <a href="${ctp}/main">메인페이지</a>
                                <a href="${ctp}/shop/productList">결제</a>
                                <span>(배송지 정보를 확인 후 결제처리합니다.)</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="shopping-cart spad">
            <table class="table-bordered text-center" style="margin:auto; width:90%">
                <tr class="table-dark text-dark">
                    <th colspan="2">상 품</th>
                    <th>총상품금액</th>
                </tr>
                <c:set var="orderTotalPrice" value="0"/>
				<c:set var="shippingCharge" value="${sOrderVOS[0].charge ne null ? sOrderVOS[0].charge : 0}"/>
                
				<c:forEach var="vo" items="${sOrderProducts}">
					<c:set var="itemTotalPrice" value="${vo.price * vo.orderQuantity}"/>
	                <c:set var="orderTotalPrice" value="${orderTotalPrice + itemTotalPrice}"/>
                    <tr align="center">
                        <td><img src="${ctp}/product/${vo.productThumb}" width="150px"/></td>
                        <td align="left">
                            <p><b>모델명:</b> <span style="color:orange;">${vo.productName}</span><br/>
                               <b>옵션:</b> <span style="color:blue;">${vo.optionName}</span> (${vo.orderQuantity}개)
                            </p>
                        </td>
                        <td><b><fmt:formatNumber value="${itemTotalPrice}" pattern='#,###원'/></b></td>
                    </tr>
                </c:forEach>
				<c:set var="finalTotalPrice" value="${orderTotalPrice + shippingCharge}"/>
            </table>
            <table style="margin:auto; width:90%">
                <tr>
                    <td>
						<div style="padding:8px; background-color:#eee; text-align:center;">
						    <b>총 주문(결제) 금액</b> : 
						    상품가격(<fmt:formatNumber value="${orderTotalPrice}" pattern='#,###원'/>) +
						    배송비(<fmt:formatNumber value="${shippingCharge}" pattern='#,###원'/>) =
						    <b><font size="5" color="orange"><fmt:formatNumber value="${finalTotalPrice}" pattern='#,###원'/></font></b>
						</div>
                    </td>
                </tr>
            </table>
            <p><br/></p>
            <form name="myform" method="post">
                <section class="checkout spad">
                    <div class="container">
                        <div class="checkout__form">
                            <div class="row">
                                <div class="col-lg-12 col-md-6">
                                    <!-- <h6 class="coupon__code"><span class="icon_tag_alt"></span> 쿠폰이 있으신가요? <a href="#">여기를 클릭하시어</a> 코드번호를 입력하세요</h6> -->
                                    <h2 class="checkout__title">주문자 정보입력</h2>
                                    <div class="row">
                                        <div class="col">
                                            <div class="checkout__input">
                                                <p>주문자<span>*</span></p>
                                                <input type="text" name="buyer_name" value="${userVO.name}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="checkout__input">
                                        <p>주소<span>*</span></p>
                                        <div class="form-group">
                                            <div class="input-group mb-1">
                                                <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
                                                <div class="input-group-append">
                                                    <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
                                                </div>
                                            </div>
                                            <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
                                            <div class="input-group mb-1">
                                                <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
                                                <div class="input-group-append">
                                                    <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="checkout__input">
                                                <p>이메일<span>*</span></p>
                                                <input type="text" name="buyer_email" value="${userVO.email}">
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="checkout__input">
                                                <p>연락처<span>*</span></p>
                                                <input type="text" name="buyer_tel" value="${userVO.tel}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="checkout__input">
                                        <p>배송시요청사항<span>*</span></p>
                                        <select name="message" class="form-control">
                                            <option>부재중 경비실에 맡겨주세요.</option>
                                            <option>빠른 배송부탁합니다.</option>
                                            <option>부재중 현관문 앞에 놓아주세요.</option>
                                            <option>부재중 전달해주지 마세요.</option>
                                        </select>
                                    </div>
                                    <div class="checkout__input">
                                        <p>처리될 총 결제금액(테스트자료 10원)<span>*</span></p>
                                        <input type="text" name="amount" value="10" class="form-control" autofocus readonly />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#card">카드결제</a></li>
                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#bank">은행결제</a></li>
                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#telCheck">상담사연결</a></li>
                </ul>

                <div class="tab-content">
                    <div id="card" class="container tab-pane active"><br>
                        <h3>카드결제</h3>
                        <p>
                            <select name="paymentCard" id="paymentCard">
                                <option value="">카드선택</option>
                                <option>국민카드</option>
                                <option>현대카드</option>
                                <option>신한카드</option>
                                <option>농협카드</option>
                                <option>BC카드</option>
                                <option>롯데카드</option>
                                <option>삼성카드</option>
                                <option>LG카드</option>
                            </select>
                        </p>
                        <p>카드번호 : <input type="text" name="payMethodCard" id="payMethodCard"/></p>
                    </div>
                    <div id="bank" class="container tab-pane fade"><br>
                        <h3>무통장입금</h3>
                        <p>
                            <select name="paymentBank" id="paymentBank">
                                <option value="">은행선택</option>
                                <option value="국민은행">국민(111-111-111)</option>
                                <option value="신한은행">신한(222-222-222)</option>
                                <option value="우리은행">우리(333-333-333)</option>
                                <option value="농협">농협(444-444-444)</option>
                                <option value="신협">신협(555-555-555)</option>
                            </select>
                        </p>
                        <p>입금자명 : <input type="text" name="payMethodBank" id="payMethodBank"/></p>
                    </div>
                    <div id="telCheck" class="container tab-pane fade"><br>
                        <h3>전화상담</h3>
                        <p>콜센터(☎) : 043-1234-1234</p>
                    </div>
                </div>
                <hr/>
                <input type="hidden" name="postcode" id="hiddenPostcode"/>
				<input type="hidden" name="buyer_addr" id="buyer_addr"/>

                <div align="center">
                    <a type="button" class="btn btn-primary" onclick="payment()" >결제하기</a> &nbsp;
                    <button type="button" class="btn btn-info" onclick="location.href='${ctp}/shop/productCart';">장바구니보기</button> &nbsp;
                    <button type="button" class="btn btn-success" onclick="location.href='${ctp}/shop/productList';">계속 쇼핑하기</button>
                </div>
                <input type="hidden" name="sOrderVOS" value="${sOrderVOS}"/>
                <input type="hidden" name="orderIdx" value="${orderIdx}"/>
                <input type="hidden" name="orderTotalPrice" value="${orderTotalPrice}"/>
                <input type="hidden" name="userId" value="${sUid}"/>
                <input type="hidden" name="payment" id="payment"/>
                <input type="hidden" name="payMethod" id="payMethod"/>
                <input type="hidden" name="name" value="${sOrderVOS[0].productName}"/>
            </form>
        </section>
    </div>
    </section>
    <p><br/></p>
    <script src="${ctp}/js/shop/jquery.nice-select.min.js"></script>
    <script src="${ctp}/js/shop/jquery.slicknav.js"></script>
    <script src="${ctp}/js/shop/main.js"></script>
    <jsp:include page="/WEB-INF/views/include/user/footer.jsp"/>
</body>
</html>

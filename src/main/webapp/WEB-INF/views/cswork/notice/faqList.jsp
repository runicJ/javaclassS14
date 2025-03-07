<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>faqList</title>
	<link rel="icon" type="image/png" href="images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        h2 {
            text-align: center;
            margin-top: 20px;
            color: #333;
        }

        .accordion-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .accordion {
            background-color: #fff;
            color: #444;
            cursor: pointer;
            padding: 15px;
            width: 100%;
            border: none;
            text-align: left;
            outline: none;
            font-size: 16px;
            transition: background-color 0.3s ease;
            margin-bottom: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .accordion:hover {
            background-color: #f1f1f1;
        }

        .panel {
            padding: 0 15px;
            display: none;
            overflow: hidden;
            background-color: #fff;
            border-left: 1px solid #ddd;
            border-right: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            border-radius: 0 0 5px 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 10px;
        }

        .active, .accordion:after {
            background-color: #e0e0e0;
        }

        .accordion:after {
            content: '\f078';
            font-family: 'Font Awesome 5 Free';
            font-weight: 900;
            transition: transform 0.3s ease;
        }

        .accordion.active:after {
            transform: rotate(180deg);
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br></p>
<section class="page">
<div class="container">
<h2>자주묻는질문 20문</h2>
<div class="accordion-container">
    <button class="accordion">1. 주문 상태는 어떻게 확인하나요?</button>
    <div class="panel">
        <p>주문 상태는 로그인 후 "마이페이지"에서 확인할 수 있습니다. 주문 번호를 클릭하면 자세한 주문 상태를 볼 수 있습니다.</p>
    </div>

    <button class="accordion">2. 배송 기간은 얼마나 걸리나요?</button>
    <div class="panel">
        <p>배송은 일반적으로 3~5일이 소요됩니다. 지역에 따라 배송 시간이 다를 수 있으며, 배송 추적을 통해 현재 배송 상태를 확인할 수 있습니다.</p>
    </div>

    <button class="accordion">3. 상품을 반품하려면 어떻게 해야 하나요?</button>
    <div class="panel">
        <p>반품을 원하실 경우 고객 센터에 문의하시거나 "마이페이지"에서 반품 요청을 할 수 있습니다. 반품 정책에 따라 일부 상품은 반품이 불가할 수 있습니다.</p>
    </div>

    <button class="accordion">4. 교환 정책은 어떻게 되나요?</button>
    <div class="panel">
        <p>교환은 상품 수령 후 7일 이내에 가능하며, 상품의 상태가 새 것과 동일해야 합니다. 교환 시 추가 비용이 발생할 수 있습니다.</p>
    </div>

    <button class="accordion">5. 결제 방법은 어떤 것이 있나요?</button>
    <div class="panel">
        <p>신용카드, 체크카드, 페이팔, 무통장 입금 등의 결제 방법을 지원합니다. 결제 시 보안이 강화된 결제 시스템을 사용하고 있습니다.</p>
    </div>

    <button class="accordion">6. 회원 가입은 어떻게 하나요?</button>
    <div class="panel">
        <p>회원 가입은 홈페이지 상단의 "회원가입" 버튼을 클릭하여 진행할 수 있습니다. 간단한 정보를 입력하면 즉시 회원으로 가입할 수 있습니다.</p>
    </div>

    <button class="accordion">7. 비밀번호를 잊어버렸어요. 어떻게 재설정하나요?</button>
    <div class="panel">
        <p>로그인 페이지에서 "비밀번호 찾기"를 클릭한 후, 이메일 주소를 입력하면 비밀번호 재설정 링크를 보내드립니다.</p>
    </div>

    <button class="accordion">8. 회원 정보는 어떻게 변경하나요?</button>
    <div class="panel">
        <p>로그인 후 "마이페이지"에서 회원 정보를 수정할 수 있습니다. 이메일, 주소, 전화번호 등 개인정보를 안전하게 변경할 수 있습니다.</p>
    </div>

    <button class="accordion">9. 쿠폰은 어떻게 사용하나요?</button>
    <div class="panel">
        <p>결제 페이지에서 쿠폰 코드를 입력하면 할인이 적용됩니다. 쿠폰은 특정 조건에 따라 사용이 제한될 수 있습니다.</p>
    </div>

    <button class="accordion">10. 배송비는 얼마인가요?</button>
    <div class="panel">
        <p>배송비는 구매 금액과 배송지에 따라 다르며, 50,000원 이상 구매 시 무료 배송을 제공합니다.</p>
    </div>

    <button class="accordion">11. 포인트는 어떻게 적립되나요?</button>
    <div class="panel">
        <p>상품 구매 시 결제 금액의 일정 비율이 포인트로 적립됩니다. 적립된 포인트는 다음 구매 시 사용 가능합니다.</p>
    </div>

    <button class="accordion">12. 해외 배송이 가능한가요?</button>
    <div class="panel">
        <p>일부 상품은 해외 배송이 가능하며, 배송비와 통관 수수료가 추가로 발생할 수 있습니다. 자세한 사항은 고객 센터로 문의해 주세요.</p>
    </div>

    <button class="accordion">13. 주문 내역을 수정할 수 있나요?</button>
    <div class="panel">
        <p>주문 내역은 주문 후 1시간 이내에만 수정 가능합니다. 변경 사항은 고객 센터로 연락하여 처리해 주세요.</p>
    </div>

    <button class="accordion">14. 계정을 탈퇴하려면 어떻게 해야 하나요?</button>
    <div class="panel">
        <p>계정 탈퇴는 "마이페이지" > "회원 탈퇴" 메뉴를 통해 가능합니다. 탈퇴 후에는 모든 정보가 삭제되며, 복구가 불가능합니다.</p>
    </div>

    <button class="accordion">15. 세금계산서를 발급받으려면 어떻게 해야 하나요?</button>
    <div class="panel">
        <p>세금계산서는 구매 시 발행 요청을 하거나 고객 센터를 통해 발행 신청할 수 있습니다. 발행 소요 시간은 영업일 기준 2~3일입니다.</p>
    </div>

    <button class="accordion">16. 적립된 포인트는 어떻게 확인하나요?</button>
    <div class="panel">
        <p>적립된 포인트는 "마이페이지"에서 확인할 수 있으며, 사용 내역 및 적립 내역도 함께 조회할 수 있습니다.</p>
    </div>

    <button class="accordion">17. 반품 후 환불은 언제 처리되나요?</button>
    <div class="panel">
        <p>반품이 확인된 후 영업일 기준 3~5일 내에 환불 처리가 완료됩니다. 결제 수단에 따라 환불 소요 시간이 달라질 수 있습니다.</p>
    </div>

    <button class="accordion">18. 배송지를 변경하려면 어떻게 해야 하나요?</button>
    <div class="panel">
        <p>배송지는 주문 후 1시간 이내에만 변경 가능합니다. 변경을 원하실 경우 고객 센터에 연락해 주세요.</p>
    </div>

    <button class="accordion">19. 재입고 알림을 받을 수 있나요?</button>
    <div class="panel">
        <p>상품 상세 페이지에서 "재입고 알림 신청"을 통해 알림을 받을 수 있습니다. 재입고 시 알림 메일이 발송됩니다.</p>
    </div>

    <button class="accordion">20. 주문을 취소하려면 어떻게 해야 하나요?</button>
    <div class="panel">
        <p>주문 취소는 "마이페이지"에서 직접 진행할 수 있으며, 취소 가능 여부는 주문 상태에 따라 달라질 수 있습니다.</p>
    </div>
    <div>답변이 부족한 경우 1:1문의를 이용해 주세요</div>
</div>

</div>
</section>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
<script>
    const acc = document.querySelectorAll(".accordion");
    acc.forEach(function (button) {
        button.addEventListener("click", function () {
            this.classList.toggle("active");
            const panel = this.nextElementSibling;
            if (panel.style.display === "block") {
                panel.style.display = "none";
            } else {
                panel.style.display = "block";
            }
        });
    });
</script>

</body>
</html>
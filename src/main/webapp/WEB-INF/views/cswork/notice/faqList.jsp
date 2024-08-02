<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>faqList</title>
	<link rel="icon" type="image/png" href="images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br></p>
<section class="page">
<div class="container">
       <div class="csHeader wide">
           <div class="csHeadinner">
               <h2>고객센터<span style="display:none;">1500-0000</span></h2>
               <div class="info-open">
                   <div class="info open">
                       <img src="http://fiximage.10x10.co.kr/web2021/cscenter/img_open_info01.png?v=2.1" alt="운영시간 : 10:00 ~ 17:00">
                   </div>
                   <div class="info lunch">
                       <img src="http://fiximage.10x10.co.kr/web2021/cscenter/img_open_info02.png?v=2.1" alt="점심시간 : 12:30 ~ 13:30">
                   </div>
               </div>
               <div class="btn-csgroups">
                   <div class="service-group">
                       <img src="http://fiximage.10x10.co.kr/web2021/cscenter/btn_csgroup.png?v=2.1" alt="1:1상담하기 / 1:1상담내역">
                       <a href="" onclick="myqnawrite(); fnAmplitudeEventMultiPropertiesAction('click_cs_1on1','',''); return false;" class="btn-consulting01">1:1 상담신청</a>
                       <a href="/my10x10/qna/myqnalist.asp" class="btn-consulting02">1:1 상담내역</a>
                   </div>
               </div>
           </div>
       </div>
	<div id="contentWrap">
		<div class="csContent">
			
			<div class="lnbWrap">
				<ul class="lnb">
					<li>
						<a href="/cscenter/faq/faqList.asp"><strong>FAQ 안내</strong></a>
						<ul>
						<li><a href="/cscenter/faq/faqList.asp?divcd=F019" title="회원/가입">회원/가입</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F020" title="주문/결제">주문/결제</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F021" title="배송">배송</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F022" title="취소">취소</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F023" title="교환">교환</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F024" title="반품">반품</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F025" title="시스템">시스템</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F026" title="증빙서류">증빙서류</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F027" title="쿠폰">쿠폰</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F028" title="마일리지">마일리지</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F029" title="기프트카드">기프트카드</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F030" title="이벤트/사은품">이벤트/사은품</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F031" title="멤버십">멤버십</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F032" title="선물포장서비스">선물포장서비스</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F035" title="이니렌탈">이니렌탈</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F036" title="입점">입점</a></li><li><a href="/cscenter/faq/faqList.asp?divcd=F037" title="오프라인">오프라인</a></li>
						</ul>
					</li>
				</ul>
		
				<ul class="aside">
					<!-- li><a href="/cscenter/membershipGuide/" title="회원혜택 안내"><span>회원혜택 안내</span></a></li -->
					<li><a href="/offshop/point/card_service.asp" title="멤버십카드 안내"><span>멤버십카드 안내</span></a></li>
					<li><a href="/giftcard/" title="기프트카드 안내"><span>기프트카드 안내</span></a></li>
					<li><a href="/gift/gifticon/" title="기프티콘 상품 교환"><span>기프티콘 상품 교환</span></a></li>
					
					<!-- li><a href="/cscenter/oversea/emsIntro.asp" title="해외배송 안내"><span>해외배송 안내</span></a></li -->
					<li><a href="/offshop/index.asp" title="매장안내"><span>매장안내</span></a></li>
				</ul>

				<p class="findDepositor" onclick="window.open('/common/online_banking_list.asp', 'popDepositor', 'width=395, height=685, scrollbars=yes'); return false;" title="입금자를 찾습니다"><strong>입금자를 찾습니다.</strong></p>

				<div class="csInfo">
					
						<strong><img src="http://fiximage.10x10.co.kr/web2013/cscenter/txt_cs_tel.gif" alt="1644-6030"></strong>
						<a href="mailto:customer@10x10.co.kr" class="crRed"><strong>customer@10x10.co.kr</strong></a>
						<p><strong>오전 10시 ~ 오후 5시</strong> (점심시간:오후 12시 30분~1시 30분)<br> 토, 일, 공휴일 휴무</p>
					
				</div>
			</div>


			<!-- content -->
			<div class="content">
				<div class="searchBox">
					<form name="FAQSearchFrm" method="get" action="/cscenter/faq/faqList.asp" onkeypress="if (event.keyCode == 13) TnFAQSearch();" onsubmit="return false;">
					<input type="hidden" name="pg" value="1">
						<fieldset>
							<legend>FAQ 검색</legend>
							<div class="searchField">
								<label for="searchFaq">FAQ 검색</label>
								<input id="searchFaq" type="text" name="srch" class="txtInp">
								<input type="submit" value="검색" class="btn btnS1 btnRed" onclick="TnFAQSearch()">
							</div>

							<ul class="searchOption">
								<li><a href="javascript:TnFAQSearch('반품')" title="반품 검색">반품</a></li>
								<li><a href="javascript:TnFAQSearch('교환')" title="교환 검색">교환</a></li>
								<li><a href="javascript:TnFAQSearch('배송비')" title="배송비 검색">배송비</a></li>
								<li><a href="javascript:TnFAQSearch('쿠폰')" title="쿠폰 검색">쿠폰</a></li>
								<li><a href="javascript:TnFAQSearch('마일리지')" title="마일리지 검색">마일리지</a></li>
							</ul>
						</fieldset>
					</form>
				</div>

				<div class="boardList faqList">
					<h3><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_faq_top10.gif" alt="자주하는 질문 TOP 10"></h3>
					<table>
						<caption>자주하는 질문 TOP 10</caption>
						<colgroup>
								<col width="70"> <col width="150"> <col width="*">
							</colgroup>
						<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">구분</th>
							<th scope="col">제목</th>
						</tr>
						</thead>
						<tbody>
						
						<tr>
							<td>10</td>
							<td>회원/가입</td>
							<td class="lt"><a href="javascript:showhideFAQ('1', '0','10','143');" class="question" title="회원 가입 방법">회원 가입 방법</a></td>
						</tr>
						<tr class="answer" id="FAQblock10" style="display: table-row;">
							<td class="ico"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_answer.gif" alt="ANSWER"></td>
							<td colspan="2" class="detail">
								텐바이텐은 <b>일반회원</b> 과 <b>SNS 회원</b> 가입으로 나누어 집니다.<br>사이트 회원 가입을 위해서는 <b>국내 휴대폰 번호</b>로 본인 인증이 필요합니다.<br><br><b>일반회원가입</b><br><br><b>WEB</b> : 오른쪽 상단 회원 가입 버튼 클릭 후 회원가입을 진행하시면 됩니다.<br>(본인인증을 위해 정확한 이메일 주소, 휴대폰 번호 입력을 부탁드립니다. ) <br><br><a href="https://tenten.app.link/03NX0e1Kjjb"><font color="red">[회원가입 바로가기] </font></a><br><br><b>APP</b> :  어플 메인에 마이텐바이텐 통해서 회원가입 버튼 클릭 후 회원가입이 가능합니다.<br><br><br><b>SNS 회원가입</b><br><br>1. SNS 회원가입은 SNS와 연동하여 간편하게 회원가입 하는 서비스입니다.<br><br>2. 가입 가능 SNS : 카카오톡 / Apple / 구글 / 네이버 / 페이스북<br><br>- Apple과의 연동은 APP을 통한 연동만 가능합니다. (WEB버전 연동불가)<br><br>- facebook 연동의 경우, 해당사 facebook의 요청으로 기간 미정 연동 불가합니다.<br>  기존 facebook 계정으로 로그인 불가능하오니 텐바이텐 일반회원으로 전환 후 이용부탁드립니 <br>  다. (24년 1월 기준)<br><br>3. SNS 회원가입 후 로그인 시 텐바이텐 ID가 아닌, <br>    해당 SNS 클릭 후 SNS ID 및 비밀번호 입력하여 로그인 가능합니다.  <br><br>4. SNS연동 해제 또는 다른 SNS로 연동 요청 하실 경우 텐바이텐 일반회원으로 전환 후 해제 가능 <br>합니다.<br><br>5. 텐바이텐 일반회원 전환 시 1:1상담 또는 상담톡을 통해 전환할 수 있습니다.<br><br><br>
								<p>답변이 충분하지 않으시다면 1:1상담신청을 이용해 주세요. <a href="javascript:myqnawrite();" class="linkBtn"><strong>1:1상담신청하기</strong></a></p>
							</td>
						</tr>
						
						<tr>
							<td>9</td>
							<td>회원/가입</td>
							<td class="lt"><a href="javascript:showhideFAQ('1', '1','10','144');" class="question" title="회원 정보 수정">회원 정보 수정</a></td>
						</tr>
						<tr class="answer" id="FAQblock11" style="DISPLAY:none;">
							<td class="ico"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_answer.gif" alt="ANSWER"></td>
							<td colspan="2" class="detail">
								<b>WEB</b> :  HOME &gt; MY 텐바이텐 &gt; MY 회원정보 &gt; 개인정보수정 을 통해 수정 가능합니다.<br><br>1. 개명 하였을 경우에도 개인정보수정을 통해 이름 수정 가능합니다.<br><br>2. 한 번 가입된 아이디는 수정 또는 변경 불가능합니다.<br><br><a href="https://tenten.app.link/03NX0e1Kjjb"><font color="red">[개인정보수정 바로가기]</font></a><br><br><b>APP</b> : HOME &gt; MY 텐바이텐 &gt; 하단 나의 정보 관리 &gt; 개인정보 관리 에서 수정 가능합니다. <br>
								<p>답변이 충분하지 않으시다면 1:1상담신청을 이용해 주세요. <a href="javascript:myqnawrite();" class="linkBtn"><strong>1:1상담신청하기</strong></a></p>
							</td>
						</tr>
						
						<tr>
							<td>8</td>
							<td>회원/가입</td>
							<td class="lt"><a href="javascript:showhideFAQ('1', '2','10','146');" class="question" title="아이디/비밀번호 찾기">아이디/비밀번호 찾기</a></td>
						</tr>
						<tr class="answer" id="FAQblock12" style="DISPLAY:none;">
							<td class="ico"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_answer.gif" alt="ANSWER"></td>
							<td colspan="2" class="detail">
								- 아이디와 비밀번호를 분실한 경우<br><br><b>WEB</b>: 홈페이지 우측상단의 로그인 메뉴를 클릭하신 후 아이디찾기 또는 비밀번호찾기를 선택하여 본인 확인 절차를 거친 후 이용가능합니다.<br><br><b>APP</b>: 마이텐바이텐 클릭 후 로그인 버튼 하단 [아이디/비밀번호찾기] 통해 본인 확인 절차를 거친 후 이용가능합니다.<br><br>이메일 또는 연락처가 변경 되었을 경우 1:1상담 또는 상담톡을 통해서 임시비밀번호 발급 후 로그인이 가능합니다.<br> <br><br>- SNS 계정으로 회원가입하신 경우 비밀번호 찾기가 불가능합니다. <br>   가입하신 SNS 아이디와 비밀번호를 통해 로그인을 해주세요.<br><br><br><a href="https://tenten.app.link/pgD4QadLjjb"><font color="red">[아이디/비밀전호 찾기 바로가기]</font></a>
								<p>답변이 충분하지 않으시다면 1:1상담신청을 이용해 주세요. <a href="javascript:myqnawrite();" class="linkBtn"><strong>1:1상담신청하기</strong></a></p>
							</td>
						</tr>
						
						<tr>
							<td>7</td>
							<td>회원/가입</td>
							<td class="lt"><a href="javascript:showhideFAQ('1', '3','10','147');" class="question" title="회원 탈퇴">회원 탈퇴</a></td>
						</tr>
						<tr class="answer" id="FAQblock13" style="DISPLAY:none;">
							<td class="ico"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_answer.gif" alt="ANSWER"></td>
							<td colspan="2" class="detail">
								회원 탈퇴가 완료된 후 기존에 사용된 ID로는 재가입이 불가능하며, <br>주문한 주문내역과 마일리지, 고객정보 등이 모두 삭제됩니다.<br><br><b>WEB</b> : HOME &gt; MY 텐바이텐 &gt; MY 회원정보 &gt; [회원탈퇴] 통해 신청가능합니다.<br><br><a href="https://www.10x10.co.kr/my10x10/userinfo/withdrawal.asp"><font color="red">[회원 탈퇴 바로가기]</font></a> <br><br><b>APP</b> : HOME &gt; MY 텐바이텐 &gt; 개인정보관리 &gt; 페이지 하단 [회원탈퇴] 통해 신청가능합니다.<br>
								<p>답변이 충분하지 않으시다면 1:1상담신청을 이용해 주세요. <a href="javascript:myqnawrite();" class="linkBtn"><strong>1:1상담신청하기</strong></a></p>
							</td>
						</tr>
						
						<tr>
							<td>6</td>
							<td>주문/결제</td>
							<td class="lt"><a href="javascript:showhideFAQ('1', '4','10','148');" class="question" title="주문 방법">주문 방법</a></td>
						</tr>
						<tr class="answer" id="FAQblock14" style="DISPLAY:none;">
							<td class="ico"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_answer.gif" alt="ANSWER"></td>
							<td colspan="2" class="detail">
								<b>회원주문방법</b><br><br>1. 로그인 후 구매하실 상품(옵션)을 선택하여 바로구매 or 장바구니를 선택합니다.<br><br>2. 이동한 주문결제 화면에서 주문고객 정보, 배송지 정보, 할인정보를 확인합니다.<br><br>3. 결제하실 결제수단을 선택 후, 구매조건 동의여부 '동의' 클릭한 뒤 결제하기 버튼을 선택하여 결제하면 주문이 완료됩니다.<br><br><br><b>비회원 주문방법</b><br><br>1, 구매하실 상품 선택후 바로구매 또는 장바구니를 선택합니다.<br><br>2. 비회원 로그인 화면에서 비회원 주문 선택합니다.<br><br>3. 주문고객 정보, 배송지 정보 입력 후, 결제하실 결제수단을 선택합니다.<br><br>4. 구매조건 동의여부 '동의' 클릭 후 결제하기 버튼을 선택하여 결제하면 주문이 완료됩니다.<br><br>※ 비회원으로 주문 시 각종 할인이나 적립 혜택을 받으실 수 없습니다.<br>
								<p>답변이 충분하지 않으시다면 1:1상담신청을 이용해 주세요. <a href="javascript:myqnawrite();" class="linkBtn"><strong>1:1상담신청하기</strong></a></p>
							</td>
						</tr>
						
						<tr>
							<td>5</td>
							<td>주문/결제</td>
							<td class="lt"><a href="javascript:showhideFAQ('1', '5','10','149');" class="question" title="결제 수단">결제 수단</a></td>
						</tr>
						<tr class="answer" id="FAQblock15" style="DISPLAY:none;">
							<td class="ico"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_answer.gif" alt="ANSWER"></td>
							<td colspan="2" class="detail">
								텐바이텐에서 사용할 수 있는 결제수단은 신용카드, 텐바이텐 체크카드, 무통장입금, 실시간계좌이체, 휴대폰 결제, Npay, PAYCO, toss, KAKAOpay, SAMSUNG Pay, PIN Pay, 편의점 결제가 있습니다. <br><br><b>신용카드</b><br><br>1. 인터넷안전결제(ISP) : 국민, 비씨카드 등 고객님의 안전한 전자상거래를 위해 카드번호, 유효기간, 비밀번호 등의 개인 신용정보를 입력하지 않고 고객님만이 알 수 있는 별도의 인증번호로만 거래하는 방식입니다.<br><br>인터넷안전결제(ISP)는 인터넷을 통해 쇼핑몰 등에서 물건을 구입하시는 경우 발생할 수 있는 정보유출, 타인에 의한 도용 등을 방지한 결제 서비스입니다. <br>인터넷안전결제(ISP)를 이용하시면 금융감독원에서 권고사항으로 지정한 PKI기반 전자서명으로 모든 결제가 이뤄지므로, 신용카드 번호 등의 유출이 원천적으로 불가능합니다.<br><br>2. 안심클릭 : 안전결제(ISP) 카드를 제외한 나머지 삼성,LG,외환,신한,현대 등 결제시 안전하고 편리한 온라인 전자상거래를 돕기 위해 개발된 인증 서비스로 온라인 쇼핑 시 고객님의 카드번호, 유효기간, 주민번호, 비밀번호을 입력하지 않고 안심클릭서비스 암호를 통해 거래하는 새로운 개념의 서비스입니다.<br><br>3. 해외신용카드 결제<br><b>최근 텐바이텐의  BIN Attack(해외카드 부정사용)의심 건 증가로 인해</b><br><b>23년 3월 23일 오전 10시부터 VISA, MC, JCB 등 전 해외 발행카드 전 브랜드의 사용이 중단되었습니다.</b><br><br><b>죄송하게도 결제대행사를 통한 사용가능시점 전달 전까지는 해외카드(VISA, MC, JCB 등) 이용이 어렵습니다.</b><br><br>해외에서 결제시 이용 가능한 수단으로 국내에서 발행되지 않은 신용카드를 사용하여 결제하는 방법입니다.<br>이 경우, 3D 인증을 받아야 사용이 가능합니다.<br><br><b>3D 인증 방법</b><br><br>1)해외VISA카드의 경우 <br>해당카드사의 홈페이지에 접속 &gt; Personal 메뉴를 클릭 &gt;;Security &gt; Visa Security Program 항목을 클릭,<br>해당 카드사의 안내사항을 읽어본 후, 절차에 맞게 3D인증 온라인 등록을 하면 됩니다.<br><br>* VISA : http://usa.visa.com/personal/security/security-program/index.jsp<br><br>2) 해외 MASTER카드의 경우 <br>해당카드사의 홈페이지에 접속 &gt; Products 메뉴를 클릭 &gt; SecureCod 항목을 클릭,<br>해당 카드사의 안내사항을 읽어본 후, 절차에 맞게 3D인증 온라인 등록을 하면 됩니다. <br><br>* MASTER : http://www.mastercard.us/securecode.html<br>* 3D 인증 FAQ : http://www.mastercard.com/us/personal/en/cardholderservices/securecode/index.html<br><br><br><b>텐바이텐 체크카드</b><br><br>1. 결제금액 기준 5% 할인 혜택이 제공됩니다.<br><br>2.  텐바이텐 비바G 하나 체크카드에 적용되는 혜택으로 일반 하나카드는 '신용카드' 메뉴에서 결제 진행하시기 바랍니다.<br><br>3.  배송비만 결제되는 경우에는 추가 할인이 적용되지 않습니다.<br><br><b>*현재 텐바이텐 체크카드 발급은 종료되었습니다.</b><br><br><br><b>가상계좌입금</b><br><br>1. 무통장입금이란 말 그대로 통장 없이 입금하는 것을 말합니다.<br><br>2. 방법에는 폰뱅킹, 인터넷뱅킹, 은행창구에서 직접 입금하는방법, ATM기계를 통해 입금하는 방법, 모바일뱅킹 등으로 결제할 수 있습니다.<br><br>3. 주문시 부여받으신 가상계좌로, 입금하실 금액과 성함에 맞게 정확히 입금해주시면 됩니다.<br><br>4. 가상계좌로 입금하실 경우, 제공된 계좌번호와 입금하실 금액이 일치해야 이체처리가 완료되며, 실시간으로 결제 확인이 가능합니다.<br><br>5. 무통장 입금 기한은 3일이며, 기간경과 시 주문은 자동취소 됩니다.<br><br>*타은행 입금 시 별도의 수수료 발생되오니 참고해주세요.<br><br><br><b>실시간 계좌이체</b><br><br>1. 고객님이 가지고 계신 은행계좌의 주민등록번호를 입력하시면 자동으로 계좌이체되어 결제가 되는 편리한 서비스입니다.<br><br>2. 자신의 거래은행의 계좌에서 지불하는 서비스로, 은행계좌와 공인인증서만 있으면 누구나 이용할 수 있습니다. <br>간편하게 통장에서 바로 결제를 하실수 있으며, 별도의 수수료 부담이 없는 결제방법입니다.<br><br><br><b>휴대폰 결제</b><br><br>1. 휴대폰 결제는 소액결제에 한하여 우선 휴대폰으로 승인번호를 받고 그 승인번호를 웹 상에 입력하여 결제를 하는 후불제 방식입니다.<br><br>2. 결제금액은 결제하신 다음달 휴대폰 요금에 부과되어 청구되며, 별도의 수수료는 부과되지 않습니다.<br><br>3. 텐바이텐에서 휴대폰으로 결제 가능한 최대 금액은 월 30만원이나, 개인별 한도금액은 통신사 및 개인 설정에 따라 다를 수 있습니다.<br><br><br><b>네이버페이</b><br><br>1. 주문 변경 시 카드사 혜택 및 할부 적용 여부는 해당 카드사 정책에 따라 변경될 수 있습니다.<br><br>2. 네이버페이는 네이버ID로 별도 앱 설치 없이 신용카드 또는 은행계좌 정보를 등록하여 네이버페이 비밀번호로 결제할 수 있는 간편결제 서비스입니다.<br><br>3. 네이버페이 카드 간편결제는 네이버페이에서 제공하는 카드사 별 무이자, 청구할인 혜택을 받을 수 있습니다.<br><br>[결제 가능한 신용카드 : 신한, 삼성, 현대, BC, 국민, 하나, 롯데, NH농협, 씨티]<br><br>[결제 가능한 은행 : NH농협, 국민, 신한, 우리, 기업, SC제일, 부산, 경남, 수협, 우체국]<br><br><br><b>PAYCO 간편결제</b><br><br>1. PAYCO는 온/오프라인 쇼핑은 물론 송금, 멤버십 적립까지 가능한 통합 서비스입니다.<br><br>2. 휴대폰과 카드 명의자가 동일해야 결제 가능하며, 결제금액 제한은 없습니다.<br><br>[지원카드 : 모든 국내 신용/체크카드]<br><br><br><b>토스 간편결제</b><br><br>1. 토스는 계좌 및 카드 등록 후 비밀번호 하나로 간편하게 결제할 수 있는 결제 서비스입니다.<br><br>2. 카드사별 무이자 할부, 청구할인 혜택은 토스 내 혜택 안내를 통해 확인하실 수 있습니다.<br><br>토스 결제 문의, 토스 고객센터 1599-4905<br><br><br><b>카카오페이</b><br><br>1. 카카오페이란, 카카오톡 안에서 개인 신용카드(체크카드 포함)를 등록하면, 비밀번호만으로 간단하게 결제할 수 있는 모바일 결제 서비스입니다.<br><br>2. 본 결제수단은 카카오톡이 기본적으로 설치되어 있어야 이용 가능합니다.<br><br>3. 본인 명의의 휴대폰을 이용하여 본인 명의의 카드를 등록하게 되면 모바일을 통해서 사용이 가능합니다.<br><br><br><b>SAMSUNG Pay</b><br><br>1. 삼성페이는 안드로이드 폰 기종에서 사용 가능합니다.<br><br>2. 삼성페이에 개인 신용카드(체크카드 포함)를 등록하면, 비밀번호만으로 간단하게 결제할 수 있는 모바일 결제 서비스입니다.<br><br>3. 본인 명의의 휴대폰을 이용하여 본인 명의의 카드를 등록하게 되면 모바일을 통해서 사용이 가능합니다.<br><br><br><b>현대카드 X PIN PAY</b><br><br>1. 현대카드의 간편걸제 서비스입니다.<br><br>2. WEB / APP 최초 1회 현대카드 회원 본인인증이 필요합니다.<br><br>3. 결제수단 중 [ 현대카드XPIN PAY ]를 선택 후 결제할 현대카드를 선택 및 개인인증번호(PIN)를 입력하면 즉시 결제 완료됩니다.<br><br>4. 별도의 카드사 결제 앱 실행없이 원클릭 결제 가능합니다.<br><br><br><b>편의점 결제</b><br><br>1. 편의점 결제는 가까운 GS편의점에 방문하여 발급받은 바코드를 편의점 점원에게 제시, 바코드를 스캔하고 현금으로 결제하는 서비스입니다.<br><br>2. 편의점 결제는 현금 결제만 가능합니다.<br><br>3. 편의점 입금 후 1시간 이내에 결제 확인 되며, 입금 확인 시 배송이 이루어집니다.<br><br>4. 편의점 결제 주문 후 바고드 유효기간까지 입금되지 않을 경우 주문은 자동으로 취소 됩니다.<br><br><b>선물하기 서비스</b><br><br>1. 선물하기 서비스는 모바일에서만 진행이 가능 합니다.<br><br>2. 선물하고자 하는 상품 페이지 하단에 [선물하기]를 클릭하여 진행 합니다.<br><br>3. 메시지 카드 선택 및 메시지 기재하여 카카오톡 또는 문자로 선물받는 사람에게 발송을 하면 선물받는 사람이 직접 배송받을 주소를 등록하는 서비스 입니다.<br><br>4. 선물하기 결제가 완료되면 선물받는 사람을 선택하여 발송 합니다.<br><br>5. 선물받는 사람이 배송지 입력할 수 있는 기간은 1주일이며, 주소등록 기간이 경과되면 자동으로 취소가 됩니다.<br><br>6. 선물받는 사람이 배송지를 입력하지 않았을 경우에는 구매자가 직접 취소도 가능하며, 선물받는 사람이 선물 거절하기도 가능 합니다.<br><br><b>선물하기 취소</b><br><br>1. 선물하기 취소는 선물을 보낸 구매자가 결제 진행한 원결제 수단으로만 취소가 가능 합니다.<br><br>2. 주소 등록 후 취소를 희망하는 경우에는 직접 취소가 불가하니 1:1상담 또는 상담톡 통해 문의 부탁드립니다.<br><br>
								<p>답변이 충분하지 않으시다면 1:1상담신청을 이용해 주세요. <a href="javascript:myqnawrite();" class="linkBtn"><strong>1:1상담신청하기</strong></a></p>
							</td>
						</tr>
						
						<tr>
							<td>4</td>
							<td>주문/결제</td>
							<td class="lt"><a href="javascript:showhideFAQ('1', '6','10','150');" class="question" title="주문조회 및 정보 변경">주문조회 및 정보 변경</a></td>
						</tr>
						<tr class="answer" id="FAQblock16" style="DISPLAY:none;">
							<td class="ico"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_answer.gif" alt="ANSWER"></td>
							<td colspan="2" class="detail">
								<b>주문조회 방법</b><br><br>1. 회원 주문 조회방법 <br><br>로그인 후 HOME &gt; MY 텐바이텐&gt; MY 쇼핑리스트 &gt; 주문배송조회 에서 주문내역을 확인하실 수 있습니다<br><br>2. 비회원 주문 조회 방법<br><br>사이트 상단 [주문배송조회] 클릭 후, 비회원 로그인을 통해 확인 가능합니다.<br><br>비회원 로그인시 '<b>주문번호</b>'와 주문자의 '<b>이메일</b>'을 입력하시면 됩니다.<br><br><a href="https://tenten.app.link/L1izHiDBdjb"><font color="red">[주문조회바로가기]</font></a><br><br><br><b>주문 정보 변경</b><br><br>1. 배송지변경<br><br>HOME &gt; MY 텐바이텐&gt; MY 쇼핑리스트 &gt; 주문정보변경 에서 주문상태에 따라 직접 변경 가능합니다.<br><br>1) 결제대기중 ~ 상품 확인 중 : WEB직접변경가능<br><br>2) 상품포장중 : 1:1상담문의 또는 상담톡 요청<br><br>3) 배송시작 : 변경불가<br><br>2.결제수단변경<br><br>결제수단은 PC에서만 가능하며, HOME &gt; MY 텐바이텐&gt; MY 쇼핑리스트 &gt; 주문정보변경 &gt; 결제방법변경  에서 가능합니다.<br><br>결제수단은 무통장결제 -&gt; 카드결제로만 변경 가능합니다.<br><br>무통장 입금 전 결제방법 변경 클릭하여, 결제방법 신용카드 선택 후 결제하기 누르면 결제방법이 변경됩니다.<br> <br><a href="https://tenten.app.link/X1tVB9BIjjb"><font color="red">[주문정보변경 바로가기]</font></a><br><br><b>* 결제완료후에는 다른결제수단으로 결제방법 변경은 어렵습니다. 주문 취소 후 재구매 해주셔야 합니다.</b><br><br>3. 상품&amp;옵션변경 <br><br>주문 완료 후에는고객 직접 상품&amp;옵션변경이 불가 하오니, 취소 후 재구매 해주시거나 1:1상담문의 또는 상담톡으로 문의 부탁드립니다.  <br>※ 단, 상품 출고 이후 상품&amp;옵션 변경 불가<br>
								<p>답변이 충분하지 않으시다면 1:1상담신청을 이용해 주세요. <a href="javascript:myqnawrite();" class="linkBtn"><strong>1:1상담신청하기</strong></a></p>
							</td>
						</tr>
						
						<tr>
							<td>3</td>
							<td>배송</td>
							<td class="lt"><a href="javascript:showhideFAQ('1', '7','10','151');" class="question" title="배송구분">배송구분</a></td>
						</tr>
						<tr class="answer" id="FAQblock17" style="DISPLAY:none;">
							<td class="ico"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_answer.gif" alt="ANSWER"></td>
							<td colspan="2" class="detail">
								<b>발송처에 따른 배송구분</b><br><br>텐바이텐 사이트내 배송은 자사 물류센터(포천 위치)에서 발송되는 텐바이텐배송과 각 브랜드에서 직접 발송하는 업체 배송으로 나뉘어 진행됩니다.<br><br><b>발송방법에 따른 배송구분</b><br><br>1. 텐바이텐 배송은 롯데택배(거래 택배사) 통하여 택배 발송되며, 업체 배송은 업체 거래 택배사 통하여 발송되는 일반 택배 배송, 화물택배 배송 및 가구/가전 직배송 등으로 발송될 수 있습니다.<br><br>2. 일반 택배 배송은 평균 발송 후 평일기준 1~4일 정도 배송기간 소요되며, 배송지 물량에 따라 소요기간은 달라질 수 있습니다.<br><br>3. 가구/가전 직배송의 경우 별도 배송조회가 되지는 않으며, 발송처에서 수령자분께 해피콜 진행 후 협의된 날짜에 배송이 진행됩니다.<br><br>4. 가구/가전 직배송 해피콜 진행까지는 상품마다 소요되는 준비기간이 다를 수 있어 상품페이지 내 준비기간이 별도 기재해두고 있습니다.<br><br><b>배송비에 따른 배송구분</b><br><br>1. 무료 배송, 조건 배송, 착불 배송으로 나뉘며 구매시 상품 페이지 내에서 확인이 가능합니다.<br><br>2. 무료 배송은 배송비 무료, 조건배송은 구매 희망 브랜드의 무료 배송 조건에 따라 배송비가 부과 될 수 있으며, 착불 배송비는 상품 수령시 배송비를 지불하는 방법입니다.<br><br><b>배송구분확인</b><br><br><b>WEB</b>: 상품 상세페이지 우측<br><b>APP</b>: 상품 상세페이지 썸네일 아래
								<p>답변이 충분하지 않으시다면 1:1상담신청을 이용해 주세요. <a href="javascript:myqnawrite();" class="linkBtn"><strong>1:1상담신청하기</strong></a></p>
							</td>
						</tr>
						
						<tr>
							<td>2</td>
							<td>배송</td>
							<td class="lt"><a href="javascript:showhideFAQ('1', '8','10','152');" class="question" title="배송조회">배송조회</a></td>
						</tr>
						<tr class="answer" id="FAQblock18" style="DISPLAY:none;">
							<td class="ico"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_answer.gif" alt="ANSWER"></td>
							<td colspan="2" class="detail">
								배송 조회는 HOME &gt; MY 텐바이텐&gt; MY 쇼핑리스트 &gt; 주문배송조회  통해 확인이 가능합니다.<br><br>1. 일반 택배 배송은 주문내역서에 입력된 운송장 번호 클릭 하시어 조회가 가능합니다. <br><br>2. 직배송의 경우 기타 배송으로 표시 되며 별도 조회가 되지 않습니다. <br>(기사님 해피콜 진행 시 배송일정 사전 협의 후 배송) <br><br><a href="http://www.10x10.co.kr/my10x10/order/myorderlist.asp"><font color="red">[나의 배송 조회]</font></a><br><br>주문 번호 클릭 시, 구매 상품별 택배 정보 확인 가능하며, 택배 정보에 기재된 운송장 클릭 시 조회가 가능합니다.<br>
								<p>답변이 충분하지 않으시다면 1:1상담신청을 이용해 주세요. <a href="javascript:myqnawrite();" class="linkBtn"><strong>1:1상담신청하기</strong></a></p>
							</td>
						</tr>
						
						<tr>
							<td>1</td>
							<td>취소</td>
							<td class="lt"><a href="javascript:showhideFAQ('1', '9','10','153');" class="question" title="주문취소">주문취소</a></td>
						</tr>
						<tr class="answer" id="FAQblock19" style="DISPLAY:none;">
							<td class="ico"><img src="http://fiximage.10x10.co.kr/web2013/common/ico_answer.gif" alt="ANSWER"></td>
							<td colspan="2" class="detail">
								발송되지 않은 주문건의 경우 사이트내 직접 취소 신청 또는 고객센터를 통하여 취소 접수 가능합니다.<br><br><br><br><b>고객 직접취소</b><br><br>HOME &gt; MY 텐바이텐 &gt; MY 쇼핑리스트 &gt; 주문취소<br><br>사이트내 주문내역 조회 후 [주문취소]버튼을 통하여 취소 접수가 가능합니다.<br><a href="http://www.10x10.co.kr/my10x10/order/order_cancel_detail.asp"><font color="red">[주문취소 바로가기]</font></a><br> <br><br><b>고객센터 통하여 취소</b><br><br>1. 부분 취소 또는 상품 준비 중 취소로 인하여 직접 취소가 불가한 경우 고객센터 1:1 상담 또는 상담톡을 통하여 취소 문의 가능합니다.<br><br>2. 주문취소의 경우 상품 발송 전 취소가 가능하며, 운송장번호 입력 전이더라도 상품이 준비되어 포장 상태일 경우 취소가 불가능 할 수 있습니다.<br><br>3. 주문제작 상품은 제작이 시작되었을 경우 주문 취소가 불가할 수 있습니다.<br><br>4. 가구 또는 가전 등 직접배송되는 품목이나 해외직구 배송의 경우 상품 준비 상태에 따라 취소가 불가능할 수 있습니다.<br>
								<p>답변이 충분하지 않으시다면 1:1상담신청을 이용해 주세요. <a href="javascript:myqnawrite();" class="linkBtn"><strong>1:1상담신청하기</strong></a></p>
							</td>
						</tr>
						
						</tbody>
					</table>
				</div>

				<div class="boardList noticeboard">
					<div class="column">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_notice.gif" alt="공지사항"></h3>
						<ul>
						
							<li>
								<a href="/common/news_popup.asp?idx=19968" onclick="window.open(this.href, 'popNotice', 'width=620, height=750, scrollbars=yes'); return false;" title="[텐바이텐 회원등급제도 변경 공지]">
									[텐바이텐 회원등급제도 변경 공지]
										<img src="http://fiximage.10x10.co.kr/web2013/cscenter/ico_new.gif" alt="NEW">
									
								</a>
								<span>2024.07.31</span>
							</li>
						
							<li>
								<a href="/common/news_popup.asp?idx=19965" onclick="window.open(this.href, 'popNotice', 'width=620, height=750, scrollbars=yes'); return false;" title="고객센터 채팅 상담 임시 중단 안내">
									고객센터 채팅 상담 임시 중단 안내
								</a>
								<span>2024.07.22</span>
							</li>
						
						</ul>
						<div class="moreBtn"><a href="/common/news_list.asp" onclick="window.open(this.href, 'popNotice', 'width=620, height=750, scrollbars=yes'); return false;" title="공지사항 더보기 새창">more</a></div>
					</div>

					<div class="column">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/cscenter/tit_event_win.gif" alt="이벤츠 당첨 안내"></h3>
						<ul>
						
							<li>
								<a href="/common/news_popup.asp?idx=19967&amp;type=E" onclick="window.open(this.href, 'popEvent', 'width=620, height=750, scrollbars=yes'); return false;" title="<더 갖고 싶은 산리오캐릭터즈 핸디팬은?> 당첨자 공지">
									&lt;더 갖고 싶은 산리오캐릭터즈 핸디팬은?&gt; 당첨자 공지
								</a>
								<span>2024.07.30</span>
							</li>
						
						</ul>
						<div class="moreBtn"><a href="/common/news_list.asp?type=E" onclick="window.open(this.href, 'popNotice', 'width=620, height=750, scrollbars=yes'); return false;" title="이벤트 당첨 안내 더보기 새창">more</a></div>
					</div>
				</div>
			</div>
			<!-- //content -->

							<div class="quickMenu">
				<ul class="quick_list02">
					<li class="idPw"><a href="/member/forget.asp">아이디/<br> 비밀번호 찾기</a></li>
					<li class="orderDelivery"><a href="/my10x10/order/myorderlist.asp">주문/<br> 배송조회</a></li>
					<li class="orderCancel"><a href="/my10x10/order/order_cancel_detail.asp">주문취소</a></li>
					<li class="retrun"><a href="/my10x10/order/order_return_detail.asp">반품/환불</a></li>
					<li class="document"><a href="/my10x10/order/document_issue.asp">증빙서류발급</a></li>
					<li class="event"><a href="/my10x10/myeventmaster.asp ">응모한 이벤트</a></li>
					<li class="thanks"><a href="/cscenter/thanks10x10.asp ">고마워, <br>텐바이텐</a></li>
				</ul>
			</div>

			<script type="text/javascript">
				function chatChannel() {
					Kakao.Channel.chat({
					channelPublicId: '_xiAFPs',
					})
				}
			</script>

		</div>
	</div>
</div>
</section>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
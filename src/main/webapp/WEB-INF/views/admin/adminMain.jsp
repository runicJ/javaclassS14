<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>adminMain</title>
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
	<script src="https://kit.fontawesome.com/df66332deb.js" crossorigin="anonymous"></script>
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
	<script src="https://unpkg.com/ionicons@4.5.10-0/dist/ionicons.js"></script>
    <link href="${ctp}/css/admin/c3.min.css" rel="stylesheet">
    <link href="${ctp}/css/admin/chartist.min.css" rel="stylesheet">
    <link href="${ctp}/css/admin/style.min.css" rel="stylesheet">
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/5.16.0/d3.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.7.20/c3.min.js"></script>
    
    <script>
    function sendCoupon(userId) {
	    $.ajax({
	        url: '${ctp}/admin/sendCoupon',
	        type: 'POST',
	        data: { userId: userId },
	        success: function(response) {
	            alert('쿠폰이 발송되었습니다!');
	        },
	        error: function(error) {
	            alert('전송오류!');
	        }
	    });
	}
    </script>
    
</head>
<body>
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
        data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
        <jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
		<jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
        <header class="topbar" data-navbarbg="skin6">
            <nav class="navbar top-navbar navbar-expand-md">
                <div class="navbar-header" data-logobg="skin6">
                    <!-- This is for the sidebar toggle which is visible on mobile only -->
                    <a class="nav-toggler waves-effect waves-light d-block d-md-none" href="javascript:void(0)"><i class="fas fa-bars"></i></a>
                    <div class="navbar-brand">
                        <a href="${ctp}/main">
                            <span class="logo-icon">
                                <img src="${ctp}/images/logo.png" alt="homepage" class="myLogo" style="width:100px;height:auto;"/>
                            </span>
                        </a>
                    </div>
                </div>
                <div class="navbar-collapse collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav float-left mr-auto ml-3 pl-1">
                        <!-- Notification -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle pl-md-3 position-relative" href="javascript:void(0)"
                                id="bell" role="button" data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false">
                                <span><i data-feather="bell" class="svg-icon"></i></span>
                                <span class="badge badge-primary notify-no rounded-circle">5</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-left mailbox animated bounceInDown">
                                <ul class="list-style-none">
                                    <li>
                                        <div class="message-center notifications position-relative">
                                            <!-- Message -->
                                            <a href="javascript:void(0)"
                                                class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                <div class="btn btn-danger rounded-circle btn-circle"><i
                                                        data-feather="airplay" class="text-white"></i></div>
                                                <div class="w-75 d-inline-block v-middle pl-2">
                                                    <h6 class="message-title mb-0 mt-1">Luanch Admin</h6>
                                                    <span class="font-12 text-nowrap d-block text-muted">Just see
                                                        the my new
                                                        admin!</span>
                                                    <span class="font-12 text-nowrap d-block text-muted">9:30 AM</span>
                                                </div>
                                            </a>
                                            <!-- Message -->
                                            <a href="javascript:void(0)"
                                                class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                <span class="btn btn-success text-white rounded-circle btn-circle"><i
                                                        data-feather="calendar" class="text-white"></i></span>
                                                <div class="w-75 d-inline-block v-middle pl-2">
                                                    <h6 class="message-title mb-0 mt-1">Event today</h6>
                                                    <span
                                                        class="font-12 text-nowrap d-block text-muted text-truncate">Just
                                                        a reminder that you have event</span>
                                                    <span class="font-12 text-nowrap d-block text-muted">9:10 AM</span>
                                                </div>
                                            </a>
                                            <!-- Message -->
                                            <a href="javascript:void(0)"
                                                class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                <span class="btn btn-info rounded-circle btn-circle"><i
                                                        data-feather="settings" class="text-white"></i></span>
                                                <div class="w-75 d-inline-block v-middle pl-2">
                                                    <h6 class="message-title mb-0 mt-1">Settings</h6>
                                                    <span
                                                        class="font-12 text-nowrap d-block text-muted text-truncate">You
                                                        can customize this template
                                                        as you want</span>
                                                    <span class="font-12 text-nowrap d-block text-muted">9:08 AM</span>
                                                </div>
                                            </a>
                                            <!-- Message -->
                                            <a href="javascript:void(0)"
                                                class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                <span class="btn btn-primary rounded-circle btn-circle"><i
                                                        data-feather="box" class="text-white"></i></span>
                                                <div class="w-75 d-inline-block v-middle pl-2">
                                                    <h6 class="message-title mb-0 mt-1">Pavan kumar</h6> <span
                                                        class="font-12 text-nowrap d-block text-muted">Just
                                                        see the my admin!</span>
                                                    <span class="font-12 text-nowrap d-block text-muted">9:02 AM</span>
                                                </div>
                                            </a>
                                        </div>
                                    </li>
                                    <li>
                                        <a class="nav-link pt-3 text-center text-dark" href="javascript:void(0);">
                                            <strong>Check all notifications</strong>
                                            <i class="fa fa-angle-right"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i data-feather="settings" class="svg-icon"></i>
                            </a>
                            <!--
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="#">Action</a>
                                <a class="dropdown-item" href="#">Another action</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">Something else here</a>
                            </div>
                              -->
                        </li>
                    </ul>
                    <ul class="navbar-nav float-right">
                        <li class="nav-item d-none d-md-block">
                            <a class="nav-link" href="javascript:void(0)">
                                <form>
                                    <div class="customize-input">
                                        <input class="form-control custom-shadow custom-radius border-0 bg-white"
                                            type="search" placeholder="Search" aria-label="Search">
                                        <i class="form-control-icon" data-feather="search"></i>
                                    </div>
                                </form>
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false">
                                <img src="${ctp}/user/${sImage}" alt="user" class="rounded-circle" width="50" height="50">
                                <span class="ml-2 d-none d-lg-inline-block"><span>안녕하세요,</span> <span
                                        class="text-dark">${sNickName} 님</span> <i data-feather="chevron-down"
                                        class="svg-icon"></i></span>
                            </a>
							
                            <div class="dropdown-menu dropdown-menu-right user-dd animated flipInY">
                            	<!--
                                <a class="dropdown-item" href="javascript:void(0)"><i data-feather="user"
                                        class="svg-icon mr-2 ml-1"></i>
                                    My Profile</a>
                                <a class="dropdown-item" href="javascript:void(0)"><i data-feather="credit-card"
                                        class="svg-icon mr-2 ml-1"></i>
                                    My Balance</a>
                                <a class="dropdown-item" href="javascript:void(0)"><i data-feather="mail"
                                        class="svg-icon mr-2 ml-1"></i>
                                    Inbox</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="javascript:void(0)"><i data-feather="settings"
                                        class="svg-icon mr-2 ml-1"></i>
                                    Account Setting</a>
                                <div class="dropdown-divider"></div>
                                  -->
                                <a class="dropdown-item" href="${ctp}/users/userLogout"><i data-feather="power"
                                        class="svg-icon mr-2 ml-1"></i>
                                    Logout</a>
                                <div class="dropdown-divider"></div>
                                <div class="pl-4 p-3"><a href="${ctp}/admin/adminMain" class="btn btn-sm btn-info">관리자 메인으로</a></div>
                            </div>
                            
                        </li>
                    </ul>
                </div>
            </nav>
        </header>

        <jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
        <div class="page-wrapper">
            <div class="page-breadcrumb">
                <div class="row">
                    <div class="col-7 align-self-center">
                        <h3 class="page-title text-truncate text-dark font-weight-medium mb-1">좋은 하루 되세요:) ${sNickName} 님!</h3>
                        <div class="d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb m-0 p-0">
                                    <li class="breadcrumb-item"><a href="${ctp}/main"><i class="fa-solid fa-house-chimney-window"></i> 메인페이지로</a>
                                    </li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                    <!--
                    <div class="col-5 align-self-center">
                        <div class="customize-input float-right">
                            <select class="custom-select custom-select-set form-control bg-white border-0 custom-shadow custom-radius">
                                <option value="6" selected>2024. 6.</option>
                                <option value="7">2024. 7.</option>
                                <option value="8">2024. 8.</option>
                            </select>
                        </div>
                    </div>
                     -->
                </div>
            </div>

            <div class="container-fluid">
                <div class="card-group">
                    <div class="card border-right">
                        <div class="card-body">
                            <div class="d-flex d-lg-flex d-md-block align-items-center">
                                <div>
                                    <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">즉시 탈퇴 처리 회원</h6>
                                    <div class="d-inline-flex align-items-center">
                                        <h2 class="text-dark mb-1 font-weight-medium"><a href="${ctp}/admin/user/deleteUserList?deleteStatus='탈퇴유예만료'" style="${deleteExUser != 0 ? 'color:red;font-weight:bold;' : ''}">${empty deleteExUser ? 0 : deleteExUser}명</a></h2>
					                    <span class="badge bg-primary font-12 text-white font-weight-medium badge-pill ml-2 d-lg-block d-md-none"> 
										    ${sign}&nbsp;&nbsp;${percentage}
					                    </span>
                                    </div>
                                </div>
                                <div class="ml-auto mt-md-3 mt-lg-0">
                                    <a href="${ctp}/admin/user/userList"><span class="opacity-7 text-muted"><i data-feather="user-plus"></i></span></a>
                                </div>
                            </div>
                            <p>회원 : <a href="${ctp}/admin/user/userList">${empty recentUser ? 0 : recentUser}</a>명 | 탈퇴신청 : <a href="${ctp}/admin/user/deleteUserList">${empty deleteResUser ? 0 : deleteResUser}</a>명</p>
                        </div>
                    </div>
                    <div class="card border-right">
                        <div class="card-body">
                            <div class="d-flex d-lg-flex d-md-block align-items-center">
                                <div>
                                    <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">주문 미처리 현황</h6>
                                    <h2 class="text-dark mb-1 w-100 text-truncate font-weight-medium"><a href="${ctp}/admin/order/orderList?orderStatus='주문'" style="${orderCount != 0 ? 'color:red;font-weight:bold;' : ''}">${empty orderCount ? 0 : orderCount}건</a></h2>
                                </div>
                                <div class="ml-auto mt-md-3 mt-lg-0">
                                    <a href="${ctp}/admin/order/orderList"><span class="opacity-7 text-muted"><i data-feather="dollar-sign"></i></span></a>
                                </div>
                            </div>
                            <p>주문 : <a href="${ctp}/admin/order/orderList">${empty orderCount ? 0 : orderCount}</a>명 | 배송 : <a href="${ctp}/admin/order/orderList">${empty shippingCount ? 0 : shippingCount}</a>명</p>
                        </div>
                    </div>
                    <div class="card border-right">
                        <div class="card-body">
                            <div class="d-flex d-lg-flex d-md-block align-items-center">
                                <div>
                                    <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">제품 문의 미처리 현황</h6>
                                    <div class="d-inline-flex align-items-center">
                                        <h2 class="text-dark mb-1 font-weight-medium"><a href="${ctp}/admin/info/productQnaList" style="${productQnaCount != 0 ? 'color:red;font-weight:bold;' : ''}">${empty productQnaCount ? 0 : productQnaCount}건</a></h2>
                                    </div>
                                </div>
                                <div class="ml-auto mt-md-3 mt-lg-0">
                                    <span class="opacity-7 text-muted"><i data-feather="file-plus"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex d-lg-flex d-md-block align-items-center">
                                <div>
                                    <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">1:1 문의 미처리 현황</h6>
                                    <h2 class="text-dark mb-1 font-weight-medium"><a href="${ctp}/admin/info/qnaList?qnaAnswerFlag='n'" style="${qnaCount != 0 ? 'color:red;font-weight:bold;' : ''}">${empty qnaCount ? 0 : qnaCount}건</a></h2>
                                </div>
                                <div class="ml-auto mt-md-3 mt-lg-0">
                                    <span class="opacity-7 text-muted"><i data-feather="globe"></i></span>
                                </div>
                            </div>
							<p>비회원 : <a href="${ctp}/admin/info/qnaList">${empty qnaGuestCount ? 0 : qnaGuestCount}</a>명 | 회원 : <a href="${ctp}/admin/info/qnaList">${empty qnaUserCount ? 0 : qnaUserCount}</a>명</p>
                        </div>
                    </div>
                </div>
                <div class="row">
					<div class="col-lg-4 col-md-12">
					    <div class="card">
					        <div class="card-body">
					            <h4 class="card-title">회원별 가입목적</h4>
					            <div id="campaign-v2" class="mt-2" style="height:283px; width:100%;"></div>
					            <ul class="list-style-none mb-0">
					                <c:forEach var="wayVO" items="${wayVOS}" varStatus="status">
					                    <li>
											<i class="fas fa-circle font-10 mr-2"
                           						style="color: ${status.index % 6 == 0 ? '#2a9d8f' : status.index % 6 == 1 ? '#e76f51' : status.index % 6 == 2 ? '#f4a261' : status.index % 6 == 3 ? '#9d4edd' : status.index % 6 == 4 ? '#457b9d' : '#a8dadc'};"></i>
					                        <span class="text-muted">${wayVO.registerWay}</span>
					                        <span class="text-dark float-right font-weight-medium">${wayVO.wayCount}</span>
					                    </li>
					                </c:forEach>
					            </ul>
					        </div>
					    </div>
					</div>
                    <div class="col-lg-4 col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">월별 수익 내역</h4>
                                <div class="net-income mt-4 position-relative" style="height:294px;"></div>
                                <ul class="list-inline text-center mt-5 mb-2">
                                    <li class="list-inline-item text-muted font-italic">최근 4개월 판매 건수</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title mb-4">접속 오래된 회원</h4>
                                <table class="table table-hover">
                                	<tr>
                                		<th>이름</th>
                                		<th>접속일</th>
                                		<th>비고</th>
                                	</tr>
                                	<c:forEach var="mailUser" items="${mailUserVOS}">
                                	<tr>
			                            <td>${mailUser.name}</td>
			                            <td>${mailUser.loginTime != null ? fn:substring(mailUser.loginTime,0,10) : fn:substring(mailUser.createDate,0,10)}(${mailUser.lastLogin}일)</td>
			                            <td>
											<button class="badge badge-warning" onclick="sendCoupon('${mailUser.userId}')">메일보내기</button>
			                            </td>
		                            </tr>
		                            </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 
                <div class="row">
                    <div class="col-md-6 col-lg-8">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex align-items-start">
                                    <h4 class="card-title mb-0">지점별 현황표</h4>
                                    <div class="ml-auto">
                                        <div class="dropdown sub-dropdown">
                                            <button class="btn btn-link text-muted dropdown-toggle" type="button"
                                                id="dd1" data-toggle="dropdown" aria-haspopup="true"
                                                aria-expanded="false">
                                                <i data-feather="more-vertical"></i>
                                            </button>
                                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dd1">
                                                <a class="dropdown-item" href="#">Insert</a>
                                                <a class="dropdown-item" href="#">Update</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="pl-4 mb-5">
                                    <div class="stats ct-charts position-relative" style="height: 315px;"></div>
                                </div>
                                <ul class="list-inline text-center mt-4 mb-0">
                                    <li class="list-inline-item text-muted font-italic">Earnings for this month</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">알림 설정(일괄 메시지)</h4>
                                <div class="mt-4 activity">
                                    <div class="d-flex align-items-start border-left-line pb-3">
                                        <div>
                                            <a href="javascript:void(0)" class="btn btn-info btn-circle mb-2 btn-item">
                                                <i data-feather="shopping-cart"></i>
                                            </a>
                                        </div>
                                        <div class="ml-3 mt-2">
                                            <h5 class="text-dark font-weight-medium mb-2">New Product Sold!</h5>
                                            <p class="font-14 mb-2 text-muted">John Musa just purchased <br> Cannon 5M
                                                Camera.
                                            </p>
                                            <span class="font-weight-light font-14 text-muted">10 Minutes Ago</span>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-start border-left-line pb-3">
                                        <div>
                                            <a href="javascript:void(0)"
                                                class="btn btn-danger btn-circle mb-2 btn-item">
                                                <i data-feather="message-square"></i>
                                            </a>
                                        </div>
                                        <div class="ml-3 mt-2">
                                            <h5 class="text-dark font-weight-medium mb-2">New Support Ticket</h5>
                                            <p class="font-14 mb-2 text-muted">Richardson just create support <br>
                                                ticket</p>
                                            <span class="font-weight-light font-14 text-muted">25 Minutes Ago</span>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-start border-left-line">
                                        <div>
                                            <a href="javascript:void(0)" class="btn btn-cyan btn-circle mb-2 btn-item">
                                                <i data-feather="bell"></i>
                                            </a>
                                        </div>
                                        <div class="ml-3 mt-2">
                                            <h5 class="text-dark font-weight-medium mb-2">Notification Pending Order!
                                            </h5>
                                            <p class="font-14 mb-2 text-muted">One Pending order from Ryne <br> Doe</p>
                                            <span class="font-weight-light font-14 mb-1 d-block text-muted">2 Hours
                                                Ago</span>
                                            <a href="javascript:void(0)" class="font-14 border-bottom pb-1 border-info">Load More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
				-->
            </div>
        </div>
    </div>

<p><br/></p>
    <%-- <script src="${ctp}/js/admin/popper.min.js"></script> --%>
    <script src="${ctp}/js/admin/app-style-switcher.js"></script>
    <script src="${ctp}/js/admin/feather.min.js"></script>
    <script src="${ctp}/js/admin/perfect-scrollbar.jquery.min.js"></script>
    <script src="${ctp}/js/admin/sidebarmenu.js"></script>
    <script src="${ctp}/js/admin/custom.min.js"></script>
    <script src="${ctp}/js/admin/d3.min.js"></script>
    <script src="${ctp}/js/admin/c3.min.js"></script>
    <script src="${ctp}/js/admin/chartist.min.js"></script>
    <script src="${ctp}/js/admin/chartist-plugin-tooltip.min.js"></script>
    <%-- <script src="${ctp}/js/admin/dashboard1.min.js"></script> --%>
    <script>
	    $(function() {
	        var wayColumns = [];

	        <c:forEach var="wayVO" items="${wayVOS}" varStatus="status">
	            wayColumns.push(['${wayVO.registerWay}', ${wayVO.wayCount}]);
	        </c:forEach>

	        if (wayColumns.length > 0) {
	            c3.generate({
	                bindto: '#campaign-v2',
	                data: {
	                    columns: wayColumns,
	                    type: 'donut',
	                    tooltip: {
	                        show: true
	                    }
	                },
	                donut: {
	                    label: {
	                        show: false
	                    },
	                    title: "회원 가입 목적",
	                    width: 18
	                },
	                legend: {
	                    hide: false
	                },
	                color: {
	                    pattern: ["#2a9d8f", "#e76f51", "#f4a261", "#9d4edd", "#457b9d", "#a8dadc"]
	                }
	            });

	            d3.select("#campaign-v2 .c3-chart-arcs-title").style("font-family", "Rubik");
	        } else {
	            console.warn("데이터 없음");
	        }
	        
	        var monthlyLabels = [];
	        var monthlyCounts = [];

	        <c:forEach var="sale" items="${monthlySales}">
	            monthlyLabels.push('${sale.month}');
	            monthlyCounts.push(${sale.saleCount});
	        </c:forEach>

	        var monthlySalesData = {
	            labels: monthlyLabels,
	            series: [monthlyCounts]
	        };

	        var options = {
	            axisX: {
	                showGrid: false
	            },
	            axisY: {
	                onlyInteger: true,
	                offset: 20
	            },
	            plugins: [Chartist.plugins.tooltip()],
	            seriesBarDistance: 10,
	            height: '294px'
	        };

	        new Chartist.Bar('.net-income', monthlySalesData, options);

	        jQuery("#visitbylocate").vectorMap({
	            map: "world_mill_en",
	            backgroundColor: "transparent",
	            borderColor: "#000",
	            borderOpacity: 0,
	            borderWidth: 0,
	            zoomOnScroll: !1,
	            color: "#d5dce5",
	            regionStyle: {
	                initial: {
	                    fill: "#d5dce5",
	                    "stroke-width": 1,
	                    stroke: "rgba(255, 255, 255, 0.5)"
	                }
	            },
	            enableZoom: !0,
	            hoverColor: "#bdc9d7",
	            hoverOpacity: null,
	            normalizeFunction: "linear",
	            scaleColors: ["#d5dce5", "#d5dce5"],
	            selectedColor: "#bdc9d7",
	            selectedRegions: [],
	            showTooltip: !0,
	            onRegionClick: function(e, t, o) {
	                var a = 'You clicked "' + o + '" which has the code: ' + t.toUpperCase();
	                alert(a)
	            }
	        });
	        var t = new Chartist.Line(".stats", {
	            labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
	            series: [
	                [11, 10, 15, 21, 14, 23, 12]
	            ]
	        }, {
	            low: 0,
	            high: 28,
	            showArea: !0,
	            fullWidth: !0,
	            plugins: [Chartist.plugins.tooltip()],
	            axisY: {
	                onlyInteger: !0,
	                scaleMinSpace: 40,
	                offset: 20,
	                labelInterpolationFnc: function(e) {
	                    return e / 1 + "k"
	                }
	            }
	        });
	        t.on("draw", function(e) {
	            "area" === e.type && e.element.attr({
	                x1: e.x1 + .001
	            })
	        }), t.on("created", function(e) {
	            e.svg.elem("defs").elem("linearGradient", {
	                id: "gradient",
	                x1: 0,
	                y1: 1,
	                x2: 0,
	                y2: 0
	            }).elem("stop", {
	                offset: 0,
	                "stop-color": "rgba(255, 255, 255, 1)"
	            }).parent().elem("stop", {
	                offset: 1,
	                "stop-color": "rgba(80, 153, 255, 1)"
	            })
	        }), $(window).on("resize", function() {
	            t.update()
	        })
	    });
	    
    </script>
</body>
</html>
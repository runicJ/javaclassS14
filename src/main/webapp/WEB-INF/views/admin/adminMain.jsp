<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>adminMain</title>
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
</head>
<body>
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <!-- ============================================================== -->
    <!-- Main wrapper - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
        data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
        <!-- ============================================================== -->
        <!-- Topbar header - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <header class="topbar" data-navbarbg="skin6">
            <nav class="navbar top-navbar navbar-expand-md">
                <div class="navbar-header" data-logobg="skin6">
                    <!-- This is for the sidebar toggle which is visible on mobile only -->
                    <a class="nav-toggler waves-effect waves-light d-block d-md-none" href="javascript:void(0)"><i
                            class="ti-menu ti-close"></i></a>
                    <div class="navbar-brand">
                        <a href="${ctp}/main">
                            <span class="logo-icon">
                                <img src="${ctp}/images/logo.png" alt="homepage" class="myLogo" style="width:100px;height:auto;"/>
                            </span>
                        </a>
                    </div>
                </div>
                <div class="navbar-collapse collapse" id="navbarSupportedContent">
                    <!-- ============================================================== -->
                    <!-- toggle and nav items -->
                    <!-- ============================================================== -->
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
                        <!-- End Notification -->
                        <!-- ============================================================== -->
                        <!-- create new -->
                        <!-- ============================================================== -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i data-feather="settings" class="svg-icon"></i>
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="#">Action</a>
                                <a class="dropdown-item" href="#">Another action</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">Something else here</a>
                            </div>
                        </li>
                    </ul>
                    <!-- ============================================================== -->
                    <!-- Right side toggle and nav items -->
                    <!-- ============================================================== -->
                    <ul class="navbar-nav float-right">
                        <!-- ============================================================== -->
                        <!-- Search -->
                        <!-- ============================================================== -->
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
                        <!-- ============================================================== -->
                        <!-- User profile and search -->
                        <!-- ============================================================== -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false">
                                <img src="${ctp}/user/noImage.jpg" alt="user" class="rounded-circle"
                                    width="40">
                                <span class="ml-2 d-none d-lg-inline-block"><span>안녕하세요,</span> <span
                                        class="text-dark">${sNickName} 님</span> <i data-feather="chevron-down"
                                        class="svg-icon"></i></span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right user-dd animated flipInY">
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
                                <a class="dropdown-item" href="javascript:void(0)"><i data-feather="power"
                                        class="svg-icon mr-2 ml-1"></i>
                                    Logout</a>
                                <div class="dropdown-divider"></div>
                                <div class="pl-4 p-3"><a href="javascript:void(0)" class="btn btn-sm btn-info">View
                                        Profile</a></div>
                            </div>
                        </li>
                        <!-- ============================================================== -->
                        <!-- User profile and search -->
                        <!-- ============================================================== -->
                    </ul>
                </div>
            </nav>
        </header>
        <!-- ============================================================== -->
        <!-- End Topbar header -->
        <!-- ============================================================== -->
        <jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
        <div class="page-wrapper">
            <div class="page-breadcrumb">
                <div class="row">
                    <div class="col-7 align-self-center">
                        <h3 class="page-title text-truncate text-dark font-weight-medium mb-1">좋은 하루 되세요:) ${sNickName} 님!</h3>
                        <div class="d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb m-0 p-0">
                                    <li class="breadcrumb-item"><a href="${ctp}/main"><i class="icon-home">메인페이지로</i></a>
                                    </li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                    <div class="col-5 align-self-center">
                        <div class="customize-input float-right">
                            <select class="custom-select custom-select-set form-control bg-white border-0 custom-shadow custom-radius">
                                <option value="6" selected>2024. 6.</option>
                                <option value="7">2024. 7.</option>
                                <option value="8">2024. 8.</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- End Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Container fluid  -->
            <!-- ============================================================== -->
            <div class="container-fluid">
                <!-- *************************************************************** -->
                <!-- Start First Cards -->
                <!-- *************************************************************** -->
                <div class="card-group">
                    <div class="card border-right">
                        <div class="card-body">
                            <div class="d-flex d-lg-flex d-md-block align-items-center">
                                <div>
                                    <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">회원 미처리 현황</h6>
                                    <div class="d-inline-flex align-items-center">
                                        <h2 class="text-dark mb-1 font-weight-medium">236</h2>
                                        <span
                                            class="badge bg-primary font-12 text-white font-weight-medium badge-pill ml-2 d-lg-block d-md-none">+18.33%</span>
                                    </div>
                                </div>
                                <div class="ml-auto mt-md-3 mt-lg-0">
                                    <span class="opacity-7 text-muted"><i data-feather="user-plus"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card border-right">
                        <div class="card-body">
                            <div class="d-flex d-lg-flex d-md-block align-items-center">
                                <div>
                                    <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">주문 관련 미처리 현황</h6>
                                    <h2 class="text-dark mb-1 w-100 text-truncate font-weight-medium"><sup class="set-doller">$</sup>18,306</h2>
                                </div>
                                <div class="ml-auto mt-md-3 mt-lg-0">
                                    <span class="opacity-7 text-muted"><i data-feather="dollar-sign"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card border-right">
                        <div class="card-body">
                            <div class="d-flex d-lg-flex d-md-block align-items-center">
                                <div>
                                    <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">배송 관련 미처리 현황</h6>
                                    <div class="d-inline-flex align-items-center">
                                        <h2 class="text-dark mb-1 font-weight-medium">1538</h2>
                                        <span
                                            class="badge bg-danger font-12 text-white font-weight-medium badge-pill ml-2 d-md-none d-lg-block">-18.33%</span>
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
                                    <h6 class="text-muted font-weight-normal mb-0 w-100 text-truncate">문의 미처리 현황</h6>
                                    <h2 class="text-dark mb-1 font-weight-medium">864</h2>
                                </div>
                                <div class="ml-auto mt-md-3 mt-lg-0">
                                    <span class="opacity-7 text-muted"><i data-feather="globe"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- *************************************************************** -->
                <!-- End First Cards -->
                <!-- *************************************************************** -->
                <!-- *************************************************************** -->
                <!-- Start Sales Charts Section -->
                <!-- *************************************************************** -->
                <div class="row">
                    <div class="col-lg-4 col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">회원별 가입목적</h4>
                                <div id="campaign-v2" class="mt-2" style="height:283px; width:100%;"></div>
                                <ul class="list-style-none mb-0">
                                    <li>
                                        <i class="fas fa-circle text-primary font-10 mr-2"></i>
                                        <span class="text-muted">Direct Sales</span>
                                        <span class="text-dark float-right font-weight-medium">$2346</span>
                                    </li>
                                    <li class="mt-3">
                                        <i class="fas fa-circle text-danger font-10 mr-2"></i>
                                        <span class="text-muted">Referral Sales</span>
                                        <span class="text-dark float-right font-weight-medium">$2108</span>
                                    </li>
                                    <li class="mt-3">
                                        <i class="fas fa-circle text-cyan font-10 mr-2"></i>
                                        <span class="text-muted">Affiliate Sales</span>
                                        <span class="text-dark float-right font-weight-medium">$1204</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">이번주 수익 내역</h4>
                                <div class="net-income mt-4 position-relative" style="height:294px;"></div>
                                <ul class="list-inline text-center mt-5 mb-2">
                                    <li class="list-inline-item text-muted font-italic">Sales for this month</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title mb-4">접속기록이 오래된 회원</h4>
                                <div class="" style="height:180px">
                                    <div id="visitbylocate" style="height:100%"></div>
                                </div>
                                <div class="row mb-3 align-items-center mt-1 mt-5">
                                    <div class="col-4 text-right">
                                        <span class="text-muted font-14">India</span>
                                    </div>
                                    <div class="col-5">
                                        <div class="progress" style="height: 5px;">
                                            <div class="progress-bar bg-primary" role="progressbar" style="width: 100%"
                                                aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                    <div class="col-3 text-right">
                                        <span class="mb-0 font-14 text-dark font-weight-medium">28%</span>
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <div class="col-4 text-right">
                                        <span class="text-muted font-14">UK</span>
                                    </div>
                                    <div class="col-5">
                                        <div class="progress" style="height: 5px;">
                                            <div class="progress-bar bg-danger" role="progressbar" style="width: 74%"
                                                aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                    <div class="col-3 text-right">
                                        <span class="mb-0 font-14 text-dark font-weight-medium">21%</span>
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <div class="col-4 text-right">
                                        <span class="text-muted font-14">USA</span>
                                    </div>
                                    <div class="col-5">
                                        <div class="progress" style="height: 5px;">
                                            <div class="progress-bar bg-cyan" role="progressbar" style="width: 60%"
                                                aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                    <div class="col-3 text-right">
                                        <span class="mb-0 font-14 text-dark font-weight-medium">18%</span>
                                    </div>
                                </div>
                                <div class="row align-items-center">
                                    <div class="col-4 text-right">
                                        <span class="text-muted font-14">China</span>
                                    </div>
                                    <div class="col-5">
                                        <div class="progress" style="height: 5px;">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: 50%"
                                                aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                    <div class="col-3 text-right">
                                        <span class="mb-0 font-14 text-dark font-weight-medium">12%</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- *************************************************************** -->
                <!-- End Sales Charts Section -->
                <!-- *************************************************************** -->
                <!-- *************************************************************** -->
                <!-- Start Location and Earnings Charts Section -->
                <!-- *************************************************************** -->
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
                <!-- *************************************************************** -->
                <!-- End Location and Earnings Charts Section -->
                <!-- *************************************************************** -->
            </div>
            <!-- ============================================================== -->
            <!-- End Container fluid  -->
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Page wrapper  -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
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
    <script src="${ctp}/js/admin/dashboard1.min.js"></script>
</body>
</html>
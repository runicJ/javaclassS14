<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<aside class="left-sidebar" data-sidebarbg="skin6">
    <!-- Sidebar scroll-->
    <div class="scroll-sidebar" data-sidebarbg="skin6">
        <!-- Sidebar navigation-->
        <nav class="sidebar-nav">
            <ul id="sidebarnav">
                <li class="sidebar-item"> <a class="sidebar-link sidebar-link" href="${ctp}/admin/adminMain"
                          aria-expanded="false"><i data-feather="home" class="feather-icon"></i><span
                              class="hide-menu">관리자 메인</span></a></li>
                  <li class="list-divider"></li>
                  
                  <li class="nav-small-cap"><span class="hide-menu">우선 관리 목록</span></li>
                  
				<li class="sidebar-item"><a class="sidebar-link has-arrow" href="javascript:void(0)"
                      aria-expanded="false"><i data-feather="feather" class="feather-icon">
                      </i><span class="hide-menu"> 회원 관리</span></a>
                      <ul aria-expanded="false" class="collapse first-level base-level-line">
                          <li class="sidebar-item"><a href="${ctp}/admin/user/userList" class="sidebar-link">
                        <span class="hide-menu"> 현재 회원 리스트 </span></a></li>
                        <li class="sidebar-item"><a href="${ctp}/admin/user/deleteUserList" class="sidebar-link">
                        <span class="hide-menu"> 탈퇴 회원 정보 </span></a></li>
                    </ul>
                </li>
                <li class="sidebar-item"><a class="sidebar-link has-arrow" href="javascript:void(0)" 
                	aria-expanded="false"><i data-feather="tag" class="feather-icon">
                	</i><span class="hide-menu"> 주문 관리</span></a>
      	            <ul aria-expanded="false" class="collapse first-level base-level-line">
                        <li class="sidebar-item"><a href="${ctp}/admin/order/orderList" class="sidebar-link">
                        <span class="hide-menu"> 주문 상세 목록 </span></a></li>
                        <li class="sidebar-item"><a href="${ctp}/admin/order/orderCancelList" class="sidebar-link">
                        <span class="hide-menu"> 주문 상세 출력 관리 </span></a></li>
                    </ul>
                </li>
                
                <li class="sidebar-item"><a class="sidebar-link has-arrow" href="javascript:void(0)" 
                aria-expanded="false"><i data-feather="sidebar" class="feather-icon">
                </i><span class="hide-menu"> 제품 종합 관리</span></a>
                	<ul aria-expanded="false" class="collapse first-level base-level-line">
                        <li class="sidebar-item"><a href="${ctp}/admin/shop/productList" class="sidebar-link">
                        <span class="hide-menu"> 판매 제품 목록 </span></a></li>
                        <li class="sidebar-item"><a href="${ctp}/admin/shop/productCategory" class="sidebar-link">
                        <span class="hide-menu"> 제품 카테고리 등록 </span></a></li>
                        <li class="sidebar-item"><a href="${ctp}/admin/shop/productInput" class="sidebar-link">
                        <span class="hide-menu"> 제품 판매글 등록 </span></a></li>
                        <li class="sidebar-item"><a href="${ctp}/admin/shop/productOption" class="sidebar-link">
                        <span class="hide-menu"> 제품 옵션사항 등록 </span></a></li>
                   </ul>
                </li>
                <li class="sidebar-item">
                	<a class="sidebar-link has-arrow" href="javascript:void(0)" aria-expanded="false">
                		<i data-feather="edit-3" class="feather-icon"></i>
                		<span class="hide-menu"> 게시글 관리</span>
                	</a>
                    <ul aria-expanded="false" class="collapse first-level base-level-line">
                        <li class="sidebar-item">
                        	<a href="${ctp}/admin/info/noticeInput" class="sidebar-link"><span class="hide-menu"> 공지사항 관리</span></a>
                        </li>
                    </ul>
                </li>
                <li class="sidebar-item">
                	<a class="sidebar-link sidebar-link" href="${ctp}/admin/info/qnaList" aria-expanded="false">
                 	<i data-feather="message-square" class="feather-icon"></i>
                 	<span class="hide-menu"> 문의글 관리</span>
                	</a>
                </li>

                <li class="list-divider"></li>
                
                <li class="nav-small-cap"><span class="hide-menu">선택 관리 목록</span></li>
                    <li class="sidebar-item">
                    	<a class="sidebar-link has-arrow" href="javascript:void(0)" aria-expanded="false">
                     	<i data-feather="crosshair" class="feather-icon"></i>
                     	<span class="hide-menu"> 병원/지점 관리</span>
                    	</a>
                    <ul aria-expanded="false" class="collapse first-level base-level-line">
                        <li class="sidebar-item"><a href="javascript:void(0)" class="sidebar-link"><span class="hide-menu"> 병원 정보 관리</span></a>
                        </li>
                        <li class="sidebar-item"> <a class="has-arrow sidebar-link" href="javascript:void(0)" aria-expanded="false"><span class="hide-menu">지점 관리</span></a>
                            <ul aria-expanded="false" class="collapse second-level base-level-line">
                                <li class="sidebar-item"><a href="${ctp}/admin/info/branchInput" class="sidebar-link"><span class="hide-menu">지점 등록</span></a></li>
                                <li class="sidebar-item"><a href="javascript:void(0)" class="sidebar-link"><span class="hide-menu">지점 발주 관리</span></a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
                
                <li class="sidebar-item"> <a class="sidebar-link has-arrow" href="javascript:void(0)"
                        aria-expanded="false"><i data-feather="box" class="feather-icon"></i><span
                            class="hide-menu"> 광고 관리 </span></a>
                    <ul aria-expanded="false" class="collapse  first-level base-level-line">
                        <li class="sidebar-item"><a href="form-input-grid.html" class="sidebar-link"><span
                                    class="hide-menu"> 광고신청목록
                                </span></a>
                        </li>
                    </ul>
                </li>
                <li class="sidebar-item"> <a class="sidebar-link has-arrow" href="javascript:void(0)"
                        aria-expanded="false"><i data-feather="bar-chart" class="feather-icon"></i><span
                            class="hide-menu"> 통계 목록 </span></a>
                    <ul aria-expanded="false" class="collapse  first-level base-level-line">
                        <li class="sidebar-item"><a href="${ctp}/admin/survey/surveyInput" class="sidebar-link"><span
                                    class="hide-menu"> 설문조사 등록
                                </span></a>
                        </li>
                        <li class="sidebar-item"><a href="${ctp}/admin/survey/surveyList" class="sidebar-link"><span
                                    class="hide-menu"> 설문조사 리스트
                                </span></a>
                        </li>
                        <li class="sidebar-item"><a href="${ctp}/survey/surveyDetails" class="sidebar-link"><span
                                    class="hide-menu">
                                    설문별 통계 현황
                                </span></a>
                        </li>
                    </ul>
                </li>
                
                <li class="sidebar-item"> <a class="sidebar-link sidebar-link" href="authentication-register1.html" aria-expanded="false">
                	<i data-feather="lock" class="feather-icon"></i><span class="hide-menu">덤프 파일 정리</span></a>
                </li>
                
                <li class="list-divider"></li>

                <li class="sidebar-item">
                	<a class="sidebar-link sidebar-link" href="${ctp}/users/userLogout" aria-expanded="false">
                	<i data-feather="log-out" class="feather-icon"></i><span class="hide-menu">끝내기</span></a>
                </li>
            </ul>
        </nav>
        <!-- End Sidebar navigation -->
    </div>
    <!-- End Sidebar scroll-->
</aside>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<header class="primary">
    <div class="firstbar">
        <div class="container">
            <div class="row">
                <div class="col-md-2 col-sm-12">
                    <div class="brand">
                        <a href="http://localhost:9090/javaclassS14/main">
                        <!-- <a href="http://49.142.159.251:9090/javaclassS14/main"> -->
                            <img src="${ctp}/images/logo.png" alt="myLogo">
                        </a>
                    </div>                        
                </div>

                <div class="col-md-6 col-sm-12">
                    <form class="search" action="${ctp}/search" method="GET" autocomplete="off">
                        <div class="form-group">
                            <div class="input-group">
                                <input type="text" name="keyword" class="form-control" placeholder="당신의 걱정을 덜어내세요">
                                <div class="input-group-btn">
                                    <button type="submit" class="btn btn-primary"><i class="ion-search"></i></button>
                                </div>
                            </div>
                        </div>
                         <div class="help-block">
                            <div>인기검색어:</div>
                            <ul>
                                <li><a href="#">아이</a></li>
                                <li><a href="#">알레르망</a></li>
                                <li><a href="#">알레르기</a></li>
                            </ul>
                        </div>
                    </form>
                </div>

                <div class="col-md-4 col-sm-12 text-right">
                    <ul class="nav-icons">
                        <c:if test="${empty sUid}">
                            <li><a href="${ctp}/"><i class="fa-solid fa-bullhorn"></i><span style="font-size:0.8em;">0</span></a></li>
                            <li><a href="${ctp}/shop/productCart"><i class="fa-solid fa-cart-shopping"></i><span style="font-size:0.8em;">${cartCount}</span></a></li>
                            <li><a href="${ctp}/users/userPolicy"><i class="fa-solid fa-user-group"></i><span> 회원가입</span></a></li>
                            <li><a href="${ctp}/users/userLogin"><i class="ion-person"></i><span>로그인</span></a></li>
                        </c:if>
                        <c:if test="${!empty sUid}">
                            <c:choose>
                                <c:when test="${sUid == 'admin'}">
                                    <li><a href="${ctp}/"><i class="fas fa-bell"></i><span style="font-size:0.8em;">0</span></a></li>
                                    <li><a href="${ctp}/shop/productCart"><i class="fa-solid fa-cart-shopping"></i><span style="font-size:0.8em;">${cartCount}</span></a></li>
                                    <li><a href="${ctp}/admin/adminMain"><i class="ion-person"></i><span>관리자페이지</span></a></li>
                                    <li><a href="${ctp}/users/userLogout"><i class="fa-solid fa-right-from-bracket"></i><span>끝내기</span></a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="${ctp}/"><i class="fa-solid fa-bullhorn"></i><span style="font-size:0.8em;">0</span></a></li>
                                    <li><a href="${ctp}/shop/productCart"><i class="fa-solid fa-cart-shopping"></i><span style="font-size:0.8em;">${cartCount}</span></a></li>
                                    <li><a href="${ctp}/users/userMain"><i class="ion-person"></i><span>마이페이지</span></a></li>
                                    <li><a href="${ctp}/users/userLogout"><i class="fa-solid fa-right-from-bracket"></i><span>로그아웃</span></a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </div>

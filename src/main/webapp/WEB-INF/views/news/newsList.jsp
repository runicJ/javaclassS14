<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알레르기 관련 뉴스</title>
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
    <link rel="stylesheet" href="${ctp}/css/custom.css">
    <script src="${ctp}/js/custom.js"></script>
    <style>
        .article-mini:hover {
            opacity: 0.8;
            background-color: #eee;
        }
    </style>
    <script>

    </script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/user/header.jsp" />
    <jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
    <section>
        <div class="container">
            <h2 class="text-center">사이트 별 '알레르기' 관련 뉴스</h2>
            <div class="line"></div>
            <div class="row">
                 <!-- Naver News Column -->
                <div class="col-md-4 col-sm-4">
                    <h1 class="title-col">네이버 뉴스</h1>
                    <div id="naver-news" class="body-col">
                        <c:if test="${!empty vos}">
                            <c:forEach var="vo" items="${vos}" varStatus="status">
                                <article class="article-mini">
                                    <div class="inner">
                                        <figure>
                                            <c:choose>
                                                <c:when test="${!empty vo.item2}">
                                                    <img src="${vo.item2}" alt="news image" style="object-fit:cover; width: 100%; height: auto;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${ctp}/images/noImage.jpg" alt="default image" style="object-fit:cover; width: 100%; height: auto;">
                                                </c:otherwise>
                                            </c:choose>
                                        </figure>
                                        <div class="padding">
                                            <h1>
                                                <a href="${vo.itemUrl1}" target="_blank">
                                                    <c:choose>
                                                        <c:when test="${fn:length(vo.item1) gt 50}">
                                                            <c:out value="${fn:substring(vo.item1,0,50)}" />...
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:out value="${vo.item1}" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </h1>
                                            <div class="detail">
                                                <div class="category">
                                                    <c:choose>
                                                        <c:when test="${fn:length(vo.item4) gt 15}">
                                                            <c:out value="${fn:substring(vo.item4,0,15)}" />...
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:out value="${vo.item4}" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="time">${vo.item5}</div>
                                            </div>
                                        </div>
                                    </div>
                                </article>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty vos}">
                            <article class="article-mini">
                                <p>spinner</p>
                                <span>뉴스 업데이트 중입니다..<br>잠시만 기다려주세요..<br>(서버 '수리중'일 수 있습니다.)</span>
                            </article>
                        </c:if>
                    </div>
                </div>
                <!-- Nature News Column -->
                <div class="col-md-4 col-sm-4">
                    <h1 class="title-col">네이처 저널</h1>
                    <div id="nature-news" class="body-col">
                        <c:if test="${!empty nVos}">
                            <c:forEach var="nVo" items="${nVos}" varStatus="status">
                                <article class="article-mini">
                                    <div class="inner">
                                        <figure>
                                            <c:choose>
                                                <c:when test="${!empty nVo.item2}">
                                                    <img src="${nVo.item2}" alt="news image" style="object-fit:cover; width: 100%; height: auto;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${ctp}/images/noImage.jpg" alt="default image" style="object-fit:cover; width: 100%; height: auto;">
                                                </c:otherwise>
                                            </c:choose>
                                        </figure>
                                        <div class="padding">
                                            <h1>
                                                <a href="${nVo.itemUrl1}" target="_blank">
                                                    <c:choose>
                                                        <c:when test="${fn:length(nVo.item1) gt 50}">
                                                            <c:out value="${fn:substring(nVo.item1,0,50)}" />...
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:out value="${nVo.item1}" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </h1>
                                            <div class="detail">
                                                <div class="category">
                                                    <c:choose>
                                                        <c:when test="${fn:length(nVo.item4) gt 15}">
                                                            <c:out value="${fn:substring(nVo.item4,0,15)}" />...
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:out value="${nVo.item4}" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="time">${nVo.item5}</div>
                                            </div>
                                        </div>
                                    </div>
                                </article>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty nVos}">
                            <article class="article-mini">
                                <p>spinner</p>
                                <span>뉴스 업데이트 중입니다..<br>잠시만 기다려주세요..<br>(서버 '수리중'일 수 있습니다.)</span>
                            </article>
                        </c:if>
                    </div>
                </div>
                <!-- Google News Column -->
                <div class="col-md-4 col-sm-4">
                    <h1 class="title-col">Google 뉴스</h1>
                    <div id="google-news" class="body-col">
                        <c:if test="${!empty bVos}">
                            <c:forEach var="bVo" items="${bVos}" varStatus="status">
                                <article class="article-mini">
                                    <div class="inner">
                                        <figure>
                                            <c:choose>
                                                <c:when test="${!empty bVo.item2}">
                                                    <img src="${bVo.item2}" alt="news image" style="object-fit:cover; width: 100%; height: auto;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${ctp}/images/noImage.jpg" alt="default image" style="object-fit:cover; width: 100%; height: auto;">
                                                </c:otherwise>
                                            </c:choose>
                                        </figure>
                                        <div class="padding">
                                            <h1>
                                                <a href="${bVo.itemUrl1}" target="_blank">
                                                    <c:choose>
                                                        <c:when test="${fn:length(bVo.item1) gt 50}">
                                                            <c:out value="${fn:substring(bVo.item1,0,50)}" />...
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:out value="${bVo.item1}" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </h1>
                                            <div class="detail">
                                                <div class="category">
                                                    <c:choose>
                                                        <c:when test="${fn:length(bVo.item4) gt 15}">
                                                            <c:out value="${fn:substring(bVo.item4,0,15)}" />...
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:out value="${bVo.item4}" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="time">${bVo.item5}</div>
                                            </div>
                                        </div>
                                    </div>
                                </article>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty bVos}">
                            <article class="article-mini">
                                <p>spinner</p>
                                <span>뉴스 업데이트 중입니다..<br>잠시만 기다려주세요..<br>(서버 '수리중'일 수 있습니다.)</span>
                            </article>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="line"></div>
        </div>
        <a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
    </section>
    <jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
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
    <script src="${ctp}/js/skeletonJS.js"></script>
    <style>
        .article-mini:hover {
            opacity: 0.8;
            background-color: #eee;
        }
        
        .skeleton {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .skeleton-thumbnail {
            width: 100px;
            height: 60px;
            background-color: #e0e0e0;
            border-radius: 4px;
            margin-right: 10px;
        }

        .skeleton-content {
            flex: 1;
        }

        .skeleton-title, .skeleton-details {
            height: 20px;
            background-color: #e0e0e0;
            margin-bottom: 10px;
            border-radius: 4px;
            width: 80%;
        }

        .skeleton-title {
            width: 60%;
        }

        .skeleton-details {
            width: 100%;
        }

        @keyframes skeleton-loading {
            0% {
                background-color: #e0e0e0;
            }
            50% {
                background-color: #f0f0f0;
            }
            100% {
                background-color: #e0e0e0;
            }
        }

        .skeleton-thumbnail, .skeleton-title, .skeleton-details {
            animation: skeleton-loading 1.5s infinite linear;
        }

        .hidden {
            display: none;
        }

        .more-btn {
            display: block;
            width: 100%;
            text-align: center;
            color: white;
            padding: 10px;
            margin: 20px 0;
            cursor: pointer;
        }

        .more-btn:hover {
            background-color: #0056b3;
        }

        .no-more {
            text-align: center;
            color: #777;
            font-size: 14px;
            margin-top: 20px;
        }
        
        .current-time {
            text-align: right;
            color: #8d4620;
            font-size: 18px;
        }
    </style>
    <script>
        function showMoreNews(sectionId) {
            const section = document.getElementById(sectionId);
            const hiddenArticles = section.querySelectorAll('.article-mini.hidden');
            hiddenArticles.forEach((article, index) => {
                if (index < 10) { // 한 번에 10개씩 더 보여줌
                    article.classList.remove('hidden');
                }
            });
            if (hiddenArticles.length <= 10) {
                section.querySelector('.more-btn').style.display = 'none';
                const noMoreMsg = section.querySelector('.no-more');
                if (noMoreMsg) {
                    noMoreMsg.style.display = 'block';
                }
            }
        }
        
        function updateTime() {
            const now = new Date();
            const formattedTime = now.toLocaleString('ko-KR', {
                year: 'numeric', month: '2-digit', day: '2-digit',
                hour: '2-digit', minute: '2-digit', second: '2-digit',
                hour12: false
            });
            document.getElementById('current-time').innerHTML = ` <i class="fa-regular fa-clock"></i> 현재 시간 기준 - [ ` + formattedTime + " ]";
        }
        
        document.addEventListener('DOMContentLoaded', () => {
            updateTime();
            setInterval(updateTime, 1000);
        });
    </script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/user/header.jsp" />
    <jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
    <section>
        <div class="container">
            <h2 class="text-center">사이트 별 '알레르기' 관련 뉴스</h2>
            <div class="current-time mt-5" id="current-time"></div>
            <div class="line"></div>
            <div class="row">
                <!-- Naver News Column -->
                <div class="col-md-4 col-sm-4" id="naver-news-section">
                    <h1 class="title-col">네이버 뉴스</h1>
                    <div class="body-col">
                        <c:if test="${empty vos}">
                            <!-- 스켈레톤 로딩 표시 -->
                            <c:forEach var="i" begin="0" end="2">
                                <div class="skeleton">
                                    <div class="skeleton-thumbnail"></div>
                                    <div class="skeleton-content">
                                        <div class="skeleton-title"></div>
                                        <div class="skeleton-details"></div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${!empty vos}">
                            <c:forEach var="vo" items="${vos}" varStatus="status">
                                <article class="article-mini ${status.index >= 10 ? 'hidden' : ''}">
                                    <div class="inner">
                                        <figure>
                                            <c:choose>
                                                <c:when test="${!empty vo.item2}">
                                                    <img src="${vo.item2}" alt="news image" style="object-fit:cover; width: 100%; height: auto;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${ctp}/images/noImage.png" alt="default image" style="object-fit:cover; width: 100%; height: auto;">
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
                            <div class="more-btn btn btn-info" onclick="showMoreNews('naver-news-section')">더보기</div>
                            <div class="no-more" style="display: none;">더 이상 자료가 존재하지 않습니다.</div>
                        </c:if>
                    </div>
                </div>
                <!-- Nature News Column -->
                <div class="col-md-4 col-sm-4" id="nature-news-section">
                    <h1 class="title-col">네이처 저널</h1>
                    <div class="body-col">
                        <c:if test="${empty nVos}">
                            <!-- 스켈레톤 로딩 표시 -->
                            <c:forEach var="i" begin="0" end="2">
                                <div class="skeleton">
                                    <div class="skeleton-thumbnail"></div>
                                    <div class="skeleton-content">
                                        <div class="skeleton-title"></div>
                                        <div class="skeleton-details"></div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${!empty nVos}">
                            <c:forEach var="nVo" items="${nVos}" varStatus="status">
                                <article class="article-mini ${status.index >= 10 ? 'hidden' : ''}">
                                    <div class="inner">
                                        <figure>
                                            <c:choose>
                                                <c:when test="${!empty nVo.item2}">
                                                    <img src="${nVo.item2}" alt="news image" style="object-fit:cover; width: 100%; height: auto;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${ctp}/images/noImage.png" alt="default image" style="object-fit:cover; width: 100%; height: auto;">
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
                            <div class="more-btn btn btn-info" onclick="showMoreNews('nature-news-section')">더보기</div>
                            <div class="no-more" style="display: none;">더 이상 자료가 존재하지 않습니다.</div>
                        </c:if>
                    </div>
                </div>
                <!-- google News Column -->
                <div class="col-md-4 col-sm-4" id="google-news-section">
                    <h1 class="title-col">Google 뉴스</h1>
                    <div class="body-col">
                        <c:if test="${empty dVos}">
                            <!-- 스켈레톤 로딩 표시 -->
                            <c:forEach var="i" begin="0" end="2">
                                <div class="skeleton">
                                    <div class="skeleton-thumbnail"></div>
                                    <div class="skeleton-content">
                                        <div class="skeleton-title"></div>
                                        <div class="skeleton-details"></div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${!empty dVos}">
                            <c:forEach var="dVo" items="${dVos}" varStatus="status">
                                <article class="article-mini ${status.index >= 10 ? 'hidden' : ''}">
                                    <div class="inner">
                                        <figure>
                                            <c:choose>
                                                <c:when test="${!empty dVo.item2}">
                                                    <img src="${dVo.item2}" alt="news image" style="object-fit:cover; width: 100%; height: auto;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${ctp}/images/noImage.png" alt="default image" style="object-fit:cover; width: 100%; height: auto;">
                                                </c:otherwise>
                                            </c:choose>
                                        </figure>
                                        <div class="padding">
                                            <h1>
                                                <a href="${dVo.itemUrl1}" target="_blank">
                                                    <c:choose>
                                                        <c:when test="${fn:length(dVo.item1) gt 50}">
                                                            <c:out value="${fn:substring(dVo.item1,0,50)}" />...
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:out value="${dVo.item1}" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </h1>
                                            <div class="detail">
                                                <div class="category">
                                                    <c:choose>
                                                        <c:when test="${fn:length(dVo.item4) gt 15}">
                                                            <c:out value="${fn:substring(dVo.item4,0,15)}" />...
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:out value="${dVo.item4}" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="time">${dVo.item5}</div>
                                            </div>
                                        </div>
                                    </div>
                                </article>
                            </c:forEach>
                            <div class="more-btn btn btn-info" onclick="showMoreNews('google-news-section')">더보기</div>
                            <div class="no-more" style="display: none;">더 이상 자료가 존재하지 않습니다.</div>
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

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
        
        

body {
  -webkit-transform:translateZ(0);
}
/*
----------------------------------------------
Wrapper 
----------------------------------------------
*/
#loader {
  position:absolute;
  top:0;
  right:0;
  bottom:0;
  left:0;
  width:100%;
  height:100%;
  display:flex;
  flex-direction:column;
  justify-content:center;
  align-items:center;
  background:#E9E8E3;
  z-index:99;
  -webkit-animation:offscreen .5s 15s forwards;
  animation:offscreen .5s 15s forwards;
}
.refresh {
  color:#E9E8E3;
  font-family:'Open Sans Condensed', sans-serif;
  font-size:2rem;
  text-transform:uppercase;
  letter-spacing:.1rem;
}
.face {
  width:270px;
  height:270px;
}
/*
----------------------------------------------
SVG 
----------------------------------------------
*/
.head {
  transform-origin: 135px 135px;
  transform:scale(0);
  -webkit-animation:popup .6s 1s cubic-bezier(0.95, 0.05, 0.795, 0.035) forwards;
  animation:popup .6s 1s cubic-bezier(0.95, 0.05, 0.795, 0.035) forwards;
}
#eyeLeft, #eyeRight {
  transform:scale(0);
}
#eyeLeft {
  transform-origin:66px 127px;
  -webkit-animation:popup .5s 1.2s cubic-bezier(0.95, 0.05, 0.795, 0.035) forwards;
  animation:popup .5s 1.2s cubic-bezier(0.95, 0.05, 0.795, 0.035) forwards;
}
#eyeRight {
  transform-origin:203px 127px;
  -webkit-animation:popup .5s 1.25s cubic-bezier(0.95, 0.05, 0.795, 0.035) forwards;
  animation:popup .5s 1.25s cubic-bezier(0.95, 0.05, 0.795, 0.035) forwards;
}
.eyeLeft {
  transform-origin:66px 127px;
  -webkit-animation:downup 12.1s 1.6s cubic-bezier(.44,0,.01,.99) forwards;
  animation:downup 12.1s 1.6s cubic-bezier(.44,0,.01,.99) forwards;
}
.eyeRight {
  transform-origin:203px 127px;
  -webkit-animation:downup 12.1s 1.6s cubic-bezier(.44,0,.01,.99) forwards;
  animation:downup 12.1s 1.6s cubic-bezier(.44,0,.01,.99) forwards;
}
.eyeLeft > .pupil {
  transform-origin:66px 127px;
  -webkit-animation:follow 12.1s 1.6s forwards;
  animation:follow 12.1s 1.6s forwards;
}
.eyeRight > .pupil {
  transform-origin:203px 127px;
  -webkit-animation:follow 12.1s 1.6s forwards;
  animation:follow 12.1s 1.6s forwards;
}
.closedLeft {
  transform-origin:66px 127px;
  -webkit-animation:blink 12.1s 1.6s cubic-bezier(.44,0,.01,.99) forwards;
  animation:blink 12.1s 1.6s cubic-bezier(.44,0,.01,.99) forwards;
} 
.closedRight {
  transform-origin:203px 127px;
  -webkit-animation:blink 12.1s 1.6s cubic-bezier(.44,0,.01,.99) forwards;
  animation:blink 12.1s 1.6s cubic-bezier(.44,0,.01,.99) forwards;
}
.mouth {
  transform-origin:135px 233px;
  -webkit-animation:mouth 12.1s 1.6s cubic-bezier(.44,0,.01,.99) forwards;
  animation:mouth 12.1s 1.6s cubic-bezier(.44,0,.01,.99) forwards;
}
.bar {
  transform-origin:135px 233px;
  transform:scale(0);
  -webkit-animation:patient 12.8s 1s ease-in forwards;
  animation:patient 12.8s 1s ease-in forwards;
}
.smile {
  transform-origin:135px 233px;
  transform:scale(0);
  -webkit-animation:happy 12.9s 1s ease-in forwards;
  animation:happy 12.9s 1s ease-in forwards;
}
/*
----------------------------------------------
LOADING BAR 
----------------------------------------------
*/
.loading-bar {
  position:relative;
  margin-top:4rem;
  width:250px;
  background:#C1C0BC; 
}
.loading-bar:before {
  content:'';
  position:absolute;
  top:0;
  left:0;
  width:0;
  background:#58585A;
  -webkit-animation:load 12.4s 1s forwards;
  animation:load 12.4s 1s forwards;
}
.loading-bar, .loading-bar:before {
  height:4px;
  border-radius:5px;
}
/*
----------------------------------------------
ANIMATIONS
----------------------------------------------
*/
@keyframes popup {
  0% {transform:scale(0);}
  80% {transform:scale(1);}
  90% {transform:scale(0.75);}
  100% {transform:scale(1);}
}
@keyframes downup {
  0% {transform: translateY(0);}
  15% {transform: translateY(40px);}
  50% {opacity:1;}
  50.7% {opacity:0;}
  51.4% {opacity:1;}
  98% {transform: translateY(40px);}
  100% {transform: translateY(0);}
}
@keyframes mouth {
  0% {transform: translateY(-20px);}
  15% {transform: translateY(0px);}
  100% {transform: translateY(0px);}
}
@keyframes blink {
  0% {transform: translateY(0);}
  15% {transform: translateY(40px);}
  50% {opacity:1;}
  98% {transform: translateY(40px);}
  100% {transform: translateY(0);}
}
@keyframes follow {
  0% {transform: translate(0, 0);}
  15% {transform: translate(-4px, 8px);}
  95.5% {transform: translate(-2px, 10px);}
  98% {transform: translate(8px, 10px);}
  100% {transform: translate(0, 0);}
}
@keyframes patient {
  0% {transform:scale(0);}
  3% {transform:scale(0);}
  3.5% {transform:scale(1);}
  4% {transform:scale(0.75);}
  4.5% {transform:scale(1);}
  99% {transform:scale(1);}
  100% {transform:scale(0);}
}
@keyframes happy {
  0% {transform:scale(0);}
  98% {transform:scale(0);}
  100% {transform:scale(1);}
}
@keyframes load {
  0% {width:0;}
  97% {width:50px;}
  100% {width:250px;}
}
@keyframes offscreen {
  0% {transform:translateY(0);}
  100% {transform:translateY(-200%);}
}
@keyframes show {
  0% {opacity:0;}
  100% {opacity:1;}
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
<div id="loader">
  <div class="face">
  <?xml version="1.0" encoding="utf-8" standalone="yes"?>
  <svg version="1.1"
	   xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
	   x="0px" y="0px" width="270px" height="270px" viewBox="0.032 0 270 270"
	   overflow="visible" enable-background="new 0.032 0 270 270" xml:space="preserve">
  <defs>
  </defs>
  <g id="supervisior">
    <g class="head">
	    <path fill="#58585A" d="M135,10c33.389,0,64.778,13.002,88.388,36.612S260,101.611,260,135s-13.003,64.779-36.612,88.388
		S168.389,260,135,260s-64.778-13.002-88.388-36.612C23.002,199.779,10,168.389,10,135s13.002-64.779,36.612-88.388
		C70.222,23.002,101.611,10,135,10 M135,0C60.442,0,0,60.441,0,135s60.442,135,135,135s135-60.441,135-135S209.558,0,135,0L135,0z"
		  />
    </g>
    <g id="eyeLeft">
      <g class="eyeLeft">
        <circle class="eye" fill="none" stroke="#58585A" stroke-width="4" stroke-linecap="round" stroke-miterlimit="10" cx="66.063" cy="127.51" r="18.849"/>
        <circle class="pupil" fill="#58585A" cx="66.063" cy="127.511" r="8.949"/>
      </g>
      <path class="closedLeft" fill="none" stroke="#58585A" stroke-width="4" stroke-linecap="round" stroke-miterlimit="10" d="
	M47.238,127.972c0.247,10.194,8.57,18.387,18.824,18.387s18.579-8.193,18.826-18.387"/>
    </g>
    <g id="eyeRight">
      <g class="eyeRight">
        <circle class="eye" fill="none" stroke="#58585A" stroke-width="4" stroke-linecap="round" stroke-miterlimit="10" cx="203.936" cy="127.51" r="18.849"/>
        <circle class="pupil" fill="#58585A" cx="203.935" cy="127.511" r="8.949"/>
      </g>
      <path class="closedRight" fill="none" stroke="#58585A" stroke-width="4" stroke-linecap="round" stroke-miterlimit="10" d="
	M185.11,127.972c0.247,10.194,8.571,18.387,18.824,18.387c10.255,0,18.579-8.193,18.826-18.387"/>
    </g>
    <g class="mouth">
      <polyline class="bar" fill="none" stroke="#58585A" stroke-width="4" stroke-linecap="round" stroke-miterlimit="10" points="
	111.532,232.832 135.032,232.832 158.532,232.832 "/>
      <path class="smile" fill="none" stroke="#58585A" stroke-width="4" stroke-linecap="round" stroke-miterlimit="10" d="
	M62.485,168.615c0.951,35.593,33.016,64.198,72.511,64.198c39.503,0,71.566-28.605,72.519-64.198"/>
    </g>
  </g>
  </svg>
  </div>
  <div class="loading-bar"></div>
</div>
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

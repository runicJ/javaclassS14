<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />

<section class="">
	<div class="container">
		<h2 class="text-center">사이트별 알레르기 관련 뉴스</h2>
		<div class="line"></div>
		<div class="row">
			<div class="col-md-4 col-sm-4">
				<h1 class="title-col">네이버 뉴스</h1>
				<div class="body-col" data-max="100" data-nav="#hot-news-nav" data-item="article">
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
	                                <h1><a href="${vo.itemUrl1}" target="_blank">${vo.item1}</a></h1>
	                                <div class="detail">
	                                    <div class="category"><a href="${vo.itemUrl2}">${vo.item4}</a></div>
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
			<div class="col-md-4 col-sm-4">
				<h1 class="title-col">네이처 저널</h1>
				<div class="body-col" data-max="100" data-nav="#hot-news-nav" data-item="article">
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
	                                <h1><a href="https://www.nature.com${nVo.itemUrl1}" target="_blank">
	                                <c:choose>
										<c:when test="${fn:length(nVo.item1) gt 50}">
											<c:out value="${fn:substring(nVo.item1,0,50)}" />...
										</c:when>
										<c:otherwise>
											<c:out value="${nVo.item1}" />
										</c:otherwise>
									</c:choose>
	                                </a></h1>
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
			<div class="col-md-4 col-sm-4">
				<h1 class="title-col">구글 학술검색</h1>
				<div class="body-col" data-max="100" data-nav="#hot-news-nav" data-item="article">
					<c:if test="${!empty gVos}">
	                <c:forEach var="gVo" items="${gVos}" varStatus="status">
	                    <article class="article-mini">
	                        <div class="inner">
	                            <div class="padding">
	                                <h1><a href="${gVo.itemUrl1}" target="_blank">
	                                <c:choose>
										<c:when test="${fn:length(gVo.item1) gt 50}">
											<c:out value="${fn:substring(gVo.item1,0,50)}" />...
										</c:when>
										<c:otherwise>
											<c:out value="${gVo.item1}" />
										</c:otherwise>
									</c:choose>
	                                </a></h1>
	                                <div class="detail">
	                                    <div class="category">
	                             	    <c:choose>
											<c:when test="${fn:length(gVo.item3) gt 15}">
												<c:out value="${fn:substring(gVo.item3,0,15)}" />...
											</c:when>
											<c:otherwise>
												<c:out value="${gVo.item3}" />
											</c:otherwise>
										</c:choose>
	                                    </div>
	                                    <div class="time">${gVo.item4}</div>
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
		</div>
		<div class="line"> 끝 </div>
	</div>
	<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
</section>

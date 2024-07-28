<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert</title>
  	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<section class="page">
<div class="container">
<article class="sub-contents layer1300">
		<div class="sch-form hos-sch-form">
    		<form name="search_frm" id="search_frm" method="get" action="hospital_list.php">
    			<fieldset>
    				<legend class="hide">병원검색</legend>
    				<div class="bg-box bg-white">
    					<div class="form-group">
    						<label for="">병원검색</label>
    						<select name="key" id="key" class="form-control">
    							<option value="hosp_name">병원명</option>
    							<option value="chief_name">담당의</option>
    							<option value="position">전공과</option>
    							<option value="addr">주소 (시군구)</option>
    						</select>
    						<input type="text" name="keyword" id="keyword" class="form-control" placeholder="검색어를 입력해주세요.">
    					</div>
            		</div>
            		
            		<div class="btn-wrap text-center">
            			<button type="button" onclick="if_search();" class="btn btn-type3 color-type4">검색</button>
            		</div>
    			</fieldset>
    		</form>
		</div>
		
		<div class="result-wrap">
			<ul class="result-list">
								<li>
					<a href="hospital_list.php?sido=서울특별시">
						<span class="num">166</span>
						<strong>
							<span>알레르기 전문병원</span>
							서울특별시						</strong>
					</a>
				</li>
								<li>
					<a href="hospital_list.php?sido=부산광역시">
						<span class="num">29</span>
						<strong>
							<span>알레르기 전문병원</span>
							부산광역시						</strong>
					</a>
				</li>
								<li>
					<a href="hospital_list.php?sido=대구광역시">
						<span class="num">25</span>
						<strong>
							<span>알레르기 전문병원</span>
							대구광역시						</strong>
					</a>
				</li>
								<li>
					<a href="hospital_list.php?sido=울산광역시">
						<span class="num">4</span>
						<strong>
							<span>알레르기 전문병원</span>
							울산광역시						</strong>
					</a>
				</li>
								<li>
					<a href="hospital_list.php?sido=인천광역시">
						<span class="num">21</span>
						<strong>
							<span>알레르기 전문병원</span>
							인천광역시						</strong>
					</a>
				</li>
								<li>
					<a href="hospital_list.php?sido=광주광역시">
						<span class="num">9</span>
						<strong>
							<span>알레르기 전문병원</span>
							광주광역시						</strong>
					</a>
				</li>
								<li>
					<a href="hospital_list.php?sido=대전광역시">
						<span class="num">12</span>
						<strong>
							<span>알레르기 전문병원</span>
							대전광역시						</strong>
					</a>
				</li>
								<li>
					<a href="hospital_list.php?sido=경기도">
						<span class="num">72</span>
						<strong>
							<span>알레르기 전문병원</span>
							경기도						</strong>
					</a>
				</li>
								<li>
					<a href="hospital_list.php?sido=강원도">
						<span class="num">10</span>
						<strong>
							<span>알레르기 전문병원</span>
							강원도						</strong>
					</a>
				</li>
								<li>
					<a href="hospital_list.php?sido=충청북도">
						<span class="num">8</span>
						<strong>
							<span>알레르기 전문병원</span>
							충청북도						</strong>
					</a>
				</li>
								<li>
					<a href="hospital_list.php?sido=충청남도">
						<span class="num">6</span>
						<strong>
							<span>알레르기 전문병원</span>
							충청남도						</strong>
					</a>
				</li>
								<li>
					<a href="hospital_list.php?sido=경상북도">
						<span class="num">4</span>
						<strong>
							<span>알레르기 전문병원</span>
							경상북도						</strong>
					</a>
				</li>
								<li>
					<a href="hospital_list.php?sido=경상남도">
						<span class="num">8</span>
						<strong>
							<span>알레르기 전문병원</span>
							경상남도						</strong>
					</a>
				</li>
								<li>
					<a href="hospital_list.php?sido=전라북도">
						<span class="num">6</span>
						<strong>
							<span>알레르기 전문병원</span>
							전라북도						</strong>
					</a>
				</li>
								<li>
					<a href="hospital_list.php?sido=전라남도">
						<span class="num">1</span>
						<strong>
							<span>알레르기 전문병원</span>
							전라남도						</strong>
					</a>
				</li>
								<li>
					<a href="hospital_list.php?sido=제주도">
						<span class="num">5</span>
						<strong>
							<span>알레르기 전문병원</span>
							제주도						</strong>
					</a>
				</li>
							</ul>
		</div>
	</article>
	<form name="searchForm" method="get">
		<fieldset>
			<div class="bg-box bg-white">
				<div class="form-group">
					<label>병원검색</label>
					<select name="searchKey" class="form-control">
						<option>전체</option>
						<option>지역</option>
						<option>병원명</option>
					</select>
					<input type="text" id="keyword" class="form-control" placeholder="검색어를 입력하세요">
				</div>
			</div>
			<div class="text-center">
				<input type="button" class="btn btn-dark text-light" onclick="searchHospital();">
			</div>
		</fieldset>
	</form>
	<div class="demo">
		<ul name="regionList">
			<li><a href="#"><span class="num">0</span><strong><span>알레르기 전문병원</span>서울특별시</strong></a></li>
			<li><a href="#"><span class="num">0</span><strong><span>알레르기 전문병원</span>경기도</strong></a></li>
			<li><a href="#"><span class="num">0</span><strong><span>알레르기 전문병원</span>강원도</strong></a></li>
			<li><a href="#"><span class="num">0</span><strong><span>알레르기 전문병원</span>충청도</strong></a></li>
			<li><a href="#"><span class="num">0</span><strong><span>알레르기 전문병원</span>경상도</strong></a></li>
			<li><a href="#"><span class="num">0</span><strong><span>알레르기 전문병원</span>전라도</strong></a></li>
			<li><a href="#"><span class="num">0</span><strong><span>알레르기 전문병원</span>제주도</strong></a></li>
		</ul>
	</div>
	<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
</div>
</section>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
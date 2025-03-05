<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>photoGalleryList.jsp</title>
<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
  <script>
    'use strict';
    
    function photoSearch() {
    	let part = $("#part").val();
    	let choice = $("#choice").val();
    	
    	location.href = "photoGalleryList?part="+part+"&choice="+choice;
    }
    
    let lastScroll = 0;
    let curPage = 1;
    let isFetching = false;  // 중복 요청 방지

    $(document).scroll(function() {
        let currentScroll = $(this).scrollTop();
        let documentHeight = $(document).height();
        let nowHeight = $(this).scrollTop() + $(window).height();

        if (currentScroll > lastScroll && documentHeight < (nowHeight + (documentHeight * 0.1)) && !isFetching) {
            isFetching = true;
            curPage++;

            $.ajax({
                url: "photoReviewListPaging",
                type: "POST",
                data: {
                    pag: curPage,
                    part: '${part}',
                    choice: '${choice}'
                },
                success: function(res) {
                    $("#list-wrap").append(res);
                    isFetching = false;
                },
                error: function() {
                    isFetching = false;
                }
            });
        }
        lastScroll = currentScroll;
    });
    
    // 리스트 불러오기 함수(ajax처리)
    function getList(curPage) {
    	$.ajax({
    		url  : "${ctp}/photoReview/photoReviewSimpleList",
    		type : "post",
    		data : {pag : curPage},
    		success:function(res) {
    			$("#list-wrap").append(res);
    		}
    	});
    }
    
    // 화살표클릭시 화면 상단으로 부드럽게 이동하기
    $(window).scroll(function(){
    	if($(this).scrollTop() > 100) {
    		$("#topBtn").addClass("on");
    	}
    	else {
    		$("#topBtn").removeClass("on");
    	}
    	
    	$("#topBtn").click(function(){
    		window.scrollTo({top:0, behavior: "smooth"});
    	});
    });
  </script>
  <style>
		h6 {
		  position: fixed;
		  right: 1rem;
		  bottom: -50px;
		  transition: 0.7s ease;
		}
   	.on {
		  opacity: 0.8;
		  cursor: pointer;
		  bottom: 0;
		}
	
    .container {
      width: 1000px;
      margin: 0 auto;
    }
    .card {
      float:left;
      margin: 10px;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br/></p>
<section class="page">
<div class="container">
  <table class="table table-borderless">
    <tr>
      <td colspan="2"><h2 class="text-center">포토 리뷰 이벤트</h2></td>
    </tr>
    <tr>
      <td>
        <div class="input-group">
          <div>
	          <select name="part" id="part" class="form-control mr-1" style="width:100px">
		          <option value="전체" ${part == '전체' ? 'selected' : ''}>전체</option>
		          <option value="침구류" ${part == '침구류' ? 'selected' : ''}>침구류</option>
		          <option value="유기농 제품" ${part == '유기농 제품' ? 'selected' : ''}>유기농 제품</option>
		          <option value="알레르기 완화 제품" ${part == '알레르기 완화 제품' ? 'selected' : ''}>알레르기 완화 제품</option>
		        </select>
	        </div>
	        <div class="input-group-append">
		        <select name="choice" id="choice" class="form-control mr-1" style="width:100px">
		          <option value="최신순" ${choice == '최신순' ? 'selected' : ''}>최신순</option>
		          <option value="추천순" ${choice == '추천순' ? 'selected' : ''}>추천순</option>
		          <option value="조회순" ${choice == '조회순' ? 'selected' : ''}>조회순</option>
		          <option value="댓글순" ${choice == '댓글순' ? 'selected' : ''}>댓글순</option>
		        </select>
          </div>
          <div class="input-group-append">
            <input type="button" value="조건검색" onclick="photoSearch()" class="btn btn-primary"/>
          </div>
        </div>
      </td>
      <td class="text-right">
        <input type="button" value="사진올리기" onclick="location.href='photoReviewInput';" class="btn btn-success"/>
        <input type="button" value="한장씩보기" onclick="location.href='photoReviewSingle';" class="btn btn-info mr-2"/>
      </td>
    </tr>
  </table>
  <section id="list-wrap">
	  <c:forEach var="vo" items="${vos}" varStatus="st">
	    <!-- <div class="card" style="width:25%;"> -->
	    <div class="card mb-5" style="width:220px;">
		    <%-- <div class="card-body m-0 p-2"><img src="${ctp}/photoGallery/${vo.FSName}" width="100%" height="150px" title="${vo.title}" class="m-0" /></div> --%> 
		    <div class="card-body m-0 p-2 text-center">
				<a href="${ctp}/photoReview/photoReviewContent?photoReviewIdx=${vo.photoReviewIdx}">
					<img src="${ctp}/resources/data/photoReview/${vo.thumbnail}" width="200px" height="150px" title="${vo.title}" class="m-0" />
		      </a>
		    </div> 
		    <div class="card-footer">
		      <div class="row text-center" style="font-size:11px">
		        <div class="col p-0"><i class="fa-regular fa-pen-to-square" title="댓글수"></i> ${vo.replyCnt}</div>
				<div class="col p-0"><i class="fa-regular fa-face-grin-hearts" title="좋아요"></i> <c:out value="${vo.likeCnt}" default="0"/></div>
		        <div class="col p-0"><i class="fa-regular fa-eye" title="조회수"></i> ${vo.readNum}</div>
		        <div class="col p-0"><i class="fa-solid fa-layer-group" title="사진수"></i> ${vo.photoCount}</div>
		      </div>
		    </div>
		  </div>
	  </c:forEach>
  </section>
</div>
</section>
<p style="clear:both;"><br/></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
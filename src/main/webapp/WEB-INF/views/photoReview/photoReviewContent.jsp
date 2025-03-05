<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>photoReviewContent</title>
  <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />

  <style>
    .domain { max-width: 1000px; margin: auto; }
    
    /* 슬라이드쇼 */
    .slideshow-container { max-width: 1000px; position: relative; margin: auto; }
    .mySlides { display: none; text-align: center; transition: opacity 0.6s ease-in-out; }
    .mySlides img { max-width: 100%; border-radius: 10px; }
    .prev, .next {
      cursor: pointer;
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      padding: 12px;
      color: white;
      font-size: 18px;
      background-color: rgba(0, 0, 0, 0.5);
      border-radius: 3px;
      transition: 0.4s;
    }
    .prev { left: 10px; }
    .next { right: 10px; }
    .prev:hover, .next:hover { background-color: rgba(0,0,0,0.8); }
    
    /* 썸네일 네비게이션 */
    .thumbnail-container { text-align: center; margin-top: 10px; }
    .thumbnail-container img {
      width: 60px;
      height: 40px;
      margin: 5px;
      cursor: pointer;
      border: 2px solid transparent;
      transition: transform 0.3s;
    }
    .thumbnail-container img:hover { transform: scale(1.1); }

    /* 좋아요 버튼 */
    .like-btn {
      cursor: pointer;
      font-size: 22px;
      color: #aaa;
      transition: color 0.3s;
    }
    .liked { color: red !important; }

    /* 댓글 스타일 */
    #replyList { margin-top: 20px; }
    .reply-item { padding: 10px; border-bottom: 1px solid #ddd; }
    .reply-delete { cursor: pointer; color: red; margin-left: 10px; }
  </style>

  <script>
    'use strict';

    let slideIndex = 0;
    
    function showSlides(n) {
        let slides = document.getElementsByClassName("mySlides");
        let thumbnails = document.getElementsByClassName("thumbnail");

        if (slides.length === 0) return;

        slideIndex = (n + slides.length) % slides.length;

        for (let i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        for (let i = 0; i < thumbnails.length; i++) {
            thumbnails[i].style.border = "2px solid transparent";
        }

        slides[slideIndex].style.display = "block";
        thumbnails[slideIndex].style.border = "2px solid red";
    }

    function plusSlides(n) { showSlides(slideIndex + n); }

    function toggleLike(photoReviewIdx) {
        $.ajax({
            url: "${ctp}/photoReview/photoReviewLikeCheck",
            type: "POST",
            data: { photoReviewIdx: photoReviewIdx },
            success: function (res) {
                if (res.status === "not_logged_in") {
                    alert("로그인이 필요합니다.");
                    location.href = "/login";
                    return;
                }

                if (res.status === "liked") {
                    $("#likeButton").addClass("liked");
                } else if (res.status === "unliked") {
                    $("#likeButton").removeClass("liked");
                }

                $("#likeCount").text(res.likeCount);
            },
            error: function () { alert("서버 오류가 발생했습니다."); }
        });
    }

    function submitReply() {
        let content = $("#content").val().trim();
        if (content === "") {
            alert("댓글을 입력하세요.");
            return;
        }

        $.ajax({
            url: "${ctp}/photoReview/photoReviewReplyInput",
            type: "POST",
            data: {
                photoReviewIdx: '${vo.photoReviewIdx}', // 댓글이 달릴 리뷰 ID
                content: content
            },
            success: function(res) {
                if (res === "not_logged_in") {
                    alert("로그인이 필요합니다.");
                    location.href = "/login";
                } else if (res === "1") {
                    alert("댓글이 등록되었습니다.");
                    $("#content").val("");  
                    location.reload();
                } else {
                    alert("댓글 등록 실패!");
                }
            },
            error: function() { alert("서버 오류 발생!"); }
        });
    }

    
    function deleteReply(photoReviewReplyIdx) {
        if (!confirm("댓글을 삭제하시겠습니까?")) return;

        $.ajax({
            url: "${ctp}/photoReview/photoReviewReplyDelete",
            type: "POST",
            data: { photoReviewReplyIdx: photoReviewReplyIdx },
            success: function(res) {
                if (res === "not_logged_in") {
                    alert("로그인이 필요합니다.");
                    location.href = "/login";
                } else if (res === "1") {
                    alert("댓글이 삭제되었습니다.");
                    location.reload();
                } else {
                    alert("댓글 삭제 실패!");
                }
            },
            error: function() {
                alert("서버 오류 발생!");
            }
        });
    }

    $(document).ready(function() { showSlides(slideIndex); });
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br/></p>
<section class="page">
<div class="domain">
  <h2>[${vo.part}] ${vo.title}</h2>
  <div class="row">
    <div class="col">${vo.userIdx} | <c:if test="${not empty vo.reviewDate}">${fn:substring(vo.reviewDate, 0, 16)}</c:if> | ${vo.hostIp}</div>
    <div class="col text-right">
      <i class="fa-regular fa-pen-to-square"></i> ${vo.replyCnt} &nbsp;
      <i id="likeButton" class="fa-regular fa-heart like-btn ${vo.liked ? 'liked' : ''}" onclick="toggleLike(${vo.photoReviewIdx})"></i> <span id="likeCount">${vo.likeCnt}</span> &nbsp;
      <i class="fa-regular fa-eye"></i> ${vo.readNum} &nbsp;
      <i class="fa-solid fa-layer-group"></i> ${vo.photoCount}
    </div>
  </div>
  <hr/>

  <div class="slideshow-container">
    <c:forEach var="i" begin="0" end="${vo.photoCount - 1}">
        <div class="mySlides">
          <img src="${ctp}/resources/data/photoReview/${fn:split(vo.content,',')[i]}" />
        </div>
    </c:forEach>
    <a class="prev" onclick="plusSlides(-1)">❮</a>
    <a class="next" onclick="plusSlides(1)">❯</a>
  </div>

  <div class="thumbnail-container">
    <c:forEach var="i" begin="0" end="${vo.photoCount - 1}">
        <img class="thumbnail" src="${ctp}/resources/data/photoReview/${fn:split(vo.content,',')[i]}" onclick="showSlides(${i})"/>
    </c:forEach>
  </div>

  <h4>댓글</h4>
  <div id="replyList">
	<c:forEach var="replyVo" items="${replyVos}">
	    <div class="reply-item">
	        ${replyVo.content} 
	        <span class="reply-delete" onclick="deleteReply(${replyVo.photoReviewReplyIdx})">삭제</span>
	    </div>
	</c:forEach>
  </div>

  <textarea id="content" class="form-control"></textarea>
  <button class="btn btn-primary mt-2" onclick="submitReply();">댓글 달기</button>
</div>
</section>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
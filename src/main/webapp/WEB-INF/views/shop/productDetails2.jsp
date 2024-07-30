<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>productDetails</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <link rel="stylesheet" href="${ctp}/css/shop/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/nice-select.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/style.css" type="text/css">
  	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
  	<script>
	  	'use strict';
	
	    let idxArray = new Array();
	
	    $(function() {
	        $(".selectOption").change(function() {
	            let selectOption = $(this).val();
	            let optionIdx = selectOption.substring(0, selectOption.indexOf(":"));
	            let optionName = selectOption.substring(selectOption.indexOf(":") + 1, selectOption.indexOf("_"));
	            let addPrice = parseInt(selectOption.substring(selectOption.indexOf("_") + 1));
	            let basePrice = parseInt(${productVO.productPrice});
	            let totalOptionPrice = basePrice + addPrice;
	            let commaPrice = numberWithCommas(totalOptionPrice);
	            let quantity = parseInt($("#numBoxMain").val());
	
	            if ($("#layer" + optionIdx).length == 0) {
	                idxArray.push(optionIdx);
	                let index = idxArray.length - 1;
	                let str = '';
	                str += '<div class="layer row" id="layer' + optionIdx + '"><div class="col">' + optionName + '</div>';
	                str += '<input type="number" class="text-center numBox" id="numBox' + optionIdx + '" name="items[' + index + '].quantity" onchange="numChange(' + optionIdx + ')" value="' + quantity + '" min="1"/> &nbsp;';
	                str += '<input type="text" id="imsiPrice' + optionIdx + '" class="price" value="' + commaPrice + '" readonly /><span> 원</span>';
	                str += '<input type="hidden" id="price' + optionIdx + '" value="' + totalOptionPrice + '" data-add-price="' + addPrice + '"/> &nbsp;';
	                str += '<input type="button" class="btn btn-outline-danger btn-sm" onclick="remove(' + optionIdx + ')" value="X"/>';
	                str += '<input type="hidden" name="items[' + index + '].optionIdx" value="' + optionIdx + '"/>';
	                str += '<input type="hidden" name="items[' + index + '].productIdx" value="${productVO.productIdx}"/>';
	                str += '<input type="hidden" name="items[' + index + '].isSoldOut" value="false"/>';
	                str += '</div>';
	                $("#product1").append(str);
	                onTotal();
	            } 
	            else {
	                alert("이미 선택한 옵션입니다.");
	            }
	        });
	    });
	
	    function remove(optionIdx) {
	        $("div").remove("#layer" + optionIdx);
	
	        if ($(".price").length) onTotal();
	        else location.reload();
	    }
	
	    function onTotal() {
	        let total = 0;
	        for (let i = 0; i < idxArray.length; i++) {
	            if ($("#layer" + idxArray[i]).length != 0) {
	                total += parseInt(document.getElementById("price" + idxArray[i]).value);
	            }
	        }
	        document.getElementById("totalPrice").value = numberWithCommas(total);
	    }
	
	    function numChange(optionIdx) {
	        let basePrice = parseInt(${productVO.productPrice});
	        let addPrice = parseInt($("#price" + optionIdx).data("addPrice"));
	        let quantity = parseInt(document.getElementById("numBox" + optionIdx).value);
	        let totalPrice = (basePrice + addPrice) * quantity;
	        document.getElementById("imsiPrice" + optionIdx).value = numberWithCommas(totalPrice);
	        document.getElementById("price" + optionIdx).value = totalPrice;
	        onTotal();
	    }
	
	    function cart() {
	        if (document.getElementById("totalPrice").value == 0) {
	            alert("옵션을 선택해주세요");
	            return false;
	        } 
	        else {
	            myform.action = "${ctp}/shop/addToCart";
	            myform.submit();
	        }
	    }
	
	    function numberWithCommas(x) {
	        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }
	
	    function likedToggle(productIdx) {
	        if (sUid == null || sUid == "") {
	            alert("로그인 이후에 가능한 메뉴입니다!");
	            return false;
	        }
	
	        $.ajax({
	            url: "${ctp}/shop/productLikedToggle",
	            type: "post",
	            data: { productIdx: productIdx },
	            success: function(res) {
	                let icon = document.getElementById("liked-icon-" + productIdx);
	                let wishCnt = document.getElementById("likedCnt");
	                if (res.trim() == "true") {
	                    alert("해당 상품을 위시리스트에서 제거하였습니다.");
	                    icon.classList.remove('fa-solid', 'fa-heart');
	                    icon.classList.add('fa-regular', 'fa-heart');
	                    wishCnt.textContent = parseInt(wishCnt.textContent) - 1;
	                } else {
	                    alert("해당 상품을 위시리스트에 추가하였습니다.");
	                    icon.classList.remove('fa-regular', 'fa-heart');
	                    icon.classList.add('fa-solid', 'fa-heart');
	                    icon.style.color = 'red';
	                    wishCnt.textContent = parseInt(wishCnt.textContent) + 1;
	                }
	            },
	            error: function() {
	                alert("전송 오류!");
	            }
	        });
	    }
	    
	    function reviewCheck() {
	    	let star = starForm.star.value;
	    	let reviewContent = $("#reviewContent").val();
	    	
	        if (star == "") {
	            alert("별점을 부여해 주세요");
	            return false;
	        }
	    	let query = {
	    			productIdx : ${productVO.productIdx},
	    			userId	: '${sUid}',
	    			nickName : '${sNickName}',
	    			hostIp : '${pageContext.request.remoteAddr}',
	    			reviewContent : reviewContent
	    	}
	    	
	    	$.ajax({
	    		url  : "${ctp}/shop/productReviewInput",
	    		type : "post",
	    		data : query,
	    		success:function(res) {
	    			if(res != "0") {
	    				alert("댓글이 입력되었습니다.");
	    				location.reload();
	    			}
	                else alert("제품을 구매하신 분만 제품에 대한 댓글 입력이 가능합니다.");
	    		},
	    		error : function() {
	    			alert("전송 오류!");
	    		}
	    	});
	    }
	    
	    
	    // 댓글 삭제하기
	    function reviewDelete(reviewIdx) {
	    	let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
	    	if(!ans) return false;
	    	
	    	$.ajax({
	    		url  : "${ctp}/shop/productReviewDelete",
	    		type : "post",
	    		data : {reviewIdx : reviewIdx},
	    		success:function(res) {
	    			if(res != "0") {
	    				alert("댓글이 삭제되었습니다.");
	    				location.reload();
	    			}
	    			else alert("삭제 실패~~");
	    		},
	    		error : function() {
	    			alert("전송 오류!");
	    		}
	    	});
	    }
	    
	    
	    // 처음에는 대댓글 '닫기'버튼은 보여주지 않는다.
	    $(function(){
	    	$(".replyCloseBtn").hide();
	    });
	    
	    // 대댓글 입력버튼 클릭시 입력박스 보여주기
	    function replyShow(idx) {
	    	$("#replyShowBtn"+idx).hide();
	    	$("#replyCloseBtn"+idx).show();
	    	$("#replyDemo"+idx).slideDown(100);
	    }
	    
	    // 대댓글 박스 감추기
	    function replyClose(idx) {
	    	$("#replyShowBtn"+idx).show();
	    	$("#replyCloseBtn"+idx).hide();
	    	$("#replyDemo"+idx).slideUp(300);
	    }
	    
	    // 대댓글(부모댓글의 답변글)의 입력처리
	    function replyCheckRe(idx, re_step, re_order) {
	    	let content = $("#contentRe"+idx).val();
	    	if(content.trim() == "") {
	    		alert("답변글을 입력하세요");
	    		$("#contentRe"+idx).focus();
	    		return false;
	    	}
	    	
	    	let query = {
	    			productIdx : ${vo.productIdx},
	    			re_step : re_step,
	    			re_order : re_order,
	    			userId      : '${sUid}',
	    			nickName : '${sNickName}',
	    			hostIp   : '${pageContext.request.remoteAddr}',
	    			reviewContent  : reviewContent
	    	}
	    	
	    	$.ajax({
	    		url  : "${ctp}/shop/productReviewReInput",
	    		type : "post",
	    		data : query,
	    		success:function(res) {
	    			if(res != "0") {
	    				alert("답변글이 입력되었습니다.");
	    				location.reload();
	    			}
	    			else alert("답변글 입력 실패~~");
	    		},
	    		error : function() {
	    			alert("전송오류!");
	    		}
	    	});
	    }
	    
	    // 신고시 '기타'항목 선택시에 textarea 보여주기
	    function etcShow() {
	    	$("#complaintTxt").show();
	    }
	    
	    // 신고화면 선택후 신고사항 전송하기
	    function complaintCheck(reviewIdx) {
	    	if (!$("input[type=radio][name=complaint]:checked").is(':checked')) {
	    		alert("신고항목을 선택하세요");
	    		return false;
	    	}
	    	if($("input[type=radio]:checked").val() == '기타' && $("#complaintTxt").val() == "") {
	    		alert("기타 사유를 입력해 주세요.");
	    		return false;
	    	}
	    	
	    	let cpContent = modalForm.complaint.value;
	    	if(cpContent == '기타') cpContent += '/' + $("#complaintTxt").val();
	    	
	    	//alert("신고내용 : " + cpContent);
	    	let query = {
	    			part   : 'productReview',
	    			partIdx: reviewIdx,
	    			cpMid  : '${sUid}',
	    			cpContent : cpContent
	    	}
	    	
	    	$.ajax({
	    		url  : "${ctp}/cs/compliantInput",
	    		type : "post",
	    		data : query,
	    		success:function(res) {
	    			if(res != "0") {
	    				alert("신고 되었습니다.");
	    				location.reload();
	    			}
	    			else alert("신고 실패~~");
	    		},
	    		error : function() {
	    			alert("전송 오류!");
	    		}
	   		});
	    }
    </script>
    <style>
       .layer  {
          border:0px;
          width:100%;
          padding:10px;
          margin-left:1px;
          background-color:#eee;
        }
        .numBox {width:40px}
        .price  {
          width:160px;
          background-color:#eee;
          text-align:right;
          font-size:1.2em;
          border:0px;
          outline: none;
        }
        .totalPrice {
          text-align:right;
          margin-right:10px;
          color:#f63;
          font-size:1.5em;
          font-weight: bold;
          border:0px;
          outline: none;
        }
        
        /* 별점 스타일 설정하기 */
	    #starForm fieldset {
		    display: inline-block;
		    direction: rtl;
		    border:0;
	    }
	    #starForm input[type=radio] {
	      display: none;
	    }
	    #starForm label {
	      font-size: 1.6em;
	      color: transparent;
	      text-shadow: 0 0 0 #f0f0f0;
	    }
	    #starForm label:hover {
	      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
	    }
	    #starForm label:hover ~ label {
	      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
	    }
	    #starForm input[type=radio]:checked ~ label {
	      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
	    }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br/></p>
<div class="container">
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Shop Details Section Begin -->
    <section class="shop-details">
        <div class="product__details__pic">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="product__details__breadcrumb text-right">
                            <i class="fa-solid fa-barcode"></i> &nbsp;
                            <a href="${ctp}/">메인페이지</a>
                            <a href="${ctp}/shop/productList">제품판매</a>
                            <span>${productVO.productName}</span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="product__details__pic__item">
                            <img src="${ctp}/product/${productVO.productThumb}" alt="product Thumbnail">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="product__details__content">
            <div class="container">
                <div class="row d-flex justify-content-center">
                    <div class="col-lg-8">
                        <div class="product__details__text">
                            <h4>${productVO.productName}</h4>
                            <div class="rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star-o"></i>
                                <c:forEach var="i" begin="1" end="${rVo.star}" varStatus="iSt">
                        			<font color="gold"><i class="fas fa-star"></i></font>
                   				</c:forEach>
                   				 <c:forEach var="i" begin="1" end="${5 - rVo.star}" varStatus="iSt"><i class="fa fa-star"></i></c:forEach>
                                <span>(후기글 ${reviewVOS[0].productReviewCnt}개)</span>
                            </div>
                            
                            <div class="product__details__btns__option">
                                <a href="#"><i class="fa-brands fa-gratipay"></i> 관심상품</a>
                                <a href="#"><i class="fa-solid fa-square-share-nodes"></i> 공유하기</a>
                            </div>
                            
                            <div class="form-group">
                                <form name="optionForm">
                                    <h3>￦ <fmt:formatNumber value="${productVO.productPrice}" /><span>0</span></h3>
                                    <p>${productVO.productDetails}</p>
                                    <div class="product__details__cart__option">
										<div class="quantity mb-2">
                                            <div class="pro-qty">
                                                <input type="number" name="quantity" min="1" value="1" id="numBoxMain">
                                            </div>
                                        </div>
                                        <a type="button" onclick="likedToggle(${productVO.productIdx})" class="btn btn-inline-light">
                                            <c:if test="${productVO.isLiked != 0}">
                                                <i id="liked-icon-${productVO.productIdx}" class="fa-solid fa-heart" style="color:red;"></i>
                                            </c:if>
                                            <c:if test="${productVO.isLiked == 0}">
                                                <i id="liked-icon-${productVO.productIdx}" class="fa-regular fa-heart" style="color:#eee;"></i>
                                            </c:if>
                                            <span>명 관심등록</span>
                                        </a>
                                    </div>
                                    <div class="product__details__option">
                                        <c:if test="${empty optionGroupVOS}">
                                        <div class="product__details__option__size">
                                            <label for="basicIdx"> 기본
                                                <input type="radio" id="basicIdx" class="selectOption" name="selectOption" value="0:기본_0">
                                            </label>
                                        </div>
                                        </c:if>
                                        <c:forEach var="optionGroupVO" items="${optionGroupVOS}">
                                        <div class="product__details__option__size">
                                            <span>${optionGroupVO.optionGroupName}</span>
                                            <c:if test="${optionGroupVO.optionGroupName != '색상'}">
                                            <label for="basicIdx"> 기본
                                                <input type="radio" id="basicIdx" class="selectOption" name="selectOption" value="0:기본_0">
                                            </label>
                                            </c:if>
                                            <c:forEach var="optionVO" items="${optionVOS}">
                                            <c:if test="${optionGroupVO.optionGroupIdx == optionVO.optionGroupIdx}">
                                            <label for="${optionVO.optionIdx}">${optionVO.optionName} 
                                                <c:if test="${optionVO.addPrice != 0}">
                                                    <span> (+</span><fmt:formatNumber value="${optionVO.addPrice}" /><span>원)</span>
                                                </c:if>
                                                <input type="radio" id="${optionVO.optionIdx}" class="selectOption" name="selectOption" value="${optionVO.optionIdx}:${optionVO.optionName}_${optionVO.addPrice}">
                                            </label>
                                            </c:if>
                                            </c:forEach>
                                        </div>
                                        </c:forEach>
                                    </div>
                                </form>
                            </div>

                            <div>
                                <form name="myform" method="post">
                                  <input type="hidden" name="userId" value="${sUid}"/>
                                  <input type="hidden" name="productPrice" value="${productVO.productPrice}"/>
                                  <input type="hidden" name="flag" id="flag"/>
                                  <div id="product1"></div>
                                </form>
                            </div>
                            <div>
                            <hr/>
                            <div class="text-left"><font size="4" color="black">총 상품 금액</font></div>
                                <p class="text-right">
                                    <b><input type="text" class="totalPrice text-right" id="totalPrice" value="<fmt:formatNumber value='0'/>" readonly /></b>
                                </p>
                                <a href="${ctp}/shop/addToCart" class="primary-btn mr-2">바로 구매하기</a>
                                <a type="button" onclick="cart()" class="primary-btn mr-2">장바구니 담기</a>
                            </div>
                            <div class="line"></div>
                            <div class="product__details__last__option">
                                <h5><span>제품 정보</span></h5>
                                <ul>
                                    <li><span>상품 태그 : </span> [ ${productVO.productTags} ]</li>
                                    <li><span>상품 코드 : </span> [ ${productVO.productCode} ]</li>
                                    <li><span>상품 브랜드 : </span> [ ${productVO.productBrand} ]</li>
                                </ul>
                            </div>
                    	</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="product__details__tab">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#tabs-5"
                                    role="tab">제품 상세보기</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-6" role="tab">리뷰(${reviewVOS[0].productReviewCnt})</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-7" role="tab">상품 문의</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tabs-5" role="tabpanel">
                                    <div class="product__details__tab__content">
                                        <div class="product__details__tab__content__item">
                                            <div id="content" class="text-center">
                                                ${productVO.content}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tabs-6" role="tabpanel">
                                    <div class="product__details__tab__content">
                                        <div class="product__details__tab__content__item">
	                                        <div class="card">
					                            <div class="card-body">
					                                <h4 class="card-title text-center">구매 후기</h4>
						                            <div class="comment-widgets">
						                            	<c:forEach var="reviewVO" items="${reviewVOS}">
						                                <div class="d-flex flex-row comment-row m-t-0">
						                                    <div class="p-2"><img src="${ctp}/user/${reviewVO.userImage}" alt="user" width="50px" height="50px" class="rounded-circle"></div>
						                                    <div class="comment-text w-100">
						                                    	<div>
							                                        <h6 class="font-medium"><a>${reviewVO.nickName} <i class="fa-solid fa-angle-right"></i></a></h6>
							                                        <p class="float-right">
	                                                                    <c:forEach var="i" begin="1" end="${reviewVO.star}" varStatus="iSt">
									                        			<font color="gold"><i class="fas fa-star"></i></font>
									                   					</c:forEach>
									                   				 	<c:forEach var="i" begin="1" end="${5 - reviewVO.star}" varStatus="iSt"><i class="fa fa-star"></i></c:forEach>
								                   				 	</p>
						                                        </div>
					                                            <div>
					                                            <p class="text-muted">${fn:substring(reviewVO.reviewDate,0,10)}</p> 
						                                        <c:if test="${reviewVO.userId != sUid}"><button type="button" class="btn btn-danger btn-sm" onclick="compliantCheck('${reviewVO.reviewIdx}')">| 신고</button></c:if>
						                                        </div>
						                                        <span class="m-b-15 d-block">${fn:replace(reviewVO.reviewContent,newLine,'<br>')}</span>
						                                        <div class="comment-footer">
						                                            <c:if test="${reviewVO.userId == sUid}"><button type="button" class="badge badge-primary mr-2" onclick="reviewEdit('${reviewVO.reviewIdx}')">수정</button></c:if>
						                                            <c:if test="${reviewVO.userId == sUid || sUid == 'admin'}"><button type="button" class="badge badge-warning mr-2" onclick="reviewDelete('${reviewVO.reviewIdx}')">삭제</button></c:if>
						                                            <i class="fa-solid fa-thumbs-up"></i>&nbsp;<span>0</span>
						                                            <p class="float-right"><button type="button" class="btn btn-primary btn-sm" onclick="replyShow(${reviewVO.reviewIdx})" id="replyShowBtn${replyVo.idx}">답글달기</button></p>
						                                        </div>
						                                    </div>
						                                </div>
						                                </c:forEach>
						                            </div>
					                            </div>
				                            </div>
				                            <hr>
	                                    	<div>
	                                    		<form name="starForm" id="starForm" method="post">
												  <fieldset style="border:0px;">
												    <div class="text-left viewPoint m-0 b-0">
												      <input type="radio" name="star" value="5" id="star1"><label for="star1"><i class="fas fa-star"></i></label>
												      <input type="radio" name="star" value="4" id="star2"><label for="star2"><i class="fas fa-star"></i></label>
												      <input type="radio" name="star" value="3" id="star3"><label for="star3"><i class="fas fa-star"></i></label>
												      <input type="radio" name="star" value="2" id="star4"><label for="star4"><i class="fas fa-star"></i></label>
												      <input type="radio" name="star" value="1" id="star5"><label for="star5"><i class="fas fa-star"></i></label>
												    </div>
												  </fieldset>
												  <div class="m-0 p-0">
												    <textarea rows="3" name="reviewContent" id="reviewContent" class="form-control mb-1" placeholder="별점 후기를 남겨주시면 100포인트를 지급합니다."></textarea>
												  </div>
												  <div>
												    <input type="button" value="별점/리뷰등록" onclick="reviewCheck()" class="btn btn-primary btn-sm form-control mb-4"/>
												  </div>
												</form>
	                                    	</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tabs-7" role="tabpanel">
                                    <div class="product__details__tab__content">
                                        <p class="note">Nam tempus turpis at metus scelerisque placerat nulla deumantos
                                            solicitud felis. Pellentesque diam dolor, elementum etos lobortis des mollis
                                            ut risus. Sedcus faucibus an sullamcorper mattis drostique des commodo
                                        pharetras loremos.</p>
                                        <div class="product__details__tab__content__item">
                                            <h5>Products Infomation</h5>
                                            <p>A Pocket PC is a handheld computer, which features many of the same
                                                capabilities as a modern PC. These handy little devices allow
                                                individuals to retrieve and store e-mail messages, create a contact
                                                file, coordinate appointments, surf the internet, exchange text messages
                                                and more. Every product that is labeled as a Pocket PC must be
                                                accompanied with specific software to operate the unit and must feature
                                            a touchscreen and touchpad.</p>
                                            <p>As is the case with any new technology product, the cost of a Pocket PC
                                                was substantial during it’s early release. For approximately $700.00,
                                                consumers could purchase one of top-of-the-line Pocket PCs in 2003.
                                                These days, customers are finding that prices have become much more
                                                reasonable now that the newness is wearing off. For approximately
                                            $350.00, a new Pocket PC can now be purchased.</p>
                                        </div>
                                        <div class="product__details__tab__content__item">
                                            <h5>Material used</h5>
                                            <p>Polyester is deemed lower quality due to its none natural quality’s. Made
                                                from synthetic materials, not natural like wool. Polyester suits become
                                                creased easily and are known for not being breathable. Polyester suits
                                                tend to have a shine to them compared to wool and cotton suits, this can
                                                make the suit look cheap. The texture of velvet is luxurious and
                                                breathable. Velvet is a great choice for dinner party jacket and can be
                                            worn all year round.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shop Details Section End -->

    <!-- Related Section Begin -->
    <section class="related spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="related-title">Related Product</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="img/product/product-1.jpg">
                            <span class="label">New</span>
                            <ul class="product__hover">
                                <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a></li>
                                <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h6>Piqué Biker Jacket</h6>
                            <a href="#" class="add-cart">+ Add To Cart</a>
                            <div class="rating">
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                            </div>
                            <h5>$67.24</h5>
                            <div class="product__color__select">
                                <label for="pc-1">
                                    <input type="radio" id="pc-1">
                                </label>
                                <label class="active black" for="pc-2">
                                    <input type="radio" id="pc-2">
                                </label>
                                <label class="grey" for="pc-3">
                                    <input type="radio" id="pc-3">
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="img/product/product-2.jpg">
                            <ul class="product__hover">
                                <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a></li>
                                <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h6>Piqué Biker Jacket</h6>
                            <a href="#" class="add-cart">+ Add To Cart</a>
                            <div class="rating">
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                            </div>
                            <h5>$67.24</h5>
                            <div class="product__color__select">
                                <label for="pc-4">
                                    <input type="radio" id="pc-4">
                                </label>
                                <label class="active black" for="pc-5">
                                    <input type="radio" id="pc-5">
                                </label>
                                <label class="grey" for="pc-6">
                                    <input type="radio" id="pc-6">
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
                    <div class="product__item sale">
                        <div class="product__item__pic set-bg" data-setbg="img/product/product-3.jpg">
                            <span class="label">Sale</span>
                            <ul class="product__hover">
                                <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a></li>
                                <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h6>Multi-pocket Chest Bag</h6>
                            <a href="#" class="add-cart">+ Add To Cart</a>
                            <div class="rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star-o"></i>
                            </div>
                            <h5>$43.48</h5>
                            <div class="product__color__select">
                                <label for="pc-7">
                                    <input type="radio" id="pc-7">
                                </label>
                                <label class="active black" for="pc-8">
                                    <input type="radio" id="pc-8">
                                </label>
                                <label class="grey" for="pc-9">
                                    <input type="radio" id="pc-9">
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="img/product/product-4.jpg">
                            <ul class="product__hover">
                                <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a></li>
                                <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h6>Diagonal Textured Cap</h6>
                            <a href="#" class="add-cart">+ Add To Cart</a>
                            <div class="rating">
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                            </div>
                            <h5>$60.9</h5>
                            <div class="product__color__select">
                                <label for="pc-10">
                                    <input type="radio" id="pc-10">
                                </label>
                                <label class="active black" for="pc-11">
                                    <input type="radio" id="pc-11">
                                </label>
                                <label class="grey" for="pc-12">
                                    <input type="radio" id="pc-12">
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Related Section End -->
	
<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
</div>
	<!-- 신고하기 폼 모달창 -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">현재 게시글을 신고합니다.</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <b>신고사유 선택</b>
          <hr/>
          <form name="modalForm">
            <div><input type="radio" name="complaint" id="complaint1" value="광고,홍보,영리목적"/> 광고,홍보,영리목적</div>
            <div><input type="radio" name="complaint" id="complaint2" value="욕설,비방,차별,혐오"/> 설,비방,차별,혐오</div>
            <div><input type="radio" name="complaint" id="complaint3" value="불법정보"/> 불법정보</div>
            <div><input type="radio" name="complaint" id="complaint4" value="음란,청소년유해"/> 음란,청소년유해</div>
            <div><input type="radio" name="complaint" id="complaint5" value="개인정보노출,유포,거래"/> 개인정보노출,유포,거래</div>
            <div><input type="radio" name="complaint" id="complaint6" value="도배,스팸"/> 도배,스팸</div>
            <div><input type="radio" name="complaint" id="complaint7" value="기타" onclick="etcShow()"/> 기타</div>
            <div id="etc"><textarea rows="2" id="complaintTxt" class="form-control" style="display:none"></textarea></div>
            <hr/>
            <input type="button" value="확인" onclick="complaintCheck()" class="btn btn-success form-control" />
          </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
<p><br/></p>
<script src="${ctp}/js/shop/jquery.nice-select.min.js"></script>
<script src="${ctp}/js/shop/jquery.slicknav.js"></script>
<script src="${ctp}/js/shop/jquery-ui.min.js"></script>
<script src="${ctp}/js/shop/main.js"></script>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
<script>
    /*-------------------
        Radio Btn
    --------------------- */
    $(".product__color__select label, .shop__sidebar__size label, .product__details__option__size label").on('click', function () {
        $(".product__color__select label, .shop__sidebar__size label, .product__details__option__size label").removeClass('active');
        $(this).addClass('active');
    });
</script>
</body>
</html>
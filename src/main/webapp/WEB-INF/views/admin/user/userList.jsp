<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>userList</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
  	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
  	<script>
  		'use strict';
  		
  		function openUserModal(userVO) {
  		    // 기존 필드 설정
  		    $('#modalUserId').val(userVO.userId);  // userId를 숨겨진 필드에 설정
  		    $('#modalUserIdDisplay').val(userVO.userId); // 필요에 따라 별도 표시용 필드에도 설정
  		    $('#imageDemo').attr('src', '${ctp}/user/' + userVO.userImage);
  		    $('#modalName').val(userVO.name);
  		    $('#modalNickName').val(userVO.nickName);
  		    $('#modalEmail').val(userVO.email);
  		    $('#modalTel').val(userVO.tel);
  		    $('input[name="gender"][value="' + userVO.gender + '"]').prop('checked', true);
  		    $('#registerWay').val(userVO.registerWay);

  		    $('#userStatus').val(userVO.userStatus);
  		    $('#level').val(userVO.level);
  		    $('#point').val(userVO.point);
  		    $('#agreeOptional').prop('checked', userVO.policyFlag == 'y');
  		    $('#createDate').val(userVO.createDate.substring(0,19));
  		    $('#updateDate').val(userVO.updateDate.substring(0,19));

  		    // 모달 열기
  		    $('#userModal').modal('show');
  		}
  		
  		function submitForm() {
  			$('#userForm').submit();
  		}
  		
		function userInfo(userId) {
  		    $.ajax({
  		        url: '${ctp}/admin/user/userInfo',
  		        type: 'GET',
  		        data: { userId: userId },
  		        success: function(userVO) {
  		            openUserModal(userVO);
  		        },
  		        error: function() {
  		            alert("전송오류!");
  		        }
  		    });
  		}
		
		$(document).ready(function() {
		    $('.userInfo').on('click', function() {
		        let userId = $(this).data('user-id');
		        userInfo(userId);
		    });
		    
            $('#userCheckBox').on('click', function() {
                $("input[name='userCheckBox']").prop('checked', this.checked);
            });

            $("input[name='userCheckBox']").on('change', function() {
                if (!this.checked) {
                    $('#userCheckBox').prop('checked', false);
                }
            });
		});

		function searchAndSort() {
		    let keyword = $("#searchInput").val();
		    let sortOption = $("#sortSelect").val();
		    location.href = "${ctp}/admin/user/userList?pag=1&pageSize=5&keyword=" + keyword + "&sortOption=" + sortOption;
		}

		document.addEventListener("DOMContentLoaded", function() {
		    document.querySelector("#searchButton").addEventListener("click", searchAndSort);
		    document.querySelector("#sortSelect").addEventListener("change", searchAndSort);
		});
		
		function allAction(action) {
            let selectedUsers = [];
            $("input[name='userCheckBox']:checked").each(function() {
                selectedUsers.push($(this).val());
            });

            if (selectedUsers.length == 0) {
                alert("선택된 사용자가 없습니다.");
                return;
            }

            if (confirm("정말로 선택된 회원들의 '" + action + "' 처리 작업을 수행하시겠습니까?")) {
                $.ajax({
                    url: '${ctp}/admin/user/allAction',
                    type: 'POST',
                    data: { action: action,
                    		users: selectedUsers },
                    traditional: true,
                    success: function(response) {
                        alert(response.message);
                        location.reload();
                    },
                    error: function() {
                        alert("전송오류!");
                    }
                });
            }
        }
  	</script>
</head>
<body>
	<div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
        data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
        <jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
		<jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
        <div class="page-wrapper">
            <div class="page-breadcrumb">
                <div class="row">
                    <div class="col-5 align-self-center">
                        <div class="d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb m-0 p-0">
                                    <li class="breadcrumb-item"><a href="${ctp}/main"><i class="fa-solid fa-house"></i> 메인페이지로</a>
                                    </li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                    <div class="col-7 text-right">
                        <h3 class="page-title text-truncate text-dark font-weight-medium mb-1"> 관리자 님 \^0^/ 회원관리에 항상 신중하세요!</h3>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <!-- *************************************************************** -->
                <!-- Start Top Leader Table -->
                <!-- *************************************************************** -->
                <div class="row">
                    <div class="col-12">
                        <div class="card p-3">
                            <div class="card-body">
								<div class="d-flex align-items-center">
								    <h2 class="card-title mr-3">전체 회원 관리</h2>
                                    <div class="customize-input d-flex">
										<select id="sortSelect" name="sortOption" class="custom-select custom-select-set form-control bg-white border-0 custom-shadow custom-radius mr-2">
										    <option value="createDate" ${sortOption == 'createDate' ? 'selected' : ''}>가입순</option>
										    <option value="name" ${sortOption == 'name' ? 'selected' : ''}>이름순</option>
										    <optgroup label="등급별">
										        <option value="level" ${sortOption == 'level' ? 'selected' : ''}>등급순</option>
										        <option value="3" ${sortOption == '3' ? 'selected' : ''}>지식인</option>
										        <option value="2" ${sortOption == '2' ? 'selected' : ''}>전문가</option>
										        <option value="1" ${sortOption == '1' ? 'selected' : ''}>숙련가</option>
										        <option value="0.5" ${sortOption == '0.5' ? 'selected' : ''}>귀한분</option>
										    </optgroup>
										    <optgroup label="상태별">
										        <option value="userStatus" ${sortOption == 'userStatus' ? 'selected' : ''}>상태순</option>
										        <option value="정상" ${sortOption == '정상' ? 'selected' : ''}>정상</option>
										        <option value="탈퇴" ${sortOption == '탈퇴' ? 'selected' : ''}>탈퇴</option>
										        <option value="정지" ${sortOption == '정지' ? 'selected' : ''}>정지</option>
										    </optgroup>
										</select>
                                        <input name="keyword" id="searchInput" class="form-control custom-shadow custom-radius border-0 bg-white mr-2" type="search" placeholder="회원검색" value="${keyword}" aria-label="Search">
                                        <button id="searchButton" type="button" class="btn btn-primary"><i class="fa-solid fa-magnifying-glass"></i></button>
                                    </div>
	                                <div class="ml-auto">
	                                    <div class="dropdown sub-dropdown">
	                                        <button class="btn btn-link text-muted dropdown-toggle" type="button" id="dd1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                            <i data-feather="more-vertical"></i>
	                                        </button>
	                                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dd1">
	                                            <a class="dropdown-item" href="javascript:allAction('정상')">일괄 정상처리</a>
	                                            <a class="dropdown-item" href="javascript:allAction('정지')">일괄 정지처리</a>
	                                            <a class="dropdown-item" href="javascript:allAction('삭제')">일괄 삭제처리</a>
	                                        </div>
	                                    </div>
	                                </div>
                               	</div>
                                <div class="table-responsive">
                                    <table class="table no-wrap v-middle mb-0 text-center">
                                        <thead>
                                            <tr class="border-0">
                                                <th class="border-0 font-14 font-weight-medium text-muted">
				                                    <input class="form-check-input" type="checkbox" onclick="allCheck()" id="userCheckBox" name="userCheckBox" value="option">
				                                    <label class="form-check-label" for="userCheckBox">선택</label>
												</th>
                                                <th class="border-0 font-14 font-weight-medium text-muted">등급</th>
                                                <th class="border-0 font-14 font-weight-medium text-muted">이름</th>
                                                <th class="border-0 font-14 font-weight-medium text-muted px-2">아이디</th>
                                                <th class="border-0 font-14 font-weight-medium text-muted">연락 수단</th>
                                                <th class="border-0 font-14 font-weight-medium text-muted text-center">가입일</th>
                                                <th class="border-0 font-14 font-weight-medium text-muted">상태</th>
                                                <th class="border-0 font-14 font-weight-medium text-muted text-center">가입경로</th>
                                            </tr>
                                        </thead>
										<tbody id="userTableBody">
											<c:set var="curScrStartNo" value="${pageVO.curScrStartNo-1}" />
                                        	<c:forEach var="vo" items="${vos}" varStatus="st">
                                        	<c:if test="${vo.userId != 'admin'}">
                                            <tr>
                                                <td class="border-top-0 text-dark px-2 py-4">
                                                	<div class="form-check form-check-inline">
					                                    <input class="form-check-input" type="checkbox" id="userCheckBox${curScrStartNo}" name="userCheckBox" value="${vo.userId}">
					                                    <label class="form-check-label" for="userCheckBox${curScrStartNo}">${curScrStartNo}</label>
					                                </div>
                                                </td>
                                                <td class="border-top-0 text-center px-2 py-4">
                                                	<c:if test="${vo.level == 0.5}"><i class="fa fa-circle text-danger font-18" data-toggle="tooltip" data-placement="top" title="귀한분(0.5)"></i></c:if>
                                                	<c:if test="${vo.level == 1}"><i class="fa fa-circle text-warning font-16" data-toggle="tooltip" data-placement="top" title="전문가(1)"></i></c:if>
                                                	<c:if test="${vo.level == 2}"><i class="fa fa-circle text-success font-14" data-toggle="tooltip" data-placement="top" title="숙련자(2)"></i></c:if>
                                                	<c:if test="${vo.level == 3}"><i class="fa fa-circle text-primary font-12" data-toggle="tooltip" data-placement="top" title="지식인(3)"></i></c:if>
                                                </td>
                                                <td class="border-top-0 px-2 py-4">
                                                    <div class="d-flex no-block align-items-center">
                                                        <div class="mr-3">
                                                        	<img src="${ctp}/user/${vo.userImage}" alt="user" class="rounded-circle" width="45" height="45" />
                                                        </div>
                                                        <div class="text-center">
	                                                        <h5 class="text-dark mb-0 font-16 font-weight-medium">${vo.name} [${vo.gender}]</h5>
	                                                        <p><a type="button" data-toggle="modal" data-target="#userModal" class="badge badge-info userInfo" data-user-id="${vo.userId}" style="color:#fff;">상세보기</a></p>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="font-weight-medium border-top-0 text-dark px-2 py-4 font-14">${vo.userId}
                                                   <p class="text-muted font-14">@${vo.nickName}</p>
                                                </td>
                                                <td class="border-top-0 text-center font-weight-medium text-muted px-2 py-4">
	                                                <h5 class="text-dark mb-0 font-16 font-weight-medium">${vo.email}</h5>
	                                                <span class="text-muted font-14">${vo.tel}</span>
                                                </td>
                                                <td class="border-top-0 text-center font-weight-medium text-muted px-2 py-4">
                                                    ${fn:substring(vo.createDate,0,10)}<br>${fn:substring(vo.createDate,10,19)}
                                                </td>

                                               	<td class="border-top-0 px-2 py-4">
                                                    <div class="popover-icon">
                                                    	<c:if test="${vo.userStatus =='on'}">
                                                        	<a class="btn btn-success rounded-circle btn-circle font-12 popover-item" href="javascript:void(0)">정상</a>
	                                                    </c:if>
	                                                    <c:if test="${vo.userStatus == 'off'}">
                                                        	<a class="btn btn-danger rounded-circle btn-circle font-12 popover-item" href="javascript:void(0)">탈퇴</a>
                                                        </c:if>
	                                                    <c:if test="${vo.userStatus == 'stop'}">
                                                        	<a class="btn btn-warning rounded-circle btn-circle font-12 popover-item" href="javascript:void(0)">정지</a>
                                                        </c:if>
                                                        <!-- <a class="btn btn-cyan rounded-circle btn-circle font-12 popover-item" href="javascript:void(0)">문의</a> -->
                                                    </div>
                                                </td>
                                                <td class="border-top-0 text-center font-weight-medium text-muted px-2 py-4">
                                                	${vo.registerWay}
                                                </td>
                                            </tr>
                                            </c:if>
                                            <c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="text-center">
	                        <nav aria-label="...">
		                         <ul class="pagination justify-content-center">
		                             <c:if test="${pageVO.pag > 1}"><li class="page-item">
		                             	<a class="page-link" href="${ctp}/admin/user/userList?pag=1&pageSize=${pageVO.pageSize}" tabindex="-1">첫페이지</a>
		                             </li></c:if>
		                             <c:if test="${pageVO.curBlock > 0}"><li class="page-item">
		                             	<a class="page-link" href="${ctp}/admin/user/userList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-left"></i></a>
		                             </li></c:if>
		                             
		                             <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
									    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link" href="${ctp}/admin/user/userList?pag=${i}&pageSize=${pageVO.pageSize}">${i}<span class="sr-only">(current)</span></a></li></c:if>
									    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link" href="${ctp}/admin/user/userList?pag=${i}&pageSize=${pageVO.pageSize}">${i}<span class="sr-only">(current)</span></a></li></c:if>
									  </c:forEach>
			                             
									  <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="${ctp}/admin/user/userList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
									  <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="${ctp}/admin/user/ userList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
		                         </ul>
	                      	</nav>
                     	</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<p><br/></p>
<!-- The Modal -->
<div class="modal" id="userModal">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">회원 상세정보</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <!-- Modal body -->
            <div class="modal-body">
                <form id="userForm" name="userForm" method="post" enctype="multipart/form-data" action="${ctp}/admin/user/userUpdate">
                    <input type="hidden" name="userId" id="modalUserId">
                    <div class="file-input-group mb-5" style="justify-content:center;align-items:center;">
                        <img id="imageDemo" style="width:200px;height:220px;cursor:pointer;" src="" alt="User Image" onclick="$('#imageModal').modal('show');">
                        <label for="file" class="file-input-label"></label>
                        <input type="file" id="file" name="fName" onchange="previewImage()">
                    </div>
                    <div class="form-group">
                        <div class="input-group d-flex justify-content-between">
                            <label><i class="fa-solid fa-caret-right"></i> 회원상태</label>
                            <select class="form-select" id="userStatus" name="userStatus">
                                <option value="on">정상</option>
                                <option value="off">탈퇴</option>
                                <option value="stop">정지</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group d-flex justify-content-between">
                            <label><i class="fa-solid fa-caret-right"></i> 등급</label>
                            <select class="form-select" id="level" name="level">
                                <option value="0">관리자</option>
                                <option value="0.5">지점장</option>
                                <option value="1">300만원 이상</option>
                                <option value="2">50만원 이상</option>
                                <option value="3">회원</option>
                            </select>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">아이디</span>
                        </div>
                        <input type="text" id="modalUserIdDisplay" class="form-control">
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <label class="fw input-group-text">변경할 비밀번호</label>
                        </div>
                        <input type="password" name="pwdNew" id="pwdNew" class="form-control" placeholder="비밀번호 변경시 입력하세요">
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">이름</span>
                        </div>
                        <input type="text" name="name" id="modalName" class="form-control">
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">닉네임</span>
                        </div>
                        <input type="text" name="nickName" id="modalNickName" class="form-control">
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">이메일</span>
                        </div>
                        <input type="text" id="modalEmail" name="email" class="form-control">
                    </div>
                    <div class="form-group mb-3">
                        <label for="tel2"><i class="fa-solid fa-caret-right"></i> 연락처</label>
                        <div class="input-group">
                            <input type="text" id="modalTel" name="tel" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="mr-3"><i class="fa-solid fa-caret-right"></i> 성별</label>
                        <div class="form-check-inline">
                            <label class="form-check-label">
                                <input type="radio" class="form-check-input" name="gender" value="n">미선택
                            </label>
                        </div>
                        <div class="form-check-inline">
                            <label class="form-check-label">
                                <input type="radio" class="form-check-input" name="gender" value="m">남자
                            </label>
                        </div>
                        <div class="form-check-inline">
                            <label class="form-check-label">
                                <input type="radio" class="form-check-input" name="gender" value="f">여자
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group d-flex justify-content-between">
                            <label><i class="fa-solid fa-caret-right"></i> 홈페이지 가입 목적(선택)</label>
                            <select class="form-select" id="registerWay" name="registerWay">
                                <option value="미선택">미선택</option>
                                <option value="정보 취득">정보 취득</option>
                                <option value="본인의 알레르기">본인의 알레르기</option>
                                <option value="자녀 혹은 주변인의 알레르기">자녀 혹은 주변인의 알레르기</option>
                                <option value="환경에 대한 관심">환경에 대한 관심</option>
                                <option value="알레르기 물품 구입">물품 구입</option>
                                <option value="기타">기타</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="mr-3"><i class="fa-solid fa-caret-right"></i> 포인트 &nbsp;&nbsp;&nbsp;</label>
                        <input type="number" class="form-control" id="point" name="point">
                    </div>
                    <div class="form-group">
                        <label class="mr-3"><i class="fa-solid fa-caret-right"></i> 선택 약관 동의 &nbsp;&nbsp;&nbsp;</label>
                        <label class="form-check-label">
                            <input type="checkbox" class="form-check-input" name="agreeOptional" value="y">동의함
                        </label>
                    </div>
                    <div class="form-group">
                        <label class="mr-3"><i class="fa-solid fa-caret-right"></i> 가입일 &nbsp;&nbsp;&nbsp;</label>
                        <input type="text" name="createDate" id="createDate" class="form-control">
                    </div>
                    <div class="form-group">
                        <label class="mr-3"><i class="fa-solid fa-caret-right"></i> 수정일 &nbsp;&nbsp;&nbsp;</label>
                        <input type="text" name="updateDate" id="updateDate" class="form-control">
                    </div>
                </form>
            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-success btn-sm" data-dismiss="modal">확인</button>
                <button type="button" class="btn btn-warning btn-sm" onclick="submitForm()">수정</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
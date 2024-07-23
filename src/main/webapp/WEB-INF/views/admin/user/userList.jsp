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
  	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
</head>
<body>
	<div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <!-- ============================================================== -->
    <!-- Main wrapper - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
        data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
        <jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
		<jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
        <div class="page-wrapper">
            <div class="page-breadcrumb">
                <div class="row">
                    <div class="col-7 align-self-center">
                        <h3 class="page-title text-truncate text-dark font-weight-medium mb-1"> 관리자 님 \^0^/ 회원관리에 항상 신중하세요!</h3>
                        <div class="d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb m-0 p-0">
                                    <li class="breadcrumb-item"><a href="${ctp}/main"><i class="fa-solid fa-house"></i> 메인페이지로</a>
                                    </li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                    <div class="col-5 align-self-center">
                        <div class="customize-input float-right">
                            <select class="custom-select custom-select-set form-control bg-white border-0 custom-shadow custom-radius">
                                <option value="6" selected>2024. 6.</option>
                                <option value="7">2024. 7.</option>
                                <option value="8">2024. 8.</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- End Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Container fluid  -->
            <!-- ============================================================== -->
            <div class="container-fluid">
                <!-- *************************************************************** -->
                <!-- Start Top Leader Table -->
                <!-- *************************************************************** -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex align-items-center mb-4">
                                    <h2 class="card-title mr-3">전체 회원 관리</h2>
                                    <div class="mr-3">
				                        <div class="customize-input">
				                            <select class="custom-select custom-select-set form-control bg-white border-0 custom-shadow custom-radius">
				                                <option value="createDate" selected>가입순</option>
				                                <option value="name">이름순</option>
					                            <optgroup label="등급별"><option value="level">등급순</option>
					                                <option value="3">지식인</option>
					                                <option value="2">전문가</option>
					                                <option value="1">숙련가</option>
					                                <option value="0.5">귀한분</option>
					                            </optgroup>
					                            <optgroup label="상태별"><option value="userStatus">상태순</option>
					                                <option value="정상">정상</option>
					                                <option value="탈퇴신청">탈퇴</option>
					                                <option value="계정정지">정지</option>
					                            </optgroup>
				                            </select>
				                        </div>
				                    </div>
	                                <form>
	                                    <div class="customize-input">
	                                        <input class="form-control custom-shadow custom-radius border-0 bg-white" type="search" placeholder="회원검색" aria-label="Search">
	                                    </div>
	                                </form>
                                    <div class="ml-auto">
                                        <div class="dropdown sub-dropdown">
                                            <button class="btn btn-link text-muted dropdown-toggle" type="button" id="dd1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i data-feather="more-vertical"></i>
                                            </button>
                                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dd1">
                                                <a class="dropdown-item" href="#">회원 수정</a>
                                                <a class="dropdown-item" href="#">회원 정지</a>
                                                <a class="dropdown-item" href="#">회원 삭제</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="table-responsive">
                                    <table class="table no-wrap v-middle mb-0 text-center">
                                        <thead>
                                            <tr class="border-0">
                                                <th class="border-0 font-14 font-weight-medium text-muted">
				                                    <input class="form-check-input" type="checkbox" id="inlineCheckbox" value="option">
				                                    <label class="form-check-label" for="inlineCheckbox">선택</label>
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
                                        <tbody>
                                        	<c:forEach var="vo" items="${vos}" varStatus="st">
                                        	<c:if test="${vo.userId != 'admin'}">
                                            <tr>
                                                <td class="border-top-0 text-dark px-2 py-4">
                                                	<div class="form-check form-check-inline">
					                                    <input class="form-check-input" type="checkbox" id="inlineCheckbox1"
					                                        value="option1">
					                                    <label class="form-check-label" for="inlineCheckbox1">${st.count}</label>
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
	                                                        <p><a type="button" data-toggle="modal" data-target="#myModal" class="badge badge-info">상세보기</a></p>
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
                                                        <!-- <a class="btn btn-cyan rounded-circle btn-circle font-12 popover-item" href="javascript:void(0)">문의</a> -->
                                                    </div>
                                                </td>
                                                <td class="border-top-0 text-center font-weight-medium text-muted px-2 py-4">
                                                	${vo.registerWay}
                                                </td>
                                            </tr>
                                            </c:if>
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
                              	<a class="page-link" href="${ctp}/admin/userList?pag=1&pageSize=${pageVO.pageSize}" tabindex="-1">첫페이지</a>
                              </li></c:if>
                              <c:if test="${pageVO.curBlock > 0}"><li class="page-item">
                              	<a class="page-link" href="${ctp}/admin/userList??pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-left"></i></a>
                              </li></c:if>
                              
                              <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
								    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link" href="${ctp}/admin/userList?pag=${i}&pageSize=${pageVO.pageSize}">${i}<span class="sr-only">(current)</span></a></li></c:if>
								    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link" href="${ctp}/admin/userList?pag=${i}&pageSize=${pageVO.pageSize}">${i}<span class="sr-only">(current)</span></a></li></c:if>
							  </c:forEach>
                              
							  <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="${ctp}/admin/userList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
							  <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="${ctp}/admin/userList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
                          </ul>
                      	</nav>
                     	</div>
                    </div>
                </div>
                <!-- *************************************************************** -->
                <!-- End Top Leader Table -->
                <!-- *************************************************************** -->
            </div>
            <!-- ============================================================== -->
            <!-- End Container fluid  -->
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Page wrapper  -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
<p><br/></p>
<!-- The Modal -->
  <div class="modal" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">회원 상세정보</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
			<form name="myform" method="post" enctype="multipart/form-data" action="${ctp}/admin/user/userDetails">
				<div class="file-input-group text-center mb-5" style="display:flex;justify-content:center;align-items:center;">
                  <img id="imageDemo" style="width:200px;height:220px;cursor:pointer;" src="${ctp}/user/${sImage}" onclick="$('#imageModal').modal('show');">
	                  <label for="file" class="file-input-label"><i class="fas fa-tools"></i></label>
	                  <input type="file" id="file" name="fName" onchange="previewImage()">
				</div>
				
				<div class="input-group mb-3">
					<div class="input-group-prepend">
				      	<span class="input-group-text">아이디</span>
				    </div>
				    <input type="text" name="userId" class="form-control" value="${vo.userId}" readonly>
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
				    <input type="text" name="name" id="name" class="form-control" value="${vo.name}" readonly>
				    <div class="input-group-append">
				      	<a type="button" id="nameUpdateBtn" class="btn btn-warning">정보 수정</a>
				    </div>
				</div>
				
				<div class="input-group mb-3">
					<div class="input-group-prepend">
				      	<span class="input-group-text">닉네임</span>
				    </div>
				    <input type="text" name="nickName" id="nickName" class="form-control" value="${vo.nickName}" readonly>
				    <div class="input-group-append">
				      	<a type="button" id="nickUpdateBtn" class="btn btn-warning">정보 수정</a>
				    </div>
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
				      	<span class="input-group-text">이메일</span>
				    </div>
				    <c:set var="email" value="${fn:split(vo.email,'@')}" />
				    <input type="text" id="email1" name="email1" class="form-control mr-2" value="${email[0]}"/>
						<span style="font-size:1.1em;">@</span>
						<select id="email2" name="email2" class="ml-2" style="width:120px;">
							<option value="naver.com" ${email[1]=='naver.com' ? 'selected' : ''}>naver.com</option>
							<option value="gmail.com" ${email[1]=='gmail.com' ? 'selected' : ''}>gmail.com</option>
							<option value="daum.net" ${email[1]=='daum.net' ? 'selected' : ''}>daum.net</option>
						</select>
				    <div class="input-group-append">
				      	<input type="button" value="이메일 중복체크" id="emailCheckBtn" class="input-group-append btn btn-info btn-sm" onclick="emailCheck()" disabled/>
				    </div>
				</div>
				
				<div class="form-group mb-3">
					<label for="tel2"><i class="fa-solid fa-caret-right"></i> 연락처</label>
					<div class="input-group">
						<div class="input-group-prepend">
				            <select name="tel1" id="tel1" class="form-control">
				              <option value="010" selected>010</option>
				            </select>
				        </div>
				        <c:set var="tel" value="${fn:split(vo.tel,'-')}" />
						<span>&nbsp;&nbsp; - &nbsp;&nbsp;</span>
				        <input type="text" id="tel2" name="tel2" value="${tel[1]}" class="form-control" readonly />
				        <span>&nbsp;&nbsp; - &nbsp;&nbsp;</span>
				        <input type="text" id="tel3" name="tel3" value="${tel[2]}" class="form-control" readonly />
					    <div class="input-group-append">
					      	<a type="button" id="telUpdateBtn" class="btn btn-warning">정보 수정</a>
					    </div>
				    </div>
			    </div>
				
				<div class="form-group">
					<label class="mr-3"><i class="fa-solid fa-caret-right"></i> 성별</label>
			      	<div class="form-check-inline">
				        <label class="form-check-label">
				          	<input type="radio" class="form-check-input" name="gender" value="n" ${vo.gender =='n' ? 'checked' : ''}>미선택
				        </label>
					</div>
			      	<div class="form-check-inline">
				        <label class="form-check-label">
				          	<input type="radio" class="form-check-input" name="gender" value="m" ${vo.gender =='m' ? 'checked' : ''}>남자
				        </label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label">
							<input type="radio" class="form-check-input" name="gender" value="f" ${vo.gender =='f' ? 'checked' : ''}>여자
						</label>
					</div>
				</div>
				
				<div class="form-group">
					<div class="input-group d-flex justify-content-between">
					    <label><i class="fa-solid fa-caret-right"></i> 홈페이지 가입 목적(선택)</label>
					    <select class="form-select" id="registerWay" name="registerWay">
					        <option value="미선택" ${vo.registerWay =='미선택' ? 'selected' : ''}>미선택</option>
					        <option value="정보 취득" ${vo.registerWay =='정보 취득' ? 'selected' : ''}>정보 취득</option>
					        <option value="본인의 알레르기" ${vo.registerWay =='본인의 알레르기' ? 'selected' : ''}>본인의 알레르기</option>
					        <option value="자녀 혹은 주변인의 알레르기" ${vo.registerWay =='자녀 혹은 주변인의 알레르기' ? 'selected' : ''}>자녀 혹은 주변인의 알레르기</option>
					        <option value="환경에 대한 관심" ${vo.registerWay =='환경에 대한 관심' ? 'selected' : ''}>환경에 대한 관심</option>
					        <option value="알레르기 물품 구입" ${vo.registerWay =='알레르기 물품 구입' ? 'selected' : ''}>물품 구입</option>
					        <option value="기타" ${vo.registerWay =='기타' ? 'selected' : ''}>기타</option>
					    </select>
				    </div>
				</div>
				
				<div class="form-group">
					<label class="mr-3"><i class="fa-solid fa-caret-right"></i> 선택 약관 동의 &nbsp;&nbsp;&nbsp;</label>
                    <label class="form-check-label">
                        <input type="checkbox" class="form-check-input" name="agreeOptional" value="y" ${vo.policyFlag == 'y' ? 'checked' : ''}>동의함
                    </label>
				</div>
			</form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-success btnj-sm" data-dismiss="modal">확인</button>
          <input type="button" class="btn btn-success btn-sm" value="수정">
          <input type="button" class="btn btn-danger btn-sm" value="정지">
        </div>
        
      </div>
    </div>
  </div>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
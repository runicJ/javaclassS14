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
                                    <h4 class="card-title">전체 회원 관리</h4>
                                    <div class="ml-auto">
                                        <div class="dropdown sub-dropdown">
                                            <button class="btn btn-link text-muted dropdown-toggle" type="button" id="dd1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i data-feather="more-vertical"></i>
                                            </button>
                                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dd1">
                                                <a class="dropdown-item" href="#">Insert</a>
                                                <a class="dropdown-item" href="#">Update</a>
                                                <a class="dropdown-item" href="#">Delete</a>
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
                                                <th class="border-0 font-14 font-weight-medium text-muted">샹태</th>
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
                                                        <h5 class="text-dark mb-0 font-16 font-weight-medium">${vo.name} [${vo.gender}]</h5>
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
                                                        <!-- <a class="btn btn-cyan rounded-circle btn-circle font-12 popover-item"
                                                            href="javascript:void(0)">문의</a> -->
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
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
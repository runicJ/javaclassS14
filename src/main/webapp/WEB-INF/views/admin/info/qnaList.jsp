<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert</title>
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
    
    <script>
		function openResponseModal(qnaIdx) {
		    console.log('openResponseModal 호출됨:', qnaIdx); 
			
		    $.ajax({
		        url: '${ctp}/admin/info/getQnaDetails',
		        type: 'GET',
		        data: { qnaIdx: qnaIdx },
		        success: function(response) {
		            if (response.success) {
		                $('#qnaTitle').val(response.qnaData.qnaTitle);
		                $('#qnaContent').val(response.qnaData.qnaContent);
		                $('#qnaIdx').val(response.qnaData.qnaIdx);
		                
		                $('#responseModal').modal('show');
		            } else {
		                alert('데이터를 가져오는 중 오류가 발생했습니다.');
		            }
		        },
		        error: function() {
		            alert('데이터를 가져오는 중 오류가 발생했습니다.');
		            console.error('AJAX 요청 에러:', error); // 에러 상세 출력
		        }
		    });
		}
		
		function sendResponse() {
		    let qnaIdx = $('#qnaIdx').val();
		    let qnaAnswerContent = $('#qnaAnswerContent').val();
		    
		    $.ajax({
		        url: '${ctp}/admin/info/sendQnaResponse',
		        type: 'POST',
		        data: {
		            qnaIdx: qnaIdx,
		            qnaAnswerContent: qnaAnswerContent
		        },
		        success: function(response) {
		            if (response.success) {
		                alert('응답이 성공적으로 전송되었습니다.');
		                $('#responseModal').modal('hide');
		                location.reload();
		            } else {
		                alert('응답 전송 중 오류가 발생했습니다.');
		            }
		        },
		        error: function(xhr, status, error) {
		            alert('응답 전송 중 오류가 발생했습니다.');
		        }
		    });
		}
		
		function deleteQna(qnaIdx) {
		    if (confirm('정말 삭제하시겠습니까?')) {
		        $.ajax({
		            url: '${ctp}/admin/info/deleteQna',
		            type: 'POST',
		            data: { qnaIdx: qnaIdx },
		            success: function(response) {
		                if (response.success) {
		                    alert('문의가 성공적으로 삭제되었습니다.');
		                    location.reload();
		                } else {
		                    alert('문의 삭제 중 오류가 발생했습니다.');
		                }
		            },
		            error: function(xhr, status, error) {
		                alert('문의 삭제 중 오류가 발생했습니다.');
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
    <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
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
                </div>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card p-3">
                            <div class="card-body text-center">
                                <h2 class="card-title">문의 목록</h2>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="bg-danger text-white">
                                            <tr>
                                                <th>번호</th>
                                                <th>아이디</th>
                                                <th>제목</th>
                                                <th>신청일</th>
                                                <th>답변상태</th>
                                                <th>문의카테고리</th>
                                                <th>비고</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="qnaVO" items="${qnaVOS}" varStatus="st">
                                            <tr>
                                                <td>${st.count}</td>
                                                <td>${qnaVO.userId}</td>
                                                <td>
												    <a href="javascript:void(0);" 
												       onclick="javascript:openResponseModal('${qnaVO.qnaIdx}')">
												        ${qnaVO.qnaTitle}
												    </a>
                                                </td>
                                                <td>${fn:substring(qnaVO.qnaDate,0,19)}</td>
                                                <td>${qnaVO.qnaAnswerFlag}</td>
                                                <td>${qnaVO.qnaCategory}</td>
                                                <td>
                                                    <span class="badge badge-danger text-light" onclick="deleteQna('${qnaVO.qnaIdx}')">삭제</span>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<p><br/></p>
<div class="modal fade" id="responseModal" tabindex="-1" role="dialog" aria-labelledby="responseModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="responseModalLabel">질문 응답</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="responseForm">
                    <div class="form-group">
                        <label for="qnaTitle">제목:</label>
                        <input type="text" class="form-control" id="qnaTitle" readonly>
                    </div>
                    <div class="form-group">
                        <label for="qnaContent">내용:</label>
                        <textarea class="form-control" id="qnaContent" rows="3" readonly></textarea>
                    </div>
                    <div class="form-group">
                        <label for="qnaAnswerContent">답변 내용:</label>
                        <textarea class="form-control" id="qnaAnswerContent" name="qnaAnswerContent" rows="3" required></textarea>
                    </div>
                    <input type="hidden" id="qnaIdx" name="qnaIdx">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick="sendResponse()">응답 보내기</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>

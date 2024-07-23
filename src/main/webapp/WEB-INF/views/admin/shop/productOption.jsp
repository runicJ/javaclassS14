<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>productOption</title>
<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
  <jsp:include page="/WEB-INF/views/include/admin/bs4.jsp"/>
  <script>
  	'use strict';
    //let cnt = 1;
    let groupCnt = 1;
    let optionCnt = 1;
    
    // 옵션그룹 추가
    function addOptionGroup() {
    	let strOptionGroup = "";
        let groupId = "og" + groupCnt;
        
        strOptionGroup += '<div id="'+groupId+'"><hr size="5px"/>';
        strOptionGroup += '<i class="fas fa-thumbtack"></i> 제품옵션 그룹명'+groupCnt;
        strOptionGroup += '<input type="button" value="그룹 삭제" class="btn btn-outline-danger btn-sm float-right" onclick="removeOptionGroup(\'' + groupId + '\')"/><br/>'
        strOptionGroup += '<input type="text" name="optionGroupName" id="optionGroupName'+groupCnt+'" class="form-control"/>';
    	strOptionGroup += '</div>';
        $("#optionGroupType").append(strOptionGroup);
        groupCnt++;
      }

      function removeOptionGroup(groupId) {
        $("#" + groupId).remove();
      }
    
	// 옵션항목 추가
	function addOption() {
	    const optionId = "o" + optionCnt;
	    const strOption =
	      '<div id="' + optionId + '" class="option-item">' +
	        '<hr size="5px"/>' +
	        '<input type="button" value="옵션 삭제" class="btn btn-outline-danger btn-sm float-right" onclick="removeOption(\'' + optionId + '\')"/><br/>' +
	        '<i class="fas fa-thumbtack"></i> 제품옵션 그룹명 ' + optionCnt +
	        '<select name="optionGroupIdx" id="optionGroupIdx' + optionCnt + '" class="form-control">' +
	          '<option value="">옵션그룹을 선택하세요</option>' +
	        '</select>' +
	        '<i class="fas fa-thumbtack"></i> 제품옵션명 ' + optionCnt +
	        '<input type="text" name="optionName" id="optionName' + optionCnt + '" class="form-control"/>' +
	        '<div class="form-group">' +
	          '<i class="fas fa-thumbtack"></i> 옵션추가가격 ' + optionCnt +
	          '<input type="number" name="addPrice" id="addPrice' + optionCnt + '" class="form-control"/>' +
	        '</div>' +
	      '</div>';
	    $("#optionType").append(strOption);
	    loadOptionGroups(); // 모든 select 요소를 업데이트합니다.
	    optionCnt++;
	}

	// 옵션 그룹 로드
      function loadOptionGroups(productIdx, optionIndex = null) {
          if (!productIdx) {
              productIdx = $('#productIdx').val();
          }

          $.ajax({
              url: '${ctp}/admin/shop/getOptionGroup',
              method: 'GET',
              data: { productIdx: productIdx },
              success: function(groups) {
                  // 모든 그룹을 위한 옵션 HTML을 생성합니다.
                  const options = groups.map(function(group) {
                      return '<option value="' + group.optionGroupIdx + '">' + group.optionGroupName + '</option>';
                  });
                  const optionsHtml = '<option value="">옵션그룹을 선택하세요</option>' + options.join('');

                  // optionIndex가 제공된 경우 특정 select 요소만 업데이트합니다.
                  if (optionIndex !== null) {
                      const selectElement = $('#optionGroupIdx' + optionIndex);
                      selectElement.html(optionsHtml);
                  } else {
                      // optionIndex가 제공되지 않은 경우 모든 select 요소를 업데이트합니다.
                      $("select[name='optionGroupIdx']").html(optionsHtml);
                  }
              },
              error: function() {
                  alert('옵션 그룹을 불러오는 데 실패했습니다.');
              }
          });
      }
    
    // 옵션항목 삭제
    function removeOption(optionId) {
		$("#" + optionId).remove();
    }
    
    // 옵션 그룹 입력후 등록전송
    function fGroupCheck() {
        for(let i = 1; i <= groupCnt; i++) {
            if($("#og" + i).length !== 0) {
                let groupName = document.getElementById("optionGroupName" + i);
                if(groupName && groupName.value.trim() == "") {
                    alert("빈칸 없이 제품 옵션 그룹명을 모두 등록하셔야 합니다");
                    return false;
                }
            }
        }
        myform.action = "${ctp}/admin/shop/optionGroupInput";
        myform.submit();
    }
    
    // 옵션 입력후 등록전송
	function fCheck() {
	    let optionGroupIdx = document.getElementById("optionGroupIdx");
	    if(optionGroupIdx && optionGroupIdx.value.trim() == "") {
	        alert("옵션 그룹을 선택하세요");
	        return false;
	    }
	
	    for(let i = 1; i <= optionCnt; i++) {
	        if($("#o" + i).length !== 0) {
	            let optionName = document.getElementById("optionName" + i);
	            let optionPrice = document.getElementById("addPrice" + i); // 수정된 부분
	            if(optionName && optionName.value.trim() == "") {
	                alert("빈칸 없이 제품 옵션명을 모두 등록하셔야 합니다");
	                return false;
	            }
	            if(optionPrice && optionPrice.value.trim() == "") {
	                alert("빈칸 없이 제품 옵션가격을 모두 등록하셔야 합니다");
	                return false;
	            }
	        }
	    }
	    let optionName = document.getElementById("optionName");
	    let addPrice = document.getElementById("addPrice");
	    let productName = document.getElementById("productName");
	    if(optionName && optionName.value.trim() == "") {
	        alert("제품 옵션이름을 등록하세요");
	        return false;
	    }
	    if(addPrice && addPrice.value.trim() == "") {
	        alert("제품의 추가금액을 등록하세요");
	        return false;
	    }
	    if(productName && productName.value.trim() == "") {
	        alert("제품명을 선택하세요");
	        return false;
	    }
	    myform.action = "${ctp}/admin/shop/optionInput";
	    myform.submit();
	}
    
    // 제품 입력창에서 대분류 선택(Change)시 중분류가져와서 중분류 선택박스에 뿌리기
    function productTopChange() {
    	let productTopIdx = myform.productTopIdx.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/shop/productMidName",
				data : {productTopIdx : productTopIdx},
				success:function(data) {
					var str = "";
					str += "<option value=''>중분류를 선택하세요</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].productMidIdx+"'>"+data[i].productMidName+"</option>";
					}
					$("#productMidIdx").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}
    
    // 제품 입력창에서 중분류 선택(Change)시 해당 제품들을 가져와서 품목 선택박스에 뿌리기
    function productMidChange() {
    	let productTopIdx = myform.productTopIdx.value;
    	let productMidIdx = myform.productMidIdx.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/shop/productName",
				data : {
					productTopIdx : productTopIdx,
					productMidIdx : productMidIdx,
				},
				success:function(data) {
					var str = "";
					str += "<option value=''>제품을 선택하세요</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].productIdx+"'>"+data[i].productName+"</option>";
					}
					$("#productIdx").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}
    
    // 제품리스트 상세보기에서 옵션등록 버튼클릭시 수행하는 부분....
    <c:if test="${!empty productVO}">productInfoCheck('${productVO.productIdx}')</c:if>
    
    // 제품명을 선택하면 제품의 설명을 띄워준다.
    function productInfoCheck(productIdx) {
    	if(productIdx == "") productIdx = document.getElementById("productIdx").value;
    	
    	$.ajax({
    		type:"post",
    		url : "${ctp}/admin/shop/getProductInfo",
    		data: {productIdx : productIdx},
    		success:function(vo) {
    			let str = '<hr/>';
    			str += '<table class="table table-bordered">';
    			str += '<tr><th>대분류명</th><td>'+vo.productTopName+'</td>';
    			str += '<td rowspan="6" class="text-center"><img src="${ctp}/product/'+vo.productThumb+'" width="160px"/></td></tr>';
    			str += '<tr><th>중분류명</th><td>'+vo.productMidName+'</td></tr>';
    			str += '<tr><th>제품명</th><td>'+vo.productName+'</td></tr>';
    			str += '<tr><th>제품설명</th><td>'+vo.productDetails+'</td></tr>';
    			str += '<tr><th>제품가격</th><td>'+numberWithCommas(vo.productPrice)+'원</td></tr>';
    			str += '<tr><td colspan="3" class="text-center"><input type="button" value="등록된 옵션보기(삭제)" onclick="showOptions('+vo.productIdx+')" class="btn btn-info btn-sm"/></td></tr>';
    			str += '</table>';
    			str += '<hr/>';
    			str += '<div id="optionDemo"></div>';
    			$("#demo").html(str);
    			myform.productIdx.value = vo.productIdx;
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    function showOptions(productIdx) {
        $.ajax({
            type: "post",
            url: "${ctp}/admin/shop/getOptionList",
            data: { productIdx: productIdx },
            success: function (vos) {
                let str = '';
                if (vos.length != 0) {
                    str = "- 옵션 목록 -<br>";
                    for (let i = 0; i < vos.length; i++) {
                      	str += "<a href=\"javascript:deleteOption('group', " + vos[i].optionGroupIdx + ")\">";
                        str += vos[i].optionGroupName + "</a> | ";
                        if(vos[i].optionIdx != 0) {
	                        str += "<a href=\"javascript:deleteOption('option', " + vos[i].optionIdx + ")\">";
	                        str += vos[i].optionName + "</a> | <br>";
                        }
                        else str += " [옵선 없음] |";
                    }
                }
    			else {
    				str = "<div class='text-center'><font color='red'>현 제품에 등록된 옵션그룹이나 옵션이 없습니다.</font></div>";
    			}
                $("#optionDemo").html(str);
            },
            error: function () {
                alert("전송오류!");
            }
        });
    }

    function deleteOption(type, idx) {
        let ans = confirm("현재 선택한 옵션을 삭제하시겠습니까?");
        if (!ans) return false;

        let url = "";
        if (type == "group") {
            url = "${ctp}/admin/shop/optionGroupDelete";
        } 
        else if (type == "option") {
            url = "${ctp}/admin/shop/optionDelete";
        }

        $.ajax({
            type: "post",
            url: url,
            data: type == "group" ? { optionGroupIdx: idx } : { optionIdx: idx },
            success: function (res) {
            	if(res != 0) {
	                alert("옵션이 삭제되었습니다.");
	                location.reload();
            	}
            	else alert("옵션의 하위항목이 존재합니다. 하위항목 삭제 후에 시도해주세요!");
            },
            error: function () {
                alert("전송오류!");
            }
        });
    }
    
    // 콤마찍기
    function numberWithCommas(x) {
		  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
  </script>
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
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
		<div class="card p-5">
		  <h2 class="text-center"><i class="fas fa-thumbtack"></i> 제품별 옵션사항 등록</h2>
		  <form name="myform" id="myform" method="post">
		    <div class="form-group">
		      <label for="productTopIdx"><i class="fas fa-thumbtack"></i> 대분류</label>
		      <select id="productTopIdx" name="productTopIdx" class="form-control" onchange="productTopChange()">
		        <option value="">대분류를 선택하세요</option>
		        <c:forEach var="topVO" items="${topVOS}">
		        	<option value="${topVO.productTopIdx}">${topVO.productTopName}</option>
		        </c:forEach>
		        <c:if test="${!empty productVO}"><option value="${productVO.productTopIdx}" selected>${productVO.productTopName}</option></c:if>
		      </select>
		    </div>
		    <div class="form-group">
		      <label for="productMidIdx"><i class="fas fa-thumbtack"></i> 중분류</label>
		      <select id="productMidIdx" name="productMidIdx" class="form-control" onchange="productMidChange()">
		        <option value="">중분류를 선택하세요</option>
		        <c:if test="${!empty productVO}"><option value="${productVO.productMidIdx}" selected>${productVO.productMidName}</option></c:if>
		      </select>
		    </div>
		    <div class="form-group">
		      <label for="productIdx"><i class="fas fa-thumbtack"></i> 제품명</label>
		      <select name="productIdx" id="productIdx" class="form-control" onchange="productInfoCheck('')">
		        <option value="">제품을 선택하세요</option>
		        <c:if test="${!empty productVO}"><option value="${productVO.productIdx}" selected>${productVO.productName}</option></c:if>
		      </select>
		      <div class="text-center" id="demo"></div>
		    </div>
		    
		    <hr/>
		    
		    <p class="text-center">
			    <font size="4"><i class="fas fa-thumbtack"></i> <b>제품그룹 등록</b></font>&nbsp;&nbsp;
			    <input type="button" value="제품옵션그룹 추가하기" onclick="addOptionGroup();" class="btn btn-success btn-sm"/>
		    </p>
		    <div id="optionGroupType"></div>
		    <hr/>
		    <div class='text-right'><input type="button" value="옵션그룹 등록" onclick="fGroupCheck();" class="btn btn-primary"/></div>
		    
		    <p class="text-center">
			    <font size="4"><i class="fas fa-thumbtack"></i> <b>제품옵션 등록</b></font>&nbsp;&nbsp;
			    <input type="button" value="제품옵션 추가하기" onclick="addOption()" class="btn btn-secondary btn-sm"/>
			</p>
		    <div id="optionType"></div>
		    <hr/>
		    <div class='text-right'><input type="button" value="옵션등록" onclick="fCheck()" class="btn btn-primary"/></div>
		    <input type="hidden" name="productIdx">
		  </form>
		</div>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
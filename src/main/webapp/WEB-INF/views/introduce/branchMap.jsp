<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>branchMap</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
  	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
    <style>
	    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
	    .wrap * {padding: 0;margin: 0;}
	    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
	    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
	    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
	    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
	    .info .close:hover {cursor: pointer;}
	    .info .body {position: relative;overflow: hidden;}
	    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
	    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
	    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
	    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
	    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
	    .info .link {color: #5085BB;}
	    
        .modal {
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 400px;
            height: auto;
        }

        .close-modal {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close-modal:hover,
        .close-modal:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
	</style>
    <script>
        function branchSearch() {
            let branchName = document.myform.branchName.value;
            if(branchName === "") {
                alert("검색할 지점을 선택하세요");
                return false;
            }
            document.myform.submit();
        }
        
        function openModal(qrCode) {
            document.getElementById('modalImg').src = qrCode;
            document.getElementById('qrModal').style.display = "flex";
        }

        function closeModal() {
            document.getElementById('qrModal').style.display = "none";
        }
        
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                closeModal();
            }
        });

        window.addEventListener('click', function(event) {
            const modal = document.getElementById('qrModal');
            if (event.target === modal) {
                closeModal();
            }
        });
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br></p>
<section class="page">
    <div class="container">
        <h2 class="mb-5">'괄호 안 쉼표' 지점 소개</h2>
       	<span>전화번호를 클릭하시면 바로 해당 지점과 연락이 가능합니다.</span>
        <p style="color:red;font-size:bold;">지점을 선택 후에 qr코드 이미지를 클릭 시, 확대된 qr코드를 스캔하시면 해당 지점의 상세 정보가 출력됩니다!</p>
        <form name="myform" class="mb-2">
            <select name="branchName" id="branchName">
                <c:forEach var="branchVO" items="${branchVOS}">
                    <option value="${branchVO.branchName}" <c:if test="${branchVO.branchName == vo.branchName}">selected</c:if>>${branchVO.branchName}</option>
                </c:forEach>
            </select>
            <input type="button" value="지점선택" class="btn btn-primary btn-sm" onclick="branchSearch()"/>
            <c:if test="${sUid == 'admin'}"><p class="float-right">
                <input type="button" value="지점등록" class="btn btn-secondary btn-sm" onclick="location.href='${ctp}/admin/info/branchInput';" />
            <p></c:if>
        </form>
        <div id="map" style="width:100%;height:500px;"></div>
    </div>
</section>
<div id="qrModal" class="modal" style="display:none;">
    <div class="modal-content">
        <span class="close-modal" onclick="closeModal()">&times;</span>
        <img id="modalImg" src="" alt="QR Code" style="width:100%; height:100%;">
    </div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3fe3ad77eb298aac7a938386f756b9b1"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
    var mapOption = { 
        center: new kakao.maps.LatLng(${vo.latitude}, ${vo.longitude}), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    }; 

    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // 지도에 마커를 표시합니다 
    var marker = new kakao.maps.Marker({
        map: map, 
        position: new kakao.maps.LatLng(${vo.latitude}, ${vo.longitude})
    });

    // 커스텀 오버레이에 표시할 컨텐츠 입니다
    var content = '<div class="wrap">' +
                  '    <div class="info">' +
                  '        <div class="title">' +
                  '            ${vo.branchName}' +
                  '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
                  '        </div>' +
                  '        <div class="body">' +
                  '            <div class="img">' +
                  '                <img src="${ctp}/qrCode/${vo.qrCode}.png" width="73" height="70" alt="branchQR" onclick="openModal(\'${ctp}/qrCode/${vo.qrCode}.png\')">' +
                  '           </div>' +
                  '            <div class="desc">' +
                  '                <div class="ellipsis">${vo.branchLocation}</div>' +
                  '                <div class="jibun ellipsis">시작일 : ${fn:substring(vo.createDate,0,10)}</div>' +
                  '                <div><a href="tel:${vo.branchTel}" class="link">${vo.branchTel}</a></div>' +
                  '            </div>' +
                  '        </div>' +
                  '    </div>' +
                  '</div>';

    // 마커 위에 커스텀오버레이를 표시합니다
    var overlay = new kakao.maps.CustomOverlay({
        content: content,
        map: map,
        position: marker.getPosition()
    });

    // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
    kakao.maps.event.addListener(marker, 'click', function () {
        overlay.setMap(map);
    });

    // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
    function closeOverlay() {
        overlay.setMap(null);
    }
});
</script>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
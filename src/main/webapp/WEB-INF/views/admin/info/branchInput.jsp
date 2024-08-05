<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>지점 추가</title>
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3fe3ad77eb298aac7a938386f756b9b1"></script>
    <style>
        #map {
            width: 100%;
            height: 500px;
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
                <div class="card-body">
                    <h2 class="mb-5"><i class="fa-solid fa-map-location-dot"></i> 지점 추가</h2>
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success" role="alert">
                            ${successMessage}
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">
                            ${errorMessage}
                        </div>
                    </c:if>
                    <form action="${ctp}/admin/info/branchInput" method="post">
                        <div class="form-group">
                            <label for="branchName"><i class="fa-solid fa-map-location-dot"></i> 지점 이름</label>
                            <input type="text" class="form-control" id="branchName" name="branchName" required>
                        </div>
                        <div class="form-group">
                            <label for="branchTel"><i class="fa-solid fa-map-location-dot"></i> 전화번호</label>
                            <input type="text" class="form-control" id="branchTel" name="branchTel" required>
                        </div>
                        <div class="form-group">
                            <label for="branchLocation"><i class="fa-solid fa-map-location-dot"></i> 주소</label>
                            <input type="text" class="form-control" id="branchLocation" name="branchLocation" required>
                        </div>
                        <div class="form-group">
                            <label><i class="fa-solid fa-map-location-dot"></i> 위치 선택</label>
                            <div id="map"></div>
                        </div>
                        <div class="form-group">
                            <label for="latitude"><i class="fa-solid fa-map-location-dot"></i> 위도</label>
                            <input type="text" class="form-control" id="latitude" name="latitude" readonly required>
                        </div>
                        <div class="form-group">
                            <label for="longitude"><i class="fa-solid fa-map-location-dot"></i> 경도</label>
                            <input type="text" class="form-control" id="longitude" name="longitude" readonly required>
                        </div>
                        <button type="submit" class="btn btn-primary">지점 추가</button>
                    </form>
                </div>
            </div>
        </div>
        <a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
    </div>
    <p><br/></p>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var mapContainer = document.getElementById('map'),
                mapOption = {
                    center: new kakao.maps.LatLng(36.6283272, 127.4913407),
                    level: 3
                };

            var map = new kakao.maps.Map(mapContainer, mapOption);

            kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
                var latlng = mouseEvent.latLng;

                document.getElementById('latitude').value = latlng.getLat();
                document.getElementById('longitude').value = latlng.getLng();
            });
        });
    </script>
    <jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>

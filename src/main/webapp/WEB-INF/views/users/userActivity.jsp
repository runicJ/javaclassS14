<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
  	<%@ include file = "/WEB-INF/views/include/user/bs4.jsp"%>
  	<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
  	<script src="http://developers.kakao.com/sdk/js/kakao.js"></script>
    <title>userActivity</title>
    <style>
        .activity-table { width: 80%; margin: 20px auto; border-collapse: collapse; }
        .activity-table th, .activity-table td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        .activity-table th { background-color: #f8f8f8; }
        .activity-table tr:hover { background-color: #f9f9f9; }
        a { text-decoration: none; color: #333; }
    </style>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/user/header.jsp"%>
<%@ include file = "/WEB-INF/views/include/user/nav.jsp"%>
<section class="page">
<div class="container">
<div class="row">
	<jsp:include page="/WEB-INF/views/include/user/sidebar.jsp" />
	<div class="col-xs-12 col-md-8">
    <h2 style="text-align:center;">회원 활동 내역</h2>
    <table class="activity-table">
        <thead>
            <tr>
                <th>작성</th>
                <th>제목</th>
                <th>작성 시간</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Map<String, Object>> activities = (List<Map<String, Object>>) request.getAttribute("activities");
                if (activities == null || activities.isEmpty()) {
            %>
                <tr><td colspan='3' style='text-align:center;'>작성한 활동 내역이 없습니다.</td></tr>
            <%
                } else {
                    for (Map<String, Object> activity : activities) {
                        String type = (String) activity.get("type");
                        String title = (String) activity.get("title");
                        String link = (String) activity.get("link");
                        Object createdAt = activity.get("created_at");
            %>
                <tr>
                    <td><%= type %></td>
                    <td><a href="<%= link %>"><%= title %></a></td>
                    <td><%= createdAt %></td>
                </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
</div>
</div>
</div>
</section>
<%@ include file = "/WEB-INF/views/include/user/footer.jsp"%>
</body>
</html>
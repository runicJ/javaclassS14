<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>병원 목록</title>
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
    <style>
        h2, h3 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .search-bar {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }
        .search-bar select, .search-bar input, .search-bar button {
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-right: 5px;
        }
        .search-bar button {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .search-bar button:hover {
            background-color: #0056b3;
        }
        .hospital-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            list-style: none;
            padding: 0;
        }
        .hospital-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s, box-shadow 0.2s;
            overflow: hidden;
        }
        .hospital-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        .hospital-card-content {
            padding: 15px;
        }
        .hospital-card a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }
        .hospital-card a:hover {
            color: #007bff;
        }
        .hospital-details {
            margin-top: 5px;
            font-size: 14px;
            color: #666;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<section class="page">
<div class="container">
    <h2>병원 검색</h2>
    <div class="search-bar">
        <form action="${ctp}/community/hospitalList" method="get">
            <select name="key">
                <option value="hospitalName">병원명</option>
                <option value="hospitalCategory">전문분야</option>
                <option value="hospitalRegion">지역</option>
            </select>
            <input type="text" name="keyword" placeholder="검색어를 입력하세요">
            <button type="submit">검색</button>
        </form>
    </div>
    <h3>병원 목록</h3>
    <ul class="hospital-list">
        <c:forEach var="hospital" items="${hospitals}">
            <li class="hospital-card">
                <div class="hospital-card-content">
                    <a href="${ctp}/community/hospitalCommentInput?hospitalIdx=${hospital.hospitalIdx}">
                        ${hospital.hospitalName}
                    </a>
                    <div class="hospital-details">
                        ${hospital.hospitalCategory} | ${hospital.hospitalRegion}
                    </div>
                </div>
            </li>
        </c:forEach>
    </ul>
</div>
</section>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>

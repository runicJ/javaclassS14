<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>title</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
	    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin: 15px 0 5px;
        }
        input[type="text"],
        textarea,
        input[type="range"],
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .rating input {
            display: none;
        }
        .rating label {
            float: right;
            padding: 10px;
            font-size: 20px;
            color: #ddd;
            transition: all 0.3s;
        }
        .rating input:checked ~ label,
        .rating:not(:checked) label:hover,
        .rating:not(:checked) label:hover ~ label {
            color: #ffc700;
        }
    </style>
	
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br></p>
<section class="page">
<div class="container">
    <h2>${hospital.hospitalName} 후기 작성</h2>
    <form action="${ctp}/community/hospitalComment" method="post">
        <input type="hidden" name="hospitalIdx" value="${hospital.hospitalIdx}">
        <div>
            <label for="title">제목:</label>
            <input type="text" id="title" name="hospitalCommentTitle" required>
        </div>
        <div>
            <label for="comment">내용:</label>
            <textarea id="comment" name="hospitalComment" required></textarea>
        </div>
        <div>
            <label for="star">별점:</label>
            <select id="star" name="star">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>
        </div>
        <div>
            <label for="waiting_time">대기 시간:</label>
            <input type="range" id="waiting_time" name="waiting_time" min="0" max="60" value="10">
            <span id="waiting_time_value">10분</span>
        </div>
        <button type="submit">작성</button>
    </form>
</div>
</section>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
<script>
document.getElementById('waiting_time').addEventListener('input', function() {
    document.getElementById('waiting_time_value').textContent = this.value + '분';
});
</script>
</body>
</html>
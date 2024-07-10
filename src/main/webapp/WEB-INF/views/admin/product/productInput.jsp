<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>productInput</title>
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
    <script src="${ctp}/resources/ckeditor/ckeditor.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br></p>
<div class="container">
    <form>
        <textarea name="editor1" id="editor1" rows="10" cols="80">
            This is my textarea to be replaced with CKEditor 4.
        </textarea>
        <script>
            // Replace the <textarea id="editor1"> with a CKEditor 4
            // instance, using default configuration.
            CKEDITOR.replace( 'editor1' );
        </script>
    </form>
</div>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
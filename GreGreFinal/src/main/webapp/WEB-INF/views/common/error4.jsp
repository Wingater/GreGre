<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERROR</title>
<script>
(function () {
	alert("잘못된 접근입니다.");
	location.href = "${pageContext.request.contextPath}";
})();
</script>
</head>
<body>

</body>
</html>
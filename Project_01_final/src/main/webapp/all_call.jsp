<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@page import="part_01.ApiExplorer"%>
<html>
<head>
<meta charset="EUC-KR">
<title>와이파이 정보 구하기</title>

<style type="text/css">
a {
	text-decoration:underline;
}
</style>
</head>
<body>
	<%ApiExplorer.main(); %>
	<%
		ApiExplorer a = new ApiExplorer();
		int total = ApiExplorer.count();
		out.println("<h1>"+"총 "+total+"개의 데이터가 입력되었습니다."+"</h1>");
	%>
	<a id='home' style='cursor: pointer; width: 30px;'
		onclick="location.href='index.jsp'">홈으로 돌아가기!</a>
</body>
</html>
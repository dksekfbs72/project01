<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@page import="part_01.ApiExplorer"%>
<html>
<head>
<meta charset="EUC-KR">
<title>�������� ���� ���ϱ�</title>

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
		out.println("<h1>"+"�� "+total+"���� �����Ͱ� �ԷµǾ����ϴ�."+"</h1>");
	%>
	<a id='home' style='cursor: pointer; width: 30px;'
		onclick="location.href='index.jsp'">Ȩ���� ���ư���!</a>
</body>
</html>
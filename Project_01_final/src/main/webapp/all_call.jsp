<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@page import="part_01.ApiExplorer"%>
<html>
<head>
<meta charset="EUC-KR">
<title>�������� ���� ���ϱ�</title>
</head>
<body>
	<%ApiExplorer.main(); %>
	<%
		ApiExplorer a = new ApiExplorer();
		int total = ApiExplorer.count();
		out.println("<h1>"+"�� "+total+"���� �����Ͱ� �ԷµǾ����ϴ�."+"</h1>");
	%>
	<button onclick="location.href='index.html'">Ȩ</button>
</body>
</html>
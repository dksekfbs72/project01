<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="part_01.SQLtest"%>
<%@page import="org.json.simple.JSONObject" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<table id = "dynamictable" style = "border:1px solid #000;">
		<br>
		<thead>
		<tr style='background-color: darkseagreen;'>
			<th>�Ÿ�(km)</th>
			<th>������ȣ</th>
			<th>��ġ��</th>
			<th>�������̸�</th>
			<th>���θ��ּ�</th>
			<th>���ּ�</th>
			<th>��ġ��ġ</th>
			<th>��ġ����</th>
			<th>��ġ���</th>
			<th>���񽺱���</th>
			<th>������</th>
			<th>��ġ�⵵</th>
			<th>�ǳ��ܱ���</th>
			<th>WIFI����ȯ��</th>
			<th>X��ǥ</th>
			<th>Y��ǥ</th>
			<th>�۾�����</th>
		</tr>
		</thead>
		<tbody id="dynamicTbody">
		<%for(int x = 0; x<6; x++) {%>
		<tr>
		<%for(int i = 0; i<=16; i++) {%>
		
		<td><%= i%></td>
		
		<%} %>
		</tr>
		<%} %>
		</tbody>
	</table>

</body>
</html>
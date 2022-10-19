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
			<th>거리(km)</th>
			<th>관리번호</th>
			<th>자치구</th>
			<th>와이파이명</th>
			<th>도로명주소</th>
			<th>상세주소</th>
			<th>설치위치</th>
			<th>설치유형</th>
			<th>설치기관</th>
			<th>서비스구분</th>
			<th>망종류</th>
			<th>설치년도</th>
			<th>실내외구분</th>
			<th>WIFI접속환경</th>
			<th>X좌표</th>
			<th>Y좌표</th>
			<th>작업일자</th>
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
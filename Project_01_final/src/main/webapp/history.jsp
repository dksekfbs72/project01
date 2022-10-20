<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@page import="part_01.SQLtest"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="org.json.simple.JSONArray"%>
<html>
<head>
<%
String id = request.getParameter("id"); 
if(id!=null){
	SQLtest.history_del(id);
}
%>
<meta charset="EUC-KR">
<%
JSONObject json = null;
json = SQLtest.history_select();
JSONArray jsonArray = null;
jsonArray = (JSONArray) json.get("row");
JSONParser parser = new JSONParser();
%>
<title>와이파이 정보 구하기</title>
<style>
table {
	width: 100%;
	border-top: 1px solid #F6F6F6;
	border-collapse: collapse;
	border-radius: 50%;
}

th, td {
	border-bottom: 1px solid #F6F6F6;
	border-left: 1px solid #F6F6F6;
	padding: 10px;
}

th {
	background-color: #005766;
	color: #ffffff;
}

thead tr {
	background-color: #005766;
	color: #ffffff;
}

tbody tr:nth-child(2n) {
	background-color: #A6A6A6;
}

tbody tr:nth-child(2n+1) {
	background-color: #D5D5D5;
}

th:first-child, td:first-child {
	border-left: none;
}

a {
	text-decoration: underline;
}

a:visited {
	color: blue;
}
</style>
<h1 id="jb">위치 히스토리 목록</h1>
</head>
<body>
	<div style="display: inline;">
		<a id='home' style='cursor: pointer; width: 30px;'
			onclick="location.href='index.jsp'">홈</a> | <a type="button"
			id='history' style='cursor: pointer'
			onclick="location.href='history.jsp'">위치 히스토리 목록</a> | <a type="button"
			id="all_common" style='cursor: pointer'
			onclick="location.href='history.jsp'">모든 정보 가져오기</a>
	</div>
	<br>
	<table id="userList" class="table table-hover">
		<tr>
			<th>ID</th>
			<th>X좌표</th>
			<th>Y좌표</th>
			<th>조회일자</th>
			<th>비고</th>
		</tr>
		<tbody>
			<%
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jo = (JSONObject) parser.parse(jsonArray.get(i).toString());
			%>
			<tr>
				<td><%=jo.get("ID")%></td>
				<td><%=jo.get("X")%></td>
				<td><%=jo.get("Y")%></td>
				<td><%=jo.get("시간")%></td>
				<td style="text-align: center"><button
						class="btn btn-danger pull-right" type="button"
						onclick="getUserName()">삭제</button></td>
			</tr>
			<%
			}
			%>
			<tr>
			</tr>
		</tbody>
	</table>
	<script type="text/javascript">
		function getUserName() {
			let userList = document.getElementById('userList');

			for (let i = 1; i < userList.rows.length; i++) {
				userList.rows[i].cells[4].onclick = function() {
					let userName = userList.rows[i].cells[0].innerText;
					var link = "history.jsp?id="+userName;
					location.href=link;
				}
			}
		}
	</script>
</body>
</html>
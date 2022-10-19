<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@page import="part_01.SQLtest"%>
<%@page import="org.json.simple.JSONObject" %>
<%@page import="org.json.simple.parser.JSONParser" %>
<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="org.json.simple.JSONArray" %>
<%
	String lat = request.getParameter("Lat");
	String lnt = request.getParameter("Lnt");
	JSONObject json=null;
	JSONArray jsonArray=null;
	JSONParser parser = new JSONParser();
	if(lat != null && lnt != null){
		json = SQLtest.select(lat, lnt);
		jsonArray = (JSONArray) json.get("row");
	}
%>
<html>
<head>
<meta charset="EUC-KR">
<title>�������� ���� ���ϱ�</title>
<style>
table {
	border-collapse: collapse;
	text-align: center;
} /*���߼� ����*/
th, td {
	width: 100px;
	height: 50px;
	border: 1px solid #000;
	vertical-align: top; /* �� */
	vertical-align: bottom; /* �Ʒ� */
	vertical-align: middle; /* ��� */
}

tr.colored:nth-child(even) {
	background-color: #FFFFFF;
	color: #000000;
}

tr.colored:nth-child(odd) {
	background-color: #000000;
	color: #FFFFFF;
}
a {
	text-decoration:underline;
}
a:visited {
    color: blue;
}
</style>
<h1>�������� ���� ���ϱ�</h1>
</head>
<body>
	<div style="display:inline;">
	<a id='home' style='cursor: pointer; width: 30px;'
		onclick="location.href='test.jsp'">Ȩ</a>
	|
	<a type="button" id='history' style='cursor: pointer'
		onclick="location.href='test.jsp'">��ġ �����丮 ���</a>
	|
	<a type="button" id="all_common" style='cursor: pointer'
		onclick="location.href='all_call.jsp'">��� ���� ��������</a>
	</div>
	<br>
	<br>
	<form action="test.jsp" method="get">
		LAT: <input type="text" id="Lat" name = "Lat" style='width: 100px' value="0.0">&nbsp;&nbsp;LNT:
		<input type="text" id="Lnt" name = "Lnt" style='width: 100px' value="0.0">&nbsp;
		<button type="button" onclick='getLocation()'>�� ��ġ ��������</button>
		<button type="button" onclick='blink()'>��ó WIFI ���� ����</button>
	</form>
	<table id = "dynamictable">
		<br>
		<thead>
		<tr style='background-color: darkseagreen'>
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
		
		<%if (json==null) {%>
			<tr>
			<td colspan="17">��ġ ������ �Է��� �Ŀ� ��ȸ�� �ּ���.</td>
			</tr>
			
			
		<%} else{
			for(int i=0; i<jsonArray.size(); i++){
				JSONObject jo = (JSONObject) parser.parse(jsonArray.get(i).toString());%>
				<tr>
				<td><%=jo.get("�Ÿ�")%></td>
				<td><%=jo.get("������ȣ")%></td>
				<td><%=jo.get("��ġ��")%></td>
				<td><%=jo.get("�������̸�")%></td>
				<td><%=jo.get("���θ��ּ�")%></td>
				<td><%=jo.get("���ּ�")%></td>
				<td><%=jo.get("��ġ��ġ")%></td>
				<td><%=jo.get("��ġ����")%></td>
				<td><%=jo.get("��ġ���")%></td>
				<td><%=jo.get("���񽺱���")%></td>
				<td><%=jo.get("������")%></td>
				<td><%=jo.get("��ġ�⵵")%></td>
				<td><%=jo.get("�ǳ��ܱ���")%></td>
				<td><%=jo.get("WIFI����ȯ��")%></td>
				<td><%=jo.get("X��ǥ")%></td>
				<td><%=jo.get("Y��ǥ")%></td>
				<td><%=jo.get("�۾�����")%></td>
				</tr>
			<%}%>
			
		<%} %>
		
		</tbody>
	</table>
	<script type="text/javascript">
	function getLocation() {
		if (navigator.geolocation) { // GPS�� �����ϸ�
			navigator.geolocation.getCurrentPosition(function(position) {
				var lat = position.coords.latitude;
				var lnt = position.coords.longitude;
				document.getElementById("Lat").value = lat;
				document.getElementById("Lnt").value = lnt;
			}, function(error) {
				console.error(error);
			}, {
				enableHighAccuracy : false,
				maximumAge : 0,
				timeout : Infinity
			});
		} else {
			alert('GPS�� �������� �ʽ��ϴ�');
		}
	}
	function blink() {
		var lat = document.getElementById("Lat").value;
		var lnt = document.getElementById("Lnt").value;
		var link = "test.jsp?Lat="+lat+"&Lnt="+lnt;
		location.href = link;
	}
	</script>
		
</body>
</html>
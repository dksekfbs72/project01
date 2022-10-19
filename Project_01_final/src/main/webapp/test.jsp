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
<title>와이파이 정보 구하기</title>
<style>
table {
	border-collapse: collapse;
	text-align: center;
} /*이중선 제거*/
th, td {
	width: 100px;
	height: 50px;
	border: 1px solid #000;
	vertical-align: top; /* 위 */
	vertical-align: bottom; /* 아래 */
	vertical-align: middle; /* 가운데 */
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
<h1>와이파이 정보 구하기</h1>
</head>
<body>
	<div style="display:inline;">
	<a id='home' style='cursor: pointer; width: 30px;'
		onclick="location.href='test.jsp'">홈</a>
	|
	<a type="button" id='history' style='cursor: pointer'
		onclick="location.href='test.jsp'">위치 히스토리 목록</a>
	|
	<a type="button" id="all_common" style='cursor: pointer'
		onclick="location.href='all_call.jsp'">모든 정보 가져오기</a>
	</div>
	<br>
	<br>
	<form action="test.jsp" method="get">
		LAT: <input type="text" id="Lat" name = "Lat" style='width: 100px' value="0.0">&nbsp;&nbsp;LNT:
		<input type="text" id="Lnt" name = "Lnt" style='width: 100px' value="0.0">&nbsp;
		<button type="button" onclick='getLocation()'>내 위치 가져오기</button>
		<button type="button" onclick='blink()'>근처 WIFI 정보 보기</button>
	</form>
	<table id = "dynamictable">
		<br>
		<thead>
		<tr style='background-color: darkseagreen'>
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
		
		<%if (json==null) {%>
			<tr>
			<td colspan="17">위치 정보를 입력한 후에 조회해 주세요.</td>
			</tr>
			
			
		<%} else{
			for(int i=0; i<jsonArray.size(); i++){
				JSONObject jo = (JSONObject) parser.parse(jsonArray.get(i).toString());%>
				<tr>
				<td><%=jo.get("거리")%></td>
				<td><%=jo.get("관리번호")%></td>
				<td><%=jo.get("자치구")%></td>
				<td><%=jo.get("와이파이명")%></td>
				<td><%=jo.get("도로명주소")%></td>
				<td><%=jo.get("상세주소")%></td>
				<td><%=jo.get("설치위치")%></td>
				<td><%=jo.get("설치유형")%></td>
				<td><%=jo.get("설치기관")%></td>
				<td><%=jo.get("서비스구분")%></td>
				<td><%=jo.get("망종류")%></td>
				<td><%=jo.get("설치년도")%></td>
				<td><%=jo.get("실내외구분")%></td>
				<td><%=jo.get("WIFI접속환경")%></td>
				<td><%=jo.get("X좌표")%></td>
				<td><%=jo.get("Y좌표")%></td>
				<td><%=jo.get("작업일자")%></td>
				</tr>
			<%}%>
			
		<%} %>
		
		</tbody>
	</table>
	<script type="text/javascript">
	function getLocation() {
		if (navigator.geolocation) { // GPS를 지원하면
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
			alert('GPS를 지원하지 않습니다');
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
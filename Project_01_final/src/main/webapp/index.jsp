<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<%@page import="part_01.SQLtest"%>
<%@page import="org.json.simple.JSONObject" %>
<%@page import="org.json.simple.parser.JSONParser" %>
<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="org.json.simple.JSONArray" %>
<html>
<head>
<%

	String defaute = "0.0";
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
<meta charset="EUC-KR">
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
		onclick="location.href='index.jsp'">홈</a>
	|
	<a type="button" id='history' style='cursor: pointer'
		onclick="location.href='index.jsp'">위치 히스토리 목록</a>
	|
	<a type="button" id="all_common" style='cursor: pointer'
		onclick="location.href='all_call.jsp'">모든 정보 가져오기</a>
	</div>
	<br>
	<br>
	<form action="test.jsp" method="get">
		LAT: <%if(lat==null) {%><input type="text" id="Lat" name = "Lat" style='width: 100px' value="0.0">
		<%} else { %>
		<input type="text" id="Lat" name = "Lat" style='width: 100px' value = <%=lat %>>
		<%} %>
		&nbsp;&nbsp;LNT:
		<%if(lnt==null) {%><input type="text" id="Lnt" name = "Lnt" style='width: 100px' value="0.0">
		<%} else { %>
		<input type="text" id="Lnt" name = "Lnt" style='width: 100px' value = <%=lnt %>>
		<%} %>&nbsp;
		<button type="button" onclick='getLocation()'>내 위치 가져오기</button>
		<button type="button" onclick='blink()'>근처 WIFI 정보 보기</button>
	</form>
	<table id = "dynamictable">
		<br>
		<thead style = "height:50px">
		<tr>
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
			<td colspan="17" style = "text-align:center; background-color:white;">위치 정보를 입력한 후에 조회해 주세요.</td>
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
		var link = "index.jsp?Lat="+lat+"&Lnt="+lnt;
		location.href = link;
	}
	</script>
		
</body>
</html>
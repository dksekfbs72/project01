package part_01;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.*;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.json.simple.JSONArray;

/*
 * 모든 데이터 DB에 저장
 */
public class ApiExplorer {
	public static void main() throws IOException, ParseException {
		int cnt = 1;
		int total = -1;
		part_01.SQLtest.main();
		while (cnt/1000 != total) {
			StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088"); /* URL */
			urlBuilder.append("/"
					+ URLEncoder.encode("7569617355646b7335364163615242", "UTF-8")); /* 인증키 (sample사용시에는 호출시 제한됩니다.) */
			urlBuilder.append("/" + URLEncoder.encode("json", "UTF-8")); /* 요청파일타입 (xml,xmlf,xls,json) */
			urlBuilder.append("/" + URLEncoder.encode("TbPublicWifiInfo", "UTF-8")); /* 서비스명 (대소문자 구분 필수입니다.) */
			urlBuilder.append("/" + URLEncoder.encode(String.valueOf(cnt), "UTF-8")); /* 요청시작위치 (sample인증키 사용시 5이내 숫자) */
			urlBuilder.append("/" + URLEncoder.encode(String.valueOf(cnt+999), "UTF-8")); /* 요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨) */
			// 상위 5개는 필수적으로 순서바꾸지 않고 호출해야 합니다.

			// 서비스별 추가 요청 인자이며 자세한 내용은 각 서비스별 '요청인자'부분에 자세히 나와 있습니다.

			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/xml");
			System.out.println("Response code: " + conn.getResponseCode()); /* 연결 자체에 대한 확인이 필요하므로 추가합니다. */
			BufferedReader rd;

			// 서비스코드가 정상이면 200~300사이의 숫자가 나옵니다.
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();
			String json = sb.toString();

			JSONParser parser = new JSONParser();
			JSONObject jsonObject = (JSONObject) parser.parse(json);

			json = jsonObject.get("TbPublicWifiInfo").toString();

			jsonObject = (JSONObject) parser.parse(json);
			
			total = Integer.valueOf(jsonObject.get("list_total_count").toString()) / 1000 + 1 ;

			JSONArray jsonArray = new JSONArray();
			jsonArray = (JSONArray) jsonObject.get("row");

			ArrayList<String>[] list = new ArrayList[1000];
			for (int i = 0; i < list.length; i++)
				list[i] = new ArrayList<String>();

			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jo = (JSONObject) parser.parse(jsonArray.get(i).toString());
				var X_SWIFI_MGR_NO = "(\"" + jo.get("X_SWIFI_MGR_NO") + "\",";
				var X_SWIFI_MRDOFC = "\"" + jo.get("X_SWIFI_WRDOFC") + "\",";
				var X_SWIFI_MAIN_NM = "\"" + jo.get("X_SWIFI_MAIN_NM") + "\",";
				var X_SWIFI_ADRES1 = "\"" + jo.get("X_SWIFI_ADRES1") + "\",";
				var X_SWIFI_ADRES2 = "\"" + jo.get("X_SWIFI_ADRES2") + "\",";
				var X_SWIFI_INSTL_FLOOR = "\"" + jo.get("X_SWIFI_INSTL_FLOOR") + "\",";
				var X_SWIFI_INSTL_TY = "\"" + jo.get("X_SWIFI_INSTL_TY") + "\",";
				var X_SWIFI_INSTL_MBY = "\"" + jo.get("X_SWIFI_INSTL_MBY") + "\",";
				var X_SWIFI_SVC_SE = "\"" + jo.get("X_SWIFI_SVC_SE") + "\",";
				var X_SWIFI_CMCWR = "\"" + jo.get("X_SWIFI_CMCWR") + "\",";
				var X_SWIFI_CNSTC_YEAR = "\"" + jo.get("X_SWIFI_CNSTC_YEAR") + "\",";
				var X_SWIFI_INOUT_DOOR = "\"" + jo.get("X_SWIFI_INOUT_DOOR") + "\",";
				var X_SWIFI_REMARS3 = "\"" + jo.get("X_SWIFI_REMARS3") + "\",";
				var LAT = "\"" + jo.get("LAT") + "\",";
				var LNT = "\"" + jo.get("LNT") + "\",";
				var WORK_DTTM = "\"" + jo.get("WORK_DTTM") + "\")";

				String[] aaa = { (String) X_SWIFI_MGR_NO, (String) X_SWIFI_MRDOFC, (String) X_SWIFI_MAIN_NM,
						(String) X_SWIFI_ADRES1, (String) X_SWIFI_ADRES2, (String) X_SWIFI_INSTL_FLOOR,
						(String) X_SWIFI_INSTL_TY, (String) X_SWIFI_INSTL_MBY, (String) X_SWIFI_SVC_SE,
						(String) X_SWIFI_CMCWR, (String) X_SWIFI_CNSTC_YEAR, (String) X_SWIFI_INOUT_DOOR,
						(String) X_SWIFI_REMARS3, (String) LAT, (String) LNT, (String) WORK_DTTM };

				for (String k : aaa) {
					list[i].add(k);
				}
			}
			part_01.SQLtest.insert(list);
			cnt += 1000;
		}
	}
	public static int count() throws IOException, ParseException {
		String urlBuilder = "http://openapi.seoul.go.kr:8088/7569617355646b7335364163615242/json/TbPublicWifiInfo"
				+ "/1/1"; /* URL */

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/xml");
		System.out.println("Response code: " + conn.getResponseCode()); /* 연결 자체에 대한 확인이 필요하므로 추가합니다. */
		BufferedReader rd;

		// 서비스코드가 정상이면 200~300사이의 숫자가 나옵니다.
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		String json = sb.toString();

		JSONParser parser = new JSONParser();
		JSONObject jsonObject = (JSONObject) parser.parse(json);

		json = jsonObject.get("TbPublicWifiInfo").toString();

		jsonObject = (JSONObject) parser.parse(json);

		return Integer.valueOf(jsonObject.get("list_total_count").toString());
	}
}

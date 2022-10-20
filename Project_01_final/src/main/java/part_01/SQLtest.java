package part_01;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;

public class SQLtest {

	public static void main() {

		try {
			// MySQL DB용 드라이로드
			Class.forName("com.mysql.cj.jdbc.Driver");
			// DB연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/wifiinfo", "root", "1004");
			String sql = "DROP TABLE wifi";
			// sql문장
			Statement stmt = conn.createStatement();
			try {
				stmt.execute(sql);
				System.out.println("테이블 제거");
			} finally {
				sql = "create table wifi(X_SWIFI_MGR_NO TEXT,\r\n" + "X_SWIFI_MRDOFC TEXT, X_SWIFI_MAIN_NM TEXT,\r\n"
						+ "X_SWIFI_ADRES1 TEXT, X_SWIFI_ADRES2 TEXT,\r\n"
						+ "X_SWIFI_INSTL_FLOOR TEXT, X_SWIFI_INSTL_TY TEXT,\r\n"
						+ "X_SWIFI_INSTL_MBY TEXT, X_SWIFI_SVC_SE TEXT,\r\n"
						+ "X_SWIFI_MGR_CMCWR TEXT, X_SWIFI_CNSTC_YEAR TEXT,\r\n"
						+ "X_SWIFI_INOUT_DOOR TEXT, X_SWIFI_REMARS3 TEXT,\r\n"
						+ "LON FLOAT, LAT FLOAT, WORK_DTTM TEXT)";
				stmt.execute(sql);
				System.out.println("테이블 생성");
			}
			// DB연결해제
			conn.close();
			System.out.println("mysql 연결해제 성공");
		} catch (ClassNotFoundException error) {
			System.out.println("mysql driver 미설치 또는 드라이버 이름 오류");
		} catch (SQLException error) {
			System.out.println("DB접속오류");
		}

	}

	public static void insert(ArrayList<String>[] list) {
		StringJoiner joiner = new StringJoiner(",");

		for (ArrayList<String> i : list) {
			if (i.isEmpty())
				break;
			String aaa = "";
			for (String x : i) {
				aaa += x;
			}
			joiner.add(aaa);
		}

		try {
			// SQLite JDBC 체크
			Class.forName("com.mysql.cj.jdbc.Driver");
			// DB연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/wifiinfo", "root", "1004");
			// sql문장
			Statement stmt = conn.createStatement();

			String sql = "INSERT INTO wifi";
			sql += " VALUES " + joiner;
			// SQL 수행
			stmt.execute(sql);
			System.out.println("입력성공");

			if (stmt != null)
				stmt.close();

			if (conn != null)
				conn.close();

		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void histoty_insert(String lat,String lnt) {
		try {
			// SQLite JDBC 체크
			Class.forName("com.mysql.cj.jdbc.Driver");
			// DB연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/wifiinfo", "root", "1004");
			// sql문장
			Statement stmt = conn.createStatement();

			String sql = "INSERT INTO history_tbl(lat,lnt)";
			sql += " VALUES ("+lat+","+lnt+")" ;
			// SQL 수행
			stmt.execute(sql);
			System.out.println("입력성공");

			if (stmt != null)
				stmt.close();

			if (conn != null)
				conn.close();

		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static JSONObject select(String LAT, String LNG) throws IOException, ParseException {
		JSONObject jsonObject = new JSONObject();
		int cnt = 0;
		try {
			// SQLite JDBC 체크
			Class.forName("com.mysql.cj.jdbc.Driver");
			// DB연결
			Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/wifiinfo", "root", "1004");

			String sql = "select *, round((6371 * acos( cos( radians(" + LAT + ") ) * cos( radians(LAT) ) * \r\n"
					+ "cos( radians(LON) - radians(" + LNG + ") ) + sin( radians(" + LAT + ") ) * \r\n"
					+ "sin( radians(LAT)))),4) as distance from wifi order by distance ASC limit 20";
			// SQL 수행
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			JSONArray json = new JSONArray();
			while (rs.next()) {
				JSONObject data = new JSONObject();

				data.put("거리", rs.getString("distance"));
				data.put("관리번호", rs.getString("X_SWIFI_MGR_NO"));
				data.put("자치구", rs.getString("X_SWIFI_MRDOFC"));
				data.put("와이파이명", rs.getString("X_SWIFI_MAIN_NM"));
				data.put("도로명주소", rs.getString("X_SWIFI_ADRES1"));
				data.put("상세주소", rs.getString("X_SWIFI_ADRES2"));
				data.put("설치위치", rs.getString("X_SWIFI_INSTL_FLOOR"));
				data.put("설치유형", rs.getString("X_SWIFI_INSTL_TY"));
				data.put("설치기관", rs.getString("X_SWIFI_INSTL_MBY"));
				data.put("서비스구분", rs.getString("X_SWIFI_SVC_SE"));
				data.put("망종류", rs.getString("X_SWIFI_MGR_CMCWR"));
				data.put("설치년도", rs.getString("X_SWIFI_INOUT_DOOR"));
				data.put("실내외구분", rs.getString("X_SWIFI_SVC_SE"));
				data.put("WIFI접속환경", rs.getString("X_SWIFI_REMARS3"));
				data.put("X좌표", rs.getString("LAT"));
				data.put("Y좌표", rs.getString("LON"));
				data.put("작업일자", rs.getString("WORK_DTTM"));
				json.add(data);

			}
			jsonObject.put("row", json);
			if (stmt != null)
				stmt.close();

			if (conn != null)
				conn.close();
			
			return jsonObject;

		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return jsonObject;
	}
	
	public static JSONObject history_select() throws IOException, ParseException {
		JSONObject jsonObject = new JSONObject();
		Connection con = null;                 // 데이터 베이스와 연결을 위한 객체
        Statement stmt = null;                 // SQL 문을 데이터베이스에 보내기위한 객체
        ResultSet rs = null;    
		try {
			// SQLite JDBC 체크
			Class.forName("com.mysql.cj.jdbc.Driver");
			// DB연결
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/wifiinfo", "root", "1004");

			String sql = "select * from history_tbl order by id desc";
			// SQL 수행
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			JSONArray json = new JSONArray();
			while (rs.next()) {
				JSONObject data = new JSONObject();
				data.put("ID", rs.getString("id"));
				data.put("X", rs.getString("lat"));
				data.put("Y", rs.getString("lnt"));
				data.put("시간", rs.getString("time"));
				
				json.add(data);
			}
			jsonObject.put("row", json);
			if (stmt != null)
				stmt.close();

			if (con != null)
				con.close();
			return jsonObject;

		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return jsonObject;
	}
	public static void history_del(String id) throws IOException, ParseException {
		Connection con = null;                 // 데이터 베이스와 연결을 위한 객체
        Statement stmt = null;                 // SQL 문을 데이터베이스에 보내기위한 객체
		try {
			// SQLite JDBC 체크
			Class.forName("com.mysql.cj.jdbc.Driver");
			// DB연결
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/wifiinfo", "root", "1004");

			String sql = "delete from history_tbl where id="+id;
			// SQL 수행
			stmt = con.createStatement();
			stmt.execute(sql);
			System.out.println("제거 완료");
			if (stmt != null)
				stmt.close();

			if (con != null)
				con.close();
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

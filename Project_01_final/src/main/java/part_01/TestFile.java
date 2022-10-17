package part_01;

import java.sql.*;
import java.util.*;

public class TestFile {

	public static void main(String[] args) {

		Connection con = null;

		try {
			// SQLite JDBC 체크
			Class.forName("org.sqlite.JDBC");

			// SQLite 데이터베이스 파일에 연결
			String dbFile = "D:\\eclips_work\\part_01\\db\\test.db";
			con = DriverManager.getConnection("jdbc:sqlite:" + dbFile);

			// SQL 수행
			Statement stat = con.createStatement();
			ResultSet rs = stat.executeQuery("SELECT * From test");
			while (rs.next()) {
				String NO = rs.getString("X_SWIFI_MGR_NO");
				System.out.println(NO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
				}
			}
		}
		String[] aaa = new String[16];
	}

	public static void drop() {
		try {
			// SQLite JDBC 체크
			Class.forName("org.sqlite.JDBC");

			// SQLite 데이터베이스 파일에 연결
			String url = "D:\\eclips_work\\part_01\\db\\test.db";
			Connection con = DriverManager.getConnection("jdbc:sqlite:" + url);
			String sql = "DROP TABLE test";
			// SQL 수행
			Statement stmt = con.createStatement();
			try {
				stmt.execute(sql);
				System.out.println("테이블 제거");
			} finally {

				sql = "CREATE TABLE \"test\" (\r\n" + "	\"X_SWIFI_MGR_NO\"	TEXT,\r\n"
						+ "	\"X_SWIFI_MRDOFC\"	TEXT,\r\n" + "	\"X_SWIFI_MAIN_NM\"	TEXT,\r\n"
						+ "	\"X_SWIFI_ADRES1\"	TEXT,\r\n" + "	\"X_SWIFI_ADRES2\"	TEXT,\r\n"
						+ "	\"X_SWIFI_INSTL_FLOOR\"	TEXT,\r\n" + "	\"X_SWIFI_INSTL_TY\"	TEXT,\r\n"
						+ "	\"X_SWIFI_INSTL_MBY\"	TEXT,\r\n" + "	\"X_SWIFI_SVC_SE\"	TEXT,\r\n"
						+ "	\"X_SWIFI_MGR_CMCWR\"	TEXT,\r\n" + "	\"X_SWIFI_CNSTC_YEAR\"	TEXT,\r\n"
						+ "	\"X_SWIFI_INOUT_DOOR\"	TEXT,\r\n" + "	\"X_SWIFI_REMARS3\"	TEXT,\r\n"
						+ "	\"LON\"	INTEGER,\r\n" + "	\"LAT\"	INTEGER,\r\n" + "	\"WORK_DTTM\"	TEXT\r\n" + ")";
				stmt.execute(sql);
				System.out.println("테이블 생성");
			}

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
			Class.forName("org.sqlite.JDBC");

			// SQLite 데이터베이스 파일에 연결
			String url = "D:\\eclips_work\\part_01\\db\\test.db";
			Connection con = DriverManager.getConnection("jdbc:sqlite:" + url);

			String sql = "INSERT INTO test";
			sql += " VALUES " + joiner;
			// SQL 수행
			Statement stmt = con.createStatement();
			stmt.execute(sql);
			System.out.println("입력성공");

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
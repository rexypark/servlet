<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--  JDBC프로그램으로 DB데이터 가져와서 화면 출력 --%>
<%
	//JDBC 프로그램을 위한 변수 선언
	//CONNECTION / PREPAREDSTATEMENT SELECT QUERY
	String driver = "oracle.jdbc.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "SQLD_CBT";
	String password = "sqld";
	
	Connection conn = null;
	PreparedStatement  pstmt = null;
	ResultSet rs = null;
	
	//전체 인원수
	int cnt = 0;
	
	//사용할 쿼리 작성
	String sql = "";
	
	sql += "SELECT ROWNUM AS RN, SABUN, NAME, NALJA, PAY " ;
	sql +=	" FROM GUEST";
	sql +=	" ORDER BY RN ";
	
	
	String sqlCnt = "select count(*) as cnt from guest";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>사원 목록</h1>
	<table border>
		<thead>

			<tr>
				<th>번호</th>
				<th>사번</th>
				<th>성명</th>
				<th>날짜</th>
				<th>금액</th>
				<th>상세보기</th>
			</tr>
		</thead>	
		<!-- thead 끝 -->
		<tbody>
<%--			
			<tr>
				<td>1</td>
				<td>111</td>
				<td>rexy</td>
				<td>2019/12/16</td>
				<td>1000</td>
				<td>선택</td>
			</tr>
--%>
<%
	try {
		//1. 드라이버 로딩
		Class.forName(driver);
		//2. DB연결
		conn = DriverManager.getConnection(url, user, password);
		//3. Statement 객체 생성(Connection 객체로 부터)
		pstmt = conn.prepareStatement(sql);
		//4. 쿼리실행
		rs = pstmt.executeQuery();
		//5. 쿼리 실행 결과 처리
		while(rs.next()) {
%>
	<tr>
		<td><%=rs.getInt("RN") %></td>
		<td><%=rs.getInt("SABUN") %></td>
		<td><%=rs.getString("NAME") %></td>
		<td><%=rs.getDate("NALJA") %></td>
		<td><%=rs.getInt("PAY") %></td>
		<td>
			<a href="detail.jsp?idx=<%=rs.getInt("SABUN") %>">선택</a>
		</td>
	</tr>
<% 			
		}
		//전체 인원수 조회
		rs = pstmt.executeQuery(sqlCnt);
		if(rs.next()) {
			cnt = rs.getInt("CNT");	
		}
		
		
		System.out.println("cnt : " + cnt);
	} catch (Exception e) {
		out.print("<tr><td colspan='6'>");
		out.print("<h2>[예외발생] 담당자에게(8888) 연락바랍니다.</h2>");
		out.print("</tr></tr>");
		//예외처리
		e.printStackTrace();
	} finally {
		try {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
			
	}
%>
		</tbody>	
	</table>
	<p>총 인원 : <%=cnt %>명</p>
	<p>
		<a href="addForm.jsp">사원등록</a>
	</p>
</body>
</html>
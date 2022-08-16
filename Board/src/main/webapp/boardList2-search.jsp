<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String word = request.getParameter("word"); // 검색어가 있을때와 없을때(null) 분기가 필요
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	final int ROW_PER_PAGE = 10;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	// 1)
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.print("드라이버 로딩 성공");
	
	// 2) 접속
 	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdj50", "root", "1234");
	System.out.print(conn);
	
	// 게시글 목록(stmt, rs)
	PreparedStatement stmt = null;
	if(word == null) {
		stmt = conn.prepareStatement("select no,title from board order by no desc limit ?, ?");
		stmt.setInt(1, beginRow);
		stmt.setInt(2, ROW_PER_PAGE);
	} else {
		stmt = conn.prepareStatement("select no,title from board where title like ? order by no desc limit ?, ?");
		stmt.setString(1, "%"+word+"%");
		stmt.setInt(2, beginRow);
		stmt.setInt(3, ROW_PER_PAGE);
	}
	ResultSet rs = stmt.executeQuery();
	
	// 게시글 카운터(stmt, rs)
	PreparedStatement stmt2 = null;
	if(word == null) {
		stmt2 = conn.prepareStatement("select count(*) from board");
	} else {
		stmt2 = conn.prepareStatement("select count(*) from board where title like ?");
		stmt2.setString(1, "%"+word+"%");
	}
	ResultSet rs2 = stmt2.executeQuery();
	int totalCount = 0;
	if(rs2.next()) {
		totalCount = rs2.getInt("count(*)");
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<form method="get" action="./boardList2.jsp">
			<input type="text" name="word">
			<button type="submit">검색</button>
		</form>
	</div>
	<table border="1">
		<tr>
			<th>no</th>
			<th>title</th>
		</tr>
		
		<%
			while(rs.next()) {
		%>
				<tr>
					<td><%=rs.getInt("no")%></td>
					<td><%=rs.getString("title")%></td>
				</tr>
		<%		
			}
		%>
	</table>
	
	<!-- 이전/다음 페이징 -->
	<div>
		<%
			if(word == null) {
				if(currentPage > 1) {
		%>
					<a href="./boardList2.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%			
				}
			} else {
				if(currentPage > 1) {
		%>
					<a href="./boardList2.jsp?currentPage=<%=currentPage-1%>&word=<%=word%>">이전</a>		<!-- <%=word%> null이란 글자로 넘어감 => 숫자로 바꿔줘야함 -->
		<%	
				}
			}
		%>
		
		
		
		<%
			int lastPage = totalCount / ROW_PER_PAGE;
			if(totalCount % ROW_PER_PAGE != 0) {
				lastPage += 1;
			}
			
			if(word == null) {
				if(currentPage < lastPage) {
		%>
					<a href="./boardList2.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%			
				}
			} else {
				if(currentPage < lastPage) {
		%>
					<a href="./boardList2.jsp?currentPage=<%=currentPage+1%>&word=<%=word%>">다음</a>		<!-- <%=word%> null이란 글자로 넘어감 => 숫자로 바꿔줘야함 -->
		<%	
				}
			}
		%>
	</div>
</body>
</html>

<%
	// DB 자원해제
	rs2.close();
	stmt2.close();
	rs.close();
	stmt.close();
	conn.close();
%>
​
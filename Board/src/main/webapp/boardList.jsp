<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList.jsp</title>
</head>
<body>
<%

	request.setCharacterEncoding("utf-8");
	String word = request.getParameter("word"); 		// 검색어가 있을때와 없을때(null) 분기가 필요
	
	int currentPage = 1;								// current => 내장객체  현재페이지
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	final int ROW_PER_PAGE = 10;						// 한번 만들어지면 잘 안바뀜
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	// 1)
	Class.forName("org.mariadb.jdbc.Driver");		// forName => static 메서드
	// out.println("드라이버 로딩 성공!");				// out.println => object 타입		out = > 내장객체
	
	// 2) 접속
	Connection conn= null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdj50","root","1234");
	// out.println(conn);
	
	
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
	
	
	/*
	select no,title from board order by no desc 
	limit 0, 10			-> 1page	0, 15
	limit 10, 10		-> 2page	15, 15
	limit 20, 10		-> 3page	30, 15
	
	beginRow = (현재페이지에서 -1) * 페이지마다 보여줄 갯수(행의 수)							
	*/
	

	// ResultSet(java.sql.ResultSet)은 executeQuery(String sql)을 통해 쿼리 실행하면 ResultSet타입으로 반환을 해주어 결과값을 저장할 수 있다.
	// 결과값을 저장할 수 있고 저장된 값을 한 행 단위로 불러올 수 있다.
 	// 한 행에서 값을 가져올 때는 타입을 지정해 불러올 수 있다.
%>
	<h1>BOARD</h1>
	<br/>
	<div>
		<a href="./insertBoardForm.jsp">Board 입력</a>	
	</div>
	
	<table border="1">
		<tr>
			<th>no</th>
			<th>title</th>
		</tr>
<% 
	while(rs.next()){ 
%>
		<tr>
			<td><%=rs.getInt("no") %></td>
			<td><a href="./boardOne.jsp?no=<%=rs.getInt("no") %>"><%=rs.getString("title") %></a></td>
		</tr>
<% 	
	}
%>	
	</table>

	
	<!-- 검색 -->
	<div>
		<form method="get" action="./boardList2.jsp">
			<input type="text" name="word">
			<button type="submit">검색</button>
		</form>
	</div>
	
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
	// currtentPage가 마지막페이지보다 작을때
	// lastPage는 전체 행의 수와 rowPerPage를 알면 구할 수 있다.
	// select count(*) from board;   => 전체 행의 수 
	
	/* 	
		int currentPage = 1;			// 현재 페이지
		int totalCount = 0;				// 총 데이터의 갯수
		int limit = 10;					// 한 페이지 당 나타낼 데이터의 갯수
		if(rs2.next()) { totalCount = rs2.getInt("count(*)"); }  			//  db에서 전체 게시물 카운트해서 값 가져오기.
		
		int pageCount = (int)Math.ceil( totalCount / limit);				// pageCount : 화면에 나타날 페이지 갯수
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
			
		int startPage = ((currentPage - 1) / pageCount) * pageCount + 1;
		int endPage = (((currentPage - 1) / pageCount) + 1) * pageCount;
		int lastPage = totalCount / pageCount;
	    if (totalCount % pageCount != 0) { lastPage += 1; }
	    if (lastPage < endPage) { endPage = lastPage; }
			 */
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
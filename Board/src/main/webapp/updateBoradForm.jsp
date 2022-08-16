<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%
	request.setCharacterEncoding("utf-8");
	int no = Integer.parseInt(request.getParameter("no"));
	// 디버깅
	System.out.println("no : " + no);
	
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdj50","root","1234");
	System.out.println("conn : " + conn);
	
	// select no, title, content, create_date from board where no=?
	PreparedStatement stmt = conn.prepareStatement("select no, title, content, create_date from board where no=?");
	stmt.setInt(1,no);
	System.out.println(stmt);
	
	ResultSet rs = stmt.executeQuery();	
	/* select는 executeQuery
	insert, delect, update는 executeUpdate */

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Board 수정폼</h1>
	<form action="./updateBoardAction.jsp" method="post" >
	<%
		if(rs.next()){			 // rs.next가 있을때만 보여줌
	%>
		<table border = "1">
			<tr>
				<td>번호</td>
				<td><input type="text" name="no" value="<%=rs.getInt("no")%>" readonly ></td>	
			</tr>
			
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" value="<%=rs.getString("title")%>"></td>	
			</tr>
				
			<tr>
				<td>내용</td>
				<td><textarea rows="5" cols="80" name="content"><%=rs.getString("content")%></textarea></td>
											
			</tr>			
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="pw" ></td>	
			</tr>			
		</table>
		<button type="submit">입력</button>
	</form>
	
	<% 
		}
	%>
		
		
	
</body>
</html>
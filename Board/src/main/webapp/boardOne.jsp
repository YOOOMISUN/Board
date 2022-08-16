<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int no = Integer.parseInt(request.getParameter("no"));
	// 디버깅
	// System.out.println("no : " + no);
	
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdj50","root","1234");
	// System.out.println("conn : " + conn);
	
	// select no, title, content, create_date from board where no=?
	PreparedStatement stmt = conn.prepareStatement("select no, title, content, create_date from board where no=?");
	stmt.setInt(1,no);
	
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
	<h1>게시판 상세</h1>
		<div>
			<a href="./boardList.jsp">글목록</a>
		</div>
	<%
		if(rs.next()){			 // rs.next가 있을때만 보여줌
	%>
			<table border="1">
				<tr>
					<td>번호</td>
					<td><%=rs.getInt("no") %></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><%=rs.getString("title") %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><%=rs.getString("content") %></td>
				</tr>
				<tr>
					<td>날짜</td>
					<td><%=rs.getString("create_date") %></td>
				</tr>
			</table>
			<div>
				<a href="./updateBoradForm.jsp?no=<%=no%>">수정</a>
				<a href="./deleteBoardForm.jsp?no=<%=no%>">삭제</a>
			</div>
			
	<% 
		}
	%>
	
	<!-- 댓글 입력 폼 -->
	<div>
		<form action="./insertCommentAction.jsp" method="post">
			<input type="hidden" name="b_no" value="<%=no%>">
			<div>
				댓글
				<textarea name="c_content" rows="2" cols="50"></textarea>
			</div>
			<div>
				비밀번호 : <input name="c_pw" type="password">
			</div>
			<div>
				<button type="submit">댓글입력</button>
			</div>
		</form>
	</div>
	
	<!-- 댓글 목록 -->
	<%
	
	// select c_no, c_content , create_date from comment where b_no=?
	PreparedStatement stmt2 = conn.prepareStatement("select c_no, c_content, create_date from comment where b_no=? order by create_date");
	stmt2.setInt(1,no);
	
	ResultSet rs2 = stmt2.executeQuery();
	
	%>
	
		<table border="1">
			<tr>
				<td>번호</td>	<td>댓글</td><td>날짜</td>
			</tr>
	<% 
		while(rs2.next()){
	%>		
			<tr>
				<td><%=rs2.getInt("c_no") %></td>
				<td><%=rs2.getString("c_content") %></td>
				<td><%=rs2.getString("create_date") %></td>
			</tr>
			
			<tr>
				<td><a href="./deleteCommentForm.jsp?c_no=<%=rs2.getInt("c_no") %>&b_no=<%=no %>">삭제</a>
			</tr>
	
	<%	
		}
	 %>
		</table>
</body>
</html>







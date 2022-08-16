<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>


<%
	request.setCharacterEncoding("utf-8");
	Class.forName("org.mariadb.jdbc.Driver");
	int no = Integer.parseInt(request.getParameter("no"));
	String pw = request.getParameter("pw");
	System.out.println("no : " + no);
	System.out.println("pw : " + pw);
	
	Connection conn = null;
	conn=DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdj50","root","1234");
	System.out.println(conn);
	
	// delete from board where no=? and pw=?
			
	PreparedStatement stmt = conn.prepareStatement("delete from board where no=? and pw=?");
	stmt.setInt(1, no);
	stmt.setString(2, pw);
	System.out.println("stmt : " + stmt);
	
	int row = stmt.executeUpdate();		// 1이면 삭제 성공, 0이면 삭제 실패
	if(row==0){				// 삭제 실패
		response.sendRedirect("./boardOne.jsp?no="+no);			// 삭제 실패면 상세페이지로 이동
	}	else	{			// 삭제 성공
		response.sendRedirect("./boardList.jsp");				// 삭제 성공은 List로 이동
	}
	
	
%>







<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>


<%
	request.setCharacterEncoding("utf-8");
	int no = Integer.parseInt(request.getParameter("no"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String pw = request.getParameter("pw");
	
	// 디버깅
	System.out.println("no : " + no);
	
	Connection conn = null;
	conn=DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdj50","root","1234");
	System.out.println(conn);
	
	// delete from board where no=? and pw=?

	PreparedStatement stmt = conn.prepareStatement("update board set title=?, content=? where no=? and pw=?");
	stmt.setString(1, title);
	stmt.setString(2, content);
	stmt.setInt(3, no);
	stmt.setString(4, pw);
	
	int row = stmt.executeUpdate();		// 1이면 수정 성공, 0이면 수정 실패
	if(row==0){				// 수정 실패
		response.sendRedirect("./updateBoradForm.jsp?no="+no);		// 수정 실패면 수정폼으로 
	}	else	{			// 수정 성공
		response.sendRedirect("./boardOne.jsp?no="+no);				// 수정 성공은 상세페이지로 이동
	}
%>







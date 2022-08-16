<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<%
		request.setCharacterEncoding("utf-8");
		int bno = Integer.parseInt(request.getParameter("b_no"));		
		int cno = Integer.parseInt(request.getParameter("c_no"));	
		String pw = request.getParameter("c_pw");

		System.out.println("b_no : " + bno);
		System.out.println("c_no : " + cno);
		System.out.println("c_pw : " + pw);
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn= null;
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdj50","root","1234");
		
		PreparedStatement stmt = conn.prepareStatement("delete from comment where c_no=? and c_pw=?");      // 비밀번호 맞으면 삭제
		stmt.setInt(1,cno);
		stmt.setString(2,pw);
		
		stmt.executeUpdate();		
		response.sendRedirect("./boardOne.jsp?no="+bno);		// 상세페이지로	
		
	%>
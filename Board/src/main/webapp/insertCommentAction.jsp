<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<%
	request.setCharacterEncoding("utf-8");
	// 요청분석 디버깅 - 컨트롤러
	// hidden으로 받아진 board의 no 
	int b_no = Integer.parseInt(request.getParameter("b_no"));		// hidden b_no 값
	String c_content = request.getParameter("c_content");
	String c_pw = request.getParameter("c_pw");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn=DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdj50","root","1234");
	System.out.println("conn : " + conn);
	
	// db 처리 - 서비스 (모델)
	PreparedStatement stmt = conn.prepareStatement("insert into comment (b_no,c_content,c_pw,create_date) values (?,?,?,now())");
	stmt.setInt(1, b_no);		
	stmt.setString(2, c_content);		
	stmt.setString(3, c_pw);	
	
	stmt.executeUpdate();
	// 뷰
	response.sendRedirect("./boardOne.jsp?no="+b_no);				
%>





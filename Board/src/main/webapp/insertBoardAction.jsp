<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>

	<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 요청값 처리
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// 디버깅		: 사용자가 볼 수 없게 system.out.println 로
	System.out.println("tilte : " + title);
	System.out.println("content : " + content);
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/gdj50","root","1234");
	System.out.println("conn : " + conn);
	
	// insert into board (title, content, create_date) values (?,?,now());
	PreparedStatement stmt = conn.prepareStatement("insert into board (title, content, create_date) values (?,?,now())");
	stmt.setString(1, title);		// 1번째 값을 title로 
	stmt.setString(2, content);		// 2번째 값을 content로
	
	System.out.println(stmt);
	
	int row = stmt.executeUpdate();		// DB에 stmt 쿼리 내용을 실행		=> board에 추가
	System.out.println("row : " + row);
	
	response.sendRedirect("./boardList.jsp");	// response 일반 객체 / sendRedirect 일반메소드  
			// 클라이언트 브라우저에 boardList.jsp 페이지를 재요청 부탁     
	%>

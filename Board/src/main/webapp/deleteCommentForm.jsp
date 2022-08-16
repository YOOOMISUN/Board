<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   <%
		String cno = request.getParameter("c_no");
		String bno = request.getParameter("b_no");
	%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="./deleteCommentAction.jsp" method="post">
		<input type="hidden" name="c_no" value="<%=cno%>">	<!-- 코멘트 테이블 번호 받아와 숨기기 -->
		<input type="hidden" name="b_no" value="<%=bno%>">	<!-- 보드 테이블 번호 받아와 숨기기 -->
		비밀번호 : 
		<input type="password" name="c_pw">        <!-- 비밀번호 받아오기 -->
		<button type="submit">삭제</button>
	</form>
	
</body>
</html>
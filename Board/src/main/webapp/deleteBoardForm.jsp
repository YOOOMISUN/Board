<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  
    <%
		String no = request.getParameter("no");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="./deleteBoardAction.jsp" method="post">
		<input type="hidden" name="no" value="<%=no%>">		<!-- readonly="readonly" 사용가능 -->
		비밀번호 : 
		<input type="password" name="pw">
		<button type="submit">삭제</button>
	</form>
	
</body>
</html>
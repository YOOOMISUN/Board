<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Board 입력폼</h1>
	<form action="./insertBoardAction.jsp" method="post" >
		<table border = "1">
			<tr>
				<td>제목</td>
				<td><input type="text" name="title"></td>	<!-- request.getParameter("title")로 받음 -->
			</tr>
				
			<tr>
				<td>내용</td>
				<td><textarea rows="5" cols="80" name="content"></textarea></td>
												<!-- request.getParameter("content")로 받음 -->
			</tr>			
		</table>
		<button type="submit">입력</button>
	</form>
</body>
</html>
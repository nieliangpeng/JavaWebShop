<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp" %> 
<%@page errorPage="../common/UserError.jsp"%>
<c:set var="path_" value="${pageContext.request.contextPath}" scope="application"></c:set>
<c:set var="path" value="${pageContext.request.contextPath}/admin" scope="application"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网站后台管理系统</title>
<link href="${path}/css/css.css" type="text/css" rel="stylesheet" />
</head>

<frameset rows="95,*,30"  name="allFrame"frameborder="no" border="0" framespacing="0">

	<frame src="${path}/adminMain_top.jsp" name="topframe" id="topframe" scrolling="no" frameborder="no" />

	<frameset id="attachucp" framespacing="0" border="0" frameborder="no" cols="194,12,*" rows="*">
		<frame name="leftFrame" scrolling="auto"  frameborder="no"  src="${path}/adminMain_left.jsp"></frame>
		<frame id="leftbar" name="switchFrame" scrolling="no" src="${path }/swich.html"></frame>
		<frame name="mainFrame" scrolling="auto"  border="0"  src="${path }/adminMain_right.jsp"></frame>
	</frameset>

	<frame src="${path}/adminMain_bottom.jsp" name="bottomFrame" id="bottomFrame" frameborder="no" scrolling="No" />
</frameset>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp" %>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="path" value="${pageContext.request.contextPath}/user"
	scope="application"></c:set>
<c:set var="path_" value="${pageContext.request.contextPath}"
	scope="application"></c:set>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="0;URL=${path_}/jumpToIndex.action" />
<title>正在加载</title>
</head>

<body>
<center>
    <br/>
	<div>
		<font color="green" style="font-weight: bolder;">正在进入一家小店首页，请稍后....</font>
	</div>
	<br/>
	<img alt="" src="${path}/images/loadPg.gif">
</center>
</body>
</html>
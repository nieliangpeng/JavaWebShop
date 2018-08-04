<%@page import="com.sky.Bean.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp" %> 
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>右侧内容页</title>
</head>
<body>

<span style="color:#528dc5;"><strong>亲爱的<c:if test="${admin!=null}"><%=((Admin)session.getAttribute("admin")).getPerson().getRealName() %></c:if>,<br/><br/>你好,欢迎登录后台管理系统！</strong></span>
	
</body>
</html>

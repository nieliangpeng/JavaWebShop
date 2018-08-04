<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp"%>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>完成注册</title>
<c:set var="path" value="${pageContext.request.contextPath}/user"
	scope="application"></c:set>
<c:set var="path_" value="${pageContext.request.contextPath}"
	scope="application"></c:set>
<link href="${path}/css/base.css" rel="stylesheet" type="text/css">
<link href="${path}/css/css.css" rel="stylesheet" type="text/css">

<script src="${path}/js/jquery-2.1.1.min.js"></script>
<style>
.tab {
	overflow: hidden;
	margin-top: 20px;
	margin-bottom: -1px;
}

.tab li {
	display: block;
	float: left;
	width: 100px;
	padding: 10px 20px;
	cursor: pointer;
	border: 1px solid #ccc;
}

.tab li.on {
	background: #90B831;
	color: #FFF;
	padding: 10px 20px;
}

.conlist {
	padding: 30px;
	border: 1px solid #ccc;
	width: 500px;
}

.conbox {
	display: none;
}
</style>

</head>
<body class="l-bg">
	<div class="login-top">
		<div class="wrapper">
			<div class="fl font30">一家小店</div>
			<div class="fr">您好，欢迎注册一家小店账号！<a href="${path}/index.jsp"><font color="green"><strong>首页</strong></font></a></div>
		</div>
	</div>
	<div class="l_main2">
		<div class="l_bttitle">
			<h2>注册情况</h2>
		</div>
		<div class="loginbox">
			<div class="tab">
				<ul>
					<li class="on">注册状态</li>
					
				</ul>
			</div>
			<div class="conlist">
				<div class="conbox" style="display: block; text-align: left;">
					<c:if test="${msg1!=null}">
						<font color="green">${msg1}</font>
					</c:if>
					<c:if test="${msg2!=null}">
						<font color="red">${msg2}</font>&nbsp;&nbsp;&nbsp;<a  style="cursor:pointer;color: green;" href="${path}/registry.jsp"><button style="color: green;cursor:pointer;">注册</button></a>
					</c:if>
				</div>

			</div>
		</div>
	</div>
</body>
</html>
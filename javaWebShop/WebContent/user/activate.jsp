<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp"%>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>激活</title>
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
			<div class="fr">
				<a href="${path}/index.jsp"><font color="green"><strong>首页</strong></font></a>&nbsp;
				<a href="${path}/login.jsp"><font color="green"><strong>请登录</strong></font></a>&nbsp;
				<a href="${path}/registry.jsp"><font color="green"><strong>欢迎注册</strong></font></a>&nbsp;
			</div>
		</div>
	</div>
	<div class="l_main2">
		<div class="l_bttitle">
			<h2>激活</h2>
		</div>
		<div class="loginbox">
			<div class="tab">
				<ul>
					<li class="on">激活状态</li>
					
				</ul>
			</div>
			<div class="conlist">
				<div class="conbox" style="display: block; text-align: left;">
					<c:if test="${msg1!=null}">
						<font color="green">${msg1}</font>
					</c:if>
					<c:if test="${msg2!=null}">
						<font color="red">${msg2}</font>
					</c:if>
				</div>

			</div>
		</div>
	</div>
</body>
</html>
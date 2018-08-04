<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp"%>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>卖家找回密码</title>
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
	width: 300px;
}

.conbox {
	display: none;
}
</style>

<script>
	$(function() {
		$(".tab li").each(function(i) {
			$(this).click(function() {
				$(this).addClass("on").siblings().removeClass("on");
				$(".conlist .conbox").eq(i).show().siblings().hide();
			})
		})
	})
</script>
</head>

<body>
${emailMsg}
<script type="text/javascript">
		function sub() {
			var email = document.getElementById("email");
			if (email.value == "" || email == null) {
				alert("输入注册邮箱,否则无法找回密码！！！");
				return false;
			}
			return true;
		}
		
		
	</script>
	<div class="login-top">
		<div class="wrapper">
			<div class="fl font30">卖家找回密码</div>
			<div class="fr"></div>
		</div>
	</div>
	<div class="l_main">
		<div class="l_bttitle2">

			<h2>
				<a href="${path_}/admin/adminInUserLogin.jsp">< 返回登录</a>
			</h2>
		</div>
		<div class="loginbox fl">
			<div class="tab" style="text-align: center;">
				<ul>
					<li class="on" style="color: white;font-size: 20px;">找回密码</li>
				</ul>
			</div>
			<div class="conlist">
				<div class="conbox" style="display: block;">
					
					<form action="${path_}/findPasswordSubmitInAdmin.action" onsubmit="return sub();">
						<p>
							<input type="email" name="email" id="email" class="loginusername" placeholder=" 输入注册邮箱" value="${email }">
						</p>
						
						<p>
							<input type="submit" class="loginbtn" value="找回密码">
						</p>
					</form>

				</div>
				
			</div>
		</div>

		<div class="fr margin-r100 margin-t45">
			<img src="${path}/images/login-pic.jpg" width="507" height="325">
		</div>
	</div>
</body>
</html>

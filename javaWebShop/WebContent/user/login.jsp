<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp"%>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>买家登录</title>
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
${notLogigMsg}
${LoginOutMsg}
<script type="text/javascript">
		function sub() {

			var password = document.getElementById("password");
			var email = document.getElementById("email");
			var verf=document.getElementById("verf");
			if (email.value == "" || email == null) {
				alert("邮箱不可以为空");
				return false;
			}else if (password.value == "" || password == null) {
				alert("密码不可以为空");
				return false;
			}
			else if (verf.value == "" || verf== null) {
				alert("请填写验证码");
				return false;
			}
			return true;
		}
		
		
	</script>
	<div class="login-top">
		<div class="wrapper">
			<div class="fl font30">买家登录</div>
			<div class="fr">您好，赶紧登录吧！</div>
		</div>
	</div>
	<div class="l_main">
		<div class="l_bttitle2">

			<h2>
				<a href="${path_}/jumpToIndex.action">< 返回首页</a>
			</h2>
		</div>
		<div class="loginbox fl">
			<div class="tab" style="text-align: center;">
				<ul>
					<a href="${path_}/user/login.jsp"><li class="on" style="color: red;">买家登录</li></a>
					<a href="${path_}/admin/adminInUserLogin.jsp"><li class="on">卖家登录</li></a>
				</ul>
			</div>
			<div class="conlist">
				<div class="conbox" style="display: block;">
					<font color="red">${ErrorMsg}</font>
					<form action="${path_}/loginSubmit.action" onsubmit="return sub();">
						<p>
							<input type="text" name="email" id="email" class="loginusername" placeholder=" 输入注册邮箱" value="${email }">
						</p>
						<p>
							<input type="password" name="password" id="password" class="loginuserpassword" placeholder=" 密码" value="${password }" >
						</p>
						<p>
							
							    <input type="text" name="verf" class="verf" id="verf" placeholder="输入验证码"/>
								<img alt="验证码"  src="${path_}/common/verificationCode.jsp">
							
						</p>
						<p>
							<span class="fl fntz14 margin-t10"><a href="${path_}/register.action"
								style="color: #ff6000">立即注册</a></span><span
								class="fr fntz12 margin-t10"><a href="${path_}/jumpToFindPassword.action">忘记密码？</a></span>
						</p>
						<p>
							<input type="submit" class="loginbtn" value="登  录">
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

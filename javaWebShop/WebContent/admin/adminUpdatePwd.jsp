<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp"%>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="path" value="${pageContext.request.contextPath}/user"
	scope="application"></c:set>
<c:set var="path_" value="${pageContext.request.contextPath}"
	scope="application"></c:set>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${path}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${path}/css/style.css" rel="stylesheet" type="text/css" />
<link href="${path}/css/user_style.css" rel="stylesheet" type="text/css" />
<link href="${path}/skins/all.css" rel="stylesheet" type="text/css" />
<script src="${path}/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${path}/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
<script src="${path}/js/common_js.js" type="text/javascript"></script>
<script src="${path}/js/footer.js" type="text/javascript"></script>
<script src="${path}/layer/layer.js" type="text/javascript"></script>
<script src="${path}/js/iCheck.js" type="text/javascript"></script>
<script src="${path}/js/custom.js" type="text/javascript"></script>
<title>修改密码</title>

</head>

<body>
	${updateAdminPwd}
	<script type="text/javascript">
		function checkPassword() {
			var password = document.getElementById("password");
			if (password == null || password.value == "") {
				alert("原密码不可以为空");
				
			}
		}
		function checkPassword1() {
			var password = document.getElementById("newPassword");
			var password_ = /^[0-9a-zA-Z_]{3,10}$/;
			if (password == null || password.value == "") {
				alert("新密码不可以为空");
			} else {
				if (password.value.match(password_) == null) {
					password.value = "";
					alert("密码格式不对，重新输入");
				} 
			}
		}
		function checkPassword2() {
			var password = document.getElementById("newPassword1");
			if (password == null || password.value == "") {
				alert("核对密码框不可以为空");
			} 
		}
		function sub() {
			var truePwd= document.getElementById("truePwd");
			var password = document.getElementById("password");
			var newPassword = document.getElementById("newPassword");
			var newPassword1 = document.getElementById("newPassword1");
			if (password.value == "" || password == null) {
				alert("原密码不可以为空");
				password.focus();
				return false;
			} else if (newPassword.value == "" || newPassword == null) {
				alert("新密码不可以为空");
				newPassword.focus();
				return false;
			} else if (newPassword1.value == "" || newPassword1 == null) {
				alert("核对密码框不可以为空");
				newPassword1.focus();
				return false;
			} else if(truePwd.value!=password.value){
				alert("原密码不正确");
				password.value="";
				password.focus();
				return false;
			}else if(newPassword1.value!=newPassword.value){
				alert("两次输入密码不一致");
				newPassword1.value="";
				newPassword1.focus();
				return false;
			}
			return true;
		}
	</script>
	<!--用户中心样式-->
	<div class="user_style clearfix">
		<div class="user_center clearfix">
			<!--右侧样式-->
			<div class="right_style" style="float:left;">
				<!--消费记录样式-->
				<div class="user_address_style">
					<div class="title_style">
		   			 <em></em>修改密码
					</div>
					<!--用户信息样式-->
					<!--个人信息-->
					<div class="Personal_info" id="Personal">
						<form action="${path_}/updateAdminPassword.action" method="get" onsubmit="return sub();">
								
								<ul class="xinxi">
									
								   <li >
								   		<label>原密码：</label> 
								   		<span>
								   			<input style="width: 200px;" name="password" id="password" type="password" placeholder="输入原密码" class="text" disabled="disabled" onblur="checkPassword()"  />
									    </span>
								   </li>
									<li>
									 	<label>新密码：</label> 
									 	<span>
								   			<input style="width: 200px;" name="newPassword" id="newPassword" type="password" placeholder=" 3-10位 数字/字母/下划线" class="text" disabled="disabled" onblur="checkPassword1()"/>
									    </span>	
									</li>
									<li>
									 	<label>再次输入：</label> 
									 	<span>
								   			<input style="width: 200px;" name="newPassword1" id="newPassword1" type="password" class="text" placeholder="再次输入新密码" disabled="disabled" onblur="checkPassword2()"/>
									    </span>	
									</li>
									
									<div class="bottom">
										<input name="" type="button" value="修改密码" class="modify" /><input
											name="" type="submit" value="确认密码" class="confirm" />
									</div>
									<li>
										<input type="hidden" id="truePwd" name="truePwd" value="${admin.admin_passwd}" /> 
										<input type="hidden" name="username" value="${admin.admin_username}" /> 
									</li>
								</ul>
							</form>
						
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>

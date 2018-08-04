<%@page import="com.sky.Bean.Admin"%>
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
<title>管理员中心</title>

</head>

<body>
${updateAdminMsg}
<script type="text/javascript">
function checkTelephone() {
	var telephone = document.getElementById("telephone");
	var telephone_ = /^\d{11}$/;
	if (telephone != null && telephone.value != "") {
		if (telephone.value.match(telephone_) == null) {
			telephone.value = "";
			alert("手机号码格式不对，重新输入");
			telephone.focus();
		} 
	} 
}
function sub() {
	
	var upimg=document.getElementById("phone").value;
	if (upimg.length==0){
		alert("请选择一个头像");
		
		return false;
	}
	return true;
}
</script>
	
	<!--用户中心样式-->
	<div class="user_style clearfix">
		<div class="user_center clearfix">
			<!--左侧样式-->
			
			<!--右侧样式-->
			<div class="right_style" style="float:left;">
				<!--消费记录样式-->
				<div class="user_address_style">
					<div class="title_style">
						<em></em>管理员信息
					</div>
					<!--用户信息样式-->
					<!--个人信息-->
					<div class="Personal_info" id="Personal">
					<form action="${path_}/updateAdmin.action" method="get">
							
							<ul class="xinxi">
								
								
								<li>
									<label>用户名：</label> 
										<span>
											<strong style="color: green;">${admin.admin_username}</strong>
										</span>
								</li>
								<li>
									<label>真实姓名：</label> 
										<span>
											<strong style="color: green;">
												<c:if test="${admin!=null}">
													<%=((Admin)session.getAttribute("admin")).getPerson().getRealName() %>
												</c:if>
											</strong>
										</span>
								</li>
								<li>
									<label>身份证号：</label> 
										<span>
											<strong style="color: green;">
												<c:if test="${admin!=null}">
													<%=((Admin)session.getAttribute("admin")).getPerson().getIdNumber() %>
												</c:if>
											</strong>
										</span>
								</li>
							    <li>
									<label>邮箱：</label> 
										<span>
											<strong style="color: green;">${admin.admin_email}</strong>
											
										</span>
							   </li>
								
								<li>
							   		<label>手机号码：</label> 
							   		<span>
							   			<input name="telephone" id="telephone"
										type="text" value="${admin.telephone}" class="text" disabled="disabled" onchange="checkTelephone()"  />
								    </span>
							   </li>
								<li>
								 	<label>家庭住址：</label> 
								 	<span>
							   			<input name="address" type="text" value="${admin.address}" class="text" disabled="disabled" />
								    </span>	
								</li>
								
								
								<div class="bottom">
									<input name="" type="button" value="修改信息" class="modify" /><input
										name="" type="submit" value="确认修改" class="modify" class="confirm" />
								</div>
							</ul>
							<input type="hidden" name="AdminUsername" value="${admin.admin_username}" /> 
						</form>
						<form action="${path_}/updateAdminPhone.action" method="post" enctype="multipart/form-data" onsubmit="return sub();">
							<ul class="Head_portrait">
								<li class="User_avatar"><img width="200px;" height="200px;" alt="" src="${pageContext.request.contextPath}/upload/admin/${admin.admin_username}/${admin.admin_image}"></li>
								<li><input type="file" name="phone" id="phone"/></li>
								<li><input name="name" type="submit" value="上传头像" class="submit" /></li>
								<li><input type="hidden" name="AdminUsername" value="${admin.admin_username}" /> </li>
							</ul>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	

</body>
</html>

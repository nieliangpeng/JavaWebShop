<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="../common/taglib.jsp"%>
<%@page errorPage="../common/UserError.jsp"%>
<html>
<head>
<c:set var="path" value="${pageContext.request.contextPath}/admin"
	scope="application"></c:set>
<c:set var="path_" value="${pageContext.request.contextPath}"
	scope="application"></c:set>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看用户</title>
</head>
<body>
	${removeMsg}
	
	<script type="text/javascript">
		
	</script>
		
		
		<center>
		<font color="green" style="font-size: 34px;font-weight:bolder;">用户信息</font><br/><br/>
		<table border="1" width="90%" cellpadding="0" cellspacing="0" >
			<tr style="text-align: center;font-weight: bolder;">
				<td height="27px" style="border-color: #F6F6F6;width: 70px;">用户ID</td>
				<td style="border-color: #F6F6F6;">头像</td>
				<td style="border-color: #F6F6F6;">用户名</td>
				<td style="border-color: #F6F6F6;">密码</td>
				<td style="border-color: #F6F6F6;">用户邮箱</td>
				<td style="border-color: #F6F6F6;">手机号码</td>
				<td style="border-color: #F6F6F6;width: 80px;">家庭地址</td>
				<td style="border-color: #F6F6F6;width: 100px;">用户状态</td>
				<td style="border-color: #F6F6F6;width: 200px;">注册时间</td>
				<td style="border-color: #F6F6F6; width: 50px;">操作</td>
			</tr>
			<c:forEach items="${UserList}" var="user">
				<tr style="text-align: center;">
					<td height="27px" style="border-color: #F6F6F6;"><font color="green" style="font-weight: bold;">${user.id}</font>&nbsp;</td>
					<td  style="border-color: #F6F6F6;">
						<!-- 上传图片显示 -->
						<%pageContext.setAttribute("date", new Date()) ;%>
						<img height="50px" width="40px" 
						src="${pageContext.request.contextPath}/upload/user/${user.user_username}/${user.user_image}?date= ${date}" />
							
					</td>
					<td height="27px" style="border-color: #F6F6F6; ">${user.user_username}&nbsp;</td>
					<td height="27px" style="border-color: #F6F6F6;">*..**&nbsp;</td>
					<td height="27px" style="border-color: #F6F6F6;">${user.user_email}&nbsp;</td>
					<td height="27px" style="border-color: #F6F6F6;">${user.user_telephone}&nbsp;</td>
					<td height="27px" style="border-color: #F6F6F6;">${user.user_address}&nbsp;</td>
					<td height="27px" style="border-color: #F6F6F6;text-align: center;">
						<c:if test="${user.status==1}">
							<font color="green">账号已激活&nbsp;</font>
						</c:if>
						<c:if test="${user.status!=1}">
							<font color="red">账号未激活&nbsp;</font>
						</c:if>
					</td>
					
					<td height="27px" style="border-color: #F6F6F6;">${user.registerTime}&nbsp;</td>
					<td height="27px" style="border-color: #F6F6F6;">
						<a href="${path_}/removeUser.action?id=${user.id}"><button style="border-radius: 6px;color: red;">删除</button></a>
					</td>
				</tr>
			</c:forEach>

		</table>
		<br />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

		<div id="lqy_product_showpage">
			共<font color="green" style="font-weight: bold;">${pageCount.recordCount}</font>条记录&nbsp;&nbsp;共 <font color="green" style="font-weight: bold;">${pageCount.count}</font>页
			<c:if test="${pageCount.isFirst}">
  				&nbsp;<font color="green">首页</font>&nbsp;&nbsp;
			</c:if>
			<c:if test="${!(pageCount.isFirst)}">
  				&nbsp;<a href='${path_}/showUserList.action?pageNum=1'><button style="border-radius: 6px;color: green;">首页</button></a>&nbsp;
  				&nbsp;<a href='${path_}/showUserList.action?pageNum=${pageCount.showPage-1}'><button style="border-radius: 6px;color: green;">上一页</button></a>&nbsp;
			</c:if>
			<c:if test="${pageCount.isLast}">
  				&nbsp;<font color="green">尾页</font>&nbsp;&nbsp;
			</c:if>
			<c:if test="${!(pageCount.isLast)}">
	  			&nbsp;<a href='${path_}/showUserList.action?&pageNum=${pageCount.showPage+1}'><button style="border-radius: 6px;color: green;">下一页</button></a>&nbsp;
	  			&nbsp;<a href='${path_}/showUserList.action?&pageNum=${pageCount.count}'><button style="border-radius: 6px;color: green;">尾页</button></a>&nbsp;
			</c:if>
			&nbsp;当前页为第 <font color="green" style="font-weight: bold;">${pageCount.showPage}</font> 页
		</div>

</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="../common/taglib.jsp" %> 
<%@page errorPage="../common/UserError.jsp"%>
<c:set var="path_" value="${pageContext.request.contextPath}" scope="application"></c:set>
<c:set var="path" value="${pageContext.request.contextPath}/admin" scope="application"></c:set>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>查看所有订单</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<br>
<center>
<table align="center" border="1" width="80%" cellpadding="0"  cellspacing="0" style="text-align: center;">
	<tr>
		<th colspan="6" height="60px" style="border-color: #88F6F3;color:green;font-size: 35px;">订单列表</th>
	</tr>
	<tr style="font-weight: bold;">
		<td height="40px" style="border-color: #F6F6F6;">订单ID</td>
		<td style="border-color: #F6F6F6;">买家</td>
		<td style="border-color: #F6F6F6;">下单时间</td>
		<td style="border-color: #F6F6F6;">订单状态</td>
		<td style="border-color: #F6F6F6;">操作&nbsp;</td>
	</tr>
	<c:forEach items="${orderList}" var="order">
		<tr>
			<td height="40px" style="border-color: #F6F6F6;color: green;font-weight: bold;">${order.id}</td>
			<td style="border-color: #F6F6F6;">${order.user.user_username}</td>
			<td style="border-color: #F6F6F6;">${order.order_time}</td>
			<c:if test="${order.order_state=='已支付'}"><td style="background-color: #dbfebc;">${order.order_state}</td></c:if>
			<c:if test="${order.order_state!='已支付'&&order.order_state!='前台已删除'}"><td style="border-color: #F6F6F6;">${order.order_state}</td></c:if>
			<c:if test="${order.order_state=='前台已删除'}"><td style="border-color: #F6F6F6;">已完成</td></c:if>
			<td style="border-color: #F6F6F6;">
				<a href="${path_}/orderDetailInAdmin.action?orderId=${order.id}"><button style="border-radius: 6px;color: green;">进入订单</button></a>
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
  				&nbsp;<a href='${path_}/showAllOrdersInAdmin.action?pageNum=1'><button style="border-radius: 6px;color: green;">首页</button></a>&nbsp;
  				&nbsp;<a href='${path_}/showAllOrdersInAdmin.action?pageNum=${pageCount.showPage-1}'><button style="border-radius: 6px;color: green;">上一页</button></a>&nbsp;
			</c:if>
			<c:if test="${pageCount.isLast}">
  				&nbsp;<font color="green">尾页</font>&nbsp;&nbsp;
			</c:if>
			<c:if test="${!(pageCount.isLast)}">
	  			&nbsp;<a href='${path_}/showAllOrdersInAdmin.action?&pageNum=${pageCount.showPage+1}'><button style="border-radius: 6px;color: green;">下一页</button></a>&nbsp;
	  			&nbsp;<a href='${path_}/showAllOrdersInAdmin.action?&pageNum=${pageCount.count}'><button style="border-radius: 6px;color: green;">尾页</button></a>&nbsp;
			</c:if>
			&nbsp;当前页为第 <font color="green" style="font-weight: bold;">${pageCount.showPage}</font> 页
		</div>	
		</center>
</body>
</html>

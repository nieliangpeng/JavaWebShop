<%@page import="com.sky.Bean.Food"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="../common/taglib.jsp"%>
<html>
<head>
<c:set var="path" value="${pageContext.request.contextPath}/admin"
	scope="application"></c:set>
<c:set var="path_" value="${pageContext.request.contextPath}"
	scope="application"></c:set>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看商品</title>
</head>
<body>
	${foodDetailMsg}
	${deleteFoodMsg}
	<script type="text/javascript">
	</script>
	<center>
		<font color="green" style="font-size: 34px;font-weight:bolder;">商品信息</font><br/><br/>
		<table border="1" width="100%" cellpadding="0" cellspacing="0" >
			<tr style="text-align: center;font-weight: bolder;">
				<td height="27px" style="border-color: #F6F6F6;width: 70px;">商品ID</td>
				<td style="border-color: #F6F6F6;width: 70px;">商品图片</td>
				<td style="border-color: #F6F6F6;width: 100px;">商品名</td>
				<td style="border-color: #F6F6F6;width: 200px;">商品描述</td>
				<td style="border-color: #F6F6F6;width: 70px;">单价</td>
				<td style="border-color: #F6F6F6;width: 70px;"">所属类别</td>
				<td style="border-color: #F6F6F6;width: 150px;">添加商品时间</td>
				<td style="border-color: #F6F6F6; width: 150px;">操作</td>
			</tr>
			<c:forEach items="${foodList}" var="food" >
				<tr style="text-align: center;">
					<td height="60px" style="border-color: #F6F6F6;"><font color="green" style="font-weight: bold;">${food.id}</font>&nbsp;</td>
					<td  style="border-color: #F6F6F6;">
						<!-- 上传图片显示 -->
						<%pageContext.setAttribute("date", new Date()) ;%>
						<img height="50px" width="40px" 
						src="${pageContext.request.contextPath}/upload/food/${food.foodName}/${food.foodImgurl}?date= ${date}" />
							
					</td>
					<td height="27px" style="border-color: #F6F6F6;font-weight: bold;color: green; ">${food.foodName}&nbsp;</td>
					<td height="27px" style="border-color: #F6F6F6;">${food.description}&nbsp;</td>
					<td height="27px" style="border-color: #F6F6F6;color: red;font-weight: bold;">${food.price}元&nbsp;</td>
					<td height="27px" style="border-color: #F6F6F6;font-weight: bold;color: green;">
						${food.type.typeName}
					&nbsp;</td>
					<td height="27px" style="border-color: #F6F6F6;text-align: center;">
						${food.addFoodTime}&nbsp;
					</td>
					<td height="27px" style="border-color: #F6F6F6;">
						<a href="${path_}/foodDetailByType.action?id=${food.id}&foodTypeId=${foodTypeId}"><button style="border-radius: 6px;color: green;">详细</button></a>
						<a href="${path_}/removeFoodByType.action?id=${food.id}&foodName=${food.foodName}&foodTypeId=${foodTypeId}"><button style="border-radius: 6px;color: red;">删除</button></a>
						<a href="${path_}/updateFood.action?id=${food.id}"><button style="border-radius: 6px;color: red;">修改</button></a>
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
  				&nbsp;<a href='${path_}/selectFoodByTypeInAdmin.action?pageNum=1&foodTypeId=${foodTypeId}'><button style="border-radius: 6px;color: green;">首页</button></a>&nbsp;
  				&nbsp;<a href='${path_}/selectFoodByTypeInAdmin.action?pageNum=${pageCount.showPage-1}&foodTypeId=${foodTypeId}'><button style="border-radius: 6px;color: green;">上一页</button></a>&nbsp;
			</c:if>
			<c:if test="${pageCount.isLast}">
  				&nbsp;<font color="green">尾页</font>&nbsp;&nbsp;
			</c:if>
			<c:if test="${!(pageCount.isLast)}">
	  			&nbsp;<a href='${path_}/selectFoodByTypeInAdmin.action?pageNum=${pageCount.showPage+1}&foodTypeId=${foodTypeId}'><button style="border-radius: 6px;color: green;">下一页</button></a>&nbsp;
	  			&nbsp;<a href='${path_}/selectFoodByTypeInAdmin.action?pageNum=${pageCount.count}&foodTypeId=${foodTypeId}'><button style="border-radius: 6px;color: green;">尾页</button></a>&nbsp;
			</c:if>
			&nbsp;当前页为第 <font color="green" style="font-weight: bold;">${pageCount.showPage}</font> 页
		</div>	
		
		

</body>
</html>
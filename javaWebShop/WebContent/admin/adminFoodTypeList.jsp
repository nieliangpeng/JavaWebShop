<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp"%>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品类别</title>

</head>
<body>
${AddTypeMsg}
${deleteTypeMsg}
${updateFoodTypeMsg}
<script type="text/javascript"></script>
	<center>
	<font color="green" style="font-size: 34px;font-weight:bolder;">商品类别</font><br/><br/>
		<table border="1" width="80%" cellpadding="0" cellspacing="0">

			<tr style="font-weight: bold;text-align: center;">
				<td height="27px" style="border-color: #F6F6F6;">类别编号</td>
				<td style="border-color: #F6F6F6;">类别名称</td>
				<td style="border-color: #F6F6F6;">操作</td>
			</tr>

			<c:forEach items="${foodTypeList}" var="foodtype">
				<tr style="text-align: center;">
					<td height="27px" style="border-color: #F6F6F6;color: red;font-weight: bold;">
						${foodtype.id}</td>
					
					<td height="27px" style="border-color: #F6F6F6; color: green;font-weight: bold;">
						${foodtype.typeName}</td>

					<td style="border-color: #F6F6F6;">
						<a href="${path_}/deleteFoodType.action?foodTypeId=${foodtype.id}&foodTypeName=${foodtype.typeName}" style="text-decoration: none;"><button style="border-radius: 6px;color: red;">删除</button></a>
						<font color="green" style="font-weight: bold;"> | </font>
						<a href="${path_}/updateFoodType.action?foodTypeId=${foodtype.id}&foodTypeName=${foodtype.typeName}" style="text-decoration: none;"><button style="border-radius: 6px;color: green;">修改</button></a>
					    <font color="green" style="font-weight: bold;"> | </font>
						<a href="${path_}/selectFoodByTypeInAdmin.action?foodTypeId=${foodtype.id}" style="text-decoration: none;"><button style="border-radius: 6px;color: white;background-color: #034556;">商品</button></a>
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


		<a href="${path_}/addFoodType.action"><button style="border-radius: 6px;color: green;">增加类别</button></a>

	</center>
</body>
</html>
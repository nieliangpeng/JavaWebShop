<%@page import="com.sky.Bean.Orders"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp"%>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
<title>搜索订单</title>
</head>

<body>
${searchOrderMsg}
<script type="text/javascript">
function sub() {

	
	var orderId=document.getElementById("orderId");
	if (orderId.value == "" || orderId == null) {
		alert("输入订单号");
		return false;
	}
	return true;
}
				
</script>

<div class="user_style clearfix" >
 <div class="user_center clearfix">
 <!--右侧样式-->
  <div class="right_style" style="float: left;">
  <div class="title_style"><em></em>订单搜索</div> 
   <div class="Order_form_style">
      
      <div class="Order_Operation">
	     <div class="right_search" style="float:left; ">
		     <form action="${path_}/searchOrderByIdInAdmin.action" method="get" onsubmit="return sub();">
		     	<input name="orderId" id="orderId" type="text"  class="add_Ordertext" placeholder="请输入订单号进行搜索"/>
		     	<input  type="submit" value="搜索订单"  class="search_order"/>
		     </form>	
	     </div>
      </div>
  
     </div>
   </div>
   
  </div>
 </div>
</div>

</body>
</html>

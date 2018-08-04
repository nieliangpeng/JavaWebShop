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
<title>订单管理</title>
</head>

<body>
${cancelOrderMsg}
${getMoneyMsg}
${deleteOrderMsg}
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

<%@include file="header.jsp"%>
<div class="user_style clearfix">
 <div class="user_center clearfix">
   <%@include file="left.jsp"%>
 <!--右侧样式-->
  <div class="right_style">
  <div class="title_style"><em></em>订单管理</div> 
   <div class="Order_form_style">
      <div class="Order_form_filter">
       <a href="${path_}/myAllOrders.action" class="on">全部订单（${allOrdersCount}）</a>
       <a href="${path_}/varietyOrders.action?variety=未支付" class="">待付款（${count1}）</a>
       <a href="${path_}/varietyOrders.action?variety=已支付" class="">待发货（${count2}）</a>
       <a href="${path_}/varietyOrders.action?variety=已发货" class="">待收货（${count3}）</a>
       <a href="${path_}/varietyOrders.action?variety=已完成" class="">已完成（${count4}）</a>
       
      </div>
      <div class="Order_Operation">
     <div class="right_search">
	     <form action="${path_}/searchOrderById.action" method="get" onsubmit="return sub();">
	     	<input name="orderId" id="orderId" type="text" value="${search}" class="add_Ordertext" placeholder="请输入订单号进行搜索"/>
	     	<input  type="submit" value="搜索订单"  class="search_order"/>
	     </form>	
     </div>
      </div>
      <div class="Order_form_list">
         <table>
         <thead>
          <tr>
	          <td class="list_name_title0">商品</td>
	          <td class="list_name_title1">单价(元)</td>
	          <td class="list_name_title2">数量</td>
	          <td class="list_name_title4">实付款(元)</td>
	          <td class="list_name_title5">订单状态</td>
	          <td class="list_name_title6">操作</td>
         </tr>
         </thead> 
         <!-- 订单 -->
         <c:if test="${count5==0&&search==null}">
          <tbody>  
           <tr class="Order_info"><td colspan="6" class="Order_form_time" style="font-weight: bold;text-align: center;color: green;">暂无订单,O(∩_∩)O~~<em></em></td></tr>
	            
         </tbody>
         </c:if>
          <c:if test="${count5==0&&search!=null}">
          <tbody>  
           <tr class="Order_info"><td colspan="6" class="Order_form_time" style="font-weight: bold;text-align: center;color: green;">查询不到订单号为&nbsp;${search}&nbsp;的订单,(｡•ˇ‸ˇ•｡)<em></em></td></tr>
	            
         </tbody>
         </c:if>
         <c:forEach items="${orderSet}" var="order">
	         <tbody>       
	           <tr class="Order_info"><td colspan="6" class="Order_form_time">下单时间： ${order.order_time}| 订单号：${order.id} <em></em></td></tr>
	            <tr class="Order_info"><td colspan="6" class="Order_form_time">收货信息：${order.address}<em></em></td></tr>
	           
	           <tr class="Order_Details">
	           <td colspan="3">
	           <table class="Order_product_style">
	           <tbody>
	           <!-- 商品 -->
	           <c:forEach items="${order.detailSet}" var="detail">
		           <tr>
		           <td style="width: 240px;">
		            <div class="product_name clearfix">
		            <a href="${path_}/foodDetailInUser.action?foodId=${detail.food.id}" class="product_img"><img src="${pageContext.request.contextPath}/upload/food/${detail.food.foodName}/${detail.food.foodImgurl}" width="80px" height="80px"></a>
		            <a href="${path_}/foodDetailInUser.action?foodId=${detail.food.id}" class="p_name">${detail.food.foodName}</a>
		           
		            </div>
		            </td>
		            <td>￥${detail.food.price}</td>
		           <td style="padding-left: 0;text-align: center; font-weight: bold;color: red;">${detail.count}</td>
		            </tr>
		            
	            </c:forEach>
	            </tbody>
	            </table>
	           </td>   
	           <td class="split_line">￥<%=((Orders)pageContext.getAttribute("order")).allPrice() %></td>
	           <td class="split_line">
	           <p style="color:green">
	           <c:if test="${order.order_state=='未支付'}"><font color="red">等待买家付款</font></c:if>
	           <c:if test="${order.order_state=='已支付'}">买家已付款，待发货</c:if>
	           <c:if test="${order.order_state=='已发货'}">已发货，待收货</c:if>
	           <c:if test="${order.order_state=='已完成'}">已收货</c:if>
	           <c:if test="${order.order_state=='后台已删除'}">已收货</c:if>
	           	</p>
	           	</td>
	           <td class="operating">
	             <a href="${path_}/showThisOrderDetail.action?orderId=${order.id}">查看订单</a>
	           </td>
	           </tr>
	           </tbody>
          </c:forEach>
       
           
         </table>
    </div>
     </div>
   </div>
   <script>
            $(document).ready(function(){
              $('.Order_form_style input').iCheck({
                checkboxClass: 'icheckbox_flat-green',
                radioClass: 'iradio_flat-green'
              });
            });
            </script>
  </div>
 </div>
</div>
<!--网站地图-->

<%@include file="footer.jsp"%>
</body>
</html>

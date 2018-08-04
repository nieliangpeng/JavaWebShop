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
<title>订单详情</title>
</head>

<body>
${deliverGoodsMsg}
<script type="text/javascript"></script>

<div class="user_style clearfix">
 <div class="user_center clearfix">
 <!--右侧样式-->
  <div class="right_style" style="float: left;width: 100%;">
  <div class="title_style"><em></em>订单详情</div> 
   <div class="Order_form_style">
      
    
      <div class="Order_form_list">
         <table>
         <thead>
          <tr><td class="list_name_title0">商品</td>
          <td class="list_name_title1">单价(元)</td>
          <td class="list_name_title2">数量</td>
          <td class="list_name_title4">实付款(元)</td>
          <td class="list_name_title5">订单状态</td>
          <td class="list_name_title6">操作</td>
         </tr>
         </thead> 
     
            <tbody>       
	       
           <tr class="Order_info on"><td colspan="6" class="Order_form_time">下单时间：${order.order_time} | 订单号：${order.id} | 购买用户：${order.user.user_username}</td></tr>
	       <!-- 收货地址 -->
	       <tr class="Order_info on">
	           <td colspan="6" class="Order_form_time">
		            <c:if test="${order.order_state!='未支付'}">
		           		${order.address}
		            </c:if> 
		             <c:if test="${order.order_state=='未支付'}">
		           		<font color="red" style="font-weight: bold;">用户还未填写收货信息</font>
		            </c:if> 
	           </td>
	      </tr>
	           
	        
           <tr class="Order_Details" >
           <td colspan="3">
             <table class="Order_product_style">
           <tbody>
           <!-- 循环 -->
           <c:forEach items="${order.detailSet}" var="detail" >
	           <tr>
	           <td style="width: 240px;">
	            <div class="product_name clearfix"  >
	            <a href="${path_}/foodDetail.action?id=${detail.food.id}" class="product_img"><img src="${pageContext.request.contextPath}/upload/food/${detail.food.foodName}/${detail.food.foodImgurl}" width="80px" height="80px"></a>
	            <a href="${path_}/foodDetail.action?id=${detail.food.id}" class="p_name" style="padding-right: 0;">${detail.food.foodName}</a>
	            
	            </div>
	            </td>
	             <td>￥${detail.food.price}</td>
	           <td style="padding-left: 0;text-align: left; font-weight: bold;color: red;">${detail.count}</td>
	           </tr>
           </c:forEach>
           
            
            </tbody></table>          
           </td>         
           <td class="split_line">￥<%=((Orders)session.getAttribute("order")).allPrice() %></td>
           <td class="split_line"><p style="color:green;">
           	   <c:if test="${order.order_state=='未支付'}"><font color="red">等待买家付款</font></c:if>
	           <c:if test="${order.order_state=='已支付'}">买家已付款，待商家发货</c:if>
	           <c:if test="${order.order_state=='已发货'}">已发货，待买家收货</c:if>
	           <c:if test="${order.order_state=='已完成'}">买家已收货，订单完成</c:if>
	           <c:if test="${order.order_state=='前台已删除'}">买家已收货，订单完成</c:if>
           </p></td>
           <td class="operating">
           
	           <c:if test="${order.order_state=='已支付'}">
	             <a href="${path_}/deliverGoods.action?orderId=${order.id}" style="border:1px #ccc solid;padding:5px 5px;background:#80ff80;border-radius: 6px;"><font color="white">商品发货</font></a>      
	           </c:if>
	            <c:if test="${order.order_state=='已完成'}">
	             <a href="${path_}/deleteOrder.action?orderId=${order.id}" style="border:1px #ccc solid;padding:5px 5px;background:#80ff80;border-radius: 6px;"><font color="red">删除订单</font></a>      
	           </c:if>
	            <c:if test="${order.order_state=='前台已删除'}">
	             <a href="${path_}/removeOrder.action?orderId=${order.id}" style="border:1px #ccc solid;padding:5px 5px;background:#80ff80;border-radius: 6px;"><font color="red">删除订单</font></a>      
	           </c:if>
           </td>
           </tr>
          
            	
            </tbody>
           
         </table>
         
    </div>
    <br/>
	    <button style="border-radius: 6px;color: red;">
		       	 <a href="#" onclick="javascript:history.go(-1);">返回</a>
		</button> 
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

</body>
</html>

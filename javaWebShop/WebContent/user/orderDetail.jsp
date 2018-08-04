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
${getGoodsMsg}

<script type="text/javascript">
function check() {
	var noAddress = document.getElementById("noAddress");
	var selectAddress= document.getElementsByName("selectAddressId");
	var selectAddressSubmit= document.getElementById("selectAddressSubmit");
	if(noAddress!=null){
		alert("请去创建一个收货人信息");
	}else {
		var j=0;
		
		for(var i=0;i<selectAddress.length;i++)  
	    {   
	        //判断那个单选按钮为选中状态  
	        if(selectAddress[i].checked)  
	        { 
	        	
	        	j++;
	        	break;
	        }   
	    } 
		if(j==1){
			selectAddressSubmit.submit();
		}else{
			alert("请选择一个收货人信息");
		}
	}
}
</script>
<%@include file="header.jsp"%>
<div class="user_style clearfix">
 <div class="user_center clearfix">
   <%@include file="left.jsp"%>
 <!--右侧样式-->
  <div class="right_style">
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
	       
           <tr class="Order_info on"><td colspan="6" class="Order_form_time">下单时间：${order.order_time} | 订单号：${order.id}</td></tr>
	       <!-- 收货地址 -->
	       <c:if test="${order.order_state!='未支付'}">
	           <tr class="Order_info on"><td colspan="6" class="Order_form_time">${order.address}</td></tr>
	       </c:if>   
           <tr class="Order_Details" >
           <td colspan="3">
             <table class="Order_product_style">
           <tbody>
           <!-- 循环 -->
           <c:forEach items="${order.detailSet}" var="detail" >
	           <tr>
	           <td style="width: 240px;">
	            <div class="product_name clearfix"  >
	            <a href="${path_}/foodDetailInUser.action?foodId=${detail.food.id}" class="product_img"><img src="${pageContext.request.contextPath}/upload/food/${detail.food.foodName}/${detail.food.foodImgurl}" width="80px" height="80px"></a>
	            <a href="${path_}/foodDetailInUser.action?foodId=${detail.food.id}" class="p_name" style="padding-right: 0;">${detail.food.foodName}</a>
	            
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
	           <c:if test="${order.order_state=='已支付'}">买家已付款，待发货</c:if>
	           <c:if test="${order.order_state=='已发货'}">已发货，待收货</c:if>
	           <c:if test="${order.order_state=='已完成'}">已收货</c:if>
	           <c:if test="${order.order_state=='后台已删除'}">已收货</c:if>
           </p></td>
           <td class="operating">
           <c:if test="${order.order_state=='未支付'}">
             <input type="button" value="付款"  style="border-radius: 6px;color: green;padding:10px 60px;cursor:pointer;" onclick="check();"/><br/><br/>
             <a href="${path_}/cancelOrder.action?OrderId=${order.id}" style="border:1px #ccc solid;padding:5px 5px;background:#80ff80;border-radius: 6px;"><font color="red">取消订单</font></a>      
           </c:if>
           <c:if test="${order.order_state=='已发货'}">
             <a href="${path_}/getGoods.action?OrderId=${order.id}" style="border:1px #ccc solid;padding:5px 5px;background:#80ff80;border-radius: 6px;"><font color="white">确认收货</font></a>      
           </c:if>
            <c:if test="${order.order_state=='已完成'}">
             <a href="${path_}/deleteOrderInUser.action?OrderId=${order.id}" style="border:1px #ccc solid;padding:5px 5px;background:#80ff80;border-radius: 6px;"><font color="red">删除</font></a>      
           </c:if>
            <c:if test="${order.order_state=='后台已删除'}">
             <a href="${path_}/removeOrderInUser.action?OrderId=${order.id}" style="border:1px #ccc solid;padding:5px 5px;background:#80ff80;border-radius: 6px;"><font color="red">删除</font></a>      
           </c:if>
           </td>
           </tr>
           <c:if test="${order.order_state=='未支付'}">
	            <tr class="Order_info on">
	            
	            	<td colspan="6" class="Order_form_time" >
	            		<font color="blue">选择一个收货人信息</font>
	            	</td>
	            </tr>
           
             <tr class="Order_info on">
            
            	<td colspan="6" class="Order_form_time" >
             </c:if>	
            	<c:if test="${addressLength==0&&order.order_state=='未支付'}"><font color="red" style="font-weight: bold;">
            		请去创建一个收货信息
            		<form action="${path_}/getMoneyAndAddress.action" name="selectAddressSubmit" method="post">
            			<input type="hidden" id="noAddress" value="0" />
            		</form>
            		</font><br/><br/>
            	</c:if>
            	
            	<c:if test="${addressLength!=0&&order.order_state=='未支付'}">
            		<form action="${path_}/getMoneyAndAddress.action" name="selectAddressSubmit" id="selectAddressSubmit" method="post">
            			<c:forEach items="${AddressSet}" var="address"  >
	            			<input type="radio" name="selectAddressId"  value="${address.id}" >收货人【${address.username}】,收货地址【${address.provincial}${address.city}${address.counties}${address.street}】，邮编【${address.mailNum}】，手机号码【${address.phoneNum}】
            				<br/><br/>
            			</c:forEach>
            			<input type="hidden" name="orderId" value="${order.id}" />
            		</form>
            	</c:if>
            	<c:if test="${addressLength!=0&&order.order_state=='未支付'}">
            	<a href="${path_}/receiveAddress.action" style="display: inline;border:1px #ccc solid;padding:5px 5px;background:#80ff80;border-radius: 6px;">创建新的收货信息</a>
            	
            	</td>
            	</tr>
            	</c:if>
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
<!--网站地图-->
<%@include file="footer.jsp"%>

</body>
</html>

<%@page import="com.sky.Bean.Users"%>
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
<title>我的购物车</title>


</head>

<body>
${addOrderMsgErrors}
${removeProductCartMsg}
${deleteCartFoodMsg}
${deleteCartFoodBeanListMsg}
<script >

function sub(i){
	var foodBuyCount = document.getElementById("count"+i);
	var formSub=document.getElementById("formSub"+i);
	if(foodBuyCount!=null&&foodBuyCount.value>1){
		foodBuyCount.value-=1;
		formSub.submit();
	}
	
}
function add(i){
	var foodBuyCount = document.getElementById("count"+i);
	var formSub=document.getElementById("formSub"+i);
	if(foodBuyCount!=null){
		foodBuyCount.value =parseInt(foodBuyCount.value)+1;
		formSub.submit();
	}
	
}
function check(i){
	var foodBuyCount=document.getElementById("count"+i);
	var formSub=document.getElementById("formSub"+i);
	if(foodBuyCount!=null&&foodBuyCount.value==""){
		foodBuyCount.value=1;
	}
	if(foodBuyCount!=null&&foodBuyCount.value<=0){
		foodBuyCount.value=1;
	}
	formSub.submit();
}

</script>
<%@include file="header.jsp"%>
<div class="user_style clearfix">
 <div class="user_center clearfix">
  	<%@include file="left.jsp"%>
 <!--右侧样式-->
  <div class="right_style">
  <div class="title_style"><em></em>购物车</div> 
  <!-- 表单 -->
 <form action="${path_}/shopCartActive/deleteCartFoodBeanList.action" method="post" name="aaa">
	   <div class="Order_form_style">
	     
	      <form action=""></form>
	      <div class="Order_form_list">
	         <table>
		         <thead>
		          
			          <tr>
				          <td class="list_name_title0">商品</td>
				          <td class="list_name_title1">单价(元)</td>
				          <td class="list_name_title2">数量</td>
				          <td class="list_name_title4">总价(元)</td>
				          <td class="list_name_title5">描述</td>
				          <td class="list_name_title6">操作</td>
			          </tr>
		         </thead> 
		        <% 
		        	Users user=(Users)session.getAttribute("user");
		        	shoppingCartList productCart = (shoppingCartList) session.getAttribute("productCart"+user.getId());
		        	pageContext.setAttribute("productCart", productCart);
				%>
		          <c:forEach items="${productCart}" var="bean" >  
			         <tbody> 
			        
				          <tr class="Order_info"><td colspan="6" class="Order_form_time"><input name="deteleFoodList" type="checkbox" value="${bean.product.id}"  class="checkbox"/>选择删除<em></em></td></tr>
				   
				     
				           <tr class="Order_Details">
				          	  
					           <td colspan="3">
						           <table class="Order_product_style">
						           <tbody>
						           <tr>
						           <td>
						            <div class="product_name clearfix" style="width: 230px;">
						            <a href="${path_}/foodDetailInUser.action?foodId=${bean.product.id}" class="product_img"><img src="${pageContext.request.contextPath}/upload/food/${bean.product.foodName}/${bean.product.foodImgurl}" width="80px" height="80px"></a>
						            <a href="${path_}/foodDetailInUser.action?foodId=${bean.product.id}" class="p_name" style="padding-right: 0;">${bean.product.foodName}</a>
						            </div>
						            </td>
						            <td >￥${bean.product.price}</td>
						           <td>
						           	<form action="${path_}/shopCartActive/updateCountSubmit.action" method="get"  id="formSub${bean.product.id}">
						           		<input type="button" value="-" onclick="sub(${bean.product.id});"/>
						            	<input type="text" name="count" id="count${bean.product.id}" onkeyup="this.value=this.value.replace(/\D/g,'')" value="${bean.count}" style="width: 20px;text-align: center;" onblur="check(${bean.product.id});"/>
						            	<input type="button" value="+" onclick="add(${bean.product.id});"/>
						            	<input type="hidden" name="id" value="${bean.product.id}"/>
						            </form>
						           </td>
						            </tr>
						            </tbody>
						            </table>
					           </td>   
				           	   <td class="split_line">￥${bean.product.price * bean.count}</td>
				           	   <td class="split_line"><p style="color:#F30">${bean.product.description}</p></td>
					           <td >
					    			<a href="${path_}/shopCartActive/deleteCartFoodBean1.action?id=${bean.product.id}&foodName=${bean.product.foodName}" style="display: inline;border:1px #ccc solid;padding:5px 5px;background:#80ff80;border-radius: 6px;" ><font color="red">删除</font></a>
					           </td>
				           </tr>
				         
			         </tbody>
	            </c:forEach>
	           
	         </table>
	    </div>
	     <div class="Order_Operation">
	     <div class="left" style="padding-left: 470px; ">
	      
	     	<label><font style="color: red;">总金额：</font></label>
	     	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	     	&nbsp;&nbsp;&nbsp;
	     	<label>
		     	<font>
		     	<c:if test="${totalcost==null||totalcost==0}">
				  <font color="green">￥0,&nbsp;你的购物车咋一个东西也没有尼，快去<a href="${path_}/shopTown.action?action=factory"><font color="#122378" style="font-weight: bold;">商城</font></a>看看吧！！</font>
				</c:if>
				<c:if test="${totalcost!=null&&totalcost!=0}">
				      ￥${totalcost}
				</c:if>
		     	</font>
		    </label>
	     	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	     	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	     	
	     	
	      	<label>
	      	<c:if test="${totalcost!=null && totalcost!=0 }">
	      
	      		<input  type="submit" value="批量删除"  class="confirm_Order" />
	      		
	      	</c:if>
	      	</label>
	      	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	      	<c:if test="${totalcost!=null && totalcost!=0 }">
	      		<a href="${path_}/shopCartActive/removeProductCart.action" style="display: inline;border:1px #ccc solid;padding:5px 5px;background:#80ff80;border-radius: 6px;" ><font color="white">清空购物车</font></a>
	      		&nbsp;&nbsp;&nbsp;
	      		<a href="${path_}/shopCartActive/addOrder.action" style="display: inline;border:1px #ccc solid;padding:5px 5px;background:#80ff80;border-radius: 6px;"  ><font color="blue">生成订单</font></a>
	      		
	      	</c:if>
	     </div>
	      
	      </div>
	      
	      <div class="pro_detail_btn margin-t30">
	       <button style="border-radius: 6px;color: red;">
	       	 <a href="#" onclick="javascript:history.go(-1);">返回</a>
	       </button> 
	      </div>
	     </div>
   </form>
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

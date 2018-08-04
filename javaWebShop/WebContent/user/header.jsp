<%@page import="com.sky.common.shoppingCartList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp" %>
<%@page errorPage="../common/UserError.jsp"%>
<head>
${LoginOutMsg}
 <div id="header_top">
  <div id="top">
    <div class="Inside_pages">
      <div class="Collection">
	      <c:if test="${user!=null}">
	      
	      	<img width="25px;" height="25px;" alt="" src="${pageContext.request.contextPath}/upload/user/${user.user_username}/${user.user_image}">
	      	你好,<strong style="color: green;">${user.user_username}</strong>
	      	
	      </c:if>
	      <c:if test="${user==null}">
	      		
	      		<a href="${path_}/login.action" class="green">请登录</a> 
	      		<a href="${path_}/register.action" class="green">免费注册</a>
	      </c:if>
	      
	     
      </div>
	<div class="hd_top_manu clearfix">
	  <ul class="clearfix">
	  
	   <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="${path_}/jumpToIndex.action">首页</a></li>
	   <c:if test="${user!=null}">
	   		 <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="${path_}/UserLoginOut.action" style="color: red;">用户退出</a></li>
	   		 <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="${path_}/user_detail.action">用户中心</a></li> 
	   		 <li class="hd_menu_tit" data-addclass="hd_menu_hover"><a href="${path_}/login.action">登录</a></li> 
	   </c:if>
	   
	  </ul>
	</div>
    </div>
  </div>
  <div id="header"  class="header page_style">
  <div class="logo">
  	
  	<a href="${path}/index.jsp"><img src="${path}/images/logo.png" /></a></div>
  <!--结束图层-->
  <div class="Search">
        <div class="search_list">
            <ul>
                <li class="current"><a href="#">产品</a></li>
                <li><a href="#">信息</a></li>
            </ul>
        </div>
         <div class="clear search_cur">
	        <form action="${path_}/shopTown.action" method="get">
	           <input name="searchFoodName" id="searchName" class="search_box"  type="text" />
	           <input type="submit" value="搜 索"  class="Search_btn"/>
	           <input type="hidden" name="action" value="searchFood" />
	        </form>
        </div>
        <div class="clear hotword">
       		热门搜索词：
        	<c:forEach items="${foodNameList}" var="food">
        		<a href="${path_}/foodDetailInUser.action?foodId=${food.id}">${food.foodName}</a>&nbsp;&nbsp;&nbsp;
        	</c:forEach>	
       	</div>
</div>
 <!--购物车样式-->
 <div class="hd_Shopping_list" id="Shopping_list">
   <div class="s_cart"><a href="${path_}/shopCartActive/showshopCart.action">我的购物车</a> <i class="ci-right">&gt;</i>
   </div>
   
 </div>
</div>
<!--菜单栏-->
	<div class="Navigation" id="Navigation">
		 <ul class="Navigation_name" >
			<li><a href="${path_}/jumpToIndex.action">首页</a></li>
            <li class="hour"><span class="bg_muen"></span><a href="#">半小时生活圈</a></li>
			<li><a href="#">你身边的超市</a></li>
			<li><a href="#">预售专区</a><em class="hot_icon"></em></li>
			<li><a href="${path_}/shopTown.action?action=factory">商城</a></li>
			
			<li><a href="#">好评商户</a></li>
			<li><a href="#">热销活动</a></li>
			<li><a href="Brands.html">联系我们</a></li>
		 </ul>			 
		</div>
	<script>$("#Navigation").slide({titCell:".Navigation_name li",trigger:"click"});</script>
    </div>
</head>
<%@page import="com.sky.common.indexPage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp" %>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="path" value="${pageContext.request.contextPath}/user"
	scope="application"></c:set>
<c:set var="path_" value="${pageContext.request.contextPath}"
	scope="application"></c:set>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${path}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${path}/css/style.css" rel="stylesheet" type="text/css" />
<script src="${path}/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${path}/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
<script src="${path}/js/common_js.js" type="text/javascript"></script>
<script src="${path}/js/footer.js" type="text/javascript"></script>
<title>商城</title>
</head>

<body>

<%@include file="header.jsp"%>
<!--产品列表样式-->
<div class="Inside_pages"> 

    <!--产品列表样式-->
    <div id="Sorted" class="">
        <div class="Sorted">
	        <c:if test="${a=='factory'||a=='factoryByPrice'||a=='factoryByBuyCount'}">
	        	<div class="Sorted_style"> <a href="${path_}/shopTown.action?action=factory" >综合<i class="iconfont icon-fold"></i></a> <a href="${path_}/shopTown.action?action=factoryByPrice">价格<i class="iconfont icon-fold"></i></a> <a href="${path_}/shopTown.action?action=factoryByBuyCount">销量<i class="iconfont icon-fold"></i></a> </div>
	        </c:if>
            <c:if test="${a=='factoryNewFood'}">
	        	<div class="Sorted_style"> <a href="${path_}/shopTown.action?action=factoryNewFood" class="on">新品<i class="iconfont icon-fold"></i></a> </div>
	        </c:if>
	        <c:if test="${a=='factoryHotFood'}">
	        	<div class="Sorted_style"> <a href="${path_}/shopTown.action?action=factoryHotFood" class="on">热门<i class="iconfont icon-fold"></i></a> </div>
	        </c:if>
	        <c:if test="${a=='searchFood'}">
	        	<div class="Sorted_style" > <a style="width: 150px;" href="${path_}/shopTown.action?action=searchFood&searchFoodName=${searchFoodName}" class="on">搜索'${searchFoodName}'的结果</a> </div>
	        </c:if>
	        <c:if test="${a!='factory'&&a!='factoryByPrice'&&a!='factoryByBuyCount'&&a!='factoryNewFood'&&a!='factoryHotFood'&&a!='searchFood'}">
	        	<div class="Sorted_style"> <a href="${path_}/shopTown.action?action=${a}&typeName=${typeName}" class="on">
	        		${typeName}
	        	<i class="iconfont icon-fold" ></i></a> </div>
	        </c:if>
            <!--页数-->
            <div class="s_Paging"> 
            <span> 
            	<c:if test="${page.page_count!=0}">${page.current_page}/ ${page.page_count}</c:if>
            	<c:if test="${page.page_count==0}">暂无商品</c:if>
            </span> </div>
        </div>
    </div>
    <div class="p_list  clearfix" >
        <ul>
        	<c:forEach items="${FoodList}" var="food">
	        		<li class="gl-item"> <em class="icon_special tejia"></em>
		                <div class="Borders">
		                    <div class="img"><a href="${path_}/foodDetailInUser.action?foodId=${food.id}"><img src="${pageContext.request.contextPath}/upload/food/${food.foodName}/${food.foodImgurl}" style="width:220px;height:220px"></a></div>
		                    <div class="name"><a href="${path_}/foodDetailInUser.action?foodId=${food.id}"><strong style="color:#ff7200;">${food.foodName}</strong> ${food.description}</a></div>
		                    <div class="yushou">
		                        <div class="yushou-p fl">¥<strong>${food.price}&nbsp;&nbsp;&nbsp;</strong></div>
		                        <div class="fl sold">
		                            <div class="sold-num"><em>${food.buyCount}</em>件已付款</div>
		                        </div>
		                        <a href="${path_}/foodDetailInUser.action?foodId=${food.id}">
		                        <div class="fr sold-go">详情</div>
		                        </a> </div>
		                </div>
	            	</li>
        	</c:forEach>
            
           
        </ul>
        <div class="Paging">
            <div class="Pagination" style="width: 100%;text-align: center;"> 
            	<c:if test="${page.page_count!=0 }">
						<a href="${path_}/shopTown.action?action=${a}&current_page=1">首页</a>&nbsp;
						<c:if test="${page.current_bottom_page!=1 }">
							<a href="${path_}/subCurrent_bottom_page.action"> < </a>&nbsp;
						</c:if>
						<c:if test="${a=='factory'}">
							<%
							indexPage p=(indexPage)session.getAttribute("page");
							if(p.getMaxCurrent_bottom_page()<10) {
								for(int i=1;i<=p.getPage_count();i++){
									
									out.print("<a href=\"shopTown.action?action=factory&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
								}
						    
							}else if(p.getMaxCurrent_bottom_page()==p.getCurrent_bottom_page()){
								for(int i=p.getCurrent_bottom_page();i<=p.getPage_count();i++){
									out.print("<a href=\"shopTown.action?action=factory&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
								}
							}else {
								if(p.getCurrent_bottom_page()<=p.getMaxCurrent_bottom_page()){
									for(int i=p.getCurrent_bottom_page();i<=p.getCurrent_bottom_page()+8;i++){
										out.print("<a href=\"shopTown.action?action=factory&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
									}
								}
							}
							if(p.getCurrent_bottom_page()< p.getMaxCurrent_bottom_page()){
								out.print("<a href=\"addCurrent_bottom_page.action\"> > </a>"+"&nbsp;");
							}
							%>
						</c:if>
						<c:if test="${a=='factoryByPrice'}">
							<%
							indexPage p=(indexPage)session.getAttribute("page");
							if(p.getMaxCurrent_bottom_page()<10) {
								for(int i=1;i<=p.getPage_count();i++){
									
									out.print("<a href=\"shopTown.action?action=factoryByPrice&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
								}
						    
							}else if(p.getMaxCurrent_bottom_page()==p.getCurrent_bottom_page()){
								for(int i=p.getCurrent_bottom_page();i<=p.getPage_count();i++){
									out.print("<a href=\"shopTown.action?action=factoryByPrice&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
								}
							}else {
								if(p.getCurrent_bottom_page()<=p.getMaxCurrent_bottom_page()){
									for(int i=p.getCurrent_bottom_page();i<=p.getCurrent_bottom_page()+8;i++){
										out.print("<a href=\"shopTown.action?action=factoryByPrice&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
									}
								}
							}
							if(p.getCurrent_bottom_page()< p.getMaxCurrent_bottom_page()){
								out.print("<a href=\"addCurrent_bottom_page.action\"> > </a>"+"&nbsp;");
							}
							%>
						</c:if>
						<c:if test="${a=='factoryByBuyCount'}">
							<%
							indexPage p=(indexPage)session.getAttribute("page");
							if(p.getMaxCurrent_bottom_page()<10) {
								for(int i=1;i<=p.getPage_count();i++){
									
									out.print("<a href=\"shopTown.action?action=factoryByBuyCount&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
								}
						    
							}else if(p.getMaxCurrent_bottom_page()==p.getCurrent_bottom_page()){
								for(int i=p.getCurrent_bottom_page();i<=p.getPage_count();i++){
									out.print("<a href=\"shopTown.action?action=factoryByBuyCount&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
								}
							}else {
								if(p.getCurrent_bottom_page()<=p.getMaxCurrent_bottom_page()){
									for(int i=p.getCurrent_bottom_page();i<=p.getCurrent_bottom_page()+8;i++){
										out.print("<a href=\"shopTown.action?action=factoryByBuyCount&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
									}
								}
							}
							if(p.getCurrent_bottom_page()< p.getMaxCurrent_bottom_page()){
								out.print("<a href=\"addCurrent_bottom_page.action\"> > </a>"+"&nbsp;");
							}
							%>
						</c:if>
						<c:if test="${a=='factoryNewFood'}">
							<%
							indexPage p=(indexPage)session.getAttribute("page");
							if(p.getMaxCurrent_bottom_page()<10) {
								for(int i=1;i<=p.getPage_count();i++){
									
									out.print("<a href=\"shopTown.action?action=factoryNewFood&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
								}
						    
							}else if(p.getMaxCurrent_bottom_page()==p.getCurrent_bottom_page()){
								for(int i=p.getCurrent_bottom_page();i<=p.getPage_count();i++){
									out.print("<a href=\"shopTown.action?action=factoryNewFood&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
								}
							}else {
								if(p.getCurrent_bottom_page()<=p.getMaxCurrent_bottom_page()){
									for(int i=p.getCurrent_bottom_page();i<=p.getCurrent_bottom_page()+8;i++){
										out.print("<a href=\"shopTown.action?action=factoryNewFood&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
									}
								}
							}
							if(p.getCurrent_bottom_page()< p.getMaxCurrent_bottom_page()){
								out.print("<a href=\"addCurrent_bottom_page.action\"> > </a>"+"&nbsp;");
							}
							%>
						</c:if>
						<!-- 热门 -->
						<c:if test="${a=='factoryHotFood'}">
							<%
							indexPage p=(indexPage)session.getAttribute("page");
							if(p.getMaxCurrent_bottom_page()<10) {
								for(int i=1;i<=p.getPage_count();i++){
									
									out.print("<a href=\"shopTown.action?action=factoryHotFood&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
								}
						    
							}else if(p.getMaxCurrent_bottom_page()==p.getCurrent_bottom_page()){
								for(int i=p.getCurrent_bottom_page();i<=p.getPage_count();i++){
									out.print("<a href=\"shopTown.action?action=factoryHotFood&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
								}
							}else {
								if(p.getCurrent_bottom_page()<=p.getMaxCurrent_bottom_page()){
									for(int i=p.getCurrent_bottom_page();i<=p.getCurrent_bottom_page()+8;i++){
										out.print("<a href=\"shopTown.action?action=factoryHotFood&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
									}
								}
							}
							if(p.getCurrent_bottom_page()< p.getMaxCurrent_bottom_page()){
								out.print("<a href=\"addCurrent_bottom_page.action\"> > </a>"+"&nbsp;");
							}
							%>
						</c:if>
						<!-- 搜索 -->
						<c:if test="${a=='searchFood'}">
							<%
							String searchFoodName=(String)session.getAttribute("searchFoodName");
							indexPage p=(indexPage)session.getAttribute("page");
							if(p.getMaxCurrent_bottom_page()<10) {
								for(int i=1;i<=p.getPage_count();i++){
									
									out.print("<a href=\"shopTown.action?action=searchFood&searchFoodName="+searchFoodName+"&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
								}
						    
							}else if(p.getMaxCurrent_bottom_page()==p.getCurrent_bottom_page()){
								for(int i=p.getCurrent_bottom_page();i<=p.getPage_count();i++){
									out.print("<a href=\"shopTown.action?action=searchFood&searchFoodName="+searchFoodName+"current_page="+i+"\">"+i+"</a>"+"&nbsp;");
								}
							}else {
								if(p.getCurrent_bottom_page()<=p.getMaxCurrent_bottom_page()){
									for(int i=p.getCurrent_bottom_page();i<=p.getCurrent_bottom_page()+8;i++){
										out.print("<a href=\"shopTown.action?action=searchFood&searchFoodName="+searchFoodName+"current_page="+i+"\">"+i+"</a>"+"&nbsp;");
									}
								}
							}
							if(p.getCurrent_bottom_page()< p.getMaxCurrent_bottom_page()){
								out.print("<a href=\"addCurrent_bottom_page.action\"> > </a>"+"&nbsp;");
							}
							%>
						</c:if>
						<c:if test="${a!='factory' && a!='factoryByPrice'&& a!='factoryByBuyCount'&& a!='factoryNewFood'&& a!='factoryHotFood'&&a!='searchFood'}">
							<%
							String a1=(String)session.getAttribute("a");
							int a=Integer.parseInt(a1);
							indexPage p=(indexPage)session.getAttribute("page");
							if(p.getMaxCurrent_bottom_page()<10) {
								for(int i=1;i<=p.getPage_count();i++){
									out.print("<a href=\"shopTown.action?action="+a+"&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
								}
						    
							}else if(p.getMaxCurrent_bottom_page()==p.getCurrent_bottom_page()){
								for(int i=p.getCurrent_bottom_page();i<=p.getPage_count();i++){
									out.print("<a href=\"shopTown.action?action="+a+"&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
								}
							}else {
								if(p.getCurrent_bottom_page()<=p.getMaxCurrent_bottom_page()){
									for(int i=p.getCurrent_bottom_page();i<=p.getCurrent_bottom_page()+8;i++){
										out.print("<a href=\"shopTown.action?action="+a+"&current_page="+i+"\">"+i+"</a>"+"&nbsp;");
									}
								}
							}
							if(p.getCurrent_bottom_page()< p.getMaxCurrent_bottom_page()){
								out.print("<a href=\"addCurrent_bottom_page.action\"> > </a>"+"&nbsp;");
							}
							%>
							
						</c:if>
						
						
					
						<a href="${path_}/shopTown.action?action=${a}&current_page=${page.page_count }">尾页</a>&nbsp;
					</c:if>
            </div>
        </div>
    </div>
</div>
<!--网站地图-->
<%@include file="footer.jsp"%>
<!--网站地图END--> 
<!--网站页脚-->
<
<!--右侧菜单栏购物车样式-->
<div class="fixedBox">
    <ul class="fixedBoxList">
        <li class="fixeBoxLi user"><a href="#"> <span class="fixeBoxSpan"></span> <strong>消息中心</strong></a> </li>
        <li class="fixeBoxLi cart_bd" style="display:block;" id="cartboxs">
            <p class="good_cart">9</p>
            <span class="fixeBoxSpan"></span> <strong>购物车</strong>
            <div class="cartBox">
                <div class="bjfff"></div>
                <div class="message">购物车内暂无商品，赶紧选购吧</div>
            </div>
        </li>
        <li class="fixeBoxLi Service "> <span class="fixeBoxSpan"></span> <strong>客服</strong>
            <div class="ServiceBox">
                <div class="bjfffs"></div>
                <dl onclick="javascript:;">
                    <dt><img src="images/Service1.png"></dt>
                    <dd><strong>QQ客服1</strong>
                        <p class="p1">9:00-22:00</p>
                        <p class="p2"><a href="http://wpa.qq.com/msgrd?v=3&amp;uin=123456&amp;site=DGG三端同步&amp;menu=yes">点击交谈</a></p>
                    </dd>
                </dl>
                <dl onclick="javascript:;">
                    <dt><img src="images/Service1.png"></dt>
                    <dd> <strong>QQ客服1</strong>
                        <p class="p1">9:00-22:00</p>
                        <p class="p2"><a href="http://wpa.qq.com/msgrd?v=3&amp;uin=123456&amp;site=DGG三端同步&amp;menu=yes">点击交谈</a></p>
                    </dd>
                </dl>
            </div>
        </li>
        <li class="fixeBoxLi code cart_bd " style="display:block;" id="cartboxs"> <span class="fixeBoxSpan"></span> <strong>微信</strong>
            <div class="cartBox">
                <div class="bjfff"></div>
                <div class="QR_code">
                    <p><img src="images/erweim.jpg" width="180px" height="180px" /></p>
                    <p>微信扫一扫，关注我们</p>
                </div>
            </div>
        </li>
        <li class="fixeBoxLi Home"> <a href="./"> <span class="fixeBoxSpan"></span> <strong>收藏夹</strong> </a> </li>
        <li class="fixeBoxLi BackToTop"> <span class="fixeBoxSpan"></span> <strong>返回顶部</strong> </li>
    </ul>
</div>
</body>
</html>

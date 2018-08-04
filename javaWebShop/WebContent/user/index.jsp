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
<title>网站首页</title>

</head>

<body>
	<%@include file="header.jsp"%>
	<!--广告幻灯片样式-->
	<div id="slideBox" class="slideBox">
		<div class="hd">
			<ul class="smallUl"></ul>
		</div>
		<div class="bd">
			<ul>
				<li><a href="#" target="_blank"><div
							style="background: url(${path}/AD/ad-1.jpg) no-repeat; background-position: center; width: 100%; height: 450px;"></div></a></li>
				<li><a href="#" target="_blank"><div
							style="background: url(${path}/AD/ad-2.jpg) no-repeat; background-position: center; width: 100%; height: 450px;"></div></a></li>
				<li><a href="#" target="_blank"><div
							style="background: url(${path}/AD/ad-1.jpg) no-repeat rgb(226, 155, 197); background-position: center; width: 100%; height: 475px;"></div></a></li>
				<li><a href="#" target="_blank"><div
							style="background: url(${path}/AD/ad-2.jpg) no-repeat #f7ddea; background-position: center; width: 100%; height: 450px;"></div></a></li>
				<li><a href="#" target="_blank"><div
							style="background: url(${path}/AD/ad-1.jpg) no-repeat #F60; background-position: center; width: 100%; height: 450px;"></div></a></li>
			</ul>
		</div>
		<!-- 下面是前/后按钮-->
		<a class="prev" href="javascript:void(0)"></a> <a class="next"
			href="javascript:void(0)"></a>

	</div>
	<script type="text/javascript">
		jQuery(".slideBox").slide({
			titCell : ".hd ul",
			mainCell : ".bd ul",
			autoPlay : true,
			autoPage : true
		});
	</script>
	</div>

	<!--内容样式-->
	<div id="mian">
		<div class="clearfix marginbottom">
			<!--产品分类样式-->
			<div class="Menu_style" id="allSortOuterbox">
				<div class="title_name">
					<em></em>所有商品分类
				</div>
				<div class="content hd_allsort_out_box_new">
					<ul class="Menu_list">
						<c:forEach items="${foodTypeList}" var="foodType">
							<li class="name">
								<div class="Menu_name">
									<a href="${path_}/shopTown.action?action=${foodType.id}&typeName=${foodType.typeName}">${foodType.typeName}</a><span>&lt;</span>
								</div>
								
							
							</li>
							<br/>
						</c:forEach>
						
					</ul>
				</div>
			</div>
			<script>
				$("#allSortOuterbox").slide({
					titCell : ".Menu_list li",
					mainCell : ".menv_Detail",
				});
			</script>
			<!--产品栏切换-->
			<div class="product_list left">
				<div class="slideGroup">
					<div class="parHd">
						<ul>
							<a href="${path_}/shopTown.action?action=factoryNewFood"><li>新品上市</li></a>
							<a href="${path_}/shopTown.action?action=factoryHotFood"><li>热门商品</li></a>
							<li>本期团购</li>
							<li>产品精选</li>
							<li>抢先一步</li>
						</ul>
					</div>
					<div class="parBd">
						<!--新品上市  -->
						<div class="slideBoxs">
							<a class="sPrev" href="javascript:void(0)"></a>
							<ul>
								<c:forEach items="${newFoodList}" var="food">
									<li>
										<div class="pic">
											<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" ><img src="${pageContext.request.contextPath}/upload/food/${food.foodName}/${food.foodImgurl}" /></a>
										</div>
										<div class="title">
											<a href="${path_}/foodDetailInUser.action?foodId=${food.id}"  class="name"><font color="green">${food.foodName}</font> &nbsp;
												${food.description}</a>
											<h3>
												<b>￥</b>${food.price}
											</h3>
										</div>
									</li>
								</c:forEach>
								
								
							</ul>
							<a class="sNext" href="javascript:void(0)"></a>
						</div>
						<!-- slideBox End -->
						<!-- 热门商品 -->
						<div class="slideBoxs">
							<a class="sPrev" href="javascript:void(0)"></a>
							<ul>
								<c:forEach items="${hotFoodList}" var="food">
									<li>
										<div class="pic">
											<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" ><img src="${pageContext.request.contextPath}/upload/food/${food.foodName}/${food.foodImgurl}" /></a>
										</div>
										<div class="title">
											<a href="${path_}/foodDetailInUser.action?foodId=${food.id}"  class="name"><font color="green">${food.foodName}</font> &nbsp;
												${food.description}</a>
											<h3>
												<b>￥</b>${food.price}
											</h3>
										</div>
									</li>
								</c:forEach>
								
								
							</ul>
							<a class="sNext" href="javascript:void(0)"></a>
						</div>
						<!-- slideBox End -->
						<!-- 本期团购 -->
						<div class="slideBoxs">
							<a class="sPrev" href="javascript:void(0)"></a>
							<ul>
								<li>
									<div class="pic">
										<a href="#" target="_blank"><img src="${path}/products/p_57.jpg" /></a>
									</div>
									<div class="title">
										<a href="#" target="_blank" class="name">乐事
											无限薯片三连装（原味+番茄+烤肉）104g*3/组</a>
										<h3>
											<b>￥</b>23.00
										</h3>
									</div>
								</li>
								<li>
									<div class="pic">
										<a href="#" target="_blank"><img src="${path}/products/p_56.jpg" /></a>
									</div>
									<div class="title">
										<a href="#" target="_blank" class="name">乐事
											无限薯片三连装（原味+番茄+烤肉）104g*3/组</a>
										<h3>
											<b>￥</b>23.00
										</h3>
									</div>
								</li>
								<li>
									<div class="pic">
										<a href="#" target="_blank"><img src="${path}/products/p_54.jpg" /></a>
									</div>
									<div class="title">
										<a href="#" target="_blank" class="name">乐事
											无限薯片三连装（原味+番茄+烤肉）104g*3/组</a>
										<h3>
											<b>￥</b>23.00
										</h3>
									</div>
								</li>
								<li>
									<div class="pic">
										<a href="#" target="_blank"><img src="${path}/products/p_55.jpg" /></a>
									</div>
									<div class="title">
										<a href="#" target="_blank" class="name">乐事
											无限薯片三连装（原味+番茄+烤肉）104g*3/组</a>
										<h3>
											<b>￥</b>23.00
										</h3>
									</div>
								</li>
							</ul>
							<a class="sNext" href="javascript:void(0)"></a>
						</div>
						<!-- 产品精选 -->
						<!-- slideBox End -->
						<div class="slideBoxs">
							<a class="sPrev" href="javascript:void(0)"></a>
							<ul>
								<li>
									<div class="pic">
										<a href="#" target="_blank"><img src="${path}/products/p_50.jpg" /></a>
									</div>
									<div class="title">
										<a href="#" target="_blank" class="name">乐事
											无限薯片三连装（原味+番茄+烤肉）104g*3/组</a>
										<h3>
											<b>￥</b>23.00
										</h3>
									</div>
								</li>
								<li>
									<div class="pic">
										<a href="#" target="_blank"><img src="${path}/products/p_51.jpg" /></a>
									</div>
									<div class="title">
										<a href="#" target="_blank" class="name">乐事
											无限薯片三连装（原味+番茄+烤肉）104g*3/组</a>
										<h3>
											<b>￥</b>23.00
										</h3>
									</div>
								</li>
								<li>
									<div class="pic">
										<a href="#" target="_blank"><img src="${path}/products/p_52.jpg" /></a>
									</div>
									<div class="title">
										<a href="#" target="_blank" class="name">乐事
											无限薯片三连装（原味+番茄+烤肉）104g*3/组</a>
										<h3>
											<b>￥</b>23.00
										</h3>
									</div>
								</li>
								<li>
									<div class="pic">
										<a href="#" target="_blank"><img src="${path}/products/p_53.jpg" /></a>
									</div>
									<div class="title">
										<a href="#" target="_blank" class="name">乐事
											无限薯片三连装（原味+番茄+烤肉）104g*3/组</a>
										<h3>
											<b>￥</b>23.00
										</h3>
									</div>
								</li>
							</ul>
							<a class="sNext" href="javascript:void(0)"></a>
						</div>
						<!-- 抢先一步 -->
						<!-- slideBox End -->
						<div class="slideBoxs">
							<a class="sPrev" href="javascript:void(0)"></a>
							<ul>
								<li>
									<div class="pic">
										<a href="#" target="_blank"><img src="${path}/products/p_15.jpg" /></a>
									</div>
									<div class="title">
										<a href="#" target="_blank" class="name">乐事
											无限薯片三连装（原味+番茄+烤肉）104g*3/组</a>
										<h3>
											<b>￥</b>23.00
										</h3>
									</div>
								</li>
								<li>
									<div class="pic">
										<a href="#" target="_blank"><img src="${path}/products/p_17.jpg" /></a>
									</div>
									<div class="title">
										<a href="#" target="_blank" class="name">乐事
											无限薯片三连装（原味+番茄+烤肉）104g*3/组</a>
										<h3>
											<b>￥</b>23.00
										</h3>
									</div>
								</li>
								<li>
									<div class="pic">
										<a href="#" target="_blank"><img src="${path}/products/p_16.jpg" /></a>
									</div>
									<div class="title">
										<a href="#" target="_blank" class="name">乐事
											无限薯片三连装（原味+番茄+烤肉）104g*3/组</a>
										<h3>
											<b>￥</b>23.00
										</h3>
									</div>
								</li>
								<li>
									<div class="pic">
										<a href="#" target="_blank"><img src="${path}/products/p_19.jpg" /></a>
									</div>
									<div class="title">
										<a href="#" target="_blank" class="name">乐事
											无限薯片三连装（原味+番茄+烤肉）104g*3/组</a>
										<h3>
											<b>￥</b>23.00
										</h3>
									</div>
								</li>
							</ul>
							<a class="sNext" href="javascript:void(0)"></a>
						</div>
						<!-- slideBox End -->

					</div>
					<!-- parBd End -->
				</div>
				<script type="text/javascript">
					/* 内层图片无缝滚动 */
					jQuery(".slideGroup .slideBoxs").slide({
						mainCell : "ul",
						vis : 4,
						prevCell : ".sPrev",
						nextCell : ".sNext",
						effect : "leftMarquee",
						interTime : 50,
						autoPlay : true,
						trigger : "click"
					});
					/* 外层tab切换 */
					jQuery(".slideGroup").slide({
						titCell : ".parHd li",
						mainCell : ".parBd"
					});
				</script>
				<!--饮品-->
				<div class="Ads_style">
				<c:forEach items="${drinkType.foodSet}" var="food" begin="0" end="2">
					<a href="${path_}/foodDetailInUser.action?foodId=${food.id}"><img src="${pageContext.request.contextPath}/upload/food/${food.foodName}/${food.foodImgurl}" width="318" /></a>
					
				</c:forEach>
				</div>
			</div>
		</div>
		<!--板块栏目样式-->
		<div class="clearfix Plate_style">
		
			<div class="Plate_column Plate_column_left">
				<div class="Plate_name">
					<h2>酒类</h2>
					<div class="Sort_link">
						<c:if test="${wineLength>16}">
							<c:forEach items="${wineType.foodSet}" var="food" begin="0" end="15">
								<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="name">${food.foodName}</a>
							</c:forEach>
							
						</c:if>
						<c:if test="${wineLength<=16}">
							<c:forEach items="${wineType.foodSet}" var="food">
								<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="name">${food.foodName}</a>
							</c:forEach>
						</c:if>
						
						
					</div>
					<c:forEach items="${wineType.foodSet}" var="food" begin="0" end="0">
						<a href="${path_}/shopTown.action?action=${food.type.id}&typeName=${food.type.typeName}" class="Plate_link"> <img src="${path}/images/bk_img_14.png" /></a>
					</c:forEach>
				</div>
				<div class="Plate_product">
					<ul id="lists">
						<c:forEach items="${wineType.foodSet}" var="food" begin="0" end="3">
							<li class="product_display"><a href="" class="Collect"><em></em>收藏</a>
								<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="img_link"><img src="${pageContext.request.contextPath}/upload/food/${food.foodName}/${food.foodImgurl}"
									width="140" height="140" /></a> <a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="name">${food.foodName}</a>
								<h3>
									<b>￥</b>${food.price}
								</h3>
								<div class="Detailed">
									<div class="content">
										<p class="center">
											<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="Buy_btn">商品详情</a>
										</p>
									</div>
								</div>
							</li>
						</c:forEach>
						
						
					</ul>
				</div>
			</div>
			<!--板块名称-->
			<div class="Plate_column Plate_column_right">
				<div class="Plate_name">
					<h2>零食</h2>
					<div class="Sort_link">
						<c:if test="${snackLength>16}">
							<c:forEach items="${snackType.foodSet}" var="food" begin="0" end="15">
								<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="name">${food.foodName}</a>
							</c:forEach>
							
						</c:if>
						<c:if test="${snackLength<=16}">
							<c:forEach items="${snackType.foodSet}" var="food">
								<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="name">${food.foodName}</a>
							</c:forEach>
						</c:if>
					</div>
					<c:forEach items="${snackType.foodSet}" var="food" begin="0" end="0">
						<a href="${path_}/shopTown.action?action=${food.type.id}&typeName=${food.type.typeName}" class="Plate_link"> <img src="${path}/images/bk_img_19.png" /></a>
					</c:forEach>
				</div>
				<div class="Plate_product">
					<ul id="lists">
						<c:forEach items="${snackType.foodSet}" var="food" begin="0" end="3">
							<li class="product_display"><a href="" class="Collect"><em></em>收藏</a>
								<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="img_link"><img src="${pageContext.request.contextPath}/upload/food/${food.foodName}/${food.foodImgurl}"
									width="140" height="140" /></a> <a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="name">${food.foodName}</a>
								<h3>
									<b>￥</b>${food.price}
								</h3>
								<div class="Detailed">
									<div class="content">
										<p class="center">
											<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="Buy_btn">商品详情</a>
										</p>
									</div>
								</div>
							</li>
						</c:forEach>
						
					</ul>
				</div>
			</div>
			<div class="Plate_column Plate_column_left">
				<div class="Plate_name">
					<h2>美味海鲜</h2>
					<div class="Sort_link">
						<c:if test="${seaFoodLength>16}">
							<c:forEach items="${seaFoodType.foodSet}" var="food" begin="0" end="15">
								<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="name">${food.foodName}</a>
							</c:forEach>
							
						</c:if>
						<c:if test="${seaFoodLength<=16}">
							<c:forEach items="${seaFoodType.foodSet}" var="food">
								<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="name">${food.foodName}</a>
							</c:forEach>
						</c:if>
					</div>
					<c:forEach items="${seaFoodType.foodSet}" var="food" begin="0" end="0">
						<a href="${path_}/shopTown.action?action=${food.type.id}&typeName=${food.type.typeName}" class="Plate_link"> <img src="${path}/images/bk_img_22.png" /></a>
					</c:forEach>
				</div>
				<div class="Plate_product">
					<ul id="lists">
						<c:forEach items="${seaFoodType.foodSet}" var="food" begin="0" end="3">
							<li class="product_display"><a href="" class="Collect"><em></em>收藏</a>
								<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="img_link"><img src="${pageContext.request.contextPath}/upload/food/${food.foodName}/${food.foodImgurl}"
									width="140" height="140" /></a> <a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="name">${food.foodName}</a>
								<h3>
									<b>￥</b>${food.price}
								</h3>
								<div class="Detailed">
									<div class="content">
										<p class="center">
											<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="Buy_btn">商品详情</a>
										</p>
									</div>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<!--板块名称-->
			<div class="Plate_column Plate_column_right">
				<div class="Plate_name">
					<h2>厨房必备</h2>
					<div class="Sort_link">
						<c:if test="${twLength>16}">
							<c:forEach items="${twType.foodSet}" var="food" begin="0" end="15">
								<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="name">${food.foodName}</a>
							</c:forEach>
							
						</c:if>
						<c:if test="${twLength<=16}">
							<c:forEach items="${twType.foodSet}" var="food">
								<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="name">${food.foodName}</a>
							</c:forEach>
						</c:if>
					</div>
					<c:forEach items="${twType.foodSet}" var="food" begin="0" end="0">
						<a href="${path_}/shopTown.action?action=${food.type.id}&typeName=${food.type.typeName}" class="Plate_link"> <img src="${path}/images/bk_img_14.png" /></a>
					</c:forEach>
				</div>
				<div class="Plate_product">
					<ul id="lists">
						<c:forEach items="${twType.foodSet}" var="food" begin="0" end="3">
							<li class="product_display"><a href="" class="Collect"><em></em>收藏</a>
								<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="img_link"><img src="${pageContext.request.contextPath}/upload/food/${food.foodName}/${food.foodImgurl}"
									width="140" height="140" /></a> <a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="name">${food.foodName}</a>
								<h3>
									<b>￥</b>${food.price}
								</h3>
								<div class="Detailed">
									<div class="content">
										<p class="center">
											<a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="Buy_btn">商品详情</a>
										</p>
									</div>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		<!--友情链接-->
		<div class="link_style clearfix">
			<div class="title">友情链接</div>
			<div class="link_name">
				<a href="#"><img src="${path}/products/logo/34.jpg" width="100" /></a> <a
					href="#"><img src="${path}/products/logo/34.jpg" width="100" /></a> <a
					href="#"><img src="${path}/products/logo/34.jpg" width="100" /></a> <a
					href="#"><img src="${path}/products/logo/34.jpg" width="100" /></a> <a
					href="#"><img src="${path}/products/logo/34.jpg" width="100" /></a> <a
					href="#"><img src="${path}/products/logo/34.jpg" width="100" /></a> <a
					href="#"><img src="${path}/products/logo/34.jpg" width="100" /></a> <a
					href="#"><img src="${path}/products/logo/34.jpg" width="100" /></a> <a
					href="#"><img src="${path}/products/logo/34.jpg" width="100" /></a> <a
					href="#"><img src="${path}/products/logo/34.jpg" width="100" /></a> <a
					href="#"><img src="${path}/products/logo/34.jpg" width="100" /></a> <a
					href="#"><img src="${path}/products/logo/34.jpg" width="100" /></a> <a
					href="#"><img src="${path}/products/logo/34.jpg" width="100" /></a>
			</div>
		</div>
	</div>
	<!--网站地图-->
	<%@include file="footer.jsp"%>
	<!--网站地图END-->

	<!--右侧菜单栏购物车样式-->
	<div class="fixedBox">
		<ul class="fixedBoxList">
			<li class="fixeBoxLi user"><a href="#"> <span
					class="fixeBoxSpan"></span> <strong>消息中心</strong></a></li>
			<li class="fixeBoxLi cart_bd" style="display: block;" id="cartboxs">
				<p class="good_cart">9</p> <span class="fixeBoxSpan"></span> <strong>购物车</strong>
				<div class="cartBox">
					<div class="bjfff"></div>
					<div class="message">购物车内暂无商品，赶紧选购吧</div>
				</div>
			</li>
			<li class="fixeBoxLi Service "><span class="fixeBoxSpan"></span>
				<strong>客服</strong>
				<div class="ServiceBox">
					<div class="bjfffs"></div>
					<dl onclick="javascript:;">
						<dt>
							<img src="${path}/images/Service1.png">
						</dt>
						<dd>
							<strong>QQ客服1</strong>
							<p class="p1">9:00-22:00</p>
							<p class="p2">
								<a
									href="">点击交谈</a>
							</p>
						</dd>
					</dl>
					<dl onclick="javascript:;">
						<dt>
							<img src="${path}/images/Service1.png">
						</dt>
						<dd>
							<strong>QQ客服1</strong>
							<p class="p1">9:00-22:00</p>
							<p class="p2">
								<a
									href="">点击交谈</a>
							</p>
						</dd>
					</dl>
				</div></li>
			<li class="fixeBoxLi code cart_bd " style="display: block;"
				id="cartboxs"><span class="fixeBoxSpan"></span> <strong>微信</strong>
				<div class="cartBox">
					<div class="bjfff"></div>
					<div class="QR_code">
						<p>
							<img src="${path}/images/erweim.jpg" width="180px" height="180px" />
						</p>
						<p>微信扫一扫，关注我们</p>
					</div>
				</div></li>

			<li class="fixeBoxLi Home"><a href="./"> <span
					class="fixeBoxSpan"></span> <strong>收藏夹</strong>
			</a></li>
			<li class="fixeBoxLi BackToTop"><span class="fixeBoxSpan"></span>
				<strong>返回顶部</strong></li>
		</ul>
	</div>

</body>
</html>

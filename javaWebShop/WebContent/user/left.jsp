<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp" %>
<%@page errorPage="../common/UserError.jsp"%>
	<!--左侧样式-->
			<div class="left_style">
				<div class="menu_style">
					<div class="user_title">用户中心</div>
					<div class="user_Head">
						<div class="user_portrait">
							<a href="#" title="修改头像" class="btn_link"></a>
							<img width="25px;" height="25px;" alt="" src="${pageContext.request.contextPath}/upload/user/${user.user_username}/${user.user_image}">
							<div class="background_img"></div>
						</div>
						<div class="user_name">
							<p>
								<span class="name">${user.user_username}</span><a href="${path_}/jumpToUpdatePasswordpage.action">[修改密码]</a>
							</p>
							<p>访问时间：<%=new Date() %></p>
						</div>
					</div>
					<div class="sideMen">
						<!--菜单列表图层-->
						<dl class="accountSideOption1">
							<dt class="transaction_manage">
								<em class="icon_1"></em>订单管理
							</dt>
							<dd>
								<ul>
									<li><a href="${path_}/myAllOrders.action">我的订单</a></li>
									<li><a href="${path_}/receiveAddress.action">收货地址</a></li>
									<li><a href="#">缺货登记</a></li>
									<li><a href="#">跟踪包裹</a></li>
								</ul>
							</dd>
						</dl>
						<dl class="accountSideOption1">
							<dt class="transaction_manage">
								<em class="icon_2"></em>会员管理
							</dt>
							<dd>
								<ul>
									<li><a href="${path_}/user_detail.action"> 用户信息</a></li>
									<li><a href="用户中心-我的收藏.html"> 我的收藏</a></li>
									<li><a href="#"> 我的留言</a></li>
									<li><a href="#">我的标签</a></li>
									<li><a href="#"> 我的推荐</a></li>
									<li><a href="#"> 我的评论</a></li>
								</ul>
							</dd>
						</dl>
						<dl class="accountSideOption1">
							<dt class="transaction_manage">
								<em class="icon_3"></em>账户管理
							</dt>
							<dd>
								<ul>
									<li><a href="用户中心-账户管理.html">账户余额</a></li>
									<li><a href="用户中心-消费记录.html">消费记录</a></li>
									<li><a href="#">资金管理</a></li>
								</ul>
							</dd>
						</dl>
						<dl class="accountSideOption1">
							<dt class="transaction_manage">
								<em class="icon_4"></em>分销管理
							</dt>
							<dd>
								<ul>
									<li><a href="#">店铺管理</a></li>
									<li><a href="#">我的盟友</a></li>
									<li><a href="#">我的佣金</a></li>
									<li><a href="#">申请提现</a></li>
								</ul>
							</dd>
						</dl>
					</div>
					<script>
						jQuery(".sideMen").slide({
							titCell : "dt",
							targetCell : "dd",
							trigger : "click",
							defaultIndex : 0,
							effect : "slideDown",
							delayTime : 300,
							returnDefault : true
						});
					</script>
				</div>
			</div>
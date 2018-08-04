<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp" %> 
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="path" value="${pageContext.request.contextPath}/admin"
	scope="application"></c:set>
<c:set var="path_" value="${pageContext.request.contextPath}"
	scope="application"></c:set>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>左侧导航menu</title>
<link href="${path}/css/css.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${path}/js/sdmenu.js"></script>
<script type="text/javascript">
	// <![CDATA[
	var myMenu;
	window.onload = function() {
		myMenu = new SDMenu("my_menu");
		myMenu.init();
	};
	// ]]>
</script>
<style type=text/css>
html{ SCROLLBAR-FACE-COLOR: #538ec6; SCROLLBAR-HIGHLIGHT-COLOR: #dce5f0; SCROLLBAR-SHADOW-COLOR: #2c6daa; SCROLLBAR-3DLIGHT-COLOR: #dce5f0; SCROLLBAR-ARROW-COLOR: #2c6daa;  SCROLLBAR-TRACK-COLOR: #dce5f0;  SCROLLBAR-DARKSHADOW-COLOR: #dce5f0; overflow-x:hidden;}
body{overflow-x:hidden; background:url(${path}/images/main/leftbg.jpg) left top repeat-y #f2f0f5; width:194px;}
</style>
</head>
<body onselectstart="return false;" ondragstart="return false;" oncontextmenu="return false;">
<div id="left-top">
	<div><a href="${path_}/flushPhone.action"><img src="${pageContext.request.contextPath}/upload/admin/${admin.admin_username}/${admin.admin_image}" width="44" height="44" /></a></div>
    <span>用户：${admin.admin_username}<br>角色：管理员</span>
</div>
    <div style="float: left" id="my_menu" class="sdmenu">
      <div class="collapsed">
        <span>系统设置</span>
        <a href="noFunction.html" target="mainFrame" onFocus="this.blur()">后台首页</a>
        <a href="noFunction.html" target="mainFrame" onFocus="this.blur()">列表页</a>
        <a href="noFunction.html" target="mainFrame" onFocus="this.blur()">列表详细页</a>
        <a href="noFunction.html" target="mainFrame" onFocus="this.blur()">留言页</a>
        <a href="noFunction.html" target="mainFrame" onFocus="this.blur()">栏目管理</a>
      </div>
      <div>
        <span>订单管理</span>
        <a href="${path_}/jumpToSearchOrderpage.action" target="mainFrame" onFocus="this.blur()">搜索订单</a>
        <a href="${path_}/showVarietyOrdersInAdmin.action?status=未支付" target="mainFrame" onFocus="this.blur()">未支付订单</a>
        <a href="${path_}/showVarietyOrdersInAdmin.action?status=已支付" target="mainFrame" onFocus="this.blur()">已支付订单</a>
        <a href="${path_}/showVarietyOrdersInAdmin.action?status=已发货" target="mainFrame" onFocus="this.blur()">已发货订单</a>
        <a href="${path_}/showVarietyOrdersInAdmin.action?status=已完成" target="mainFrame" onFocus="this.blur()">已完成订单</a>
        <a href="${path_}/showAllOrdersInAdmin.action" target="mainFrame" onFocus="this.blur()">查看所有订单</a>
      </div>
      <div>
        <span>商品管理</span>
        <a href="${path_}/showFoodList.action" target="mainFrame" onFocus="this.blur()">商品列表</a>
        <a href="${path_}/selectFoodInAdmin.action" target="mainFrame" onFocus="this.blur()">商品搜索</a>
        <a href="${path_}/showHotFoodList.action" target="mainFrame" onFocus="this.blur()">热门商品</a>
        <a href="${path_}/showNewFoodList.action" target="mainFrame" onFocus="this.blur()">最新商品</a> 
        <a href="${path_}/addFood.action" target="mainFrame" onFocus="this.blur()">添加商品</a>
        <a href="${path_}/showFoodType.action" target="mainFrame" onFocus="this.blur()">商品分类</a>
        <a href="${path_}/addFoodType.action" target="mainFrame" onFocus="this.blur()">添加商品类别</a>
      
      </div>
      <div>
        <span>管理员维护</span>
        <a href="${path_}/adminDetail.action" target="mainFrame" onFocus="this.blur()">信息中心</a>
        <a href="${path_}/jumpToUpdateAdminPasswordPag.action" target="mainFrame" onFocus="this.blur()">修改密码</a>
        <a href="${path_}/addAdmin.action" target="mainFrame" onFocus="this.blur()">新增管理员</a>
      </div>
      <div>
        <span>用户管理</span>
        <a href="${path_}/showUserList.action" target="mainFrame" onFocus="this.blur()">查看用户</a>
      </div>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp" %>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="path" value="${pageContext.request.contextPath}/user" scope="application"></c:set>
<c:set var="path_" value="${pageContext.request.contextPath}" scope="application"></c:set>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${path}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${path}/css/style.css" rel="stylesheet" type="text/css" />
<script src="${path}/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${path}/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
<script src="${path}/js/common_js.js" type="text/javascript"></script>
<script src="${path}/js/footer.js" type="text/javascript"></script>
<title>搜索页面</title>
</head>
<body>
<head>
 <div id="header_top">
  <div id="top"></div>
  <div id="header"  class="header page_style">
  <div class="Search">
        <div class="search_list">
            <ul>
                <li class="current"><a href="#">产品</a></li>
            </ul>
        </div>
        <div class="clear search_cur">
	        <form action="searchFoodSubmit.action" method="get">
	           <input name="searchFoodName" id="searchName" class="search_box"  type="text" />
	           <input type="submit" value="搜 索"  class="Search_btn"/>
	        </form>
        </div>
        <div class="clear hotword">
        		热门搜索词：
        		<c:forEach items="${foodNameList}" var="foodName">
        			<a href="searchFoodSubmit.action?searchFoodName=${foodName}">${foodName}</a>&nbsp;&nbsp;&nbsp;
        		</c:forEach>
        </div>
 </div>

</div>
</head>
</body>
</html>

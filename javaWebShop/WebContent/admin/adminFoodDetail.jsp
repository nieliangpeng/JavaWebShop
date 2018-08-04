<%@page import="com.sky.Bean.Food"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>产品详情</title>
<c:set var="path" value="${pageContext.request.contextPath}/admin"
	scope="application"></c:set>
<c:set var="path_" value="${pageContext.request.contextPath}"
	scope="application"></c:set>
<link href="${path_}/user/css/base.css" rel="stylesheet" type="text/css" />
<link href="${path_}/user/css/css.css" rel="stylesheet" type="text/css" />
<link href="${path_}/user/css/style1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${path_}/user/js/jquery-1.8.3.min.js"></script>
<script src="${path_}/user/js/jquery.simpleGal.js"></script>
<script type="text/javascript" src="${path_}/user/js/jquery.imagezoom.min.js"></script>
<style>
img {
	max-width: none;
}
.tb-pic a {
	display: table-cell;
	text-align: center;
	vertical-align: middle;
}
.tb-pic a img {
	vertical-align: middle;
}
.tb-pic a {
*display:block;
*font-family:Arial;
*line-height:1;
}
.tb-thumb {
	margin: 10px 0 0;
	overflow: hidden;
}
.tb-thumb li {
	float: left;
	width: 86px;
	height: 86px;
	overflow: hidden;
	border: 1px solid #cdcdcd;
	margin-right: 5px;
}
.tb-thumb li:hover, .tb-thumb .tb-selected {
	width: 84px;
	height: 84px;
	border: 2px solid #799e0f;
}
.tb-s310, .tb-s310 a {
	height: 365px;
	width: 365px;
}
.tb-s310, .tb-s310 img {
	max-height: 365px;
	max-width: 365px;
}
.tb-booth {
	border: 1px solid #CDCDCD;
	position: relative;
	z-index: 1;
}
div.zoomDiv {
	z-index: 999;
	position: absolute;
	top: 0px;
	left: 0px;
	background: #ffffff;
	border: 1px solid #ccc;
	display: none;
	overflow: hidden;
}
div.zoomMask {
	position: absolute;
	background: url("images/mask.png") repeat;
	cursor: move;
	z-index: 1;
}
<!--弹出隐藏层-->
 .black_overlay {
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 1200px;
	background-color: black;
	z-index: 9999;
	-moz-opacity: 0.4;
	opacity: 0.40;
	filter: alpha(opacity=40);
}
.white_content {
	display: none;
	position: absolute;
	top: 20%;
	left: 40%;
	width: 400px;
	height: 175px;
	border: none;
	background-color: white;
	z-index: 100200;
	overflow: auto;
}
.white_content_small {
	display: none;
	position: absolute;
	top: 20%;
	left: 30%;
	width: 40%;
	height: 50%;
	background-color: white;
	z-index: 1002;
	overflow: auto;
}
.dialogbox {
	padding: 20px;
	line-height: 40px;
}
.addbtn {
	width: 22px;
	height: 22px;
	background: url(images/close2.png) no-repeat;
	margin-right: 5px;
	margin-top: 3px;
	border: none;
	float: right;
}
</style>
<script type="text/javascript">
//弹出隐藏层
function ShowDiv(show_div,bg_div){
document.getElementById(show_div).style.display='block';
document.getElementById(bg_div).style.display='block' ;
var bgdiv = document.getElementById(bg_div);
bgdiv.style.width = document.body.scrollWidth;
// bgdiv.style.height = $(document).height();
$("#"+bg_div).height($(document).height());
};
//关闭弹出层
function CloseDiv(show_div,bg_div)
{
document.getElementById(show_div).style.display='none';
document.getElementById(bg_div).style.display='none';
};

</script>
</head>

<body>
	
	<div class="pro_detail" style="margin: 30px;">
        <div class="pro_detail_img float-lt">
            <div class="gallery">
                <div class="tb-booth tb-pic tb-s310"> <a href="${pageContext.request.contextPath}/upload/food/${food.foodName}/${food.foodImgurl}"><img style="width: 800px;height: 800px;" src="${pageContext.request.contextPath}/upload/food/${food.foodName}/${food.foodImgurl}"  alt="展品细节展示放大镜特效" rel="${pageContext.request.contextPath}/upload/food/${food.foodName}/${food.foodImgurl}" class="jqzoom" /></a> </div>
                <ul class="tb-thumb" id="thumblist">
                    <li >
                        <div><img src="${pageContext.request.contextPath}/upload/food/${food.foodName}/${food.foodImgurl}" style="width: 86px;height: 86px;"/></div>
                    </li>
                   
                </ul>
            </div>
            <script type="text/javascript">
        $(function(){
				$("#h1").toggle(function(){
					$("#h1").css("background-image","url('images/iconfont-xingxingman_add.png')");
				},function(){
					$("#h1").css("background-image","url('images/iconfont-xingxingman_add.png') ");
				})
			}) 

</script>
        </div>
        <div class="float-lt pro_detail_con">
            <div class="pro_detail_tit">${food.foodName}</div>
            <div class="pro_detail_ad">${food.description}</div>
            <div class="pro_detail_score margin-t20">
                <ul>
                    <li class="margin-r20">评分</li>
                </ul>
                <ul>
                    <li style="width:16px; height:16px;"><img src="${path_}/user/images/iconfont-xingxingman.png" width="16" height="16" /></li>
                    <li style="width:16px; height:16px;"><img src="${path_}/user/images/iconfont-xingxingman.png" width="16" height="16" /></li>
                    <li style="width:16px; height:16px;"><img src="${path_}/user/images/iconfont-xingxingman.png" width="16" height="16" /></li>
                    <li style="width:16px; height:16px;"><img src="${path_}/user/images/iconfont-xingxingman.png" width="16" height="16" /></li>
                    <li style="width:16px; height:16px;"><img src="${path_}/user/images/iconfont-xingxingkong.png" width="16" height="16" /></li>
                </ul>
            </div>
            <div class="clear"></div>
            <div class="pro_detail_act margin-t20 fl"><span class="margin-r20">售价</span><span style="font-size:26px; font-weight:bold; color:#dd514c;">￥${food.price}</span></div>
            <div class="clear"></div>
            <div class="act_block margin-t5"><span>本商品可使用9999积分抵用￥9.99元</span></div>
             <div class="pro_detail_score margin-t20">
                <ul>
                    <li class="margin-r20">类别</li>
                </ul>
                <ul>
                    <li style="width:100px; height:30px;color: green;"><font style="font-weight: bold;font-size: 20px;"><%= ((Food)request.getAttribute("food")).getType().getTypeName()%></font></li>
                </ul>
            </div>
          
            <div class="pro_detail_number margin-t20">
                <div class="margin-r20 float-lt">月成交量：<span class="colorred"><strong>${food.buyCount}件</strong></span></div>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
           
            <div class="pro_detail_btn margin-t30">
                <ul>
                    <li class="pro_detail_shop"><a href="${path_}/showFoodList.action">返回商品列表</a></li>
                    <li class="pro_detail_add"><a href="#" onclick="javascript:history.go(-1);">返回</a></li>
                </ul>
            </div>
        </div>
        
    </div>
    <div class="clear"></div>
    <script>
		$(function(){
			$(".pro_tab li").each(function(i){
				$(this).click(function(){
					$(this).addClass("cur").siblings().removeClass("cur");
					$(".conlist .conbox").eq(i).show().siblings().hide();
				})
			})
		})
	</script>
    
<script type="text/javascript">
$(document).ready(function(){

	$(".jqzoom").imagezoom();
	
	$("#thumblist li a").mousemove(function(){
		$(this).parents("li").addClass("tb-selected").siblings().removeClass("tb-selected");
		$(".jqzoom").attr('src',$(this).find("img").attr("mid"));
		$(".jqzoom").attr('rel',$(this).find("img").attr("big"));
	});

});
</script>
</body>
</html>

<%@page import="com.sky.Bean.Food"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>产品详情</title>
<link href="${path}/css/base.css" rel="stylesheet" type="text/css" />
<link href="${path}/css/css.css" rel="stylesheet" type="text/css" />
<link href="${path}/css/style1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${path}/js/jquery-1.8.3.min.js"></script>
<script src="${path}/js/jquery.simpleGal.js"></script>
<script type="text/javascript" src="${path}/js/jquery.imagezoom.min.js"></script>
<link href="${path}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${path}/css/style.css" rel="stylesheet" type="text/css" />
<script src="${path}/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${path}/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
<script src="${path}/js/common_js.js" type="text/javascript"></script>
<script src="${path}/js/footer.js" type="text/javascript"></script>
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
	background: url("${path}/images/mask.png") repeat;
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
	background: url(${path}/images/close2.png) no-repeat;
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
	<script type="text/javascript">
		function sub(){
			var foodBuyCount = document.getElementById("foodBuyCount");
			if(foodBuyCount!=null&&foodBuyCount.value>1){
				foodBuyCount.value-=1;;
			}
		}
		function add(){
			var foodBuyCount = document.getElementById("foodBuyCount");
			if(foodBuyCount!=null){
				foodBuyCount.value =parseInt(foodBuyCount.value)+1;;
			}
		}
		function check(){
			var foodBuyCount=document.getElementById("foodBuyCount");
			if(foodBuyCount!=null&&foodBuyCount.value==""){
				foodBuyCount.value=1;
			}
			if(foodBuyCount!=null&&foodBuyCount.value<=0){
				foodBuyCount.value=1;
			}
		}
	</script>
	<%@include file="header.jsp"%>
	
    <div class="pro_detail" style="margin-left: 80px;margin-top: 30px;">
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
					$("#h1").css("background-image","url('${path}/images/iconfont-xingxingman_add.png')");
				},function(){
					$("#h1").css("background-image","url('${path}/images/iconfont-xingxingman_add.png') ");
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
                    <li style="width:16px; height:16px;"><img src="${path}/images/iconfont-xingxingman.png" width="16" height="16" /></li>
                    <li style="width:16px; height:16px;"><img src="${path}/images/iconfont-xingxingman.png" width="16" height="16" /></li>
                    <li style="width:16px; height:16px;"><img src="${path}/images/iconfont-xingxingman.png" width="16" height="16" /></li>
                    <li style="width:16px; height:16px;"><img src="${path}/images/iconfont-xingxingman.png" width="16" height="16" /></li>
                    <li style="width:16px; height:16px;"><img src="${path}/images/iconfont-xingxingkong.png" width="16" height="16" /></li>
                </ul>
            </div>
            <div class="clear"></div>
            <div class="pro_detail_act margin-t20 fl"><span class="margin-r20">售价</span><span style="font-size:26px; font-weight:bold; color:#dd514c;">￥${food.price}</span></div>
            <div class="clear"></div>
            <div class="act_block margin-t5"><span>本商品可使用9999积分抵用￥9.99元</span></div>
            <!-- 加入购物车 -->
            <form action="${path_}/shopCartActive/addProductToCart.action" method="get">
	            <div class="pro_detail_number margin-t30">
	                <div class="margin-r20 float-lt">数量</div>
	                <div class=""> 
	                    <input type="button" value="-" onclick="sub();"/>
	                   
	                    <input name="foodBuyCount" id="foodBuyCount" type="text" onkeyup="this.value=this.value.replace(/\D/g,'')" value="1" style="width: 30px;text-align: center;" onblur="check();"/>
	                   
	                   
	                    <input type="button" value="+" onclick="add();"/>
	                    <span>&nbsp;件</span>
	                </div>
	                <div class="clear"></div>
	            </div>
	            
	            <div class="pro_detail_score margin-t30">
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
	                    <li class="pro_detail_shop"><a href="#" onclick="javascript:history.go(-1);">返回</a></li>
	                    <li><input type="submit" value="加入购物车" style="font-size: 20px;cursor:pointer ;color: #FFFFFF;height: 42px;width: 175px;background-color: #F37A1D;text-align: center;font-family: "Microsoft YaHei", "微软雅黑";display: block;"/></li>
	                    <input type="hidden" name="foodId" value="${food.id}"/>
	                </ul>
	            </div>
            </form>
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
    <div class="pro_con margin-t55" style="overflow:hidden;margin-left: 80px;">
        <div class="pro_tab">
            <ul>
                <li class="cur">产品介绍</li>
                <li>规格及包装</li>
                <li>评价</a></li>
            </ul>
        </div>
        <div class="conlist" style="padding-left: 20px;">
            <div class="conbox" style="display:block;">${food.description}</div>
            <div class="conbox">暂无</div>
            <div class="conbox">
                <div class="pro_judge">
                    <ul>
                        <li class="cur">
                            <input name="RadioGroup1" type="radio" value="" checked="checked" id="RadioGroup1_0" />
                           	 全部（100）</li>
                        <li>
                            <input name="RadioGroup1" type="radio" value="" id="RadioGroup1_1" />
                           	 好评（80）</li>
                        <li>
                            <input name="RadioGroup1" type="radio" value="" id="RadioGroup1_2" />
                            	中评（10）</li>
                        <li>
                            <input name="RadioGroup1" type="radio" value="" id="RadioGroup1_3" />
                            	差评（10）</li>
                    </ul>
                    <table width="100%" border="0">
                        <tr>
                            <td width="80" align="left"><a href="" rel="${path}/images/01_mid.jpg" class="preview"><img src="${path}/images/01_mid.jpg" width="60" height="60" class="border_gry" /></a></td>
                            <td>茶泡出来颜色很好！味道很清香！非常喜欢！包装也很精致，下次还来买！好评！<br />
                                <br />
                                <span class="pro_judge_time">2014.1.3</span></td>
                            <td>张三</td>
                        </tr>
                        
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="hotpro" style="margin-left: 80px;">
        <div class="hotpro_title" style="">热销产品</div>
        <div class="hotpro_box">
            <div class="pro-view-hot">
	            <c:forEach items="${hotFoodList}" var="food" begin="0" end="5">
	            	<ul>
	                    <li class="pro-img"><a href="${path_}/foodDetailInUser.action?foodId=${food.id}"><img src="${pageContext.request.contextPath}/upload/food/${food.foodName}/${food.foodImgurl}" /></a></li>
	                    <li class="price"><strong>￥ ${food.price}</strong><span>已销售${food.buyCount}</span></li>
	                    <li><a href="${path_}/foodDetailInUser.action?foodId=${food.id}" class="title">${food.foodName}  ${food.description} </a></li>
                	</ul>
	            </c:forEach>
                
               
            </div>
        </div>
    </div>
    
    <div class="helper" style="margin-left: 80px;">
        <div class="mod">
            <div class="mod-wrap">
                <h4><img src="${path}/images/h1.png" width="60" height="60" /><span>新手上路</span> </h4>
            </div>
        </div>
        <div class="mod">
            <div class="mod-wrap">
                <h4><img src="${path}/images/h2.png" width="60" height="60" /><span>如何支付</span> </h4>
            </div>
        </div>
        <div class="mod">
            <div class="mod-wrap">
                <h4><img src="${path}/images/h3.png" width="60" height="60" /><span>配送运输</span> </h4>
            </div>
        </div>
        <div class="mod mod-last">
            <div class="mod-wrap">
                <h4><img src="${path}/images/h4.png" width="60" height="60" /><span>售后服务</span> </h4>
            </div>
        </div>
        <div class="mod mod-last">
            <div class="mod-wrap">
                <h4><img src="${path}/images/h5.png" width="60" height="60" /><span>联系我们</span> </h4>
            </div>
        </div>
    </div>
    
</div>

<div class="clear">&nbsp;</div>


<!--网站地图-->
<%@include file="footer.jsp"%>
<!--网站地图END-->



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

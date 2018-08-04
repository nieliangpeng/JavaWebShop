<%@page import="com.sky.Bean.Food"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp"%>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="path" value="${pageContext.request.contextPath}/user" scope="application"></c:set>
<c:set var="path_" value="${pageContext.request.contextPath}" scope="application"></c:set>
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
<title>修改商品</title>

</head>

<body>
	${updateFoodMsg}
	${updateFoodImgMsg}
	<script type="text/javascript">
		
		function sub() {
			var price = document.getElementById("price");
			var type = document.getElementById("type");
			var description = document.getElementById("description");
			
			if(price.value == "" || price == null) {
				alert("请输入单价");
				price.focus();
				return false;
			} else if (type.value == "0" || type == null) {
				alert("请输入商品类别");
				type.focus();
				return false;
			} else if(description.value =='' || description == null){
				alert("请输入商品描述");
				description.focus();
				return false;
			}
			
			return true;
		}
		function ImgSub() {
			var upimg = document.getElementById("upimg");
			
			if (upimg.value.length==0){
				alert("请选择商品图片");
				
				return false;
			}
			
			return true;
		}
	</script>
	<div class="user_style clearfix">
		<div class="user_center clearfix">
			<div class="right_style" style="float:left;">
				<div class="user_address_style">
					<div class="title_style">
		   			 <em></em>修改商品
					</div>
					<div class="Personal_info" id="Personal">
						<form action="${path_}/updateFoodSubmit.action" method="post"  onsubmit="return sub();">
								
								<ul class="xinxi" style="width: 80%;">
									
								   <li >
								   		<label>商品名称</label> 
								   		<span>
								   			<font style="color: green;">${food.foodName}</font>
									    </span>
								   </li>
									<li>
									 	<label>单价</label> 
									 	<span>
								   			<input style="width: 200px;color: green;" value="${food.price}" name="price1" id="price" type="text" placeholder="输入单价" class="text" disabled="disabled"/>
									    </span>	
									</li>
									
									 <li>
									 	<label>商品类别</label> <span class="time"><font style="color: green;">${food.type.typeName}</font></span>
							           	<div class="add_time" >
							           	  
							              <select name="typeId" id="type" style="color: green;" >
							              	<option value="0">选择类别---</option>
							              	<c:forEach items="${foodTypeList}" var="type1">
												
												<c:if test="${food.type.id==type1.id}">
													<option value="${type1.id}" selected="selected">
														${type1.typeName}
													</option>
												</c:if>
												<c:if test="${food.type.id!=type1.id}">
													<option value="${type1.id}" >
														${type1.typeName}
													</option>
												</c:if>
											</c:forEach>
											
							              </select>
							              
							           	</div>
							         </li>
							         <br/>
							        <br/>
									<table style="text-align: center;">
										<tr>
											<td width="90px;"><font style="font-size: 14px;">商品描述</font></td>
											<td>
												<textarea  rows="5" cols="50" name="description" id="description" style="border-top:#cccccc 1px solid;border-bottom:#cccccc 1px solid; border-left:#cccccc 1px solid; border-right:#cccccc 1px solid;color: green;">${food.description}</textarea>
											</td>
										</tr>
									</table>
									
									
									<div class="bottom">
										<input name="" type="button" value="修改商品" class="modify" />
										<input name="" type="submit" value="确认修改" class="confirm" />
											
									</div>
									<li>
										<input type="hidden" name="id" value="${food.id}">
										<input type="hidden" value="${food.foodName}" name="foodName" />
										<input type="hidden" value="${food.foodImgurl}" name="foodImgurl" />
										<input type="hidden" value="${food.buyCount}" name="buyCount" />
									</li>
								</ul>
							</form>
							<form action="${path_}/updateFoodImgSubmit.action" method="post" enctype="multipart/form-data" onsubmit="return ImgSub();">
								<ul class="Head_portrait"  style="width: 100px;">
								
									<li class="User_avatar"><div class='show' id="show"><img alt="图片" src="${pageContext.request.contextPath}/upload/food/${food.foodName}/${food.foodImgurl}"  width="200px;" height="200px;"/></div></li>
									<li><input type="file" name="phone" id="upimg"  multiple/></li>
									<li><input name="name" type="submit" value="上传商品图片" class="submit" /></li>
									<li><input type="hidden" name="foodId" value="${food.id}" /> </li>
									<li><input type="hidden" name="foodName" value="${food.foodName}" /> </li>
								</ul>
							</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
<script type="text/javascript">
var Upload = (function(){
    var upimg = document.getElementById('upimg');
    var show  = document.getElementById('show');
    

    function init(){
        if(!(window.FileReader && window.File && window.FileList && window.Blob)){
            show.innerHTML = '您的浏览器不支持fileReader';
            upimg.setAttribute('disabled', 'disabled');
            return false;
        }
        handler();
    }

    function handler(){
        upimg.addEventListener('change', function(e){
            var files = this.files;
            if(files.length){
                checkFile(this.files);
            }
        });

        
        show.addEventListener('click', function(e){
            var target = e.target;
            if(target.tagName.toUpperCase()=='IMG'){
                var parent = target.parentNode;
                var big = parent.className.indexOf('big')>=0;
                var item = this.childNodes;
                for(var i=0; i<item.length; i++){
                    item[i].className = 'item';
                    item[i].firstElementChild.style.cssText = '';
                }

                var parent = target.parentNode;
                if(!big){
                    // 点击放大
                    
                    target.style.cssText = 'width:'+target.naturalWidth+'px; height:'+target.naturalHeight+'px;'; // 关键
                    parent.className += ' big';
                }
            }
        }, false)
    }

    function checkFile(files){
        if (files.length != 0) {
            //获取文件并用FileReader进行读取
            var html = '';
            var i = 0, j = show.childElementCount;
            var funcs = function(){
                if(files[i]){
                    var x = parseInt((i+j)/4)*250;
                    var y = ((i+j)%4)*250;
                    var reader = new FileReader();
                    if(!/image\/\w+/.test(files[i].type)){
                        show.innerHTML = "请确保文件为图像类型";
                        return false;
                    }
                    reader.onload = function(e) {
                        html += '<div class="item" style="top:'+x+'px; left:'+y+'px;"><img src="'+e.target.result+'" alt="img" width="200px;" height="200px;"></div>';
                        i++;
                        funcs(); // onload为异步调用
                    };
                    reader.readAsDataURL(files[i]);
                }else{
                    show.innerHTML = html;
                }
            }
            funcs();
        }
    }
    return {
        init : init
    }
})();
Upload.init();

</script>
</script>

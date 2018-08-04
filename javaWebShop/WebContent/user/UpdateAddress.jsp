<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp"%>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html >
<head>
<c:set var="path" value="${pageContext.request.contextPath}/user"
	scope="application"></c:set>
<c:set var="path_" value="${pageContext.request.contextPath}"
	scope="application"></c:set>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<title>修改收货地址</title>
</head>

<body>
<head>

<script>

function checkTelephone() {
	var telephone = document.getElementById("phoneNum");
	var telephone_ = /^\d{11}$/;
	if (phoneNum != null && phoneNum.value != "") {
		if (phoneNum.value.match(telephone_) == null) {
			phoneNum.value = "";
			alert("手机号码格式不对，重新输入");
			phoneNum.focus();
		} 
	}
}
function sub() {
	var username = document.getElementById("username");
	var Provincial = document.getElementById("Provincial");
	var city = document.getElementById("city");
	var counties=document.getElementById("counties");
	var street=document.getElementById("street");
	var mailNum=document.getElementById("mailNum");
	var phoneNum=document.getElementById("phoneNum");
	if (username.value == "" || username == null) {
		alert("收货人不可以为空");
		username.focus();
		return false;
	} else if (Provincial.value == "0" || Provincial == null) {
		alert("请选择'省'");
		Provincial.focus();
		return false;
	} else if (city.value == "0" || city == null) {
		alert("请选择'市'");
		city.focus();
		return false;
	} else if (counties.value == "0" || counties == null) {
		alert("请选择'区/县'");
		counties.focus();
		return false;
	} else if (street.value == "" || street == null) {
		alert("请填写'街道地址'");
		street.focus();
		return false;
	} else if (mailNum.value == "" || mailNum == null) {
		alert("请填写'邮编'");
		mailNum.focus();
		return false;
	} else if (phoneNum.value == "" || phoneNum == null) {
		alert("请填写'手机'");
		phoneNum.focus();
		return false;
	} 
	return true;
}
</script>
 <%@include file="header.jsp"%>
<!--用户中心样式-->
<div class="user_style clearfix">
 <div class="user_center clearfix">
   <%@include file="left.jsp"%>
 <!--右侧样式属性-->
 <div class="right_style">
 <!--地址管理-->
  <div class="user_address_style">
    <div class="title_style"><em></em>修改地址</div> 
   <div class="add_address">
    <span class="name">修改送货地址</span>
    <form action="${path_}/updateReceiveAddressSubmit.action" method="post" onsubmit="return sub();">
    	<table cellpadding="0" cellspacing="0" width="100%">
      		<tr><td class="label_name">收&nbsp;货&nbsp;&nbsp;人：</td><td><input name="username" id="username" value="${updateAddress.username}" type="text"  class="add_text" style=" width:100px"/><i>*</i></td></tr>
     		<tr><td class="label_name">所在地区：</td><td>
     		
            <select name="provincial" id="Provincial">
              <option value="0">省</option>
              <c:forEach items="${provincialList}" var="provincial">
              	<c:if test="${provincial==updateAddress.provincial}">
              		<option value="${provincial}" selected="selected">${provincial}</option>
              	</c:if>
              	<c:if test="${provincial!=updateAddress.provincial}">
              		<option value="${provincial}" >${provincial}</option>
              	</c:if>
              </c:forEach>
             </select>
            <select name="city" id="city">
              <option value="0" selected="selected">市</option>
              <c:forEach items="${cityList}" var="city">
              	<c:if test="${city==updateAddress.city}">
              		<option value="${city}" selected="selected">${city}</option>
              	</c:if>
              	<c:if test="${city!=updateAddress.city}">
              		<option value="${city}" >${city}</option>
              	</c:if>
              </c:forEach>
              
              
            </select>
            <select name="counties" id="counties">
              <option value="0" selected="selected">县/区</option>
              <c:forEach items="${countiesList}" var="counties">
              	<c:if test="${counties==updateAddress.counties}">
              		<option value="${counties}" selected="selected">${counties}</option>
              	</c:if>
              	<c:if test="${counties!=updateAddress.counties}">
              		<option value="${counties}" >${counties}</option>
              	</c:if>
              </c:forEach>
              </select><i>*</i></td></tr>
     		<tr><td class="label_name">街道地址：</td><td><textarea name="street" id="street" cols="" rows="" style=" width:500px; height:100px; margin:5px 0px">${updateAddress.street}</textarea><i>*</i></td></tr>
     		<tr><td class="label_name">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编：</td><td><input name="mailNum" id="mailNum" value="${updateAddress.mailNum}" type="text" class="add_text" style=" width:100px"/><i>*</i></td></tr>
     		<tr><td class="label_name">手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</td><td><input name="phoneNum" id="phoneNum" value="${updateAddress.phoneNum}" type="text" class="add_text" style=" width:200px" onblur="checkTelephone()"/></td></tr>
     		<tr><td colspan="2" class="center"><input name="" type="submit" value="修改"  class="add_dzbtn"/><input name="" type="reset" value="清空"  class="reset_btn"/></td></tr>
    		<input type="hidden" name="addressId" value="${id}"/>
    	</table>
    </form>
    
   </div>

  </div>
 </div>
 </div>
 </div>
    <script>
            $(document).ready(function(){
              $('.moren_dz input').iCheck({
                checkboxClass: 'icheckbox_flat-green',
                radioClass: 'iradio_flat-green'
              });
            });
            </script>
 <!--网站地图-->
<%@include file="footer.jsp"%>
<!--网站地图END-->

</body>
</html>

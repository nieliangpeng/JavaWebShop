<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/taglib.jsp"%>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增管理员</title>
<c:set var="path" value="${pageContext.request.contextPath}/user"
	scope="application"></c:set>
<c:set var="path_" value="${pageContext.request.contextPath}"
	scope="application"></c:set>
<link href="${path}/css/base.css" rel="stylesheet" type="text/css">
<link href="${path}/css/css.css" rel="stylesheet" type="text/css">

<script src="${path}/js/jquery-2.1.1.min.js"></script>
<style>
.tab {
	overflow: hidden;
	margin-top: 20px;
	margin-bottom: -1px;
}

.tab li {
	display: block;
	float: left;
	width: 100px;
	padding: 10px 20px;
	cursor: pointer;
	border: 1px solid #ccc;
}

.tab li.on {
	background: #90B831;
	color: #FFF;
	padding: 10px 20px;
}

.conlist {
	padding: 30px;
	border: 1px solid #ccc;
	width: 500px;
}

.conbox {
	display: none;
}
</style>
<script>

	function sele() {
		if (document.getElementById("terms").checked == false) {
			document.getElementById("zhuce").disabled = "disabled";
		} else {

			document.getElementById("zhuce").disabled = false;
		}
	}
	function checkUsername() {
		var username = document.getElementById("username");
		var username_ = /^[0-9a-zA-Z_]{3,10}$/;
		if (username == null || username.value == "") {
			alert("用户名不可以为空");
			document.getElementById("username_yx").style.display = "none";
			username.focus();
		} else {
			if (username.value.match(username_) == null) {
				username.value = "";
				document.getElementById("username_yx").style.display = "none";
				alert("用户名格式不对，重新输入");
				username.focus();
			} else {
				document.getElementById("username_yx").style.display = "inline";
			}
		}
	}
	function checkRealName() {
		var RealName = document.getElementById("RealName");
		
		if (RealName == null || RealName.value == "") {
			alert("真实姓名不可以为空");
			document.getElementById("RealName_yx").style.display = "none";
			RealName.focus();
		} else {
			document.getElementById("RealName_yx").style.display = "inline";
			
		}
	}
	function checkIdNumber(){
		var IdNumber = document.getElementById("IdNumber");
		
		if (IdNumber == null || IdNumber.value == "") {
			alert("身份证号码不可以为空");
			document.getElementById("IdNumber_yx").style.display = "none";
			RealName.focus();
		} else {
			document.getElementById("IdNumber_yx").style.display = "inline";
			
		}
	}
	function checkPassword() {
		var password = document.getElementById("password");
		var password_ = /^[0-9a-zA-Z_]{3,10}$/;
		if (password == null || password.value == "") {
			alert("密码不可以为空");
			document.getElementById("password_yx").style.display = "none";
			password.focus();
		} else {
			if (password.value.match(password_) == null) {
				password.value = "";
				alert("密码格式不对，重新输入");
				password.focus();
			} else {
				document.getElementById("password_yx").style.display = "inline";
			}
		}
	}
	function checkPasswordAgain() {
		var password = document.getElementById("password");
		
		var r_password = document.getElementById("r_password");
		if (r_password  == null || r_password .value == "") {
			alert("再次输入密码不可以为空");
			document.getElementById("r_password_yx").style.display = "none";
			r_password .focus();
		} else {
			if (r_password.value!=password.value) {
				r_password.value = "";
				alert("两次输入密码不一致，重新输入");
				r_password.focus();
			} else {
				document.getElementById("r_password_yx").style.display = "inline";
			}
		}
	}
	function checkEmail() {
		var email = document.getElementById("email");
		var email_ = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/;
		if (email == null || email.value == "") {
			alert("邮箱不可以为空");
			document.getElementById("email_yx").style.display = "none";
			email.focus();
		} else {
			if (email.value.match(email_) == null) {
				email.value = "";
				document.getElementById("email_yx").style.display = "none";
				alert("邮箱格式不对，重新输入");
				email.focus();
			} else {
				document.getElementById("email_yx").style.display = "inline";
			}
		}
	}
	function checkTelephone() {
		var telephone = document.getElementById("telephone");
		var telephone_ = /^\d{11}$/;
		if (telephone != null && telephone.value != "") {
			if (telephone.value.match(telephone_) == null) {
				telephone.value = "";
				alert("手机号码格式不对，重新输入");
				telephone.focus();
			} else {
				document.getElementById("telephone_yx").style.display = "inline";
			}
		} else{
			document.getElementById("telephone_yx").style.display = "none";
		}
	}
	function checkAddress() {
		var address = document.getElementById("address");
		document.getElementById("address_yx").style.display = "inline";
		if (address != null && address.value != "") {
			document.getElementById("address_yx").style.display = "inline";
		} else{
			document.getElementById("address_yx").style.display = "none";
		}
		
	}
	function sub() {
		var username = document.getElementById("username");
		var RealName = document.getElementById("RealName");
		var IdNumber = document.getElementById("IdNumber");
		var password = document.getElementById("password");
		var email = document.getElementById("email");
		var msg=document.getElementById("msg");
		var E_msg=document.getElementById("E_msg");
		var upimg=document.getElementById("upimg").value;
		if (username.value == "" || username == null) {
			alert("用户名不可以为空");
			username.focus();
			return false;
		} else if(RealName.value==""||RealName ==null){
			alert("真实姓名不可以为空");
			RealName.focus();
			return false;
		}else if(IdNumber.value==""||IdNumber ==null){
			alert("身份证号码不可以为空");
			IdNumber.focus();
			return false;
		}else if(msg.innerText=="该昵称已注册"){
			alert("该昵称已被注册，请换一个昵称");
			username.value="";
			username.focus();
			return false;
		}else if (password.value == "" || password == null) {
			alert("密码不可以为空");
			password.focus();
			return false;
		} else if (email.value == "" || email == null) {
			alert("邮箱不可以为空");
			email.focus();
			return false;
		} else if(E_msg.innerText=="该邮箱已注册"){
			alert("该邮箱已被注册，请换一个邮箱");
			email.value="";
			email.focus();
			return false;
		}else if(upimg.length==0){
			alert("请上传头像");
			
			return false;
		}
		return true;
	}
</script>
</head>

<body class="l-bg">
	
	<div class="l_main2">
		<div class="l_bttitle">
			<h2>新增</h2>
		</div>
		<div class="loginbox">
			<div class="tab">
				<ul>
					<li class="on">新增管理员</li>
					
				</ul>
			</div>
			<div class="conlist">
				<div class="conbox" style="display: block; text-align: left;">
					<form name="register" action="${path_}/saveAdmin.action"  method="post" enctype="multipart/form-data" onsubmit="return sub();">
						<table>
							<tr>
								<td><label><strong><font color="red">*</font>用户名:</strong></label></td>
								<td><input type="text" name="admin_username" id="username"
									placeholder=" 3-10位   数字/字母/下划线"  onchange="checkUsername()"/></td>
								<td><div id="username_yx" style="margin-left: 10px;display: none">
									   <span id="msg"><font color="green">允许</font></span>
									</div>
								</td>
							</tr>
							<tr>
								<td><label><strong><font color="red">*</font>真实姓名:</strong></label></td>
								<td><input type="text" name="RealName" id="RealName"
									placeholder="输入真实姓名"  onchange="checkRealName()"/></td>
								<td><div id="RealName_yx" style="margin-left: 10px;display: none">
									   <font color="green">ok</font>
									</div>
								</td>
							</tr>
							<tr>
								<td><label><strong><font color="red">*</font>身份证号码:</strong></label></td>
								<td><input type="text" name="IdNumber" id="IdNumber"
									placeholder="输入有效身份证号码"  onchange="checkIdNumber()"/></td>
								<td><div id="IdNumber_yx" style="margin-left: 10px;display: none">
									  <font color="green">ok</font>
									</div>
								</td>
							</tr>
							<tr>
								<td><label><strong><font color="red">*</font>密码:</strong></label>
								</td>
								<td><input type="password" name="admin_passwd" id="password"
									placeholder=" 3-10位   数字/字母/下划线" onchange="checkPassword()" /></td>
								<td><div id="password_yx"
										style="margin-left: 10px; display: none">
										<font color="green">允许</font>
									</div></td>
							</tr>
							<tr>
								<td><label><strong><font color="red">*</font>再次输入密码:</strong></label>
								</td>
								<td><input type="password" name="r_password" id="r_password"
									placeholder=" 3-10位   数字/字母/下划线" onchange="checkPasswordAgain()" /></td>
								<td><div id="r_password_yx"
										style="margin-left: 10px; display: none">
										<font color="green">密码正确</font>
									</div></td>
							</tr>
							<tr>
								<td><label><strong><font color="red">*</font>邮箱：</strong></label></td>
								<td><input type="email" name="admin_email" id="email"
									placeholder=" 输入有效的邮箱" onchange="checkEmail()" /></td>
								<td><div id="email_yx"
										style="margin-left: 10px; display: none">
										<span id="E_msg"><font color="green">允许</font></span>
									</div></td>
							</tr>
							<tr>
								<td><label><strong>手机号码:</strong></label></td>
								<td><input type="text" name="telephone" id="telephone"
									placeholder=" 输入有效的手机号码" onchange="checkTelephone()" /></td>
								<td><div id="telephone_yx"
										style="margin-left: 10px; display: none">
										<font color="green">允许</font>
									</div></td>
							</tr>
							<tr>
								<td><label class="contact"><strong>家庭地址:</strong></label></td>
								<td><input type="text" class="contact_input" name="address"
									id="address" placeholder=" 输入有效的地址" onchange="checkAddress()" /></td>
								<td><div id="address_yx"
										style="margin-left: 10px; display: none">
										<font color="green">允许 
									</div></td>
							</tr>
						</table>
						<table>
							<tr>
								<td style="width: 80px;"> 
									<strong style="text-align: center;"><font
											color="red">*</font>头像:</strong></label>
								</td>
								
								<td> <div class='show' id="show"><img alt="头像" src="##" width="100px;" height="120px;"/></div></td>
								<td> <div class='upload_box'> <input type="file" name="phone" id="upimg" multiple/></div></td>
							</tr>
							<tr><td colspan="3">(标<font color="red">*</font>的为必填项)</td></tr>
						</table><br/>
						<input type="checkbox" name="terms" id="terms" onchange="sele()" /> 阅读并同意 <a href="#">条款 &amp;条件</a><br/><br/>
                        <input type="submit" id="zhuce" disabled="disabled" class="register" value="增加" />
                 </form>
				</div>

			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
//邮箱AJAX
window.onload=function()
{
  var nameElement=document.getElementsByName("admin_username")[0];
  var emailElement=document.getElementsByName("admin_email")[0];
  //为昵称选项注册onblur事件
  emailElement.onblur=function()
  {
    var email=this.value;
    //1.获取XMLHttpRequest对象
    var req=getXMLHttpRequest();
    //4.处理响应结果
    req.onreadystatechange=function(){
      if(req.readyState==4){//XMLHttpRequest对象读取成功
    	 
        if(req.status==200){//服务器相应正常
        	
          var msg=document.getElementById("E_msg");
          //根据返回的结果显示不同的信息
          if(req.responseText=="true"){
            msg.innerHTML="<font color='red'>该邮箱已注册</font>";
          }else if(req.responseText=="kong"){
        	  msg.innerHTML="";
          }else{
            msg.innerHTML="<font color='green'>可以使用</font>";
          }
        }
      }
    }
  
    //2.建立一个连接
    req.open("get","${pageContext.request.contextPath}/checkAdminEmail.action?email="+email);
    //3.发送get请求
    req.send(null);
  }
//为昵称选项注册onblur事件
  nameElement.onblur=function()
  {
    var name=this.value;
    //1.获取XMLHttpRequest对象
    var req=getXMLHttpRequest();
    //4.处理响应结果
    req.onreadystatechange=function(){
      if(req.readyState==4){//XMLHttpRequest对象读取成功
    	 
        if(req.status==200){//服务器相应正常
        	
          var msg=document.getElementById("msg");
          //根据返回的结果显示不同的信息
          if(req.responseText=="true"){
            msg.innerHTML="<font color='red'>该昵称已注册</font>";
          }else if(req.responseText=="kong"){
        	  msg.innerHTML="";
          }else{
            msg.innerHTML="<font color='green'>可以使用</font>";
          }
        }
      }
    }
  
    //2.建立一个连接
    req.open("get","${pageContext.request.contextPath}/checkAdminUsername.action?name="+name);
    //3.发送get请求
    req.send(null);
  }
}
function getXMLHttpRequest(){
	  var xmlhttp;
	    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
	      xmlhttp = new XMLHttpRequest();
	    } else {// code for IE6, IE5
	      xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	    }
	    return xmlhttp;
}





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
                        html += '<div class="item" style="top:'+x+'px; left:'+y+'px;"><img src="'+e.target.result+'" alt="img" width="80px;" height="100px;"></div>';
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
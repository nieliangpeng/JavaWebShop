<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page errorPage="../common/UserError.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>更新类别</title>


<style>  
 .mytxt {
    color:#333;
    line-height:normal;
    font-family:"Microsoft YaHei",Tahoma,Verdana,SimSun;
    font-style:normal;
    font-variant:normal;
    font-size-adjust:none;
    font-stretch:normal;
    font-weight:normal;
    margin-top:0px;
    margin-bottom:0px;
    margin-left:0px;
    padding-top:4px;
    padding-right:4px;
    padding-bottom:4px;
    padding-left:4px;
    font-size:15px;
    outline-width:medium;
    outline-style:none;
    outline-color:invert;
    border-top-left-radius:3px;
    border-top-right-radius:3px;
    border-bottom-left-radius:3px;
    border-bottom-right-radius:3px;
    text-shadow:0px 1px 2px #fff;
    background-attachment:scroll;
    background-repeat:repeat-x;
    background-position-x:left;
    background-position-y:top;
    background-size:auto;
    background-origin:padding-box;
    background-clip:border-box;
    background-color:rgb(255,255,255);
    margin-right:8px;
    border-top-color:#ccc;
    border-right-color:#ccc;
    border-bottom-color:#ccc;
    border-left-color:#ccc;
    border-top-width:1px;
    border-right-width:1px;
    border-bottom-width:1px;
    border-left-width:1px;
    border-top-style:solid;
    border-right-style:solid;
    border-bottom-style:solid;
    border-left-style:solid;
}
.mytxt:focus {
     border: 1px solid #fafafa;
    -webkit-box-shadow: 0px 0px 6px #007eff;
     -moz-box-shadow: 0px 0px 5px #007eff;
     box-shadow: 0px 0px 5px #007eff;   
    
}

  </style>  
 </head>  
 <body>  
${updateFoodTypeMsg}
<script type="text/javascript"></script>
 <font color="green" style="font-size: 34px;font-weight:bolder;">更新类别</font><br/><br/>
 <form action="${path_}/updateFoodTypeSubmit.action" method="get" >
 	<input type="hidden" name="foodId" value="${foodTypeId}"/>
 	<input type="hidden" name="typeName" value="${foodTypeName}"/>
 	<input type="text"  class="mytxt" name="foodTypeName" value="${foodTypeName}" placeholder="输入类别" />  
 	<br/><br/>
 	<input type="submit" value="更新" style="background-color: green;width: 100px;height:30px; color: white;font-weight: bold;border-radius: 6px;"/>
 </form>
 
 
 </body>  
</html>  

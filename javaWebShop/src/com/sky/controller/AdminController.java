package com.sky.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sky.Bean.Address;
import com.sky.Bean.Admin;
import com.sky.Bean.Food;
import com.sky.Bean.FoodType;
import com.sky.Bean.Orders;
import com.sky.Bean.Person;
import com.sky.Bean.Users;
import com.sky.common.Page;
import com.sky.common.SendEmail;
import com.sky.service.AdminService;

@Controller
public class AdminController {
	@Autowired
	private AdminService adminService;
	
	public AdminService getAdminService() {
		return adminService;
	}

	public void setAdminService(AdminService adminService) {
		this.adminService = adminService;
	}

	@RequestMapping("/adminLoginSubmit")
	public String adminLoginSubmit(Model model,String AdminEmail,String AdminPassword,String AdminVerf,HttpServletRequest request) {
		if(adminService.checkVerf(AdminVerf, request)) {
			Admin admin=adminService.findLoginAdmin(AdminEmail,AdminPassword);
			if(admin!=null) {
				if(admin.getStatus()!=0) {
					HttpSession session=request.getSession();
					session.setAttribute("admin", admin);
					return "adminIndex";
				}else {
					model.addAttribute("AdminErrorMsg","该卖家账号未激活，请到邮箱中激活再登录！");
					return "adminInUserLogin";
				}
				
			}else {
				model.addAttribute("AdminErrorMsg","管理员用户名或者密码不正确，请重新登录");
				return "adminInUserLogin";
			}
		}else {
			model.addAttribute("AdminEmail",AdminEmail);
			model.addAttribute("AdminPassword",AdminPassword);
			model.addAttribute("AdminErrorMsg","验证码错误，重新输入");
			return "adminInUserLogin";
		}
	}
	@RequestMapping("/adminLoginSubmitInManager")
	public String adminLoginSubmitInManager(Model model,String autoLogin,String AdminEmail,String AdminPassword,String AdminVerf,HttpServletRequest request,HttpServletResponse response) {
		if(adminService.checkVerf(AdminVerf, request)) {
			Admin admin=adminService.findLoginAdmin(AdminEmail,AdminPassword);
			if(admin!=null) {
				if(admin.getStatus()!=0) {
					HttpSession session=request.getSession();
					session.setAttribute("admin", admin);
					if(autoLogin != null && autoLogin.equals("on")) {
						
						session.setMaxInactiveInterval(60*60*24*7);//秒
						
						Cookie cookie=new Cookie("JSESSIONID", session.getId());
						cookie.setMaxAge(60*60*24*7);
						response.addCookie(cookie);//更新
					}
					return "adminIndex";
				}else {
					model.addAttribute("AdminErrorMsg","该卖家账号未激活，请到邮箱中激活再登录！");
					return "adminLogin";
				}
				
			}else {
				model.addAttribute("AdminErrorMsg","管理员用户名或者密码不正确，请重新登录");
				return "adminLogin";
			}
		}else {
			model.addAttribute("AdminEmail",AdminEmail);
			model.addAttribute("AdminPassword",AdminPassword);
			model.addAttribute("AdminErrorMsg","验证码错误，重新输入");
			return "adminLogin";
		}
	}
	@RequestMapping("/adminLoginOut")
	public String adminLoginOut(Model model,HttpServletRequest request) {
		boolean bool=adminService.adminLoginOut(request);
		if(bool) {
			model.addAttribute("LoginOutMsg","<script>alert('退出登录成功');</script>");
			return "adminLogin";
		}
		model.addAttribute("LoginOutMsg","<script>alert('退出登录失败');</script>");
		return "adminIndex";
		
	}
	@RequestMapping("/addAdmin")
	public String addAdmin() {
		return "adminAdd";
	}
	//ajax
	@RequestMapping("/checkAdminUsername")
	public void checkAdminUsername(@RequestParam String name,HttpServletResponse response) throws IOException {
		 PrintWriter pw=response.getWriter();
		 if(name.equals("")) {
			 pw.print("kong");
		 }else if(adminService.findAdminUsername(name)){
			 
		      pw.print(true);
		 }else{
		      pw.print(false);
		 }
    }
	@RequestMapping("/checkAdminEmail")
	public void checkAdminEmail(@RequestParam String email,HttpServletResponse response) throws IOException {
		 PrintWriter pw=response.getWriter();
		 if(email.equals("")) {
			 pw.print("kong");
		 }else if(adminService.findAdminEmail(email)){
			 
		      pw.print(true);
		 }else{
		      pw.print(false);
		 }
    }
	@RequestMapping("/saveAdmin")
	public String saveAdmin(Model model,HttpServletRequest request,Admin admin,Person person,@RequestParam MultipartFile phone) throws IOException {
		admin.setAdmin_image(phone.getOriginalFilename());
		admin.setPerson(person);
		person.setAdmin(admin);
		
		boolean bool= adminService.saveAdmin(admin,phone,request);
		
		if(bool) {
			model.addAttribute("email",admin.getAdmin_email());
			model.addAttribute("adminMsg1","添加管理员成功，已发激活码到注册邮箱，请在48小时内到邮箱点击激活账号！");
			
		}else {
			model.addAttribute("adminMsg2","添加失败,请重新添加");
		}
		return "adminComplete_Add";
	}
	@RequestMapping("/AdminActivate")
	public String activate(Model model,String email,String validateCode){
		String msg=adminService.activate(email,validateCode);
		if(msg.contains("允许成功")||msg.contains("可以登录")) {
			model.addAttribute("adminMsg1",msg);
		}else if(msg.contains("激活码不正确")||msg.contains("重新注册")||msg.contains("该邮箱未注册")){
			model.addAttribute("adminMsg2",msg);
		}
		
		return "adminActivate";
	}
	@RequestMapping("/WatchAdminStatus")
	public String WatchAdminStatus(String email,Model model) {
		int status=adminService.WatchAdminStatus(email);
		if(status==1) {
			model.addAttribute("email",email);
			model.addAttribute("adminMsg3","该管理员账号邮箱激活成功,允许登录~");
		}else {
			model.addAttribute("email",email);
			model.addAttribute("adminMsg4","该管理员账号邮箱未激活");
		}
		return "adminActivate";
	}
	@RequestMapping("/adminDetail")
	public String adminDetail() {
		return "adminDetail";
	}
	//更新
	@RequestMapping("/updateAdmin")
	public String updateUser(HttpServletRequest request,String AdminUsername,String telephone,String address) {
		HttpSession session=request.getSession();
		
		boolean bool=adminService.updateAdmin(AdminUsername,telephone,address) ;
		if(bool) {
			Admin admin=adminService.findLoginAdminByName(AdminUsername);
			session.setAttribute("admin", admin);
			request.setAttribute("updateAdminMsg","<script>alert('修改信息成功');</script>");
			return "adminDetail";
		}
		request.setAttribute("updateAdminMsg","<script>alert('修改信息失败');</script>");
		return "adminDetail";
	}
	
	@RequestMapping("/updateAdminPhone")
	public String updateAdminPhone(HttpServletRequest request,String AdminUsername,@RequestParam MultipartFile phone) throws IOException {
		HttpSession session=request.getSession();
		boolean bool=adminService.updateAdminPhone(request,AdminUsername,phone);
		if(bool) {
			Admin admin=adminService.findLoginAdminByName(AdminUsername);
			session.setAttribute("admin", admin);
			request.setAttribute("updateAdminMsg","<script>alert('上传图片成功,点击左侧头像可以刷新头像');</script>");
			return "adminDetail";
		}else {
			request.setAttribute("updateAdminMsg","<script>alert('上传图片失败');</script>");
			return "adminDetail";
		}
		
	}
	@RequestMapping("/flushPhone")
	public String flushPhone() {
		return "adminMain_left";
		
	}
	@RequestMapping("/jumpToUpdateAdminPasswordPag")
	public String updateAdminPassword() {
		return "adminUpdatePwd";
	}
	//更新密码
	@RequestMapping("/updateAdminPassword")
	public String updateAdminPassword(HttpServletRequest request,String username,String newPassword) {
		HttpSession session=request.getSession();
		boolean bool=adminService.updateAdminPassword(username,newPassword);
		if(bool) {
			Admin admin=adminService.findLoginAdminByName(username);
			session.setAttribute("admin", admin);
			request.setAttribute("updateAdminPwd","<script>alert('更新密码成功');</script>");
			return "adminUpdatePwd";
		}else {
			request.setAttribute("updateAdminPwd","<script>alert('更新密码失败');</script>");
			return "adminUpdatePwd";
		}
	}
	
	
	//查看用户列表
	@RequestMapping("/showUserList")
	public String showUserList(HttpServletRequest request,String pageNum) {
		Object [] object=adminService.showUserList(pageNum);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("UserList",(List<Users>)object[1]);
		return "adminShowUser";
	}
	//删除
	@RequestMapping("/removeUser")
	public String removeUser(HttpServletRequest request,String id) {
		boolean bool=adminService.removeUser(id);
		if(bool) {
			String removeMsg=" 成功删除ID为"+id+"的用户 ";
			request.setAttribute("removeMsg","<script>alert('"+removeMsg+"');</script>");
		
			Object [] object=adminService.showUserList("1");
			request.setAttribute("pageCount", (Page)object[0]);
			request.setAttribute("UserList",(List<Users>)object[1]);
			return "adminShowUser";
		}
		String removeMsg="删除ID为"+id+"的用户失败,请重新操作";
		request.setAttribute("removeMsg","<script>alert('"+removeMsg+"');</script>");
		Object [] object=adminService.showUserList("1");
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("UserList",(List<Users>)object[1]);
		return "adminShowUser";
	}
	
	@RequestMapping("/addFoodType")
	public String addFoodType() {
		
		return "adminAddFoodType";
	}
	//查看商品类别
	@RequestMapping("/showFoodType")
	public String showFoodType(HttpServletRequest request) {
		List<FoodType> foodTypeList=adminService.findFoodType();
		//System.out.print(foodTypeList.get(0).getTypeName());
		request.setAttribute("foodTypeList",foodTypeList );
		return "adminFoodTypeList";
	}
	
	//添加类别
	@RequestMapping("/addFoodTypeSubmit")
	public String addFoodTypeSubmit(String foodTypeName,HttpServletRequest request) {
		boolean bool=adminService.addFoodType(foodTypeName);
		if(bool) {
			List<FoodType> foodTypeList=adminService.findFoodType();
			request.setAttribute("foodTypeList",foodTypeList );
			request.setAttribute("AddTypeMsg", "<script>alert('添加成功');</script>");
			return "adminFoodTypeList";
		}else {
			request.setAttribute("AddTypeMsg", "<script>alert('添加失败，重新添加！');</script>");
			return "adminAddFoodType";
		}
	}
	//删除类别
	@RequestMapping("/deleteFoodType")
	public String deleteFoodType(String foodTypeId,String foodTypeName,HttpServletRequest request) {
		boolean bool=adminService.deleteFoodType(Integer.parseInt(foodTypeId));
		if(bool) {
			String deleteMsg=" 成功删除 "+foodTypeName;
			request.setAttribute("deleteTypeMsg","<script>alert('"+deleteMsg+"');</script>");
			
		}else {
			String deleteMsg=" 删除 "+foodTypeName+"失败";
			request.setAttribute("deleteTypeMsg","<script>alert('"+deleteMsg+"');</script>");
		}
		List<FoodType> foodTypeList=adminService.findFoodType();
		request.setAttribute("foodTypeList",foodTypeList );
		return "adminFoodTypeList";
	}
	//跳转到类别更新页面
	@RequestMapping("/updateFoodType")
	public String updateFoodType(String foodTypeId,String foodTypeName,Model model) {
		model.addAttribute("foodTypeId",foodTypeId);
		model.addAttribute("foodTypeName",foodTypeName);
		return "adminUpdateFoodType";
	}
	//更新类别
	@RequestMapping("/updateFoodTypeSubmit")
	public String updateFoodTypeSubmit(String foodId,String typeName,String foodTypeName,Model model,HttpServletRequest request) {
		boolean bool=adminService.updateFoodType(Integer.parseInt(foodId), foodTypeName);
		if(bool) {
			model.addAttribute("updateFoodTypeMsg","<script>alert('更新类别成功');</script>");
			List<FoodType> foodTypeList=adminService.findFoodType();
			request.setAttribute("foodTypeList",foodTypeList );
			return "adminFoodTypeList";
		}else {
			//回到最原始更新状态
			model.addAttribute("foodTypeId",foodId);
			model.addAttribute("foodTypeName",typeName);
			model.addAttribute("updateFoodTypeMsg","<script>alert('更新类别失败,请重新更新！');</script>");
			return "adminUpdateFoodType";
		}
		
	}
	//展示商品列表
	@RequestMapping("/showFoodList")
	public String showFoodList(HttpServletRequest request,String pageNum) {
		Object [] object=adminService.showFoodList(pageNum);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("foodList",(List<Food>)object[1]);
		return "adminShowFood";
	}
	//添加商品
	@RequestMapping("/addFood")
	public String addFood(Model model) {
		List<FoodType> foodTypeList=adminService.findFoodType();
		model.addAttribute("foodTypeList",foodTypeList);
		return "adminAddFoodPage";
	}
	@RequestMapping("/addFoodSubmit")
	public String addFoodSubmit(Food food,String price1,String typeId,@RequestParam MultipartFile phone,HttpServletRequest request,String pageNum,Model model) throws IOException {
		food.setPrice(Double.parseDouble(price1));
		food.setBuyCount(0);
		boolean bool= adminService.addFood(typeId,food,phone,request);
		if(bool) {
			request.setAttribute("AddFoodMsg","<script>alert('插入商品成功');</script>");
			Object [] object=adminService.showFoodList(pageNum);
			request.setAttribute("pageCount", (Page)object[0]);
			request.setAttribute("foodList",(List<Food>)object[1]);
			return "adminShowFood";
		}else {
			request.setAttribute("AddFoodMsg","<script>alert('插入商品失败,重新输入信息进行插入！');</script>");
			List<FoodType> foodTypeList=adminService.findFoodType();
			model.addAttribute("foodTypeList",foodTypeList);
			return "adminAddFoodPage";
		}
	}
	//删除商品
	@RequestMapping("/removeFood")
	public String removeFood(String id,String foodName,HttpServletRequest request,String pageNum) {
		boolean bool=adminService.removeFood(id);
		if(bool) {
			String deleteFoodMsg=" 成功删除 商品："+foodName;
			request.setAttribute("deleteFoodMsg","<script>alert('"+deleteFoodMsg+"');</script>");
		}else {
			String deleteFoodMsg=" 删除商品 ："+foodName+"失败";
			request.setAttribute("deleteFoodMsg","<script>alert('"+deleteFoodMsg+"');</script>");
		}
		Object [] object=adminService.showFoodList(pageNum);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("foodList",(List<Food>)object[1]);
		return "adminShowFood";
	}
	//商品详细
	@RequestMapping("/foodDetail")
	public String foodDetail(String id,Model model,HttpServletRequest request,String pageNum) {
		Food food=adminService.findFoodById(Integer.parseInt(id));
		if(food!=null) {
			model.addAttribute("food",food);
			return "adminFoodDetail";
		}
		model.addAttribute("foodDetailMsg","查询商品详情出现错误");
		Object [] object=adminService.showFoodList(pageNum);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("foodList",(List<Food>)object[1]);
		return "adminShowFood";
	}
		
	//跳转到修改商品页面
	@RequestMapping("/updateFood")
	public String jumpToUpdateFoodPage(String id,HttpServletRequest request) {
		Food food=adminService.findFoodById(Integer.parseInt(id));
		request.setAttribute("food",food);
		List<FoodType> foodTypeList=adminService.findFoodType();
		//System.out.print(foodTypeList.get(0).getTypeName());
		request.setAttribute("foodTypeList",foodTypeList );
		return "adminUpdateFoodPage";
	}
	
	//修改商品信息
	@RequestMapping("/updateFoodSubmit")
	public String updateFoodSubmit(Food food,String price1,String typeId,HttpServletRequest request) throws IOException {
		food.setPrice(Double.parseDouble(price1));
		food.setAddFoodTime(new Date());
		boolean bool=adminService.updateFood(food,typeId);
		if(bool) {
			request.setAttribute("updateFoodMsg", "<script>alert('更新商品信息成功');</script>");
		}else {
			request.setAttribute("updateFoodMsg", "<script>alert('更新商品信息失败');</script>");
		}
		Food f=adminService.findFoodById(food.getId());
		
		request.setAttribute("food",f);
		List<FoodType> foodTypeList=adminService.findFoodType();
		request.setAttribute("foodTypeList",foodTypeList );
		return "adminUpdateFoodPage";
	}
	//变更商品图片
	@RequestMapping("/updateFoodImgSubmit")
	public String updateFoodImgSubmit(HttpServletRequest request,String foodId,String foodName,@RequestParam MultipartFile phone) throws IOException {
		boolean bool=adminService.updateFoodImg(request,foodId,foodName,phone);
		if(bool) {
			request.setAttribute("updateFoodImgMsg", "<script>alert('更新商品图片成功');</script>");
		}else {
			request.setAttribute("updateFoodImgMsg", "<script>alert('更新商品图片失败');</script>");
		}
		Food f=adminService.findFoodById(Integer.parseInt(foodId));
		request.setAttribute("food",f);
		List<FoodType> foodTypeList=adminService.findFoodType();
		request.setAttribute("foodTypeList",foodTypeList );
		return "adminUpdateFoodPage";
		
	}
	//查询类别对应的商品
	@RequestMapping("/selectFoodByTypeInAdmin")
	public String selectFoodByTypeInAdmin(HttpServletRequest request,String foodTypeId,String pageNum) {
		Object [] object=adminService.selectFoodByTypeInAdmin(pageNum,foodTypeId);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("foodList",(List<Food>)object[1]);
		request.setAttribute("foodTypeId",foodTypeId);
		return "adminShowFoodbyType";
	}
	//商品详细1
	@RequestMapping("/foodDetailByType")
	public String foodDetailByType(String id,String foodTypeId,Model model,HttpServletRequest request,String pageNum) {
		Food food=adminService.findFoodById(Integer.parseInt(id));
		if(food!=null) {
			model.addAttribute("food",food);
			return "adminFoodDetail";
		}
		model.addAttribute("foodDetailMsg","查询商品详情出现错误");
		//回到
		Object [] object=adminService.selectFoodByTypeInAdmin(pageNum,foodTypeId);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("foodList",(List<Food>)object[1]);
		request.setAttribute("foodTypeId",foodTypeId);
		return "adminShowFoodbyType";
	}	
	//删除商品
	@RequestMapping("/removeFoodByType")
	public String removeFoodByType(String id,String foodName,HttpServletRequest request,String pageNum,String foodTypeId) {
		boolean bool=adminService.removeFood(id);
		if(bool) {
			String deleteFoodMsg=" 成功删除 商品："+foodName;
			request.setAttribute("deleteFoodMsg","<script>alert('"+deleteFoodMsg+"');</script>");
		}else {
			String deleteFoodMsg=" 删除商品 ："+foodName+"失败";
			request.setAttribute("deleteFoodMsg","<script>alert('"+deleteFoodMsg+"');</script>");
		}
		Object [] object=adminService.selectFoodByTypeInAdmin(pageNum,foodTypeId);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("foodList",(List<Food>)object[1]);
		request.setAttribute("foodTypeId",foodTypeId);
		return "adminShowFoodbyType";
	}	
	//热门商品
	@RequestMapping("/showHotFoodList")
	public String showHotFoodList(String pageNum,HttpServletRequest request) {
		Object [] object=adminService.showHotFoodList(pageNum);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("foodList",(List<Food>)object[1]);
		return "adminShowHotFood";
	}
	@RequestMapping("/hotFoodDetail")
	public String hotFoodDetail(String id,Model model,HttpServletRequest request,String pageNum) {
		Food food=adminService.findFoodById(Integer.parseInt(id));
		if(food!=null) {
			model.addAttribute("food",food);
			return "adminFoodDetail";
		}
		model.addAttribute("hotFoodDetailMsg","查询商品详情出现错误");
		Object [] object=adminService.showHotFoodList(pageNum);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("foodList",(List<Food>)object[1]);
		return "adminShowHotFood";
	}
	@RequestMapping("/removeHotFood")
	public String removeHotFood(String id,String foodName,HttpServletRequest request,String pageNum) {
		boolean bool=adminService.removeFood(id);
		if(bool) {
			String deleteFoodMsg=" 成功删除 商品："+foodName;
			request.setAttribute("deleteHotFoodMsg","<script>alert('"+deleteFoodMsg+"');</script>");
		}else {
			String deleteFoodMsg=" 删除商品 ："+foodName+"失败";
			request.setAttribute("deleteHotFoodMsg","<script>alert('"+deleteFoodMsg+"');</script>");
		}
		Object [] object=adminService.showHotFoodList(pageNum);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("foodList",(List<Food>)object[1]);
		return "adminShowHotFood";
	}	
	//最新商品
	@RequestMapping("/showNewFoodList")
	public String showNewFoodList(String pageNum,HttpServletRequest request) {
		Object [] object=adminService.showNewFoodList(pageNum);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("foodList",(List<Food>)object[1]);
		return "adminShowNewFood";
	}
	@RequestMapping("/newFoodDetail")
	public String newFoodDetail(String id,Model model,HttpServletRequest request,String pageNum) {
		Food food=adminService.findFoodById(Integer.parseInt(id));
		if(food!=null) {
			model.addAttribute("food",food);
			return "adminFoodDetail";
		}
		model.addAttribute("newFoodDetailMsg","查询商品详情出现错误");
		Object [] object=adminService.showNewFoodList(pageNum);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("foodList",(List<Food>)object[1]);
		return "adminShowNewFood";
	}
	@RequestMapping("/removeNewFood")
	public String removeNewFood(String id,String foodName,HttpServletRequest request,String pageNum) {
		boolean bool=adminService.removeFood(id);
		if(bool) {
			String deleteFoodMsg=" 成功删除 商品："+foodName;
			request.setAttribute("deleteNewFoodMsg","<script>alert('"+deleteFoodMsg+"');</script>");
		}else {
			String deleteFoodMsg=" 删除商品 ："+foodName+"失败";
			request.setAttribute("deleteNewFoodMsg","<script>alert('"+deleteFoodMsg+"');</script>");
		}
		Object [] object=adminService.showNewFoodList(pageNum);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("foodList",(List<Food>)object[1]);
		return "adminShowNewFood";
	}	
	//搜索商品
	@RequestMapping("/selectFoodInAdmin")
	public String selectFoodInAdmin(HttpServletRequest request) {
		List<String> list=adminService.showHotFoodFontList();
		request.setAttribute("foodNameList", list);
		return "adminSelectFood";
	}
	@RequestMapping("/searchFoodSubmit")
	public String searchFoodSubmit(String searchFoodName,String pageNum,HttpServletRequest request) {
		Object [] object=adminService.searchFoodSubmit(pageNum,searchFoodName);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("foodList",(List<Food>)object[1]);
		request.setAttribute("searchFoodName", searchFoodName);
		return "adminShowSearchFood";
	}
	@RequestMapping("/searchFoodDetail")
	public String searchFoodDetail(String id,String searchFoodName,Model model,HttpServletRequest request,String pageNum) {
		Food food=adminService.findFoodById(Integer.parseInt(id));
		if(food!=null) {
			model.addAttribute("food",food);
			return "adminFoodDetail";
		}
		model.addAttribute("searchFoodDetailMsg","查询商品详情出现错误");
		Object [] object=adminService.searchFoodSubmit(pageNum,searchFoodName);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("foodList",(List<Food>)object[1]);
		request.setAttribute("searchFoodName", searchFoodName);
		return "adminShowSearchFood";
	}
	@RequestMapping("/removeSearchFood")
	public String removeSearchFood(String id,String foodName,String searchFoodName,HttpServletRequest request,String pageNum) {
		boolean bool=adminService.removeFood(id);
		if(bool) {
			String deleteFoodMsg=" 成功删除 商品："+foodName;
			request.setAttribute("deleteSearchFoodMsg","<script>alert('"+deleteFoodMsg+"');</script>");
		}else {
			String deleteFoodMsg=" 删除商品 ："+foodName+"失败";
			request.setAttribute("deleteSearchFoodMsg","<script>alert('"+deleteFoodMsg+"');</script>");
		}
		Object [] object=adminService.searchFoodSubmit(pageNum,searchFoodName);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("foodList",(List<Food>)object[1]);
		request.setAttribute("searchFoodName", searchFoodName);
		return "adminShowSearchFood";
	}	
	//展示所有订单  分页展示
	@RequestMapping("/showAllOrdersInAdmin")
	public String showAllOrdersInAdmin(HttpServletRequest request,String pageNum) {
		Object [] object=adminService.showAllOrders(pageNum);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("orderList",(List<Orders>)object[1]);
		return "adminShowOrders";
	}	
	//订单详情及相应操作
	@RequestMapping("/orderDetailInAdmin")
	public String orderDetailInAdmin(String orderId,HttpServletRequest request) {
		Orders order=adminService.showThisOrderDetail(orderId);
		HttpSession session=request.getSession();
		session.setAttribute("order", order);
		return "adminOrderDetail";
	}
	//发货
	@RequestMapping("/deliverGoods")
	public String deliverGoods(String orderId,HttpServletRequest request) {
		boolean bool=adminService.changeOrderStatus(orderId,"已发货");
		String deliverGoodsMsg=null;
		if(bool) {
			deliverGoodsMsg=" 订单号为 【"+orderId+"】的订单对应的商品已发货";
			
		}else {
			deliverGoodsMsg=" 订单号为 【"+orderId+"】的订单对应的商品发货失败";
		}
		request.setAttribute("deliverGoodsMsg","<script>alert('"+deliverGoodsMsg+"');</script>");
		Orders order=adminService.showThisOrderDetail(orderId);
		HttpSession session=request.getSession();
		session.setAttribute("order", order);
		return "adminOrderDetail";
	}
	//分页显示各类订单
	@RequestMapping("/showVarietyOrdersInAdmin")
	public String showVarietyOrdersInAdmin(String status,HttpServletRequest request,String pageNum) {
		Object [] object=adminService.showVarietyOrdersInAdmin(pageNum,status);
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("orderList",(List<Orders>)object[1]);
		request.setAttribute("status", status);
		return "adminVarietyOrders";
	}
	//删除订单  已完成状态下的删除，改状态
	@RequestMapping("/deleteOrder")
	public String deleteOrder(String orderId,HttpServletRequest request) {
		boolean bool=adminService.changeOrderStatus(orderId,"后台已删除");
		if(bool) {
			request.setAttribute("deleteOrderMsg","<script>alert('删除订单成功！！');</script>" );
			
		}else {
			request.setAttribute("deleteOrderMsg","<script>alert('删除订单失败！！');</script>" );
		}
		Object [] object=adminService.showVarietyOrdersInAdmin(null,"已完成");
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("orderList",(List<Orders>)object[1]);
		request.setAttribute("status", "已完成");
		return "adminVarietyOrders";
		
	}
	//删除订单  前台已删除状态下  直接删除数据库
	@RequestMapping("/removeOrder")
	public String removeOrder(String orderId,HttpServletRequest request) {
		boolean bool=adminService.removeOrder(orderId);
		if(bool) {
			request.setAttribute("deleteOrderMsg","<script>alert('删除订单成功！！');</script>" );
			
		}else {
			request.setAttribute("deleteOrderMsg","<script>alert('删除订单失败！！');</script>" );
		}
		Object [] object=adminService.showVarietyOrdersInAdmin(null,"已完成");
		request.setAttribute("pageCount", (Page)object[0]);
		request.setAttribute("orderList",(List<Orders>)object[1]);
		request.setAttribute("status", "已完成");
		return "adminVarietyOrders";
		
	}	
	//跳转到搜索订单页面
	@RequestMapping("/jumpToSearchOrderpage")
	public String jumpToSearchOrderpage() {
		return "adminSearchOrderpage";
	}
	//搜索提交
	@RequestMapping("/searchOrderByIdInAdmin")
	public String searchOrderByIdInAdmin(String orderId,HttpServletRequest request) {
		Orders order=adminService.searchOrderById(orderId);
		HttpSession session=request.getSession();
		if(order!=null&&(!order.getOrder_state().equals("后台已删除"))) {
			session.setAttribute("order", order);
			return "adminOrderDetail";
		}else {
			request.setAttribute("searchOrderMsg", "<script>alert('订单不存在,请换一个订单号查询！！！');</script>");
			return "adminSearchOrderpage";
		}
		
		
		
	}
	
	//跳转到找回密码页面
	@RequestMapping("/jumpToAdminFindPassword")
	public String jumpToAdminFindPassword() {
		return "adminFindPassword";
	}	
	
	//找回密码
	@RequestMapping("/findPasswordSubmitInAdmin")
	public String findPasswordSubmitInAdmin(String email,HttpServletRequest request) {
		Admin admin=adminService.findByEmail(email);
		if(admin!=null) {
			//邮件的内容
			StringBuffer sb = new StringBuffer();
			sb.append("亲爱的管理员【");
			sb.append(admin.getAdmin_username());
			sb.append("】,您的一家小店的后台登录密码为【");
			sb.append(admin.getAdmin_passwd());
			sb.append("】,请勿向其他人泄露您的密码，以免账号被盗,如果不是您本人的操作，忽略该信息！");
			boolean bool = SendEmail.send(admin.getAdmin_email(), sb.toString());
			request.setAttribute("emailMsg", "<script>alert('已发送邮件至注册邮箱，请及时查看，找回密码，进行登录！！！');</script>");
			
			return "adminInUserLogin";
		}else {
			request.setAttribute("emailMsg", "<script>alert('该邮箱并未注册账号，请核对是否输入正确！！');</script>");
			request.setAttribute("email", email);
			return "adminFindPassword";
		}
		
	}	
	
	
	
	
}

package com.sky.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
import com.sky.Bean.Food;
import com.sky.Bean.FoodType;
import com.sky.Bean.Orders;
import com.sky.Bean.Users;
import com.sky.common.Page;
import com.sky.common.SendEmail;
import com.sky.common.indexPage;
import com.sky.common.shoppingCartList;
import com.sky.service.UserService;
import com.sun.org.apache.regexp.internal.RE;
import com.sun.org.apache.xalan.internal.xsltc.compiler.sym;

import sun.print.resources.serviceui;



@Controller
public class UserController {
	@Autowired
	private UserService userService;
	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@RequestMapping("/register")
	public String jumpToRegister() {
		return "registry";
	}
	@RequestMapping("/login")
	public String jumpToLogin() {
		return "login";
	}
	@RequestMapping("/checkUsername")
	public void checkUsername(@RequestParam String name,HttpServletResponse response) throws IOException {
		 PrintWriter pw=response.getWriter();
		 if(name.equals("")) {
			 pw.print("kong");
		 }else if(userService.findUsername(name)){
			 
		      pw.print(true);
		 }else{
		      pw.print(false);
		 }
    }
	@RequestMapping("/checkEmail")
	public void checkEmail(@RequestParam String email,HttpServletResponse response) throws IOException {
		 PrintWriter pw=response.getWriter();
		 if(email.equals("")) {
			 pw.print("kong");
		 }else if(userService.findEmail(email)){
			 
		      pw.print(true);
		 }else{
		      pw.print(false);
		 }
    }
	@RequestMapping("/saveUser")
	public String saveUser(Model model,HttpServletRequest request,String username,String password,String email,String telephone,String address,@RequestParam MultipartFile phone) throws IOException {
		Users user=new Users();
		user.setUser_username(username);
		user.setUser_passwd(password);
		user.setUser_email(email);
		user.setUser_telephone(telephone);
		user.setUser_address(address);
		user.setUser_image(phone.getOriginalFilename());
		boolean bool= userService.saveUser(user,phone,request);
		
		if(bool) {
			model.addAttribute("msg1","注册成功，已发激活码到您的邮箱，请在48小时内到您的邮箱点击激活您的账号！");
			
		}else {
			model.addAttribute("msg2","注册失败,请重新注册");
		}
		return "complete_register";
	}
	@RequestMapping("/activate")
	public String activate(Model model,String email,String validateCode){
		String msg=userService.activate(email,validateCode);
		if(msg.contains("激活成功")||msg.contains("请登录")) {
			model.addAttribute("msg1",msg);
		}else if(msg.contains("激活码不正确")||msg.contains("重新注册")||msg.contains("该邮箱未注册")){
			model.addAttribute("msg2",msg);
		}
		
		return "activate";
	}
	@RequestMapping("/loginSubmit")
	 public String checkLoginUser(Model model,String email,String password,String verf,HttpServletRequest request) {
		if(userService.checkVerf(verf, request)) {
			Users user=userService.findLoginUser(email, password);
			if(user!=null) {
				if(user.getStatus()!=0) {
					HttpSession session=request.getSession();
					session.setAttribute("user", user);
					return "redirect:jumpToIndex.action";
				}else {
					model.addAttribute("ErrorMsg","该账号未激活，请到邮箱中激活再登录！");
					return "login";
				}
				
			}else {
				model.addAttribute("ErrorMsg","用户名或者密码不正确，请重新登录");
				return "login";
			}
		}else {
			model.addAttribute("email",email);
			model.addAttribute("password",password);
			model.addAttribute("ErrorMsg","验证码错误，重新输入");
			return "login";
		}
		
	 }
	@RequestMapping("/user_detail")
	public String user_detail() {
		
		return "user_detail";
	}
	//更新
	@RequestMapping("/updateUser")
	public String updateUser(HttpServletRequest request,String username,String telephone,String address) {
		HttpSession session=request.getSession();
		
		//System.out.print(username);
		boolean bool=userService.updateUser(username,telephone,address) ;
		if(bool) {
			Users user=userService.findLoginUserByName(username);
			session.setAttribute("user", user);
			request.setAttribute("updateMsg","<script>alert('修改信息成功');</script>");
			return "user_detail";
		}
		request.setAttribute("updateMsg","<script>alert('修改信息失败');</script>");
		return "user_detail";
	}
	@RequestMapping("/updatePhone")
	public String updatePhone(HttpServletRequest request,String username,@RequestParam MultipartFile phone) throws IOException {
		HttpSession session=request.getSession();
		boolean bool=userService.updatePhone(request,username,phone);
		if(bool) {
			Users user=userService.findLoginUserByName(username);
			session.setAttribute("user", user);
			request.setAttribute("updateMsg","<script>alert('上传图片成功');</script>");
			return "user_detail";
		}else {
			request.setAttribute("updateMsg","<script>alert('上传图片失败');</script>");
			return "user_detail";
		}
		
	}
	@RequestMapping("/jumpToUpdatePasswordpage")
	public String jumpToUpdatePasswordpage() {
		return "updatePassword";
	}
	@RequestMapping("/updatePassword")
	public String updatePassword(HttpServletRequest request,String username,String newPassword) {
		HttpSession session=request.getSession();
		boolean bool=userService.updatePassword(username,newPassword);
		if(bool) {
			Users user=userService.findLoginUserByName(username);
			session.setAttribute("user", user);
			request.setAttribute("updatePwd","<script>alert('更新密码成功');</script>");
			return "updatePassword";
		}else {
			request.setAttribute("updatePwd","<script>alert('更新密码失败');</script>");
			return "updatePassword";
		}
	}
	
	//查看购物车
	@RequestMapping("/shopCartActive/showshopCart")
	public String showshopCart(HttpServletRequest request) {
		HttpSession session=request.getSession();
		Users user=(Users) session.getAttribute("user");//一定不为空
		shoppingCartList productCart = (shoppingCartList) session.getAttribute("productCart"+user.getId());
		if (productCart != null) {
			request.setAttribute("totalcost", productCart.getTotalCost());
		}	
		return "showshopCart";
	}
	
	//退出登录
	@RequestMapping("/UserLoginOut")
	public String UserLoginOut(Model model,HttpServletRequest request) {
		boolean bool=userService.UserLoginOut(request);
		if(bool) {
			model.addAttribute("LoginOutMsg","<script>alert('用户退出成功,您可以继续登录');</script>");
			return "login";
		}
		model.addAttribute("LoginOutMsg","<script>alert('用户退出失败,回到首页');</script>");
		return "index";
	}
	//查询动态内容,首页
	@RequestMapping("/jumpToIndex")
	public String jumpToIndex(HttpServletRequest request) {
		HttpSession session=request.getSession();
		//热门关键字
		List<Food> list=userService.showHotFoodFontList();
		//类别
		List<FoodType> foodTypeList=userService.findFoodType();
		//最新商品
		List<Food> newFoodList=userService.findNewFoodList();
		//热门商品
		List<Food> hotFoodList=userService.findHotFoodList();
		//饮品
		FoodType drinkType=userService.findFoodTypeByName("饮品类");
		//酒类
		FoodType wineType=userService.findFoodTypeByName("酒类");
		//零食
		FoodType snackType=userService.findFoodTypeByName("零食类");
		//海鲜
		FoodType seaFoodType=userService.findFoodTypeByName("海鲜类");
		//调味品
		FoodType twType=userService.findFoodTypeByName("调味品类");
		request.setAttribute("foodTypeList",foodTypeList );
		session.setAttribute("foodNameList", list);
		request.setAttribute("newFoodList", newFoodList);
		request.setAttribute("hotFoodList",hotFoodList );
		request.setAttribute("drinkType", drinkType);
		request.setAttribute("wineType", wineType);
		request.setAttribute("wineLength", wineType.getFoodSet().size());
		request.setAttribute("snackType", snackType);
		request.setAttribute("snackLength", snackType.getFoodSet().size());
		request.setAttribute("seaFoodType", seaFoodType);
		request.setAttribute("seaFoodLength", seaFoodType.getFoodSet().size());
		request.setAttribute("twType", twType);
		request.setAttribute("twLength", twType.getFoodSet().size());
		return "index";
	}
	
	//商城
	@RequestMapping("/shopTown")
	public String showShopTown(String searchFoodName,String action,String typeName,String current_page,HttpServletRequest request) throws SQLException {
		System.out.println(action);
		Object[] object=userService.showShopTown(searchFoodName,action,current_page,request);
		HttpSession session=request.getSession();
		
		session.setAttribute("FoodList", (List<Food>)object[0]);
		session.setAttribute("page", (indexPage)object[1]);
		session.setAttribute("a", (String)object[2]);
		session.setAttribute("typeName", typeName);
		session.setAttribute("searchFoodName", searchFoodName);
		return "shopTown";
	}
	@RequestMapping("/subCurrent_bottom_page")
	public String subCurrent_bottom_page(HttpServletRequest request) {
		HttpSession session=request.getSession();
		indexPage page=(indexPage) session.getAttribute("page");
		int n=page.getCurrent_bottom_page();
		n=n-9;
		page.setCurrent_bottom_page(n);
		session.setAttribute("page", page);
		return "shopTown";
	}
	@RequestMapping("/addCurrent_bottom_page")
	public String addCurrent_bottom_page(HttpServletRequest request) {
		HttpSession session=request.getSession();
		indexPage page=(indexPage) session.getAttribute("page");
		int n=page.getCurrent_bottom_page();
		n=n+9;
		page.setCurrent_bottom_page(n);
		session.setAttribute("page", page);
		return "shopTown";
	}
	//商品详细
	@RequestMapping("/foodDetailInUser")
	public String foodDetailInUser(String foodId,Model model,HttpServletRequest request) {
		Food food=userService.foodDetailInUser(Integer.parseInt(foodId));
		List<Food> hotFoodList=userService.findHotFoodList();
		request.setAttribute("hotFoodList",hotFoodList );
		model.addAttribute("food",food);
		return "foodDetail";
			
		
	}
	//跳转到收货地址
	@RequestMapping("/receiveAddress")
	public String receiveAddress(HttpServletRequest request) {
		HttpSession session=request.getSession();
		Users u=(Users) session.getAttribute("user");
		Users user=userService.findLoginUserByName(u.getUser_username());
		session.setAttribute("user", user);
		
		Set<Address> AddressSet=userService.findAddressOfUser(request);
		
		session.setAttribute("AddressSet", AddressSet);
		session.setAttribute("addressLength", AddressSet.size());
		return "receiveAddress";
	}
	//添加收货地址
	@RequestMapping("/addReceiveAddress")
	public String addReceiveAddress(Address address,HttpServletRequest request) {
		Boolean bool=userService.addReceiveAddress(request,address);
		HttpSession session=request.getSession();
		if(bool) {
			request.setAttribute("addAddressMsg", "<script>alert('添加收货地址成功');</script>");
		}else {
			request.setAttribute("addAddressMsg", "<script>alert('添加收货地址失败');</script>");
		}
		//重新设置user
		Users u=(Users) session.getAttribute("user");
		Users user=userService.findLoginUserByName(u.getUser_username());
		session.setAttribute("user", user);
		//
		Set<Address> AddressSet=userService.findAddressOfUser(request);
		session.setAttribute("AddressSet", AddressSet);
		session.setAttribute("addressLength", AddressSet.size());
		return "receiveAddress";
	}
		
	//删除收货地址
	@RequestMapping("/removeAddress")
	public String removeAddress(String id,HttpServletRequest request) {
		HttpSession session=request.getSession();
		Users u=(Users) session.getAttribute("user");
		boolean bool = userService.removeAddress(id,u);
		if(bool) {
			request.setAttribute("deleteAddressMsg", "<script>alert('删除收货地址成功');</script>");
		}else {
			request.setAttribute("deleteAddressMsg", "<script>alert('删除收货地址失败');</script>");
		}
		Users user=userService.findLoginUserByName(u.getUser_username());
		session.setAttribute("user", user);
		//
		Set<Address> AddressSet=userService.findAddressOfUser(request);
		session.setAttribute("AddressSet", AddressSet);
		session.setAttribute("addressLength", AddressSet.size());
		return "receiveAddress";
	}
	//跳转至更新收货地址
	@RequestMapping("/updateAddress")
	public String updateAddress(String id,HttpServletRequest request) {
		Address address=userService.findAddress(id);
		String[] provincialList= {"浙江省","河北省","江苏省","河南省","湖南省","东北省","山西省","陕西省","湖北省"};
		String[] cityList= {"台州市","石家庄市","杭州市","温岭市","临海市","邯郸市","廊坊市","邢台市","衡水市"};
		String[] countiesList= {"椒江区","裕华区","黄岩区","仙居","元氏县"};
		request.setAttribute("updateAddress", address);
		request.setAttribute("provincialList",provincialList );
		request.setAttribute("cityList", cityList);
		request.setAttribute("countiesList", countiesList);
		request.setAttribute("id", id);
		return "UpdateAddress";
	}
	//修改提交
	@RequestMapping("/updateReceiveAddressSubmit")
	public String updateReceiveAddressSubmit(String addressId ,Address address ,HttpServletRequest request) {
		HttpSession session=request.getSession();
		Users u=(Users) session.getAttribute("user");
		boolean bool = userService.updateAddress(addressId,address,u);
		if(bool) {
			request.setAttribute("deleteAddressMsg", "<script>alert('更新收货地址成功');</script>");
		}else {
			request.setAttribute("deleteAddressMsg", "<script>alert('更新收货地址失败');</script>");
		}
		
		
		Users user=userService.findLoginUserByName(u.getUser_username());
		session.setAttribute("user", user);
		//
		Set<Address> AddressSet=userService.findAddressOfUser(request);
		session.setAttribute("AddressSet", AddressSet);
		session.setAttribute("addressLength", AddressSet.size());
		return "receiveAddress";		
	}
	//加入购物车   没有登录不允许加入购物车
	@RequestMapping("/shopCartActive/addProductToCart")
	public String addProductToCart(String foodBuyCount,String foodId,HttpServletRequest request,HttpServletResponse response) {
		userService.addProductToCart(foodBuyCount,foodId,request);
		HttpSession session = request.getSession();
		//设置购物车列表存在的时间为一周
		session.setMaxInactiveInterval(60*60*24*7);//秒
		
		Cookie cookie=new Cookie("JSESSIONID", session.getId());
		cookie.setMaxAge(60*60*24*7);
		response.addCookie(cookie);//更新
		
		return "redirect:/shopCartActive/showshopCart.action";
	}
	//修改数量  购物车列表中
	@RequestMapping("/shopCartActive/updateCountSubmit")
	public String updateCountSubmit(String id,String count,HttpServletRequest request) {
		userService.updateCountToCart(id,count,request);
		return "redirect:/shopCartActive/showshopCart.action";
	}
	//购物车删除物品  单个删除
	@RequestMapping("/shopCartActive/deleteCartFoodBean1")
	public String deleteCartFoodBean(String id,String foodName,HttpServletRequest request) {
		//System.out.println("单个删除");
		boolean bool =userService.deleteCartFoodBean(id,request);
		if(bool) {
			String deleteCartFoodMsg=" 成功删除 购物车商品："+foodName;
			request.setAttribute("deleteCartFoodMsg","<script>alert('"+deleteCartFoodMsg+"');</script>");
		
		}else {
			String deleteCartFoodMsg=" 删除 购物车商品："+foodName+"失败";
			request.setAttribute("deleteCartFoodMsg","<script>alert('"+deleteCartFoodMsg+"');</script>");
		
		}
		HttpSession session=request.getSession();
		Users user=(Users) session.getAttribute("user");
		shoppingCartList productCart = (shoppingCartList) session.getAttribute("productCart"+user.getId());
		if (productCart != null) {
			request.setAttribute("totalcost", productCart.getTotalCost());
		}	
		return "showshopCart";
	}
	//购物车删除物品  批量删除
	@RequestMapping("/shopCartActive/deleteCartFoodBeanList")
	public String deleteCartFoodBeanList(String[] deteleFoodList,HttpServletRequest request) {
		//System.out.println("批量删除");
		boolean bool =userService.deleteCartFoodBeanList(deteleFoodList,request);
		if(bool) {
			request.setAttribute("deleteCartFoodBeanListMsg", "<script>alert('批量删除购物车商品成功');</script>");
		}else {
			request.setAttribute("deleteCartFoodBeanListMsg", "<script>alert('批量删除购物车商品失败');</script>");
		}
		HttpSession session=request.getSession();
		Users user=(Users) session.getAttribute("user");
		shoppingCartList productCart = (shoppingCartList) session.getAttribute("productCart"+user.getId());
		if (productCart != null) {
			request.setAttribute("totalcost", productCart.getTotalCost());
		}	
		return "showshopCart";
	}
	//清空购物车
	@RequestMapping("/shopCartActive/removeProductCart")
	public String removeProductCart(HttpServletRequest request) {
		boolean bool =userService.removeProductCart(request);
		if(bool) {
			request.setAttribute("removeProductCartMsg", "<script>alert('清空购物车商品成功');</script>");
		}else {
			request.setAttribute("removeProductCartMsg", "<script>alert('清空购物车商品失败');</script>");
		}
		HttpSession session=request.getSession();
		Users user=(Users) session.getAttribute("user");
		shoppingCartList productCart = (shoppingCartList) session.getAttribute("productCart"+user.getId());
		if (productCart != null) {
			request.setAttribute("totalcost", productCart.getTotalCost());
		}	
		return "showshopCart";
	}
	//生成订单
	@RequestMapping("/shopCartActive/addOrder")
	public String addOrder(HttpServletRequest request) {
		boolean bool =userService.addOrder(request);
		HttpSession session=request.getSession();
		Users user=(Users) session.getAttribute("user");
		if(bool) {
			request.setAttribute("addOrderMsgSuccess", "<script>alert('生成订单成功');</script>");
			Set<Address> AddressSet=userService.findAddressOfUser(request);
			session.setAttribute("AddressSet", AddressSet);
			session.setAttribute("addressLength", AddressSet.size());
			return "showOrderAndDetail";
		}else {
			request.setAttribute("addOrderMsgErrors", "<script>alert('生成订单失败');</script>");
			
			shoppingCartList productCart = (shoppingCartList) session.getAttribute("productCart"+user.getId());
			if (productCart != null) {
				request.setAttribute("totalcost", productCart.getTotalCost());
			}	
			return "showshopCart";
		}
		
	}
	//显示所有订单
	@RequestMapping("/myAllOrders")
	public String myAllOrders(HttpServletRequest request) {
		userService.showMyAllOrders(request);
		
		return "allOfOrders";
	}
	//展示订单详情
	@RequestMapping("/showThisOrderDetail")
	public String showThisOrderDetail(String orderId,HttpServletRequest request) {
		Orders order=userService.showThisOrderDetail(orderId);
		HttpSession session=request.getSession();
		Set<Address> AddressSet=userService.findAddressOfUser(request);
		session.setAttribute("AddressSet", AddressSet);
		session.setAttribute("addressLength", AddressSet.size());
		session.setAttribute("order", order);
		return "orderDetail";
	}
	//付款
	@RequestMapping("/getMoneyAndAddress")
	public String getMoneyAndAddress(String orderId,String selectAddressId,HttpServletRequest request) {
		System.out.println(selectAddressId);
		boolean bool=userService.getMoneyAndAddress(orderId,selectAddressId,request);
		if(bool) {
			request.setAttribute("getMoneyMsg", "<script>alert('付款成功，等待商家发货');</script>");
		}else {
			request.setAttribute("getMoneyMsg", "<script>alert('付款失败，重新付款');</script>");
		}
		userService.showMyAllOrders(request);
		return "allOfOrders";
	}
	//取消订单
	@RequestMapping("/cancelOrder")
	public String cancelOrder(HttpServletRequest request,String OrderId) {
		HttpSession session=request.getSession();
		Users user=(Users) session.getAttribute("user");//用户
		boolean bool=userService.cancelOrder(Integer.parseInt(OrderId));
		if(bool) {
			request.setAttribute("cancelOrderMsg", "<script>alert('取消订单成功');</script>");
		}else {
			request.setAttribute("cancelOrderMsg", "<script>alert('取消订单失败');</script>");
		}
		user=userService.findLoginUserByName(user.getUser_username());
		session.setAttribute("user", user);//更新用户
		userService.showMyAllOrders(request);
		return "allOfOrders";
	}
	
	//各类订单
	@RequestMapping("/varietyOrders")
	public String varietyOrders(String variety,HttpServletRequest request) {
		userService.showVarietyOrders(request,variety);
		//System.out.println(variety);
		return "allOfOrders";
	}
	//确认收货
	@RequestMapping("/getGoods")
	public String getGoods(String OrderId,HttpServletRequest request) {
		boolean bool=userService.changeOrdersStatus(OrderId,"已完成");
		if(bool) {
			request.setAttribute("getGoodsMsg", "<script>alert('操作成功');</script>");
		}else {
			request.setAttribute("getGoodsMsg", "<script>alert('操作失败');</script>");
		}
		Orders order=userService.showThisOrderDetail(OrderId);
		HttpSession session=request.getSession();
		Set<Address> AddressSet=userService.findAddressOfUser(request);
		session.setAttribute("AddressSet", AddressSet);
		session.setAttribute("addressLength", AddressSet.size());
		session.setAttribute("order", order);
		return "orderDetail";
	}
	//已完成状态下的删除  
	@RequestMapping("/deleteOrderInUser")
	public String deleteOrderInUser(String OrderId,HttpServletRequest request) {
		boolean bool=userService.changeOrdersStatus(OrderId,"前台已删除");
		if(bool) {
			request.setAttribute("deleteOrderMsg","<script>alert('删除订单成功');</script>" );
		}else {
			request.setAttribute("deleteOrderMsg","<script>alert('删除订单失败');</script>" );
		}
		userService.showVarietyOrders(request,"已完成");
		return "allOfOrders";
	}
	//删除数据库中的订单
	@RequestMapping("/removeOrderInUser")
	public String removeOrderInUser(String OrderId,HttpServletRequest request) {
		boolean bool=userService.cancelOrder(Integer.parseInt(OrderId));
		if(bool) {
			request.setAttribute("deleteOrderMsg","<script>alert('删除订单成功');</script>" );
		}else {
			request.setAttribute("deleteOrderMsg","<script>alert('删除订单失败');</script>" );
		}
		userService.showVarietyOrders(request,"已完成");
		return "allOfOrders";
	}
	
	//查询订单
	@RequestMapping("/searchOrderById")
	public String searchOrderById(String orderId,HttpServletRequest request) {
		userService.showSearchOrder(request,orderId);
		request.setAttribute("search", orderId);
		
		return "allOfOrders";
	}	
	
	//跳转到找回密码页面
	@RequestMapping("/jumpToFindPassword")
	public String jumpToFindPassword() {
		return "findPassword";
	}
	//找回密码
	@RequestMapping("/findPasswordSubmit")
	public String findPasswordSubmit(String email,HttpServletRequest request) {
		Users user=userService.findByEmail(email);
		if(user!=null) {
			//邮件的内容
			StringBuffer sb = new StringBuffer();
			sb.append("亲爱的买家【");
			sb.append(user.getUser_username());
			sb.append("】,您的一家小店的密码为【");
			sb.append(user.getUser_passwd());
			sb.append("】,请勿向其他人泄露您的密码，以免账号被盗,如果不是您本人的操作，忽略该信息！");
			boolean bool = SendEmail.send(user.getUser_email(), sb.toString());
			request.setAttribute("emailMsg", "<script>alert('已发送邮件至注册邮箱，请及时查看，找回密码，进行登录！！！');</script>");
			
			return "login";
		}else {
			request.setAttribute("emailMsg", "<script>alert('该邮箱并未注册账号，请核对是否输入正确！！');</script>");
			request.setAttribute("email", email);
			return "findPassword";
		}
		
	}
	
	
	
	
}

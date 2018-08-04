package com.sky.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.criteria.CriteriaBuilder.In;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sky.Bean.Address;
import com.sky.Bean.Food;
import com.sky.Bean.FoodType;
import com.sky.Bean.OrderDetail;
import com.sky.Bean.Orders;
import com.sky.Bean.Users;
import com.sky.Dao.UserDao;
import com.sky.common.CartFoodBean;
import com.sky.common.SendEmail;
import com.sky.common.indexPage;
import com.sky.common.shoppingCartList;

import jdk.nashorn.internal.runtime.UserAccessorProperty;





@Service
public class UserService {
	@Autowired
	private UserDao userDao;

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	@Transactional
	public boolean findUsername(String name) {
		return userDao.findUsername(name);
	}

	@Transactional
	public boolean findEmail(String email) {
		// TODO Auto-generated method stub
		return userDao.findEmail(email);
	}

	@Transactional
	public boolean saveUser(Users user, MultipartFile phone, HttpServletRequest request) throws IOException {
		// TODO Auto-generated method stub
		ServletContext servletContext = request.getServletContext();
		String realPath = servletContext.getRealPath("/");
		File dir = new File(realPath + "upload");
		File dir1=new File(dir,"user");
		File dir2 = new File(dir1, user.getUser_username());
		if (!dir.exists()) {
			dir.mkdir();
		}
		if (!dir1.exists()) {
			dir1.mkdir();
		}
		if (!dir2.exists()) {
			dir2.mkdir();
		}
		if (phone != null) {
			File file = new File(dir2, user.getUser_image());
			FileOutputStream fos = new FileOutputStream(file);
			fos.write(phone.getBytes());
			fos.flush();
			fos.close();

		}
		user.setStatus(0);
		user.setRegisterTime(new Date());
		user.setValidateCode(Math.random() * 1000 + user.getUser_email());
		boolean bool = userDao.saveUser(user);
		//邮件的内容
		StringBuffer sb = new StringBuffer("点击下面链接激活账号，48小时生效，否则重新注册账号，链接只能使用一次，请尽快激活！</br>");
		sb.append("<a href=\"http://localhost:8080/javaWebShop/activate.action?email=");
		sb.append(user.getUser_email());
		sb.append("&validateCode=");
		sb.append(user.getValidateCode());
		sb.append("\">[激活]一家小店账号");
		sb.append("</a>");

		// 发送邮件
		boolean bool1 = SendEmail.send(user.getUser_email(), sb.toString());
		boolean bool2 = bool1 && bool;

		return bool2;
	}
	@Transactional
	public String activate(String email, String validateCode) {
		// TODO Auto-generated method stub
		Users user = userDao.findByEmail(email);

		// 验证用户是否存在
		if (user != null) {
			// 验证用户状态
			if (user.getStatus() == 0) {
				Date currentTime = new Date();
				// 验证链接是否过期
				if (currentTime.before(user.getLastActivateTime())) {
					// 验证激活码是否正确
					if (validateCode.equals(user.getValidateCode())) {
						// 激活成功，
						userDao.updateUserStatus(user, 1);
						return "激活成功,快去登录吧~";
					} else {
						return "激活码不正确，重新注册！";
					}
				} else {
					return "激活码已过期！重新注册！";
				}
			} else {
				return "邮箱已激活，请登录！";
			}
		} else {
			return"该邮箱未注册（邮箱地址不存在）！";
		}
	}
	@Transactional
	public boolean checkVerf(String verf,HttpServletRequest request) {
	
		HttpSession session=request.getSession();
		String rand= (String) session.getAttribute("rand");
		if(verf.equals(rand)) {
			return true;
		}else {
			return false;
		}
		
	}
	@Transactional
	 public Users findLoginUser(String email,String password) {
		 return userDao.findLoginUser(email, password);
	 }

	@Transactional
	public boolean updateUser(String username, String telephone, String address) {
		// TODO Auto-generated method stub
		
		return userDao.updateUser(username, telephone, address);
	}
	@Transactional
	 public Users findLoginUserByName(String username) {
		 return userDao.findLoginUserByName(username);
	 }
	@Transactional
	public boolean updatePhone(HttpServletRequest request, String username, MultipartFile phone) throws IOException {
		// TODO Auto-generated method stub
		ServletContext servletContext = request.getServletContext();
		String realPath = servletContext.getRealPath("/");
		File dir = new File(realPath + "upload");
		File dir1=new File(dir,"user");
		File dir2 = new File(dir1, username);
		if (!dir.exists()) {
			dir.mkdir();
		}
		if (!dir1.exists()) {
			dir1.mkdir();
		}
		if (!dir2.exists()) {
			dir2.mkdir();
		}
		if (phone != null) {
			File file = new File(dir2, phone.getOriginalFilename());
			FileOutputStream fos = new FileOutputStream(file);
			fos.write(phone.getBytes());
			fos.flush();
			fos.close();

		}
		//更新用户数据中的头像名字
		return userDao.updatePhone(username,phone.getOriginalFilename());
		
	}
	@Transactional
	public boolean updatePassword(String username, String newPassword) {
		// TODO Auto-generated method stub
		return userDao.updatePassword(username,newPassword);
	}
	@Transactional
	public boolean UserLoginOut(HttpServletRequest request) {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
		try {
			session.removeAttribute("user");
		}catch (Exception e) {
			// TODO: handle exception
			return false;
		}
		return true;
	}
	@Transactional
	public List<Food> showHotFoodFontList() {
		// TODO Auto-generated method stub
		return userDao.showHotFoodFontList();
	}
	@Transactional
	public List<FoodType> findFoodType() {
		
		return userDao.findFoodType();
	}
	@Transactional
	public List<Food> findNewFoodList() {
		// TODO Auto-generated method stub
		List<Food> foodList= userDao.findNewFoodList();
		for(int i=0;i<foodList.size();i++) {
			String s=foodList.get(i).getDescription();
			if(s.length()>=20) {
				s=s.substring(0,20)+"...";
				foodList.get(i).setDescription(s);
			}
		}
		return foodList;
	}
	@Transactional
	public List<Food> findHotFoodList() {
		// TODO Auto-generated method stub
		List<Food> foodList= userDao.findHotFoodList();
		for(int i=0;i<foodList.size();i++) {
			String s=foodList.get(i).getDescription();
			if(s.length()>=20) {
				s=s.substring(0,20)+"...";
				foodList.get(i).setDescription(s);
			}
		}
		return foodList;
	}
	@Transactional
	public FoodType findFoodTypeByName(String name) {
		return userDao.findFoodTypeByName(name);
	}
	@Transactional
	public Object[] showShopTown(String searchFoodName,String action, String current_page, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		List<Food> FoodList=new ArrayList<Food>();
		HttpSession session=request.getSession();
		indexPage page=(indexPage) session.getAttribute("page");
		if(page==null) {
			page=new indexPage();
		}
		if(action.equals("factory")) {
			page.setColumn_count(userDao.getCount());
		}else if(action.equals("factoryByPrice")){
			page.setColumn_count(userDao.getCount());
		}else if(action.equals("factoryByBuyCount")){
			page.setColumn_count(userDao.getCount());
		}else if(action.equals("factoryNewFood")){
			page.setColumn_count(userDao.amountNewFood());
		}else if(action.equals("factoryHotFood")){
			page.setColumn_count(userDao.amountHotFood());
		}else if(action.equals("searchFood")){
			page.setColumn_count(userDao.amountSearchFood(searchFoodName));
		}else {
			int id=Integer.parseInt(action);
			page.setColumn_count(userDao.getCountById(id));
		}
		page.setCurrent_page(1);
		if(current_page!=null) {
			page.setCurrent_page(Integer.parseInt(current_page));
		}
		if(action.equals("factory")) {
			FoodList=userDao.getSomeFood(page);
		}else if(action.equals("factoryByPrice")){
			FoodList=userDao.getSomeFood_1(page);
		}else if(action.equals("factoryByBuyCount")){
			FoodList=userDao.getSomeFood_2(page);
		}else if(action.equals("factoryNewFood")){
			FoodList=userDao.getSomeFood_3(page);
		}else if(action.equals("factoryHotFood")){
			FoodList=userDao.getSomeFood_4(page);
		}else if(action.equals("searchFood")){
			FoodList=userDao.getSomeFood_5(page,searchFoodName);
		}else {
			int id=Integer.parseInt(action);
			FoodList=userDao.selectFoodByTypeId(id,page);
		}
		for(int i=0;i<FoodList.size();i++) {
			String s=FoodList.get(i).getDescription();
			if(s.length()>=20) {
				s=s.substring(0,20)+"...";
				FoodList.get(i).setDescription(s);
			}
		}
		Object[] object= {FoodList,page,action};
		return object;
			
			
		
	}
	@Transactional
	public Food foodDetailInUser(int foodId) {
		// TODO Auto-generated method stub
		return userDao.findFoodById(foodId);
	}
	@Transactional
	public Set<Address> findAddressOfUser(HttpServletRequest request) {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
		
		Users user=(Users) session.getAttribute("user");
		return user.getAddressSet();
	}
	@Transactional
	public Boolean addReceiveAddress(HttpServletRequest request, Address address) {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
		Users user=(Users) session.getAttribute("user");
		return userDao.addReceiveAddress(user,address);
	}
	@Transactional
	public boolean removeAddress(String id, Users u) {
		// TODO Auto-generated method stub
		return userDao.removeAddress(Integer.parseInt(id),u);
	}
	@Transactional
	public Address findAddress(String id) {
		// TODO Auto-generated method stub
		return userDao.findAddress(Integer.parseInt(id));
	}
	@Transactional
	public boolean updateAddress(String addressId, Address address, Users u) {
		// TODO Auto-generated method stub
		return userDao.updateAddress( Integer.parseInt(addressId),  address,  u);
	}
	//加入购物车列表
	@Transactional
	public void addProductToCart(String foodBuyCount, String foodId, HttpServletRequest request) {
		// TODO Auto-generated method stub
		int id = Integer.parseInt(foodId);
		int count=Integer.parseInt(foodBuyCount);//数量
		Food food= userDao.findFoodById(id);//书
		String s=food.getDescription();
		if(s.length()>=20) {
			s=s.substring(0,20)+"...";
			food.setDescription(s);
		}
		CartFoodBean bean = new CartFoodBean();//购物车商品单元
		shoppingCartList list=null ;//购物车列表
		HttpSession session = request.getSession();
		Users user=(Users) session.getAttribute("user");
		list =(shoppingCartList) session.getAttribute("productCart"+user.getId());
		if(list==null) {
			//第一次,不存在重复
			list=new shoppingCartList();
			bean.setProduct(food);
			bean.setCount(count);
			list.add(bean);
			session.setAttribute("productCart"+user.getId(), list);
			
		}else {
			//已经有session对象
			bean.setProduct(food);
			bean.setCount(count);
			if(list.equals(bean)) {
				session.setAttribute("productCart"+user.getId(), list);
			}else {
				//没有
				list.add(bean);
				session.setAttribute("productCart"+user.getId(), list);
			}
		}
		
	}
	//更新数量  同时更新金额
	@Transactional
	public void updateCountToCart(String productId, String foodCount, HttpServletRequest request) {
		// TODO Auto-generated method stub
		int id = Integer.parseInt(productId);
		int count=Integer.parseInt(foodCount);
		Food food = userDao.findFoodById(id);//商品
		CartFoodBean bean = new CartFoodBean();
		shoppingCartList list=null ;
		HttpSession session = request.getSession();
		Users user=(Users) session.getAttribute("user");
		list =(shoppingCartList) session.getAttribute("productCart"+user.getId());
		bean.setProduct(food);
		bean.setCount(count);
		list.update(bean);
		session.setAttribute("productCart"+user.getId(), list);
	}
	//单个删除购物车商品
	@Transactional
	public boolean deleteCartFoodBean(String foodId, HttpServletRequest request) {
		int id = Integer.parseInt(foodId);
		shoppingCartList list=null ;
		HttpSession session = request.getSession();
		Users user=(Users) session.getAttribute("user");
		list =(shoppingCartList) session.getAttribute("productCart"+user.getId());
		boolean bool= list.delete(id);
		session.setAttribute("productCart"+user.getId(), list);//更新购物车
		return bool;
	}
	//批量删除购物车商品
	@Transactional
	public boolean deleteCartFoodBeanList(String[] deteleFoodList, HttpServletRequest request) {
		int[] idList=new int[deteleFoodList.length];
		for(int i=0;i<deteleFoodList.length;i++) {
			int id = Integer.parseInt(deteleFoodList[i]);
			idList[i]=id;
		}
		shoppingCartList list=null ;
		HttpSession session = request.getSession();
		Users user=(Users) session.getAttribute("user");
		list =(shoppingCartList) session.getAttribute("productCart"+user.getId());
		boolean bool= list.deleteIdList(idList);//批量删除
		session.setAttribute("productCart"+user.getId(), list);//更新购物车
		return bool;
	}
	//清空购物车商品
	@Transactional
	public boolean removeProductCart(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Users user=(Users) session.getAttribute("user");
		shoppingCartList list=null ;
		list =(shoppingCartList) session.getAttribute("productCart"+user.getId());
		boolean bool= list.removeAll();
		session.setAttribute("productCart"+user.getId(), list);//更新购物车
		return bool;
	}
	//生成未支付订单
	@Transactional
	public boolean addOrder(HttpServletRequest request) {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
		Users user=(Users) session.getAttribute("user");//用户
		shoppingCartList productCart = (shoppingCartList) session.getAttribute("productCart"+user.getId());//购物车
		
		int orderId=userDao.addOrders(user);//生成订单   
		user=findLoginUserByName(user.getUser_username());
		session.setAttribute("user", user);//更新用户
		
		boolean bool=userDao.addOrderDetail(productCart, orderId);
		
		if(bool==true) {
			double totalMoney=productCart.getTotalCost();
			session.removeAttribute("productCart"+user.getId());
			
			List<OrderDetail> orderDetailList=userDao.selectOrderDetailByOrder_id(orderId);
			Orders o=userDao.findOrder(orderId);
			
			session.setAttribute("orderDetailList", orderDetailList);
			session.setAttribute("order", o);
			session.setAttribute("totalMoney", totalMoney);
			
		}
		return bool;
		
	}
	//展示所有订单
	@Transactional
	public void showMyAllOrders(HttpServletRequest request) {
		HttpSession session=request.getSession();
		
		Users user=(Users) session.getAttribute("user");//用户
		user=findLoginUserByName(user.getUser_username());
		session.setAttribute("user", user);//更新用户
		user=(Users) session.getAttribute("user");
		
		Set<Orders> orderSet1=user.getOrderSet();//包括前后台已删除
		
		//去掉前台已删除
		Set<Orders> orderSet=new HashSet<Orders>();//不包括前台已删除状态下的订单
		for(Orders order : orderSet1) {
			if(!order.getOrder_state().equals("前台已删除")) {
				orderSet.add(order);
				
			}
		}
		
		session.setAttribute("allOrdersCount", orderSet.size());
		int count1=0;
		int count2=0;
		int count3=0;
		int count4=0;
		for(Orders order : orderSet) {
			if(order.getOrder_state().equals("未支付")) {
				count1++;
			}
			if(order.getOrder_state().equals("已支付")) {
				count2++;
			}
			if(order.getOrder_state().equals("已发货")) {
				count3++;
			}
			if(order.getOrder_state().equals("已完成")) {
				count4++;
			}
			if(order.getOrder_state().equals("后台已删除")) {
				count4++;
			}
		}
		session.setAttribute("count1", count1);
		session.setAttribute("count2", count2);
		session.setAttribute("count3", count3);
		session.setAttribute("count4", count4);
		session.setAttribute("orderSet", orderSet);//不包括前台已删除
		session.setAttribute("count5", orderSet.size());
	
	}
	//订单详情
	@Transactional
	public Orders showThisOrderDetail(String orderId) {
		// TODO Auto-generated method stub
		Orders order=userDao.findOrder(Integer.parseInt(orderId));
		return order;
	}
	//付款，提交收货信息，修改状态，增加销售量
	public boolean getMoneyAndAddress(String orderId, String selectAddressId, HttpServletRequest request) {
		HttpSession session=request.getSession();
		Users user=(Users) session.getAttribute("user");//用户
		
		Address address=userDao.findAddress(Integer.parseInt(selectAddressId));
		String addressToOrder="收货人【"+address.getUsername()+"】,收货地址【"+address.getProvincial()+
				address.getCity()+ address.getCounties()+ address.getStreet()+"】,邮编【"+address.getMailNum()+"】,手机号码【"+address.getPhoneNum()+"】";
	    boolean bool =userDao.setAddressToOrder(addressToOrder,Integer.parseInt(orderId));   //添加地址   
	    
	    boolean bool1=userDao.updateOrderStatus(Integer.parseInt(orderId),"已支付");//修改状态
	    
		//改销售量
		Orders order=userDao.findOrder(Integer.parseInt(orderId));
		Set<OrderDetail> detailSet=order.getDetailSet();
		for(OrderDetail detail:detailSet) {
			Food food=detail.getFood();
			int count=detail.getCount();
			userDao.addCount(food,count);
		}
		user=findLoginUserByName(user.getUser_username());
		session.setAttribute("user", user);//更新用户
		
		return bool&&bool1;
	}
	//取消订单
    @Transactional
	public boolean cancelOrder(int orderId) {
		// TODO Auto-generated method stub
		return userDao.cancelOrder(orderId);
	}
    //各类订单
    @Transactional
	public void showVarietyOrders(HttpServletRequest request, String variety) {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
		
		Users user=(Users) session.getAttribute("user");//用户
		user=findLoginUserByName(user.getUser_username());
		session.setAttribute("user", user);//更新用户
		user=(Users) session.getAttribute("user");
		Set<Orders> orderSet1=user.getOrderSet();//包括前后台已删除
		
		//去掉前台已删除
		Set<Orders> orderSet=new HashSet<Orders>();//不包括前台已删除状态下的订单
		for(Orders order : orderSet1) {
			if(!order.getOrder_state().equals("前台已删除")) {
				orderSet.add(order);
				
			}
		}
		
		
		session.setAttribute("allOrdersCount", orderSet.size());
		int count1=0;
		int count2=0;
		int count3=0;
		int count4=0;
		for(Orders order : orderSet) {
			if(order.getOrder_state().equals("未支付")) {
				count1++;
			}
			if(order.getOrder_state().equals("已支付")) {
				count2++;
			}
			if(order.getOrder_state().equals("已发货")) {
				count3++;
			}
			if(order.getOrder_state().equals("已完成")) {
				count4++;
			}
			if(order.getOrder_state().equals("后台已删除")) {
				count4++;
			}
		}
		Set<Orders> orders=new HashSet<Orders>();
		if(variety.equals("已完成")) {
			for(Orders order : orderSet) {
				if(order.getOrder_state().equals(variety)) {
					orders.add(order);
				}
				if(order.getOrder_state().equals("后台已删除")) {
					orders.add(order);
				}
			}
		}
		if(!variety.equals("已完成")) {
			for(Orders order : orderSet) {
				if(order.getOrder_state().equals(variety)) {
					orders.add(order);
				}
			}
		}
		
		session.setAttribute("count1", count1);
		session.setAttribute("count2", count2);
		session.setAttribute("count3", count3);
		session.setAttribute("count4", count4);
		session.setAttribute("orderSet", orders);
		session.setAttribute("count5", orders.size());
	}
	//修改状态
    @Transactional
	public boolean changeOrdersStatus(String orderId, String status) {
		// TODO Auto-generated method stub
		return userDao.updateOrderStatus(Integer.parseInt(orderId), status);
	}
    //搜索订单
    @Transactional
	public void showSearchOrder(HttpServletRequest request, String orderId) {
		// TODO Auto-generated method stub
    	HttpSession session=request.getSession();
		
		Users user=(Users) session.getAttribute("user");//用户
		user=findLoginUserByName(user.getUser_username());
		session.setAttribute("user", user);//更新用户
		user=(Users) session.getAttribute("user");
		Set<Orders> orderSet1=user.getOrderSet();//包括前后台已删除
		
		//去掉前台已删除
		Set<Orders> orderSet=new HashSet<Orders>();//不包括前台已删除状态下的订单
		for(Orders order : orderSet1) {
			if(!order.getOrder_state().equals("前台已删除")) {
				orderSet.add(order);
				
			}
		}
		
		
		session.setAttribute("allOrdersCount", orderSet.size());
		int count1=0;
		int count2=0;
		int count3=0;
		int count4=0;
		for(Orders order : orderSet) {
			if(order.getOrder_state().equals("未支付")) {
				count1++;
			}
			if(order.getOrder_state().equals("已支付")) {
				count2++;
			}
			if(order.getOrder_state().equals("已发货")) {
				count3++;
			}
			if(order.getOrder_state().equals("已完成")) {
				count4++;
			}
			if(order.getOrder_state().equals("后台已删除")) {
				count4++;
			}
		}
		Set<Orders> orders=new HashSet<Orders>();
		int id=Integer.parseInt(orderId);
		for(Orders order : orderSet) {
			if(order.getId()==id) {
				orders.add(order);
			}
		}
		
		session.setAttribute("count1", count1);
		session.setAttribute("count2", count2);
		session.setAttribute("count3", count3);
		session.setAttribute("count4", count4);
		session.setAttribute("orderSet", orders);
		session.setAttribute("count5", orders.size());
	}
    //找邮箱对应的用户
    @Transactional
	public Users findByEmail(String email) {
    	return userDao.findByEmail(email);
    }
	
	
	
	
	
	
	
}

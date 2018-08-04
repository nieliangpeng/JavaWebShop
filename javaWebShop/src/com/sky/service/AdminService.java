package com.sky.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sky.Bean.Admin;
import com.sky.Bean.Food;
import com.sky.Bean.FoodType;
import com.sky.Bean.Orders;
import com.sky.Bean.Users;
import com.sky.Dao.AdminDao;
import com.sky.Dao.UserDao;
import com.sky.common.Page;
import com.sky.common.SendEmail;


@Service
public class AdminService {
	@Autowired
	private AdminDao adminDao;
	@Autowired
	private UserDao userDao;
	public AdminDao getAdminDao() {
		return adminDao;
	}

	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	@Transactional
	public boolean checkVerf(String adminVerf, HttpServletRequest request) {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
		String rand= (String) session.getAttribute("rand");
		if(adminVerf.equals(rand)) {
			return true;
		}else {
			return false;
		}
	}
	@Transactional
	public Admin findLoginAdmin(String adminEmail, String adminPassword) {
		// TODO Auto-generated method stub
		return adminDao.findLoginAdmin(adminEmail,adminPassword);
	}
	@Transactional
	public boolean adminLoginOut(HttpServletRequest request) {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
		try {
			session.removeAttribute("admin");
		}catch (Exception e) {
			// TODO: handle exception
			return false;
		}
		
		return true;
	}
	
	@Transactional
	public boolean findAdminUsername(String name) {
		return adminDao.findAdminUsername(name);
	}

	@Transactional
	public boolean findAdminEmail(String email) {
		// TODO Auto-generated method stub
		return adminDao.findAdminEmail(email);
	}
	//注册
	@Transactional
	public boolean saveAdmin(Admin admin, MultipartFile phone, HttpServletRequest request) throws IOException {
		// TODO Auto-generated method stub
		ServletContext servletContext = request.getServletContext();
		String realPath = servletContext.getRealPath("/");
		File dir = new File(realPath + "upload");
		File dir1=new File(dir,"admin");
		File dir2 = new File(dir1, admin.getAdmin_username());
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
			File file = new File(dir2,admin.getAdmin_image());
			FileOutputStream fos = new FileOutputStream(file);
			fos.write(phone.getBytes());
			fos.flush();
			fos.close();

		}
		admin.setStatus(0);
		admin.setRegisterTime(new Date());
		admin.setValidateCode(Math.random() * 1000 + admin.getAdmin_email());
		boolean bool = adminDao.saveAdmin(admin);
		//邮件的内容
		StringBuffer sb = new StringBuffer("点击下面链接激活账号，48小时生效，否则需要重新添加管理员，链接只能使用一次，请尽快激活！</br>");
		sb.append("<a href=\"http://localhost:8080/javaWebShop/AdminActivate.action?email=");
		sb.append(admin.getAdmin_email());
		sb.append("&validateCode=");
		sb.append(admin.getValidateCode());
		sb.append("\">[激活]一家小店管理员账号");
		sb.append("</a>");

		// 发送邮件
		boolean bool1 = SendEmail.send(admin.getAdmin_email(), sb.toString());
		boolean bool2 = bool1 && bool;

		return bool2;
	}
	@Transactional
	public String activate(String email, String validateCode) {
		// TODO Auto-generated method stub
		Admin admin=adminDao.findByEmail(email);

		// 验证用户是否存在
		if (admin != null) {
			// 验证用户状态
			if (admin.getStatus() == 0) {
				Date currentTime = new Date();
				// 验证链接是否过期
				if (currentTime.before(admin.getLastActivateTime())) {
					// 验证激活码是否正确
					if (validateCode.equals(admin.getValidateCode())) {
						// 激活成功，
						adminDao.updateAdminStatus(admin, 1);
						return "该管理员邮箱激活成功,允许登录~";
					} else {
						return "激活码不正确，重新添加！";
					}
				} else {
					return "激活码已过期！重新添加该管理员！";
				}
			} else {
				return "邮箱已激活，该管理员可以登录！";
			}
		} else {
			return"该邮箱未注册（邮箱地址不存在）！";
		}
	}
	public int WatchAdminStatus(String email) {
		
		return adminDao.WatchAdminStatus(email);
	}
	
	@Transactional
	public boolean updateAdmin(String AdminUsername, String telephone, String address) {
		// TODO Auto-generated method stub
		
		return adminDao.updateAdmin(AdminUsername, telephone, address);
	}

	@Transactional
	public Admin findLoginAdminByName(String AdminUsername) {
		return adminDao.findLoginAdminByName(AdminUsername);
	}
	
	@Transactional
	public boolean updateAdminPhone(HttpServletRequest request, String AdminUsername, MultipartFile phone) throws IOException {
		// TODO Auto-generated method stub
		ServletContext servletContext = request.getServletContext();
		String realPath = servletContext.getRealPath("/");
		File dir = new File(realPath + "upload");
		File dir1 = new File(dir, "admin");
		File dir2 = new File(dir1, AdminUsername);
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
		return adminDao.updateAdminPhone(AdminUsername,phone.getOriginalFilename());
		
	}
	@Transactional
	public boolean updateAdminPassword(String username, String newPassword) {
		// TODO Auto-generated method stub
		return adminDao.updateAdminPassword(username,newPassword);
	}
	@Transactional
	public Object [] showUserList(String pageNum) {
		// TODO Auto-generated method stub
		int showPage;
		if (pageNum == null) {
			pageNum = "1";
		}
		try {
			showPage = Integer.parseInt(pageNum);
		} catch (NumberFormatException e) {
			showPage = 1;
		}
		
		Page pageCount = new Page();// 创建分页对象
		pageCount.setPageSize(10);
		pageCount.setRecordCount(userDao.amountUsers());
		pageCount.setCount(pageCount.getRecordCount(), pageCount.getPageSize());
		pageCount.setShowPage(showPage);
		
		showPage = pageCount.getShowPage();
		int pageSize = pageCount.getPageSize();

		int begin, end;
		if (pageCount.getCount()== 1) {
			begin = 1;
			end=pageCount.getRecordCount();
		} else if (pageCount.getIsLast()) {
			begin = (pageCount.getCount() - 1) * pageSize+1;
			end=pageCount.getRecordCount();
		} else {
			begin = (showPage - 1) * pageSize+1;
			end=begin+pageSize-1;
		}
		List<Users> list = userDao.showUserList(begin, end);
		Object []object= {pageCount,list}; 
		return object;
	}
	@Transactional
	public boolean removeUser(String id) {
		// TODO Auto-generated method stub
		
		return userDao.removeUser(Integer.parseInt(id));
	}
	@Transactional
	public List<FoodType> findFoodType() {
		
		return adminDao.findFoodType();
	}
	@Transactional
	public boolean addFoodType(String foodTypeName) {
		// TODO Auto-generated method stub
		return adminDao.addFoodType(foodTypeName);
	}
	@Transactional
	public boolean deleteFoodType(int foodTypeId) {
		return adminDao.deleteFoodType(foodTypeId);
		
		
	}
	@Transactional
	public boolean updateFoodType(int foodId,String foodTypeName ) {
		return adminDao.updateFoodType(foodId, foodTypeName);
	}
	
	//展示商品列表
	@Transactional
	public Object [] showFoodList(String pageNum) {
		// TODO Auto-generated method stub
		int showPage;
		if (pageNum == null) {
			pageNum = "1";
		}
		try {
			showPage = Integer.parseInt(pageNum);
		} catch (NumberFormatException e) {
			showPage = 1;
		}
		
		Page pageCount = new Page();// 创建分页对象
		pageCount.setPageSize(10);
		pageCount.setRecordCount(adminDao.amountFood());
		pageCount.setCount(pageCount.getRecordCount(), pageCount.getPageSize());
		pageCount.setShowPage(showPage);
		
		showPage = pageCount.getShowPage();
		int pageSize = pageCount.getPageSize();

		int begin, end;
		if (pageCount.getCount()== 1) {
			begin = 1;
			end=pageCount.getRecordCount();
		} else if (pageCount.getIsLast()) {
			begin = (pageCount.getCount() - 1) * pageSize+1;
			end=pageCount.getRecordCount();
		} else {
			begin = (showPage - 1) * pageSize+1;
			end=begin+pageSize-1;
		}
		List<Food> list = adminDao.showFoodList(begin, end);
		Object []object= {pageCount,list}; 
		return object;
	}
	//添加商品
	@Transactional
	public boolean addFood(String typeId, Food food, MultipartFile phone, HttpServletRequest request) throws IOException {
		// TODO Auto-generated method stub
		food.setFoodImgurl(phone.getOriginalFilename());
		food.setAddFoodTime(new Date());
		ServletContext servletContext = request.getServletContext();
		String realPath = servletContext.getRealPath("/");
		File dir = new File(realPath + "upload");
		File dir1=new File(dir,"food");
		File dir2 = new File(dir1, food.getFoodName());
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
			File file = new File(dir2,food.getFoodImgurl());
			FileOutputStream fos = new FileOutputStream(file);
			fos.write(phone.getBytes());
			fos.flush();
			fos.close();

		}
		
		return adminDao.addFood(food,typeId);
		
		

		
	}
	@Transactional
	public boolean removeFood(String id) {
		// TODO Auto-generated method stub
		return adminDao.removeFood(Integer.parseInt(id));
	}
	@Transactional
	public Food findFoodById(int id) {
		return adminDao.findFoodById(id);
	}
	@Transactional
	public boolean updateFood(Food food, String typeId) {
		// TODO Auto-generated method stub
		return adminDao.updateFood(food,typeId);
	}
	//更新商品图片
	@Transactional
	public boolean updateFoodImg(HttpServletRequest request, String foodId, String foodName, MultipartFile phone) throws IOException {
		ServletContext servletContext = request.getServletContext();
		String realPath = servletContext.getRealPath("/");
		File dir = new File(realPath + "upload");
		File dir1=new File(dir,"food");
		File dir2 = new File(dir1, foodName);
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
		//更新数据库
		return adminDao.updateFoodImg(Integer.parseInt(foodId),phone.getOriginalFilename());
	}
	//展示商品列表
	@Transactional
	public Object [] selectFoodByTypeInAdmin(String pageNum,String foodTypeId) {
		// TODO Auto-generated method stub
		FoodType type=adminDao.findTypeById(Integer.parseInt(foodTypeId));
		List<Food> list = new ArrayList<Food> ();  
		list.addAll(type.getFoodSet());
		//System.out.println(list.size());
		int showPage;
		if (pageNum == null) {
			pageNum = "1";
		}
		try {
			showPage = Integer.parseInt(pageNum);
		} catch (NumberFormatException e) {
			showPage = 1;
		}
		
		Page pageCount = new Page();// 创建分页对象
		pageCount.setPageSize(5);
		pageCount.setRecordCount(list.size());
		pageCount.setCount(pageCount.getRecordCount(), pageCount.getPageSize());
		pageCount.setShowPage(showPage);
		
		showPage = pageCount.getShowPage();
		int pageSize = pageCount.getPageSize();

		int begin, end;
		if (pageCount.getCount()== 1) {
			begin = 1;
			end=pageCount.getRecordCount();
		} else if (pageCount.getIsLast()) {
			begin = (pageCount.getCount() - 1) * pageSize+1;
			end=pageCount.getRecordCount();
		} else {
			begin = (showPage - 1) * pageSize+1;
			end=begin+pageSize-1;
		}
		if(end!=0) {
			list=list.subList(begin-1,end);
		}
		
		Object []object= {pageCount,list}; 
		return object;
	}
	//展示热门商品
	@Transactional
	public Object[] showHotFoodList(String pageNum) {
		// TODO Auto-generated method stub
		int showPage;
		if (pageNum == null) {
			pageNum = "1";
		}
		try {
			showPage = Integer.parseInt(pageNum);
		} catch (NumberFormatException e) {
			showPage = 1;
		}
		
		Page pageCount = new Page();// 创建分页对象
		pageCount.setPageSize(5);
		pageCount.setRecordCount(adminDao.amountHotFood());
		pageCount.setCount(pageCount.getRecordCount(), pageCount.getPageSize());
		pageCount.setShowPage(showPage);
		
		showPage = pageCount.getShowPage();
		int pageSize = pageCount.getPageSize();

		int begin, end;
		if (pageCount.getCount()== 1) {
			begin = 1;
			end=pageCount.getRecordCount();
		} else if (pageCount.getIsLast()) {
			begin = (pageCount.getCount() - 1) * pageSize+1;
			end=pageCount.getRecordCount();
		} else {
			begin = (showPage - 1) * pageSize+1;
			end=begin+pageSize-1;
		}
		List<Food> list = adminDao.showHotFoodList(begin, end);
		Object []object= {pageCount,list}; 
		return object;
	}	
	//展示最新商品
	//分页
	@Transactional
	public Object[] showNewFoodList(String pageNum) {
		// TODO Auto-generated method stub
		int showPage;
		if (pageNum == null) {
			pageNum = "1";
		}
		try {
			showPage = Integer.parseInt(pageNum);
		} catch (NumberFormatException e) {
			showPage = 1;
		}
		
		Page pageCount = new Page();// 创建分页对象
		pageCount.setPageSize(5);
		pageCount.setRecordCount(adminDao.amountNewFood());
		pageCount.setCount(pageCount.getRecordCount(), pageCount.getPageSize());
		pageCount.setShowPage(showPage);
		
		showPage = pageCount.getShowPage();
		int pageSize = pageCount.getPageSize();

		int begin, end;
		if (pageCount.getCount()== 1) {
			begin = 1;
			end=pageCount.getRecordCount();
		} else if (pageCount.getIsLast()) {
			begin = (pageCount.getCount() - 1) * pageSize+1;
			end=pageCount.getRecordCount();
		} else {
			begin = (showPage - 1) * pageSize+1;
			end=begin+pageSize-1;
		}
		List<Food> list = adminDao.showNewFoodList(begin, end);
		Object []object= {pageCount,list}; 
		return object;
	}
	@Transactional
	public List<String> showHotFoodFontList(){
		return adminDao.showHotFoodFontList();
	}
	@Transactional
	public Object[] searchFoodSubmit(String pageNum, String searchFoodName) {
		// TODO Auto-generated method stub
		
		int showPage;
		if (pageNum == null) {
			pageNum = "1";
		}
		try {
			showPage = Integer.parseInt(pageNum);
		} catch (NumberFormatException e) {
			showPage = 1;
		}
		
		Page pageCount = new Page();// 创建分页对象
		pageCount.setPageSize(5);
		pageCount.setRecordCount(adminDao.amountSearchFood(searchFoodName));
		pageCount.setCount(pageCount.getRecordCount(), pageCount.getPageSize());
		pageCount.setShowPage(showPage);
		
		showPage = pageCount.getShowPage();
		int pageSize = pageCount.getPageSize();

		int begin, end;
		if (pageCount.getCount()== 1) {
			begin = 1;
			end=pageCount.getRecordCount();
		} else if (pageCount.getIsLast()) {
			begin = (pageCount.getCount() - 1) * pageSize+1;
			end=pageCount.getRecordCount();
		} else {
			begin = (showPage - 1) * pageSize+1;
			end=begin+pageSize-1;
		}
		List<Food> list=adminDao.searchFoodSubmit(searchFoodName,begin,end);
		Object []object= {pageCount,list}; 
		return object;
		
	}
	//展示所有订单 分页
	@Transactional
	public Object [] showAllOrders(String pageNum) {
		// TODO Auto-generated method stub
		int showPage;
		if (pageNum == null) {
			pageNum = "1";
		}
		try {
			showPage = Integer.parseInt(pageNum);
		} catch (NumberFormatException e) {
			showPage = 1;
		}
		
		Page pageCount = new Page();// 创建分页对象
		pageCount.setPageSize(10);
		pageCount.setRecordCount(adminDao.amountOrders());
		pageCount.setCount(pageCount.getRecordCount(), pageCount.getPageSize());
		pageCount.setShowPage(showPage);
		
		showPage = pageCount.getShowPage();
		int pageSize = pageCount.getPageSize();

		int begin, end;
		if (pageCount.getCount()== 1) {
			begin = 1;
			end=pageCount.getRecordCount();
		} else if (pageCount.getIsLast()) {
			begin = (pageCount.getCount() - 1) * pageSize+1;
			end=pageCount.getRecordCount();
		} else {
			begin = (showPage - 1) * pageSize+1;
			end=begin+pageSize-1;
		}
		List<Orders> list = adminDao.showAllOrders(begin, end);
		Object []object= {pageCount,list}; 
		return object;
	}	
	//订单详情
	@Transactional
	public Orders showThisOrderDetail(String orderId) {
		Orders order=adminDao.findOrder(Integer.parseInt(orderId));
		return order;
	}
	//修改状态
	@Transactional
	public boolean changeOrderStatus(String orderId, String status) {
		// TODO Auto-generated method stub
		
		return adminDao.changeOrderStatus(Integer.parseInt(orderId),status);
	}
	//分页显示各类订单
	@Transactional
	public Object[] showVarietyOrdersInAdmin(String pageNum, String status) {
		int showPage;
		if (pageNum == null) {
			pageNum = "1";
		}
		try {
			showPage = Integer.parseInt(pageNum);
		} catch (NumberFormatException e) {
			showPage = 1;
		}
		
		Page pageCount = new Page();// 创建分页对象
		pageCount.setPageSize(10);
		
		if(status.equals("已完成")) {
			pageCount.setRecordCount(adminDao.amountVarietyOrders1(status));
		}
		if(!status.equals("已完成")) {
			pageCount.setRecordCount(adminDao.amountVarietyOrders(status));
		}
		
		pageCount.setCount(pageCount.getRecordCount(), pageCount.getPageSize());
		pageCount.setShowPage(showPage);
		
		showPage = pageCount.getShowPage();
		int pageSize = pageCount.getPageSize();

		int begin, end;
		if (pageCount.getCount()== 1) {
			begin = 1;
			end=pageCount.getRecordCount();
		} else if (pageCount.getIsLast()) {
			begin = (pageCount.getCount() - 1) * pageSize+1;
			end=pageCount.getRecordCount();
		} else {
			begin = (showPage - 1) * pageSize+1;
			end=begin+pageSize-1;
		}
		List<Orders> list=null;
		if(status.equals("已完成")) {
			list = adminDao.showVarietyOrders1(begin, end,status);
		}
		if(!status.equals("已完成")) {
			list = adminDao.showVarietyOrders(begin, end,status);
		}
		
		Object []object= {pageCount,list}; 
		return object;
	}
	//删除订单
	@Transactional
	public boolean removeOrder(String orderId) {
		return adminDao.deleteOrder(Integer.parseInt(orderId));
	}
	//查询订单
	@Transactional
	public Orders searchOrderById(String orderId) {
		return adminDao.findOrder(Integer.parseInt(orderId));
		
	}
	
	//找邮箱对应的管理员
    @Transactional
	public Admin findByEmail(String email) {
    	return adminDao.findByEmail(email);
    }
	
	
	
	
	
	
	
	
	
	
}

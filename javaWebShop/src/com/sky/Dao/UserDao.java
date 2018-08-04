package com.sky.Dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.apache.catalina.filters.AddDefaultCharsetFilter;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.sky.Bean.Address;
import com.sky.Bean.Admin;
import com.sky.Bean.Food;
import com.sky.Bean.FoodType;
import com.sky.Bean.OrderDetail;
import com.sky.Bean.Orders;
import com.sky.Bean.Person;
import com.sky.Bean.Users;
import com.sky.common.CartFoodBean;
import com.sky.common.indexPage;
import com.sky.common.shoppingCartList;



@Repository
public class UserDao {
	@Autowired
	private SessionFactory sessionFactory;

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	public boolean findUsername(String name) {
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		
		Query<Users> query=session.createQuery("from Users where user_username=:name");
		query.setParameter("name", name);
		List<Users> list=query.list();
		tran.commit();
		session.close();
		if(list.size()==0) {
			
			return false;
		}else {
			return true;
		}
		
		
	}

	public boolean findEmail(String email) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		
		Query<Users> query=session.createQuery("from Users where user_email=:email");
		query.setParameter("email", email);
		List<Users> list=query.list();
		tran.commit();
		session.close();
		if(list.size()==0) {
			
			return false;
		}else {
			return true;
		}
	}

	public boolean saveUser(Users user) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		
		try {
			session.save(user);
			tran.commit();
			session.close();
			return true;
		}catch(Exception e) {
			System.out.print(e);
			tran.rollback();
			session.close();
			return false;
		}
	} 
	 /** 
     * 根据Email查找用户 
     * @param email 
     * @return 
     */  
    public Users findByEmail(String email) {  
        Session session = sessionFactory.openSession(); 
        Transaction tran=session.beginTransaction();  
        Query query = session.createQuery("from Users where user_email=?");  
        query.setParameter(0, email);
        Users user=(Users) query.uniqueResult();
        tran.commit();
        session.close();
        return user;
    }  
  
    /** 
     * 更新用户状态  
     * @param status 
     */  
    public boolean updateUserStatus(Users user, int status) {  
    	 Session session = sessionFactory.openSession(); 
         Transaction tran=session.beginTransaction();  
         
         try {
        	 user.setStatus(status);
             session.update(user);
             tran.commit();
             session.close();
 			 return true;
 		 }catch(Exception e) {
 			tran.rollback();
 			return false;
 		 }
    } 
    public Users findLoginUser(String email,String password) {
    	Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		
		Query<Users> query=session.createQuery("from Users where user_email=:email and user_passwd=:passwd");
		query.setParameter("email", email);
		query.setParameter("passwd", password);
		Users user=query.uniqueResult();
		tran.commit();
		session.close();
		return user;
    	
    }
    public Users findLoginUserByName(String username) {
    	Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		
		Query<Users> q=session.createQuery("from Users where user_username=?");
		q.setParameter(0,username);
		Users user=q.uniqueResult();
		tran.commit();
		session.close();
		System.out.print(user.getId());
		return user;
    	
    }
    public boolean updateUser(String username,String telephone,String address) {
    	Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		Users user=findLoginUserByName(username);
		Query query=session.createQuery("update Users set user_telephone=?,user_address=? where id=?");
		query.setParameter(0, telephone);
		query.setParameter(1, address);
		query.setParameter(2,user.getId());
		int result=query.executeUpdate();
		//System.out.print(result);
		tran.commit();
		session.close();
		if(result>0) {
			return true;
		}
		return false;
	}
    public boolean updatePhone(String username, String phoneName) {
    	Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		Users user=findLoginUserByName(username);
		Query query=session.createQuery("update Users set user_image=? where id=?");
		query.setParameter(0, phoneName);
		query.setParameter(1, user.getId());
		int result=query.executeUpdate();
		//System.out.print(result);
		tran.commit();
		session.close();
		if(result>0) {
			return true;
		}
		return false;
    }

	public boolean updatePassword(String username, String newPassword) {
		// TODO Auto-generated method stub
		
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		Users user=findLoginUserByName(username);
		Query query=session.createQuery("update Users set user_passwd=? where id=?");
		query.setParameter(0, newPassword);
		query.setParameter(1, user.getId());
		int result=query.executeUpdate();
		//System.out.print(result);
		tran.commit();
		session.close();
		if(result>0) {
			return true;
		}
		return false;
	}
	//分页
	public List<Users> showUserList(int begin,int end){
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		Query<Users> query=session.createQuery("from Users");
		query.setFirstResult(begin-1);
		query.setMaxResults(end-begin+1);
		List<Users> list=query.list();
		tran.commit();
		session.close();
		return list;
	}
	public int amountUsers() {
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		Query<Users> query=session.createQuery("from Users");
		List<Users> list=query.list();
		tran.commit();
		session.close();
		return list.size();
	}
	//删除用户
	public boolean removeUser(int id) {
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		try {
			Users user=session.get(Users.class, id);
			session.remove(user);
			tran.commit();
			session.close();
			return true;
		}catch (Exception e) {
			// TODO: handle exception
			tran.rollback();
			return false;
		}
		
		
		
	}

	public List<Food> showHotFoodFontList() {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<Food> query = session.createQuery("from Food where buyCount > 1000 order by buyCount desc");
		query.setFirstResult(0);
		query.setMaxResults(3);
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list;
	}
	// 查询商品类型
	public List<FoodType> findFoodType() {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();

		Query<FoodType> query = session.createQuery("from FoodType");
		List<FoodType> list = query.list();
		tran.commit();
		session.close();
		return list;
	}
	//查询最新商品
	public List<Food> findNewFoodList() {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		//最近一周
		Date endDate = new Date();//现在
		Calendar cl = Calendar.getInstance();
		cl.setTime(endDate);
		cl.add(Calendar.DATE, -7);
		Date startDate = cl.getTime();//一周前
		Query<Food> query = session.createQuery("from Food where addFoodTime>=? and addFoodTime<=? order by addFoodTime desc");
		query.setParameter(0, startDate);
		query.setParameter(1, endDate);
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list;
	}
	//查询所有热门商品
	public List<Food> findHotFoodList() {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<Food> query = session.createQuery("from Food where buyCount > 1000 order by buyCount desc");
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list;
	}	
	//根据类型名字查询类型
	public FoodType findFoodTypeByName(String name) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<FoodType> query = session.createQuery("from FoodType where typeName=?");
		query.setParameter(0, name);
		FoodType type = query.uniqueResult();
		tran.commit();
		session.close();
		return type;
	}
	
	//分页
	//按照id排序
	public List<Food> getSomeFood(indexPage page) throws SQLException{
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		int begin=1;
		int end=1;
		if(page.getPage_count()==1) {
			begin=1;
			end=page.getColumn_count();
		}else if(page.isLast_page()) {
			begin=(page.getCurrent_page()-1)*page.getColumn_page()+1;
			end=page.getColumn_count();
		}else {
			begin=(page.getCurrent_page()-1)*page.getColumn_page()+1;
			end=begin+page.getColumn_page()-1;
		}
		Query<Food> query = session.createQuery("from Food order by id");
		query.setFirstResult(begin - 1);
		query.setMaxResults(end - begin + 1);
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list;
	}
	
	public int getCount() throws SQLException {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<Food> query = session.createQuery("from Food");
		List<Food> food=query.list();
		tran.commit();
		session.close();
		return food.size();
	}
	//各个类别商品分页
	//查询某个类型的商品数目
	public int getCountById(int id) throws SQLException {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<FoodType> query = session.createQuery("from FoodType where id=?");
		query.setParameter(0, id);
		FoodType type=query.uniqueResult();
		tran.commit();
		session.close();
		return type.getFoodSet().size();
	}
	//通过类别查询 分页
	public List<Food> selectFoodByTypeId(int id,indexPage page) throws SQLException {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		int begin=1;
		int end=1;
		if(page.getPage_count()==1) {
			begin=1;
			end=page.getColumn_count();
		}else if(page.isLast_page()) {
			begin=(page.getCurrent_page()-1)*page.getColumn_page()+1;
			end=page.getColumn_count();
		}else {
			begin=(page.getCurrent_page()-1)*page.getColumn_page()+1;
			end=begin+page.getColumn_page()-1;
		}
		Query<FoodType> query = session.createQuery("from FoodType where id=?");
		query.setParameter(0, id);
		FoodType type=query.uniqueResult();
		List<Food> list=new ArrayList<>();
		list.addAll(type.getFoodSet());
		List<Food> list1=new ArrayList<>();
		if(list.size()!=0) {
			list1=list.subList(begin - 1, end);
		}
		tran.commit();
		session.close();
		return list1;
		
	}
	//分页     价格排序
	public List<Food> getSomeFood_1(indexPage page) throws SQLException{
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		int begin=1;
		int end=1;
		if(page.getPage_count()==1) {
			begin=1;
			end=page.getColumn_count();
		}else if(page.isLast_page()) {
			begin=(page.getCurrent_page()-1)*page.getColumn_page()+1;
			end=page.getColumn_count();
		}else {
			begin=(page.getCurrent_page()-1)*page.getColumn_page()+1;
			end=begin+page.getColumn_page()-1;
		}
		Query<Food> query = session.createQuery("from Food order by price ");
		query.setFirstResult(begin - 1);
		query.setMaxResults(end - begin + 1);
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list;
	}
	//分页     销量排序
	public List<Food> getSomeFood_2(indexPage page) throws SQLException{
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		int begin=1;
		int end=1;
		if(page.getPage_count()==1) {
			begin=1;
			end=page.getColumn_count();
		}else if(page.isLast_page()) {
			begin=(page.getCurrent_page()-1)*page.getColumn_page()+1;
			end=page.getColumn_count();
		}else {
			begin=(page.getCurrent_page()-1)*page.getColumn_page()+1;
			end=begin+page.getColumn_page()-1;
		}
		Query<Food> query = session.createQuery("from Food order by buyCount desc ");
		query.setFirstResult(begin - 1);
		query.setMaxResults(end - begin + 1);
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list;
	}	
	//查询最新商品  分页
	public List<Food> getSomeFood_3(indexPage page) throws SQLException{
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		int begin=1;
		int end=1;
		if(page.getPage_count()==1) {
			begin=1;
			end=page.getColumn_count();
		}else if(page.isLast_page()) {
			begin=(page.getCurrent_page()-1)*page.getColumn_page()+1;
			end=page.getColumn_count();
		}else {
			begin=(page.getCurrent_page()-1)*page.getColumn_page()+1;
			end=begin+page.getColumn_page()-1;
		}
		Date endDate = new Date();//现在
		Calendar cl = Calendar.getInstance();
		cl.setTime(endDate);
		cl.add(Calendar.DATE, -7);
		Date startDate = cl.getTime();//一周前
		Query<Food> query = session.createQuery("from Food where addFoodTime>=? and addFoodTime<=? order by addFoodTime desc");
		query.setParameter(0, startDate);
		query.setParameter(1, endDate);
		query.setFirstResult(begin - 1);
		query.setMaxResults(end - begin + 1);
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list;
	}	
	//查询最新一周内商品数量
	public int amountNewFood() {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		//最近一周
		Date endDate = new Date();//现在
		Calendar cl = Calendar.getInstance();
		cl.setTime(endDate);
		cl.add(Calendar.DATE, -7);
		Date startDate = cl.getTime();//一周前
		Query<Food> query = session.createQuery("from Food where addFoodTime>=? and addFoodTime<=?");
		query.setParameter(0, startDate);
		query.setParameter(1, endDate);
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list.size();
	}	
	//查询热门商品 分页
	public List<Food> getSomeFood_4(indexPage page) throws SQLException{
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		int begin=1;
		int end=1;
		if(page.getPage_count()==1) {
			begin=1;
			end=page.getColumn_count();
		}else if(page.isLast_page()) {
			begin=(page.getCurrent_page()-1)*page.getColumn_page()+1;
			end=page.getColumn_count();
		}else {
			begin=(page.getCurrent_page()-1)*page.getColumn_page()+1;
			end=begin+page.getColumn_page()-1;
		}
		Query<Food> query = session.createQuery("from Food where buyCount > 1000 order by buyCount desc");
		query.setFirstResult(begin - 1);
		query.setMaxResults(end - begin + 1);
		
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list;
	}	
	
	//热门商品数量
	public int amountHotFood() {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<Food> query = session.createQuery("from Food where buyCount > 1000");
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list.size();
	}
	//搜索结果 分页
	public List<Food> getSomeFood_5(indexPage page,String searchFoodName) throws SQLException{
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		int begin=1;
		int end=1;
		if(page.getPage_count()==1) {
			begin=1;
			end=page.getColumn_count();
		}else if(page.isLast_page()) {
			begin=(page.getCurrent_page()-1)*page.getColumn_page()+1;
			end=page.getColumn_count();
		}else {
			begin=(page.getCurrent_page()-1)*page.getColumn_page()+1;
			end=begin+page.getColumn_page()-1;
		}
		String sql="from Food where foodName like '%"+searchFoodName+"%'" +"order by buyCount desc";
		Query<Food> query = session.createQuery(sql);
		query.setFirstResult(begin - 1);
		query.setMaxResults(end - begin + 1);
		
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list;
	}	
	public int amountSearchFood(String searchFoodName) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		String sql="from Food where foodName like '%"+searchFoodName+"%'" +"order by buyCount desc";
		Query<Food> query = session.createQuery(sql);
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list.size();
	}	
	//根据id查询商品
	public Food findFoodById(int foodId) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Food food = null;
		try {
			food=session.get(Food.class, foodId);
			
			tran.commit();
			session.close();
			
		} catch (Exception e) {
			tran.rollback();
		}
		return food;
	}

	public Boolean addReceiveAddress(Users user, Address address) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		
		try {
			user.getAddressSet().add(address);
			address.setUser(user);
			session.update(user);
			session.save(address);
			tran.commit();
			session.close();
			return true;
		}catch(Exception e) {
			System.out.print(e);
			tran.rollback();
			session.close();
			return false;
		}
	}
	//删除收货地址
	public boolean removeAddress(int id, Users u) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		try {
			Address address=session.get(Address.class, id);
			u.getAddressSet().remove(address);
			session.clear();
			session.remove(address);
			session.update(u);
			tran.commit();
			session.close();
			return true;
		}catch(Exception e) {
			System.out.println(e);
			tran.rollback();
			session.close();
			return false;
		}
	}
	//查询地址
	public Address findAddress(int id) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		Address address=session.get(Address.class, id);
		tran.commit();
		session.close();
		return address;
	}
	//更新地址
	public boolean updateAddress(int addressId, Address address, Users u) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		try {
			Address a=session.get(Address.class, addressId);
			u.getAddressSet().remove(a);
			
			a.setUsername(address.getUsername());
			a.setMailNum(address.getMailNum());
			a.setPhoneNum(address.getPhoneNum());
			a.setProvincial(address.getProvincial());
			a.setCity(address.getCity());
			a.setCounties(address.getCounties());
			a.setStreet(address.getStreet());
			a.setUser(u);
			
			u.getAddressSet().add(a);
			session.clear();
			session.update(u);
			session.update(a);
			tran.commit();
			session.close();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
			tran.rollback();
			session.close();
			return false;
		}
		
		
		
	}	
	//生成未支付订单
	public int addOrders(Users user) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		Object id=null;
		try {
			Orders order=new Orders();
			order.setOrder_time(new Date());
			order.setOrder_state("未支付");
			order.setUser(user);
			user.getOrderSet().add(order);
			session.update(user);
			session.save(order);
			id = session.getIdentifier(order);//订单id
			tran.commit();
			session.close();
			
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
			tran.rollback();
		}
		return (int)id;
	}
	//根据id查询订单
	public Orders findOrder(int orderId) {
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		Orders order=session.get(Orders.class, orderId);
		tran.commit();
		session.close();
		return order;
	}
	//增加订单id所对应的订单详情  关联关系
	public boolean addOrderDetail(shoppingCartList productCart, int orderId) {
		// TODO Auto-generated method stub
		Orders order=findOrder(orderId);
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		try {
			for(CartFoodBean bean : productCart) {
				OrderDetail detail=new OrderDetail();
				detail.setCount(bean.getCount());
				detail.setOrder(order);
				detail.setFood(bean.getProduct());
				order.getDetailSet().add(detail);
				bean.getProduct().getDetailSet().add(detail);
				session.update(order);
				session.save(detail);
				session.update(bean.getProduct());
			}
			tran.commit();
			session.close();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			tran.rollback();
			return false;
		}
		
	}
	//查询订单对应 的所有订单详情
	public List<OrderDetail> selectOrderDetailByOrder_id(int orderId) {
		// TODO Auto-generated method stub
		Orders order=findOrder(orderId);
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		Query<OrderDetail> query = session.createQuery("from OrderDetail where order=? ");
		query.setParameter(0, order);
		List<OrderDetail> list=query.list();
		tran.commit();
		session.close();
		return list;
	}
	//根据id查询地址
	public Address findAddressById(int id) {
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		Address address=null;
		try {
			address=session.get(Address.class,id);
			tran.commit();
			session.close();
			
		} catch (Exception e) {
			System.out.println(e);
			tran.rollback();
		}
		return address;
	}
	//给订单添加地址
	public  boolean setAddressToOrder(String addressToOrder, int id) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		try {
			Orders order=session.get(Orders.class, id);
			order.setAddress(addressToOrder);
			session.update(order);
			tran.commit();
			session.close();
			return true;
			
		} catch (Exception e) {
			System.out.println(e);
			tran.rollback();
		}
		return false;
	}
	//修改状态
	public boolean updateOrderStatus(int id, String status) {
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		try {
			Orders order=session.get(Orders.class, id);
			order.setOrder_state(status);;
			session.update(order);
			tran.commit();
			session.close();
			return true;
			
		} catch (Exception e) {
			System.out.println(e);
			tran.rollback();
		}
		return false;
	}
	//添加销售量
	public void addCount(Food food, int count) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		Query query=session.createQuery("update Food set buyCount=? where id=?");
		query.setParameter(0, count+food.getBuyCount());
		query.setParameter(1, food.getId());
		int result=query.executeUpdate();
		//System.out.print(result);
		tran.commit();
		session.close();
		
	}
	//取消订单
	public boolean cancelOrder(int orderId) {
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		try {
			Orders order=session.get(Orders.class, orderId);
			session.remove(order);
			tran.commit();
			session.close();
			return true;
			
		} catch (Exception e) {
			System.out.println(e);
			tran.rollback();
			session.close();
			return false;
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
}

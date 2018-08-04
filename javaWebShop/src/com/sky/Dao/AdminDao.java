package com.sky.Dao;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sky.Bean.Admin;
import com.sky.Bean.Food;
import com.sky.Bean.FoodType;
import com.sky.Bean.Orders;
import com.sky.Bean.Users;

@Repository
public class AdminDao {
	@Autowired
	private SessionFactory sessionFactory;

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public Admin findLoginAdmin(String adminEmail, String adminPassword) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();

		Query<Admin> query = session.createQuery("from Admin where admin_email=:email and admin_passwd=:passwd");
		query.setParameter("email", adminEmail);
		query.setParameter("passwd", adminPassword);
		Admin admin = query.uniqueResult();
		// System.out.print(admin.getPerson().getRealName());
		tran.commit();
		session.close();
		return admin;
	}

	public boolean findAdminUsername(String name) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();

		Query<Admin> query = session.createQuery("from Admin where admin_username=:name");
		query.setParameter("name", name);
		List<Admin> list = query.list();
		tran.commit();
		session.close();
		if (list.size() == 0) {

			return false;
		} else {
			return true;
		}

	}

	public boolean findAdminEmail(String email) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();

		Query<Admin> query = session.createQuery("from Admin where admin_email=:email");
		query.setParameter("email", email);
		List<Admin> list = query.list();
		tran.commit();
		session.close();
		if (list.size() == 0) {

			return false;
		} else {
			return true;
		}
	}

	//
	public boolean saveAdmin(Admin admin) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();

		try {
			session.save(admin);
			tran.commit();
			session.close();
			return true;
		} catch (Exception e) {
			System.out.print(e);
			tran.rollback();
			session.close();
			return false;
		}
	}

	public boolean updateAdminStatus(Admin admin, int status) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();

		try {
			admin.setStatus(status);
			session.update(admin);
			tran.commit();
			session.close();
			return true;
		} catch (Exception e) {
			tran.rollback();
			return false;
		}
	}

	public Admin findByEmail(String email) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query query = session.createQuery("from Admin where admin_email=?");
		query.setParameter(0, email);
		Admin admin = (Admin) query.uniqueResult();
		tran.commit();
		session.close();
		return admin;
	}

	public int WatchAdminStatus(String email) {
		Admin admin = findByEmail(email);
		return admin.getStatus();
	}

	//
	public Admin findLoginAdminByName(String AdminUsername) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();

		Query<Admin> q = session.createQuery("from Admin where admin_username=?");
		q.setParameter(0, AdminUsername);
		Admin admin = q.uniqueResult();
		tran.commit();
		session.close();
		return admin;

	}

	public boolean updateAdmin(String AdminUsername, String telephone, String address) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Admin admin = findLoginAdminByName(AdminUsername);
		Query query = session.createQuery("update Admin set telephone=?,address=? where id=?");
		query.setParameter(0, telephone);
		query.setParameter(1, address);
		query.setParameter(2, admin.getId());
		int result = query.executeUpdate();
		// System.out.print(result);
		tran.commit();
		session.close();
		if (result > 0) {
			return true;
		}
		return false;
	}

	public boolean updateAdminPhone(String AdminUsername, String phoneName) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Admin admin = findLoginAdminByName(AdminUsername);
		Query query = session.createQuery("update Admin set admin_image=? where id=?");
		query.setParameter(0, phoneName);
		query.setParameter(1, admin.getId());
		int result = query.executeUpdate();
		// System.out.print(result);
		tran.commit();
		session.close();
		if (result > 0) {
			return true;
		}
		return false;
	}

	public boolean updateAdminPassword(String username, String newPassword) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Admin admin = findLoginAdminByName(username);
		Query query = session.createQuery("update Admin set admin_passwd=? where id=?");
		query.setParameter(0, newPassword);
		query.setParameter(1, admin.getId());
		int result = query.executeUpdate();
		// System.out.print(result);
		tran.commit();
		session.close();
		if (result > 0) {
			return true;
		}
		return false;
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

	// 添加商品类型
	public boolean addFoodType(String foodTypeName) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		FoodType type = new FoodType();
		type.setTypeName(foodTypeName);
		try {
			session.save(type);
			tran.commit();
			session.close();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			tran.rollback();
			return false;
		}
	}

	// 删除类别
	public boolean deleteFoodType(int foodTypeId) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		try {
			FoodType type = session.get(FoodType.class, foodTypeId);
			session.delete(type);
			tran.commit();
			session.close();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			tran.commit();
			return false;
		}

	}

	// 更新类别
	public boolean updateFoodType(int foodId, String foodTypeName) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();

		try {
			FoodType type = session.get(FoodType.class, foodId);
			type.setTypeName(foodTypeName);
			tran.commit();
			session.close();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			tran.rollback();
			return false;
		}
	}

	// 查询商品
	// 分页
	public List<Food> showFoodList(int begin, int end) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<Food> query = session.createQuery("from Food");
		query.setFirstResult(begin - 1);
		query.setMaxResults(end - begin + 1);
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list;
	}
	//商品数量
	public int amountFood() {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<Food> query = session.createQuery("from Food");
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list.size();
	}
	
	
	//添加商品
	public boolean addFood(Food food, String typeId) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();

		try {
			FoodType type=session.get(FoodType.class, Integer.parseInt(typeId));
			type.getFoodSet().add(food);
			food.setType(type);
			session.save(food);
			tran.commit();
			session.close();
			return true;
		} catch (Exception e) {
			System.out.print(e);
			tran.rollback();
			session.close();
			return false;
		}
	}
	//删除商品
	public boolean removeFood(int id) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();

		try {
			Food food=session.get(Food.class, id);
			
			session.delete(food);
			tran.commit();
			session.close();
			return true;
		} catch (Exception e) {
			tran.rollback();
			session.close();
			return false;
		}
	}
	//根据iD查询商品
	public Food findFoodById(int id) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Food food = null;
		try {
			food=session.get(Food.class, id);
			
			tran.commit();
			session.close();
			
		} catch (Exception e) {
			tran.rollback();
		}
		return food;
	}
	//根据foodId查询FoodType
	public FoodType findFoodTypeByFoodId(int id) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		FoodType foodType=null;
		try {
			Food food=session.get(Food.class, id);
			foodType=food.getType();
			tran.commit();
			session.close();
			
		} catch (Exception e) {
			tran.rollback();
			
			
		}
		return foodType;
	}
	public boolean updateFood(Food food, String typeId) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		
		try {
			FoodType foodType=findFoodTypeByFoodId(food.getId());
			Food selectFood=session.get(Food.class, food.getId());
			foodType.getFoodSet().remove(selectFood);
			FoodType type=session.get(FoodType.class,Integer.parseInt(typeId));
			type.getFoodSet().add(food);
			food.setType(type);
			session.update(type);
			session.clear();//必须清理，否则session中会存在两个id相同的同一个类的对象
			session.update(foodType);
			session.update(food);
			tran.commit();
			session.close();
			return true;
		} catch (Exception e) {
			System.out.print(e);
			tran.rollback();
			session.close();
			return false;
		}
		
	}

	public boolean updateFoodImg(int foodId, String phoneName) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		Query query=session.createQuery("update Food set foodImgurl=? where id=?");
		query.setParameter(0, phoneName);
		query.setParameter(1, foodId);
		int result=query.executeUpdate();
		//System.out.print(result);
		tran.commit();
		session.close();
		if(result>0) {
			return true;
		}
		return false;
	}
	public FoodType findTypeById(int foodTypeId) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<FoodType> query = session.createQuery("from FoodType where id=?");
		query.setParameter(0, foodTypeId);
		FoodType type=query.uniqueResult();
		
		tran.commit();
		session.close();
		return type;
	}
	//查询热门商品
	public List<Food> showHotFoodList(int begin, int end) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<Food> query = session.createQuery("from Food where buyCount > 1000 order by buyCount desc");
		query.setFirstResult(begin - 1);
		query.setMaxResults(end - begin + 1);
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list;
	}
	//查询热门关键词
	public List<String> showHotFoodFontList() {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<String> query = session.createQuery("select foodName from Food where buyCount > 1000 order by buyCount desc");
		query.setFirstResult(0);
		query.setMaxResults(3);
		List<String> list = query.list();
		tran.commit();
		session.close();
		return list;
	}
	//商品数量
	public int amountHotFood() {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<Food> query = session.createQuery("from Food where buyCount > 1000");
		List<Food> list = query.list();
		tran.commit();
		session.close();
		return list.size();
	}
	//查询最新一周内的商品
	public List<Food> showNewFoodList(int begin, int end) {
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
	//搜索商品
	public List<Food> searchFoodSubmit(String searchFoodName,int begin,int end) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
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
	//展示所有的订单  分页（不包括后台已删除状态）
	public List<Orders> showAllOrders(int begin, int end) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<Orders> query = session.createQuery("from Orders where order_state !=?");
		query.setParameter(0, "后台已删除");
		query.setFirstResult(begin - 1);
		query.setMaxResults(end - begin + 1);
		List<Orders> list = query.list();
		tran.commit();
		session.close();
		return list;
	}
	//所有订单数量（不包括后台已删除状态）
	public int amountOrders() {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<Orders> query = session.createQuery("from Orders where order_state !=?");
		query.setParameter(0, "后台已删除");
		List<Orders> list = query.list();
		tran.commit();
		session.close();
		return list.size();
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
	//修改状态
	public boolean changeOrderStatus(int orderId, String status) {
		// TODO Auto-generated method stub
		Session session=sessionFactory.openSession();
		Transaction tran =session.beginTransaction();
		try {
			Orders order=session.get(Orders.class, orderId);
			order.setOrder_state(status);
			session.update(order);
			tran.commit();
			session.close();
			return true;
		} catch (Exception e) {
			System.out.println(e);
			return false;
		}
		
	}
	//显示各类订单的数量    未支付，已支付，已发货
	public int amountVarietyOrders(String status) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<Orders> query = session.createQuery("from Orders where order_state=?");
		query.setParameter(0, status);
		List<Orders> list = query.list();
		tran.commit();
		session.close();
		return list.size();
	}
	//显示各类订单的数量   已完成  前台已删除
	public int amountVarietyOrders1(String status) {
		// TODO Auto-generated method stub
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<Orders> query = session.createQuery("from Orders where order_state=? or order_state='前台已删除'");
		query.setParameter(0, status);
		List<Orders> list = query.list();
		tran.commit();
		session.close();
		return list.size();
	}
	//分页显示各类订单  未支付，已支付，已发货
	public List<Orders> showVarietyOrders(int begin, int end, String status) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<Orders> query = session.createQuery("from Orders where order_state=?");
		query.setParameter(0, status);
		query.setFirstResult(begin - 1);
		query.setMaxResults(end - begin + 1);
		List<Orders> list = query.list();
		tran.commit();
		session.close();
		return list;
	}	
	//前台已删除  已完成
	public List<Orders> showVarietyOrders1(int begin, int end, String status) {
		Session session = sessionFactory.openSession();
		Transaction tran = session.beginTransaction();
		Query<Orders> query = session.createQuery("from Orders where order_state=? or order_state='前台已删除'");
		query.setParameter(0, status);
		query.setFirstResult(begin - 1);
		query.setMaxResults(end - begin + 1);
		List<Orders> list = query.list();
		tran.commit();
		session.close();
		return list;
	}
	//删除订单
	public boolean deleteOrder(int orderId) {
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

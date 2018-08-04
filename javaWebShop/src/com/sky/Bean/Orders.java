package com.sky.Bean;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Orders {
	private int id;
	private Date order_time;
	private String order_state;
	private Users user;
	private String address;
	private Set<OrderDetail> detailSet=new HashSet<OrderDetail>();
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	
	public Set getDetailSet() {
		return detailSet;
	}
	public void setDetailSet(Set detailSet) {
		this.detailSet = detailSet;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getOrder_time() {
		return order_time;
	}
	public void setOrder_time(Date order_time) {
		this.order_time = order_time;
	}
	public String getOrder_state() {
		return order_state;
	}
	public void setOrder_state(String order_state) {
		this.order_state = order_state;
	}
	public Users getUser() {
		return user;
	}
	public void setUser(Users user) {
		this.user = user;
	}
	public double allPrice() {
		double allPrice=0;
		for(OrderDetail detail:detailSet) {
			allPrice+=detail.getFood().getPrice()*detail.getCount();
		}
		return allPrice;
	}
	
}

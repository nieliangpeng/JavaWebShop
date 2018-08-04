package com.sky.Bean;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class Food {
	private int id;
	private String foodName;
	private double price;
	private String description;
	private String foodImgurl;
	private FoodType type;
	private Date addFoodTime; //添加食物时间
	private int buyCount;//该商品总的购买的数量
	private Set detailSet=new HashSet<OrderDetail>();
	
	public int getBuyCount() {
		return buyCount;
	}
	public void setBuyCount(int buyCount) {
		this.buyCount = buyCount;
	}
	public Date getAddFoodTime() {
		return addFoodTime;
	}
	public void setAddFoodTime(Date addFoodTime) {
		this.addFoodTime = addFoodTime;
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
	public String getFoodName() {
		return foodName;
	}
	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getFoodImgurl() {
		return foodImgurl;
	}
	public void setFoodImgurl(String foodImgurl) {
		this.foodImgurl = foodImgurl;
	}
	public FoodType getType() {
		return type;
	}
	public void setType(FoodType type) {
		this.type = type;
	}
	
}

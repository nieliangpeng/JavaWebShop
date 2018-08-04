package com.sky.common;

import com.sky.Bean.Food;
public class CartFoodBean {
	private int count;//商品数量
	private Food product;//哪个商品
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Food getProduct() {
		return product;
	}
	public void setProduct(Food product) {
		this.product = product;
	}
	//该商品的总金额
	public Double getTotalCost() {
		return  product.getPrice()*count;
	}
}

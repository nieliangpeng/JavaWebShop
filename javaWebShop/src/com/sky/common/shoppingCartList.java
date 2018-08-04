package com.sky.common;

import java.util.ArrayList;
public class shoppingCartList extends ArrayList<CartFoodBean>  {
	public boolean add(CartFoodBean cartFoodBean) {
		super.add(cartFoodBean);
		return true;
	}

	public CartFoodBean remove(int index) {
		super.remove(index);
		return super.get(index);
	}

	public CartFoodBean get(int index) {
		return super.get(index);
	}

	public int size() {
		return super.size();
	}
	//看购物车中是否已经有该商品的存在
	public boolean equals(CartFoodBean bean) {
		for (int i = 0; i < this.size(); i++) {
			//存在，直接加数量
			if (this.get(i).getProduct().getId() == bean.getProduct().getId() ) {
				this.get(i).setCount(this.get(i).getCount() +bean.getCount() );
				// System.out.println(i);
				return true;
			}
		}
		return false;
	}
	//更新
	public void update(CartFoodBean bean) {
		for (int i = 0; i < this.size(); i++) {
			
			if (this.get(i).getProduct().getId() == bean.getProduct().getId()) {
				this.get(i).setCount(bean.getCount() );
				
			}
		}
		
	}
	//商品的id 单个删除
	public boolean delete(int id) {
		for (int i = 0; i < this.size(); i++) {
			if (this.get(i).getProduct().getId() == id) {
				super.remove(i);
				return true;
			}
		}
		return false;
	}
	//批量删除
	public boolean deleteIdList(int[] idList) {
		int count=0;
		for(int i=0;i<idList.length;i++) {
			for (int j = 0; j < this.size(); j++) {
				if (this.get(j).getProduct().getId() == idList[i]) {
					super.remove(j);
					count++;
					break;
				}
			}
		}
		if(count==idList.length) {
			return true;
		}
		return false;
	}	
	//清空购物车列表   删除所有
	public boolean removeAll() {
		return super.removeAll(this);
	}
	
	//购物车中的所有的总额
	public double getTotalCost() {
		double totalCost = 0;
		for (int i = 0; i < this.size(); i++) {
			totalCost = totalCost + this.get(i).getTotalCost();
		}
		return totalCost;
	}
}

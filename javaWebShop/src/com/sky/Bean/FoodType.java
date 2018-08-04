package com.sky.Bean;

import java.util.HashSet;
import java.util.Set;

public class FoodType {
	private int id;
	private String typeName;
	private Set foodSet=new HashSet<Food>();
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public Set getFoodSet() {
		return foodSet;
	}
	public void setFoodSet(Set foodSet) {
		this.foodSet = foodSet;
	}
	
}

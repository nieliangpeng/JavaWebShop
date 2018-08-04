package com.sky.Bean;

import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

public class Users {
	
	private int id;
	private String user_username;
	private String user_passwd;
	private String user_email;
	private String user_telephone;
	private String user_address;
	private String user_image;
	//激活
	private Integer status;//状态，0-未激活；1-已激活  
    private String validateCode;//激活码  
    private Date registerTime;//注册时间  
    private Set addressSet=new HashSet<Address>();
	private Set orderSet=new HashSet<Orders>();
	
	public Set getOrderSet() {
		return orderSet;
	}
	public void setOrderSet(Set orderSet) {
		this.orderSet = orderSet;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUser_username() {
		return user_username;
	}
	public void setUser_username(String user_username) {
		this.user_username = user_username;
	}
	public String getUser_passwd() {
		return user_passwd;
	}
	public void setUser_passwd(String user_passwd) {
		this.user_passwd = user_passwd;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_telephone() {
		return user_telephone;
	}
	public void setUser_telephone(String user_telephone) {
		this.user_telephone = user_telephone;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public String getUser_image() {
		return user_image;
	}
	public void setUser_image(String user_image) {
		this.user_image = user_image;
	}
	public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    public Set getAddressSet() {
		return addressSet;
	}
	public void setAddressSet(Set addressSet) {
		this.addressSet = addressSet;
	}
	public String getValidateCode() {
        return validateCode;
    }

    public void setValidateCode(String validateCode) {
        this.validateCode = validateCode;
    }
    public Date getRegisterTime() {  
        return registerTime;  
    }  
  
    public void setRegisterTime(Date registerTime) {  
        this.registerTime = registerTime;  
    }
   
    public Date getLastActivateTime() {  
        Calendar cl = Calendar.getInstance();  
        cl.setTime(registerTime);  
        cl.add(Calendar.DATE , 2);  
          
        return cl.getTime();  
    }  
	
}

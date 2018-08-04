package com.sky.Bean;

import java.util.Calendar;
import java.util.Date;

public class Admin {
	private Integer id;
	private String admin_username;
	private String admin_passwd;
	private String admin_image;
	private String admin_email;
	private String telephone;
	private String address;
	private Integer status;//状态，0-未激活；1-已激活  
    private String validateCode;//激活码  
    private Date registerTime;//注册时间  
	private Person person;
	
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
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
	public Person getPerson() {
		return person;
	}
	public void setPerson(Person person) {
		this.person = person;
	}
	public String getAdmin_email() {
		return admin_email;
	}
	public void setAdmin_email(String admin_email) {
		this.admin_email = admin_email;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAdmin_username() {
		return admin_username;
	}
	public void setAdmin_username(String admin_username) {
		this.admin_username = admin_username;
	}
	public String getAdmin_passwd() {
		return admin_passwd;
	}
	public void setAdmin_passwd(String admin_passwd) {
		this.admin_passwd = admin_passwd;
	}
	public String getAdmin_image() {
		return admin_image;
	}
	public void setAdmin_image(String admin_image) {
		this.admin_image = admin_image;
	}
	public Date getLastActivateTime() {  
        Calendar cl = Calendar.getInstance();  
        cl.setTime(registerTime);  
        cl.add(Calendar.DATE , 2);  
          
        return cl.getTime();  
    }  
}

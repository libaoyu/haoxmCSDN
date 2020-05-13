package com.mybatis.bean;

import java.util.List;

public class Menu {

	private String id;
	private String pid;
	private String name;
	private List<Menu> listMenu;
	
	public List<Menu> getListMenu() {
		return listMenu;
	}
	public void setListMenu(List<Menu> listMenu) {
		this.listMenu = listMenu;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}

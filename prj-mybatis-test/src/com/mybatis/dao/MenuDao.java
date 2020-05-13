package com.mybatis.dao;

import com.mybatis.bean.Menu;

public interface MenuDao {
	
	Menu selectMenu(String name);
}

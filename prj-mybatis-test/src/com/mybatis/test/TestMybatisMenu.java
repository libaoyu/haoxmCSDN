package com.mybatis.test;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.mybatis.bean.Menu;
import com.mybatis.dao.MenuDao;

public class TestMybatisMenu {

	public static void main(String[] args) throws IOException {
		
		String xml = "mybatis-config.xml";
		InputStream inputStream = Resources.getResourceAsStream(xml);
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		SqlSession session = sqlSessionFactory.openSession();
		
		MenuDao menuDao = session.getMapper(MenuDao.class);
		Menu menu = menuDao.selectMenu("0");
//		getMenuName(menuDao,menu);
//		List<Menu> list = menu.getListMenu();
//		for (Menu menu2 : list) {
//			System.out.println(menu2.getName());
//		}
		
//		String xmlStr = getMenuName(menu,menu.getName()+"__");
//		System.out.println(xmlStr);
	}
	
//	public static String getMenuName(MenuDao menuDao,Menu menu){
//		
//		if (menu==null) {
//			return "";
//		}else{
//			List<Menu> listMenu = menuDao.selectMenu(menu.getId()).getListMenu();
//			for (Menu menu2 : listMenu) {
//				return menu2.getName();
//			}
//			
//		}
//	}

}

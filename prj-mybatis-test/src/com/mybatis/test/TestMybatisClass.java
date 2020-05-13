package com.mybatis.test;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
//import org.apache.ibatis.session.SqlSessionManager;
import org.apache.log4j.Logger;

import com.mybatis.bean.ClassInfo;
import com.mybatis.dao.ClassDao;
import com.mybatis.dao.StudentDao;

public class TestMybatisClass {
	
	Logger logger = Logger.getLogger(TestMybatisClass.class);

	@SuppressWarnings("deprecation")
	public static void main(String[] args) throws IOException {
		
		String resource = "mybatis-config.xml";
		InputStream input = Resources.getResourceAsStream(resource);
//		SqlSessionManager mannager = SqlSessionManager.newInstance(input);
		SqlSessionFactory mannager = new SqlSessionFactoryBuilder().build(input);
		SqlSession session = mannager.openSession();
		
//		ClassDao dao = session.getMapper(ClassDao.class);
//		List<ClassInfo> classInfo = dao.selectAllClass();
//		for (ClassInfo info:classInfo) {
//			if (info!=null) {
//				System.out.println("班级："+info.getId()+" 性别："+info.getTeacher_sex()+" 年龄："+info.getTeacher_age()+" 姓名："+info.getTeacher_name());
//			}
//		}
//		
//		ClassInfo classInfo1 = dao.selectClassOne("110");
//		System.out.println("班级："+classInfo1.getId()+" 性别："+classInfo1.getTeacher_sex()+" 年龄："+classInfo1.getTeacher_age()+" 姓名："+classInfo1.getTeacher_name());
		
//		List<ClassInfo> classInfo = session.selectList("selectAllClass");
//		for (ClassInfo info : classInfo) {
//			if ("110".equals(info.getClass_id())) {
//				System.out.println("老师姓名："+info.getClass_teacher_name());
//			}
//		}
		
//		ClassInfo info2 = session.selectOne("selectClassOne");
//		System.out.println(info2.getClass_teacher_name());
		
//		Map map = session.selectMap("selectAllClass", "class_id");
//		System.out.println(map+"_______"+map.get("111"));
//		session.close();
		
//		StudentDao dao = session.getMapper(StudentDao.class);
//		StudentInfo stuInfo = dao.selectStudentForStudentID("110001");
//		System.out.println(stuInfo.getStudent_name());
		
//		ClassDao classDao = session.getMapper(ClassDao.class);
//		ClassInfo classInfo = classDao.selectOneClass("张老师", 35);
//		System.out.println(classInfo.getClass_teacher_sex());
		
//		ClassDao classDao = session.getMapper(ClassDao.class);
//		ClassInfo classInfo = new ClassInfo();
//		classInfo.setClass_teacher_name("张老师");
//		classInfo.setClass_teacher_age(35);
//		ClassInfo classInfo1 = classDao.selectOneClass(classInfo);
//		System.out.println(classInfo1.getClass_teacher_sex());
		
//		ClassDao classDao = session.getMapper(ClassDao.class);
//		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("class_teacher_name", "张老师");
//		map.put("class_teacher_age", 35);
//		ClassInfo classInfo = classDao.selectOneClass(map);
//		System.out.println(classInfo.getClass_teacher_sex());
		
//		ClassDao classDao = session.getMapper(ClassDao.class);
//		Map<String,Object> map = new HashMap<String,Object>();
//		ClassInfo classInfo = new ClassInfo();
//		classInfo.setClass_teacher_name("张老师");
//		classInfo.setClass_teacher_age(35);
//		map.put("classInfo", classInfo);
//		ClassInfo classInfo1 = classDao.selectOneClass(map);
//		System.out.println(classInfo1.getClass_teacher_sex());
		
//		ClassDao classDao = session.getMapper(ClassDao.class);
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("clumn_name", "class_teacher_name");
//		map.put("class_id", "110");
//		map.put("paixu_flag", "asc");
//		classDao.selectOneClass(map);
		
//		ClassDao classDao = session.getMapper(ClassDao.class);
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("table_name", "class");
//		classDao.selectTableClumn(map);
		
//		ClassDao classDao = session.getMapper(ClassDao.class);
//		List<Map<String, Object>> classMap = classDao.selectMoHu("老师");
//		List<Map> map = classDao.selectMoHu("老师");
//		Set<String> set = classMap.keySet();
//		for (String key : set) {
//			System.out.println(classMap.get(key));
//		}
//		System.out.println(new JSONArray(classMap).toString());
//		for (Map<String, Object> map : classMap) {
//			System.out.println(new JSONObject(map).toString());
//			Set<String> set = map.keySet();
//			for (String key : set) {
//				System.out.println(map.get(key));
//			}
//		}
//		session.close();
//		System.out.println("***************************");
//		SqlSession sqlSession = mannager.openSession();
//		ClassDao classDao1 = sqlSession.getMapper(ClassDao.class);
//		List<Map<String, Object>> classMap1 = classDao1.selectMoHu("老师");
//		System.out.println(new JSONArray(classMap1).toString());
		
//		ClassDao classDao = session.getMapper(ClassDao.class);
//		Map<Long,Map> map = classDao.selectMoHu("老师");
//		Map<Long,Map> map1 = classDao.selectMoHu("老师");
//		System.out.println(new JSONObject(map).toString());
		
//		session.commit(true);
//		ClassDao classDao = session.getMapper(ClassDao.class);
//		ClassInfo classInfo = new ClassInfo("112", "王老师", 42, "女");
//		classDao.insertClass(classInfo);
		
//		ClassDao classDao = session.getMapper(ClassDao.class);
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("class_teacher_name", "赵老师");
//		map.put("class_id", "112");
//		classDao.updateClass(map);
		
//		ClassDao classDao = session.getMapper(ClassDao.class);
//		classDao.deletClass("112");
		
//		ClassDao classDao = session.getMapper(ClassDao.class);
//		ClassInfo classInfo = new ClassInfo("112", "王老师", 42, "女");
//		classDao.insertClass(classInfo);
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("class_teacher_name", "赵老师");
//		map.put("class_id", "112");
//		classDao.updateClass(map);
//		classDao.deletClass("112");
		
//		session.commit();
//		session.close();
		
		//一对多
		ClassDao classDao = session.getMapper(ClassDao.class);
		ClassInfo classInfo = classDao.selectStudentByClass("110");
//		System.out.println(classInfo.getStudentList().size());
		System.out.println(classInfo.getClass_teacher_name());
	}

}

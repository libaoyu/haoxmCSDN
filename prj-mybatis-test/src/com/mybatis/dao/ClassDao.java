package com.mybatis.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.mybatis.bean.ClassInfo;
import com.mybatis.bean.StudentInfo;

public interface ClassDao {
	
//	List<ClassInfo> selectAllClass();
//	
//	ClassInfo selectClassOne(String id);
	
//	ClassInfo selectOneClass(@Param(value = "class_teacher_name") String name ,@Param(value = "class_teacher_age") int age);
	
//	ClassInfo selectOneClass(ClassInfo info);

//	List<ClassInfo> selectOneClass(Map map);
	
//	Map<String,Object> selectMoHu(String name);
	
//	List<Map> selectMoHu(String name);

//	List<ClassInfo> selectTableClumn(Map map);
	
//	List<Map<String,Object>> selectMoHu(String name);

//	Map<Long,Map> selectMoHu(String name);

//	void insertClass(ClassInfo classInfo);
	
//	void updateClass(Map<String,Object> map);
	
//	void deletClass(String id);
	
	ClassInfo selectStudentByClass(String id);
}

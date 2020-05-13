package com.mybatis.dao;

import com.mybatis.bean.StudentInfo;

public interface StudentDao {
	
//	StudentInfo selectStudentForStudentID(String id);
	
//	List<StudentInfo> luoJiFenYe(); 
	
//	List<StudentInfo> wuLiFenYe(Map<String,Object> map); 
	
//	List<StudentInfo> dongTaiChaXun(Map<String,Object> map);
	//错误例子由于学生表与班级表关联 外键无法得到更新又没有默认值导致无法做插入更新操作
//	void insertStudent(StudentInfo studentInfo);
	
	StudentInfo selectClassTeacherName(String name);
}

package com.mybatis.dao;

import com.mybatis.bean.StudentInfo;

public interface StudentDao {
	
//	StudentInfo selectStudentForStudentID(String id);
	
//	List<StudentInfo> luoJiFenYe(); 
	
//	List<StudentInfo> wuLiFenYe(Map<String,Object> map); 
	
//	List<StudentInfo> dongTaiChaXun(Map<String,Object> map);
	//������������ѧ������༶����� ����޷��õ�������û��Ĭ��ֵ�����޷���������²���
//	void insertStudent(StudentInfo studentInfo);
	
	StudentInfo selectClassTeacherName(String name);
}

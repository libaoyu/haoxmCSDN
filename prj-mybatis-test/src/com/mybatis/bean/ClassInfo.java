package com.mybatis.bean;

import java.io.Serializable;
import java.util.List;

public class ClassInfo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String  class_id;
	private String  class_teacher_name;
	private int  class_teacher_age;
	private String  class_teacher_sex;
	private List<StudentInfo> studentList;
	public String getClass_id() {
		return class_id;
	}
	public void setClass_id(String class_id) {
		this.class_id = class_id;
	}
	public List<StudentInfo> getStudentList() {
		return studentList;
	}
	public void setStudentList(List<StudentInfo> studentList) {
		this.studentList = studentList;
	}
	public String getClass_teacher_name() {
		return class_teacher_name;
	}
	public void setClass_teacher_name(String class_teacher_name) {
		this.class_teacher_name = class_teacher_name;
	}
	public int getClass_teacher_age() {
		return class_teacher_age;
	}
	public void setClass_teacher_age(int class_teacher_age) {
		this.class_teacher_age = class_teacher_age;
	}
	public String getClass_teacher_sex() {
		return class_teacher_sex;
	}
	public void setClass_teacher_sex(String class_teacher_sex) {
		this.class_teacher_sex = class_teacher_sex;
	}
}

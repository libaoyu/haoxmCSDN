package com.mybatis.bean;

public class StudentInfo {

	private String student_id;
	private String student_name;
	private String student_sex;
	private String student_age;
	private String student_course;
	private String student_class_id;
	private ClassInfo classInfo;
	
	public ClassInfo getClassInfo() {
		return classInfo;
	}
	public void setClassInfo(ClassInfo classInfo) {
		this.classInfo = classInfo;
	}
	public String getStudent_id() {
		return student_id;
	}
	public void setStudent_id(String student_id) {
		this.student_id = student_id;
	}
	public String getStudent_name() {
		return student_name;
	}
	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}
	public String getStudent_sex() {
		return student_sex;
	}
	public void setStudent_sex(String student_sex) {
		this.student_sex = student_sex;
	}
	public String getStudent_age() {
		return student_age;
	}
	public void setStudent_age(String student_age) {
		this.student_age = student_age;
	}
	public String getStudent_course() {
		return student_course;
	}
	public void setStudent_course(String student_course) {
		this.student_course = student_course;
	}
	public String getStudent_class_id() {
		return student_class_id;
	}
	public void setStudent_class_id(String student_class_id) {
		this.student_class_id = student_class_id;
	}
	
}

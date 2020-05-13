package com.mybatis.test;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.mybatis.bean.StudentInfo;
import com.mybatis.dao.StudentDao;

public class TestMybatisStudent {

	public static void main(String[] args) throws IOException {
		
		String str = "mybatis-config.xml";
		InputStream stream = Resources.getResourceAsStream(str);
		SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(stream);
		SqlSession session = sessionFactory.openSession();
		
//		int pageno = 2;
//		int pagesize = 2;
		//�����ҳ
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("startIndex", (pageno-1)*pagesize);
//		map.put("pagesize", pagesize);
//		StudentDao studentDao = session.getMapper(StudentDao.class);
//		List<StudentInfo> list = studentDao.wuLiFenYe(map);
		
		//�߼���ҳ
//		StudentDao studentDao = session.getMapper(StudentDao.class);
//		List<StudentInfo> list = studentDao.luoJiFenYe();
//		RowBounds rowBounds = new RowBounds((pageno-1)*pagesize, pagesize);
//		List<StudentInfo> list = session.selectList("luoJiFenYe", null, rowBounds);
//		System.out.println(new JSONArray(list));
		
//		StudentDao studentDao = session.getMapper(StudentDao.class);
//		Map<String, Object> map = new HashMap<String, Object>();
//		List<String> list = new ArrayList<String>();
//		list.add("110001");
//		list.add("111001");
//		map.put("ids", list);
//		map.put("username", "zhangsan");
//		studentDao.dongTaiChaXun(map);
		//������������ѧ������༶����� ����޷��õ�������û��Ĭ��ֵ�����޷���������²���
//		StudentDao studentDao = session.getMapper(StudentDao.class);
//		StudentInfo studentInfo = new StudentInfo("112001", "zhaoliu", "��", "16", "���");
//		studentDao.insertStudent(studentInfo);
		//���һ
		StudentDao studentDao = session.getMapper(StudentDao.class);
		
		StudentInfo student = studentDao.selectClassTeacherName("zhangsan");
		
//		System.out.println(student.getClassInfo().getClass_teacher_name());
	}

}

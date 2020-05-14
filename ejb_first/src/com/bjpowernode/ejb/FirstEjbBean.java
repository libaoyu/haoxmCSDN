package com.bjpowernode.ejb;

import javax.ejb.Local;
import javax.ejb.Remote;
import javax.ejb.Stateless;


@Stateless
@Local
//@Remote
public class FirstEjbBean implements FirstEjb {

	public String sayHello(String name) {
		return "hello " + name;
	}
}

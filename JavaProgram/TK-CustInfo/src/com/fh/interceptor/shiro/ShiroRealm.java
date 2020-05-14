package com.fh.interceptor.shiro;


import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import com.fh.entity.system.User;
import com.fh.util.Const;


/**
 * @author fh
 *  2015-3-6
 */
public class ShiroRealm extends AuthorizingRealm {

	/*
	 * 登录信息和用户验证信息验证(non-Javadoc)
	 * @see org.apache.shiro.realm.AuthenticatingRealm#doGetAuthenticationInfo(org.apache.shiro.authc.AuthenticationToken)
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		 String username = (String)token.getPrincipal();  				//得到用户名 
	     String password = new String((char[])token.getCredentials()); 	//得到密码
	     if(null != username && null != password){
	    	 return new SimpleAuthenticationInfo(username, password, getName());
	     }else{
	    	 return null;
	     }
	}
	
	/*
	 * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用,负责在应用程序中决定用户的访问控制的方法(non-Javadoc)
	 * @see org.apache.shiro.realm.AuthorizingRealm#doGetAuthorizationInfo(org.apache.shiro.subject.PrincipalCollection)
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection pc) {
		/****/
		System.out.println("========2");
		return null;
		
		/**
		 * create by zxq at 2017.11.28 begin
		 
		User user = (User) SecurityUtils.getSubject().getSession().getAttribute(Const.SESSION_USER); 
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();  
		info.addRole(user.getRole().getROLE_ID());
		return info;
		*/
		/**
		 * create by zxq at 2017.11.28 end
		 */
	}

}

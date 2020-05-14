package com.fh.util;

public class BizOutMap extends TKMap {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4272613146467658519L;
	
	/***
	 * 标记是否意外情况不成功
	 */
	private static final String SUCCESS = "success";
	
	public BizOutMap() {
		this.put(SUCCESS, true);
	}
	
	public Boolean getSuccess() {
		return this.getBoolean(SUCCESS);
	}

	public void setSuccess(Boolean success) {
		this.put(SUCCESS, success);
	}

	
}

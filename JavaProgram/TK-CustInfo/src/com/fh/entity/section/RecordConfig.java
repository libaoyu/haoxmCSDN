package com.fh.entity.section;

/** 
 * 类名称：RecordController
 * 创建人：shanghaizhao 
 * 创建时间：2017-11-06
 * 配置表实体类
 */
public class RecordConfig {
	
	private String configureId;
	private String fieldName;
	private String label;
	private String hosipitalId;
	private String interType;//同家医院的不同接口
	private String isShow;
	private String showType;
	private String fieldOrder;
	
	public String getShowType() {
		return showType;
	}
	public void setShowType(String showType) {
		this.showType = showType;
	}
	public String getConfigureId() {
		return configureId;
	}
	public void setConfigureId(String configureId) {
		this.configureId = configureId;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public String getInterType() {
		return interType;
	}
	public void setInterType(String interType) {
		this.interType = interType;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getHosipitalId() {
		return hosipitalId;
	}
	public void setHosipitalId(String hosipitalId) {
		this.hosipitalId = hosipitalId;
	}
	public String getIsShow() {
		return isShow;
	}
	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}
	public String getFieldOrder() {
		return fieldOrder;
	}
	public void setFieldOrder(String fieldOrder) {
		this.fieldOrder = fieldOrder;
	}
	
}

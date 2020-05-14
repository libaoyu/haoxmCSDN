package com.fh.entity.system;

import java.util.Date;

public class QuestionsHeader {
	/**
	 * 问卷头的实体
	 * by xiaoding
	 */
	private String headerId;//标题id
	private String batchId;//问卷批次号
	private String questionnaireId;//问卷编号
	private String titleName;////问题编号ID
	private String titleValue;//值
	private String createUser;//创建人。未登陆用户默认为    
	private Date creatTime;//创建时间
	private String respondentCode;//调查对象
	private String column1;
	private String column2;
	private String column3;
	private String remarks;
	
	
	
	
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getColumn1() {
		return column1;
	}
	public void setColumn1(String column1) {
		this.column1 = column1;
	}
	public String getColumn2() {
		return column2;
	}
	public void setColumn2(String column2) {
		this.column2 = column2;
	}
	public String getColumn3() {
		return column3;
	}
	public void setColumn3(String column3) {
		this.column3 = column3;
	}
	public String getRespondentCode() {
		return respondentCode;
	}
	public void setRespondentCode(String respondentCode) {
		this.respondentCode = respondentCode;
	}
	public String getQuestionnaireId() {
		return questionnaireId;
	}
	public void setQuestionnaireId(String questionnaireId) {
		this.questionnaireId = questionnaireId;
	}
	public String getHeaderId() {
		return headerId;
	}
	public void setHeaderId(String headerId) {
		this.headerId = headerId;
	}
	public String getBatchId() {
		return batchId;
	}
	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}
	public String getTitleName() {
		return titleName;
	}
	public void setTitleName(String titleName) {
		this.titleName = titleName;
	}
	public String getTitleValue() {
		return titleValue;
	}
	public void setTitleValue(String titleValue) {
		this.titleValue = titleValue;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	public Date getCreatTime() {
		return creatTime;
	}
	public void setCreatTime(Date creatTime) {
		this.creatTime = creatTime;
	}
	
}

package com.fh.entity.questionnaire;

import java.io.Serializable;
import java.util.List;

import com.fh.util.PageData;
/**
 * 
* 类名称：Menu.java
* 类描述： 
* @author FH
* 作者单位： 
* 联系方式：
* 创建时间：2017年4月11日
* @version 1.0
 */
public class QuestionnaireTemp implements Serializable{
	
	private String questionId;//问卷，问题的id
	private String questionnaireId;//问卷的id
	private String batchId;//批次号
	private String parentId;//父类id
	private String questionCode;//问题的code
	private String title;//标题
	private String level;//问题类型(级别)
	private String classification;//问题等级:卷头、一级分类、二级分类
	private String types;//题型(单选、多选)
	private String scaleType;//量表类型
	private String scaleRange;//量表范围
	private String questionData;//数据
	private String sort;//排序字段
	private Integer mustFlag;//必填标识                1 表示必填，0表示不必天
	private String description;//备注/描述
	private  String createUser;
	private String createTime;
	private String modifyUser;
	
	private  String modifyTime;
	private Integer status=0;//结果表是否有效1表示无效0表示有效
	private Integer isRight=0;//导入问卷的格式是否正确0表示正确1表示不正确
	private Integer isImport=0;//是否导入到正式表：0表示未导入，1表示导入
	private String isQuestionnaire;//字段判断是问卷还是问题：questionnaire表示问卷，question表示问题   question_header代表问卷卷头的数据 
	
	private String whereIsError;//错误数据在什么位置。
	
	private String allBatchId;//导入的批次号
	private String preface;//卷首语
	
	private String DEPARTMENT_ID;
	private String CREATE_USER;
	
	
	private List<PageData> childTemp;
	
	
	
	private String respondentsParentId;//调查对象类型（父类）
	
	
	
	
	
	public String getRespondentsParentId() {
		return respondentsParentId;
	}
	public void setRespondentsParentId(String respondentsParentId) {
		this.respondentsParentId = respondentsParentId;
	}
	public String getDEPARTMENT_ID() {
		return DEPARTMENT_ID;
	}
	public void setDEPARTMENT_ID(String dEPARTMENT_ID) {
		DEPARTMENT_ID = dEPARTMENT_ID;
	}
	public String getCREATE_USER() {
		return CREATE_USER;
	}
	public void setCREATE_USER(String cREATE_USER) {
		CREATE_USER = cREATE_USER;
	}
	public String getAllBatchId() {
		return allBatchId;
	}
	public void setAllBatchId(String allBatchId) {
		this.allBatchId = allBatchId;
	}
	public List<PageData> getChildTemp() {
		return childTemp;
	}
	public void setChildTemp(List<PageData> childTemp) {
		this.childTemp = childTemp;
	}
	public String getPreface() {
		return preface;
	}
	public void setPreface(String preface) {
		this.preface = preface;
	}
	@Override
	public String toString() {
		return "QuestionnaireTemp [questionId=" + questionId
				+ ", questionnaireId=" + questionnaireId + ", batchId="
				+ batchId + ", parentId=" + parentId + ", questionCode="
				+ questionCode + ", title=" + title + ", level=" + level
				+ ", classification=" + classification + ", types=" + types
				+ ", scaleType=" + scaleType + ", scaleRange=" + scaleRange
				+ ", questionData=" + questionData + ", sort=" + sort
				+ ", mustFlag=" + mustFlag + ", description=" + description
				+ ", createUser=" + createUser + ", createTime=" + createTime
				+ ", modifyUser=" + modifyUser + ", modifyTime=" + modifyTime
				+ ", status=" + status + ", isRight=" + isRight + ", isImport="
				+ isImport + ", isQuestionnaire=" + isQuestionnaire
				+ ", whereIsError=" + whereIsError + ", preface=" + preface
				+ "]";
	}
	public String getWhereIsError() {
		return whereIsError;
	}
	public void setWhereIsError(String whereIsError) {
		this.whereIsError = whereIsError;
	}
	public String getIsQuestionnaire() {
		return isQuestionnaire;
	}
	public void setIsQuestionnaire(String isQuestionnaire) {
		this.isQuestionnaire = isQuestionnaire;
	}
	public String getQuestionId() {
		return questionId;
	}
	public void setQuestionId(String questionId) {
		this.questionId = questionId;
	}
	public String getQuestionnaireId() {
		return questionnaireId;
	}
	public void setQuestionnaireId(String questionnaireId) {
		this.questionnaireId = questionnaireId;
	}
	public String getBatchId() {
		return batchId;
	}
	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getQuestionCode() {
		return questionCode;
	}
	public void setQuestionCode(String questionCode) {
		this.questionCode = questionCode;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getClassification() {
		return classification;
	}
	public void setClassification(String classification) {
		this.classification = classification;
	}
	public String getTypes() {
		return types;
	}
	public void setTypes(String types) {
		this.types = types;
	}
	public String getScaleType() {
		return scaleType;
	}
	public void setScaleType(String scaleType) {
		this.scaleType = scaleType;
	}
	public String getScaleRange() {
		return scaleRange;
	}
	public void setScaleRange(String scaleRange) {
		this.scaleRange = scaleRange;
	}
	public String getQuestionData() {
		return questionData;
	}
	public void setQuestionData(String questionData) {
		this.questionData = questionData;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public Integer getMustFlag() {
		return mustFlag;
	}
	public void setMustFlag(Integer mustFlag) {
		this.mustFlag = mustFlag;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getModifyUser() {
		return modifyUser;
	}
	public void setModifyUser(String modifyUser) {
		this.modifyUser = modifyUser;
	}
	public String getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(String modifyTime) {
		this.modifyTime = modifyTime;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getIsRight() {
		return isRight;
	}
	public void setIsRight(Integer isRight) {
		this.isRight = isRight;
	}
	public Integer getIsImport() {
		return isImport;
	}
	public void setIsImport(Integer isImport) {
		this.isImport = isImport;
	}
	
	
}

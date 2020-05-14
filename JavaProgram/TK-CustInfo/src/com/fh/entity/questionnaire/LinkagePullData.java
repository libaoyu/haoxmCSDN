package com.fh.entity.questionnaire;

import java.io.Serializable;
import java.util.List;

public class LinkagePullData implements Serializable{
	private String linkageId;
	private String linkageName;
	private String parentId;
	private Integer level;
	private String questionnaireId;
	private String createTime;
	private String createUser;
	private String updateTime;
	private String updateUser;
	private long sort;
	
	private LinkagePullData linkage;
	private List<LinkagePullData> subLinkage;
	private String treeurl;
	private String target;
	
	
	public LinkagePullData getLinkage() {
		return linkage;
	}
	public void setLinkage(LinkagePullData linkage) {
		this.linkage = linkage;
	}
	public List<LinkagePullData> getSubLinkage() {
		return subLinkage;
	}
	public void setSubLinkage(List<LinkagePullData> subLinkage) {
		this.subLinkage = subLinkage;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	
	public String getTreeurl() {
		return treeurl;
	}
	public void setTreeurl(String treeurl) {
		this.treeurl = treeurl;
	}
	public long getSort() {
		return sort;
	}
	public void setSort(long l) {
		this.sort = l;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public String getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}
	public String getLinkageId() {
		return linkageId;
	}
	public void setLinkageId(String linkageId) {
		this.linkageId = linkageId;
	}
	public String getLinkageName() {
		return linkageName;
	}
	public void setLinkageName(String linkageName) {
		this.linkageName = linkageName;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}
	public String getQuestionnaireId() {
		return questionnaireId;
	}
	public void setQuestionnaireId(String questionnaireId) {
		this.questionnaireId = questionnaireId;
	}
	@Override
	public String toString() {
		return "LinkagePullData [linkageId=" + linkageId + ", linkageName="
				+ linkageName + ", parentId=" + parentId + ", level=" + level
				+ ", questionnaireId=" + questionnaireId + "]";
	}
	
}

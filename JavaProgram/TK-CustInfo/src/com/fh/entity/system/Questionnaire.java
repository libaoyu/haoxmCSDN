package com.fh.entity.system;

import java.io.Serializable;
import java.util.List;

import com.fh.entity.questionnaire.FileDetails;
/**
 * 
* 类名称：Menu.java
* 类描述： 
* @author FH
* 作者单位： 
* 联系方式：
* 创建时间：2017年5月11日
* @version 1.0
 */
public class Questionnaire implements Serializable{
	private String questionnaireId;//id
	private String title;//标题	
	private String preface;//卷首语
	//private String volumeHeader;//卷头
	private String releaseStatus;//发布状态	
	private String questionUrl;//问卷地址
	private String qrCodePath;//二维码图片
	private String respondents;//受访者
	private String description;
	private Integer validState;
	private String createUser;
	private String createTime;
	private String modifyUser;
	private String modifyTime;
	private String logoImgId;//logo
	private String logoImgPath;
	private Object logoImgFile;
	private String backgroundImgId;//背景
	private String backgroundImgPath;
	private Object backgroundImgFile;
	private List<FileDetails> fileDetails;//文件信息
	private List<Questionnaire> SUBQUESTIONS;
	
	private String startTime;
	private String endTime;
	private String backMusic;
	private boolean backMusicSwith;
	private String finishBackground;
	private String create_user;
	private String department_id;
	
	private String respondentsParentId;//调查对象的父类型
	private String questionnaireType;//问卷的类型
	
	private String bootomType;//星级问卷底部logo
	
	private String hospitalCode;//医院编码
	private String interfaceCode;//医院对应的接口的编码
	private boolean allowedRepeatSwith;//是否允许重复提交开关
	
	private String markedWords;//提示语
	
	public String getMarkedWords() {
		return markedWords;
	}
	public void setMarkedWords(String markedWords) {
		this.markedWords = markedWords;
	}
	public boolean getAllowedRepeatSwith() {
		return allowedRepeatSwith;
	}
	public void setAllowedRepeatSwith(boolean allowedRepeatSwith) {
		this.allowedRepeatSwith = allowedRepeatSwith;
	}
	public String getHospitalCode() {
		return hospitalCode;
	}
	public void setHospitalCode(String hospitalCode) {
		this.hospitalCode = hospitalCode;
	}
	public String getInterfaceCode() {
		return interfaceCode;
	}
	public void setInterfaceCode(String interfaceCode) {
		this.interfaceCode = interfaceCode;
	}
	public String getDepartment_id() {
		return department_id;
	}
	public void setDepartment_id(String department_id) {
		this.department_id = department_id;
	}
	public String getBootomType() {
		return bootomType;
	}
	public void setBootomType(String bootomType) {
		this.bootomType = bootomType;
	}
	public String getRespondentsParentId() {
		return respondentsParentId;
	}
	public void setRespondentsParentId(String respondentsParentId) {
		this.respondentsParentId = respondentsParentId;
	}
	public String getQuestionnaireType() {
		return questionnaireType;
	}
	public void setQuestionnaireType(String questionnaireType) {
		this.questionnaireType = questionnaireType;
	}
	public String getCreate_user() {
		return create_user;
	}
	public void setCreate_user(String create_user) {
		this.create_user = create_user;
	}
	public String getBackMusic() {
		return backMusic;
	}
	public void setBackMusic(String backMusic) {
		this.backMusic = backMusic;
	}
	
	public boolean isBackMusicSwith() {
		return backMusicSwith;
	}
	public void setBackMusicSwith(boolean backMusicSwith) {
		this.backMusicSwith = backMusicSwith;
	}
	public String getFinishBackground() {
		return finishBackground;
	}
	public void setFinishBackground(String finishBackground) {
		this.finishBackground = finishBackground;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getQuestionnaireId() {
		return questionnaireId;
	}
	public void setQuestionnaireId(String questionnaireId) {
		this.questionnaireId = questionnaireId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPreface() {
		return preface;
	}
	public void setPreface(String preface) {
		this.preface = preface;
	}
	public String getReleaseStatus() {
		return releaseStatus;
	}
	public void setReleaseStatus(String releaseStatus) {
		this.releaseStatus = releaseStatus;
	}
	public String getQuestionUrl() {
		return questionUrl;
	}
	public void setQuestionUrl(String questionUrl) {
		this.questionUrl = questionUrl;
	}
	public String getQrCodePath() {
		return qrCodePath;
	}
	public void setQrCodePath(String qrCodePath) {
		this.qrCodePath = qrCodePath;
	}
	public String getRespondents() {
		return respondents;
	}
	public void setRespondents(String respondents) {
		this.respondents = respondents;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getValidState() {
		return validState;
	}
	public void setValidState(Integer validState) {
		this.validState = validState;
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
	public List<Questionnaire> getSUBQUESTIONS() {
		return SUBQUESTIONS;
	}
	public void setSUBQUESTIONS(List<Questionnaire> sUBQUESTIONS) {
		SUBQUESTIONS = sUBQUESTIONS;
	}
	public String getLogoImgId() {
		return logoImgId;
	}
	public void setLogoImgId(String logoImgId) {
		this.logoImgId = logoImgId;
	}
	public String getBackgroundImgId() {
		return backgroundImgId;
	}
	public void setBackgroundImgId(String backgroundImgId) {
		this.backgroundImgId = backgroundImgId;
	}
	public List<FileDetails> getFileDetails() {
		return fileDetails;
	}
	public void setFileDetails(List<FileDetails> fileDetails) {
		this.fileDetails = fileDetails;
	}
	public String getLogoImgPath() {
		return logoImgPath;
	}
	public void setLogoImgPath(String logoImgPath) {
		this.logoImgPath = logoImgPath;
	}
	public String getBackgroundImgPath() {
		return backgroundImgPath;
	}
	public void setBackgroundImgPath(String backgroundImgPath) {
		this.backgroundImgPath = backgroundImgPath;
	}
	public Object getLogoImgFile() {
		return logoImgFile;
	}
	public void setLogoImgFile(Object logoImgFile) {
		this.logoImgFile = logoImgFile;
	}
	public Object getBackgroundImgFile() {
		return backgroundImgFile;
	}
	public void setBackgroundImgFile(Object backgroundImgFile) {
		this.backgroundImgFile = backgroundImgFile;
	}

	
	
	
	
	
}

package com.fh.entity.questionnaire;

import java.io.Serializable;
import java.util.List;
/**
 * 
* 类名称：FileDetails
* 类描述：附件详情
* @author Zhangxq
* 作者单位： 
* 联系方式：
* 创建时间：2017年5月20日
* @version 1.0
 */
public class FileDetails implements Serializable{
    private String fileId;//ID       
    private String ownershipMasterId;//主体编号
    private String category;//业务分类(logo、背景图片)
    private String fileTitle;//标题
    private String fileName;//文件名称   
    private String fileExtension;//文件格式、扩展名
    private String specification;//规范要求
    private String filePath;//存储路径     
    private String description;  
    private String createTime;   
    private String createUser;
    private String modifyUser;
    private String modifyTime;
    private byte[] content;//二进制文件流
    private String enCodePath;//二维码url
    private String shortUrl;//二维码短链接码
    
	public String getShortUrl() {
		return shortUrl;
	}
	public void setShortUrl(String shortUrl) {
		this.shortUrl = shortUrl;
	}
	public String getEnCodePath() {
		return enCodePath;
	}
	public void setEnCodePath(String enCodePath) {
		this.enCodePath = enCodePath;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getOwnershipMasterId() {
		return ownershipMasterId;
	}
	public void setOwnershipMasterId(String ownershipMasterId) {
		this.ownershipMasterId = ownershipMasterId;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getFileTitle() {
		return fileTitle;
	}
	public void setFileTitle(String fileTitle) {
		this.fileTitle = fileTitle;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileExtension() {
		return fileExtension;
	}
	public void setFileExtension(String fileExtension) {
		this.fileExtension = fileExtension;
	}
	public String getSpecification() {
		return specification;
	}
	public void setSpecification(String specification) {
		this.specification = specification;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	public byte[] getContent() {
		return content;
	}
	public void setContent(byte[] content) {
		this.content = content;
	}
    
    
    
    
	
	
	
	
	
	
}

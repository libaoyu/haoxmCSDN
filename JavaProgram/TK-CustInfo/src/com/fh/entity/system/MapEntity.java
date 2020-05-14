package com.fh.entity.system;

public class MapEntity {
	private String key;
	private String value;
	private String enCodePath;
	// addby shanghz 短链接字段
	private String shortUrl;
	//
	private String img;
	
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
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
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	@Override
	public String toString() {
		return "MapEntity [key=" + key + ", value=" + value + ", enCodePath=" + enCodePath + ", shortUrl=" + shortUrl
				+ ", img=" + img + "]";
	}
	
	
	
}

package com.fh.util;

import java.io.IOException;
import java.security.MessageDigest;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;  
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.HttpClientUtils;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;  
import org.slf4j.Logger;  
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONObject;
import com.sun.org.apache.xml.internal.security.utils.Base64;
  
/** 
 * HttpClient4.3工具类 
 * @author shanghaizhao 
 * @date 2017-12-01 
 * 
 */  
public class HttpClientUtil {  
	
	//请求华为的服务基地址
	private static String serverRoot = Const.SERVER_ROOT;
	private static String userName = Const.HW_USERNAME;
	private static String passWord = Const.HW_PASSWORD;
	
    private static Logger logger = LoggerFactory  
            .getLogger(HttpClientUtils.class); // 日志记录  
  
      
    /** 
     * post请求传输json参数 
     *  
     * @param url 
     *            url地址 
     * @param json 
     *            参数 
     * @return 
     */  
    public static JSONObject httpPost(String url, JSONObject jsonParam,String token) {  
        // post请求返回结果  
        CloseableHttpClient httpClient = HttpClients.createDefault();  
        JSONObject jsonResult = null;  
        HttpPost httpPost = new HttpPost(url);  
        // 设置请求和传输超时时间  
        RequestConfig requestConfig = RequestConfig.custom()  
                .setSocketTimeout(2000).setConnectTimeout(2000).build(); 
        httpClient = HttpClients.custom().setDefaultRequestConfig(requestConfig).build();
        //httpPost.setConfig(requestConfig);  
        // 添加请求头token
        if(!Tools.isEmpty(token)) {
        	httpPost.setHeader("token", token);
        }
        try {  
            if (null != jsonParam) {  
                // 解决中文乱码问题  
                StringEntity entity = new StringEntity(jsonParam.toString(),  
                        "utf-8");  
                entity.setContentEncoding("UTF-8");  
                entity.setContentType("application/json");  
                httpPost.setEntity(entity);  
            }  
            CloseableHttpResponse result = httpClient.execute(httpPost);  
            //请求发送成功，并得到响应  
            if (result.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {  
                String str = "";  
                try {  
                    //读取服务器返回过来的json字符串数据   
                    str = EntityUtils.toString(result.getEntity(), "utf-8");  
                    //把json字符串转换成json对象   
                    jsonResult = JSONObject.parseObject(str);  
                } catch (Exception e) {  
                    logger.error("post请求提交失败:" + url, e);  
                }  
            }  
        } catch (IOException e) {  
            logger.error("post请求提交失败:" + url, e);  
        } finally {  
            httpPost.releaseConnection();  
        }  
        return jsonResult;  
    }  
      
      
    /** 
     * post请求传输String参数 
     * 例如：name=Jack&sex=1&type=2 
     * Content-type:application/x-www-form-urlencoded 
     * @param url 
     *            url地址 
     * @param strParam 
     *            参数 
     * @param noNeedResponse 
     *            不需要返回结果 
     * @return 
     */  
    public static JSONObject httpPost(String url, String strParam) {  
        // post请求返回结果  
        CloseableHttpClient httpClient = HttpClients.createDefault();  
        JSONObject jsonResult = null;  
        HttpPost httpPost = new HttpPost(url);  
        // 设置请求和传输超时时间  
        RequestConfig requestConfig = RequestConfig.custom()  
                .setSocketTimeout(2000).setConnectTimeout(2000).build();  
        httpClient = HttpClients.custom().setDefaultRequestConfig(requestConfig).build();
        //httpPost.setConfig(requestConfig); 
        try {  
            if (null != strParam) {  
                // 解决中文乱码问题  
                StringEntity entity = new StringEntity(strParam,"utf-8");  
                entity.setContentEncoding("UTF-8");  
                entity.setContentType("application/x-www-form-urlencoded");  
                httpPost.setEntity(entity);
            }  
            CloseableHttpResponse result = httpClient.execute(httpPost);  
            //请求发送成功，并得到响应  
            if (result.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {  
                String str = "";  
                try {  
                    //读取服务器返回过来的json字符串数据  
                    str = EntityUtils.toString(result.getEntity(), "utf-8");  
                    //把json字符串转换成json对象  
                    jsonResult = JSONObject.parseObject(str);  
                } catch (Exception e) {  
                    logger.error("post请求提交失败:" + url, e);  
                }  
            }  
        } catch (IOException e) {  
            logger.error("post请求提交失败:" + url, e);  
        } finally {  
            httpPost.releaseConnection();  
        }  
        return jsonResult;  
    }  
    
 
  
    /** 
     * 发送get请求 
     *  
     * @param url 
     *            路径 
     * @return 
     */  
    public static JSONObject httpGet(String url,String token) {  
        // get请求返回结果  
        JSONObject jsonResult = null;  
        CloseableHttpClient client = HttpClients.createDefault();  
        // 发送get请求  
        HttpGet request = new HttpGet(url);  
        // 设置请求和传输超时时间  
        RequestConfig requestConfig = RequestConfig.custom()  
                .setSocketTimeout(2000).setConnectTimeout(2000).build();  
        client = HttpClients.custom().setDefaultRequestConfig(requestConfig).build();
        // 添加请求头token
        if(!Tools.isEmpty(token)) {
        	request.setHeader("token", token);
        }
        try {  
            CloseableHttpResponse response = client.execute(request);  
  
            //请求发送成功，并得到响应  
            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {  
                //读取服务器返回过来的json字符串数据  
                HttpEntity entity = response.getEntity();  
                String strResult = EntityUtils.toString(entity, "utf-8");  
                //把json字符串转换成json对象  
                jsonResult = JSONObject.parseObject(strResult);  
            } else {  
                logger.error("get请求提交失败:" + url);  
            }  
        } catch (IOException e) {  
            logger.error("get请求提交失败:" + url, e);  
        } finally {  
            request.releaseConnection();  
        }  
        return jsonResult;  
    }  
    
    
    /***
     * 华为云通信小号平台请求
     *  @author shanghaizhao
     *  @param serviceName 请求地址(不包含基地址)
	 *  @param data 入参
     */
    public static JSONObject hwGet(String serviceName, String data) { 
    	// get请求返回结果  
        JSONObject jsonResult = null;  
        HttpClient httpClient = null;
        String result=null;
        //实际的接口请求服务地址
        String url= serverRoot + serviceName + data;
        try {
        	System.out.println("----get url---------"+url);
    		System.out.println("----get Data---------"+data);
            String Nonce=getRandomStr();
            String Created=DateUtil.getUTCTimeStr();
            
    		httpClient = new HttpsSsl();
    		HttpGet httpGet = new HttpGet(url);
    		
    		//设置方法
    		httpGet.addHeader("Host", serverRoot);       
    		httpGet.addHeader("Content-Type", "application/json; charset=UTF-8");       
    		httpGet.addHeader("Accept", "application/json");       
    		httpGet.addHeader("Authorization", "WSSE realm=\"SDP\",profile=\"UsernameToken\",type=\"Appkey\"");       
    		httpGet.addHeader("X-WSSE", "UsernameToken Username=\""+userName+"\",PasswordDigest=\""+Base64.encode(SHA256(Nonce+Created+passWord))+"\",Nonce=\""+Nonce+"\",Created=\""+Created+"\"");       
    		
    		HttpResponse response = httpClient.execute(httpGet);
    		
    		if(response != null){
    			HttpEntity resEntity = response.getEntity();
    			if(resEntity != null){
    				result = EntityUtils.toString(resEntity, "UTF-8");
    				jsonResult = JSONObject.parseObject(result);
    				System.out.println("----get result---------"+result);
    			}
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
        return jsonResult;  
    }
    
    /**
	 * 以Post方式来调用华为接口
	 * @param serviceName
	 * @param data
	 * @return
	 */   
    public String  invokeHwByPost(String serviceName, String data){
    	HttpClient httpClient = null;
    	String result=null;
    	//实际的接口请求服务地址
    	String url= serverRoot + serviceName;
    	try {
    		System.out.println("----Post url---------"+url);
    		System.out.println("----Post Data---------"+data);
    		String Nonce=getRandomStr();
    		String Created=DateUtil.getUTCTimeStr();
            
    		httpClient = new HttpsSsl();
    		HttpPost httppost = new HttpPost(url);
    		
    		StringEntity myEntity = new StringEntity(data, "UTF-8");
    		//设置方法
    		httppost.addHeader("Host", serverRoot);       
    		httppost.addHeader("httpposttent-Type", "application/json; charset=UTF-8");       
    		httppost.addHeader("Accept", "application/json");       
    		httppost.addHeader("Authorization", "WSSE realm=\"SDP\",profile=\"UsernameToken\",type=\"Appkey\"");       
    		httppost.addHeader("X-WSSE", "UsernameToken Username=\""+userName+"\",PasswordDigest=\""+Base64.encode(SHA256(Nonce+Created+passWord))+"\",Nonce=\""+Nonce+"\",Created=\""+Created+"\"");       
    		httppost.setEntity(myEntity);
    		
    		HttpResponse response = httpClient.execute(httppost);
    		
    		if(response != null){
    			
    			HttpEntity resEntity = response.getEntity();
    			if(resEntity != null){
    				result = EntityUtils.toString(resEntity, "UTF-8");
    				System.out.println("----Post result---------"+result);
    			}
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return result;
    }
    
    
    /**
     * 获取32位随机字符串
     * @param count 位数
     * @return
     */
    private static String getRandomStr() {
        String s = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        StringBuffer str =new StringBuffer() ;
        char c;     
        for (int i = 0; i < 32; i++) {
            c = s.charAt((int) (Math.random() * 36));
            str.append( c);
        }
        return str.toString();
    }
    
    private static byte[] SHA256(String str){
    	byte[] digest2=null;
    	try{
    		MessageDigest digest = MessageDigest.getInstance("SHA-256");
    		digest2 = digest.digest(str.getBytes("utf-8"));
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	
    	return digest2;
    }
    
}
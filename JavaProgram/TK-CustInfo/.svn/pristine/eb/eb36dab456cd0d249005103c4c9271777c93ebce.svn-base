package com.fh.util;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import com.swetake.util.Qrcode;

/**
 * @author lixiaomin
 * @data 2016年8月5日 上午9:14:59
 * @parameter 备注：二维码
 */
public class QRcode {
	public static String path;
	
	public static boolean encode(String srcValue, String qrcodePicfilePath){
			 int MAX_DATA_LENGTH = 200;
		     byte[] d = srcValue.getBytes();
		     int dataLength = d.length;
		     int imageWidth = 139; 
		     int imageHeight = imageWidth;
 
		     BufferedImage bi = new BufferedImage(imageWidth, imageHeight,BufferedImage.TYPE_INT_RGB);
		     Graphics2D g = bi.createGraphics();
		     g.setBackground(Color.WHITE);
		     g.clearRect(0, 0, imageWidth, imageHeight);
		     g.setColor(Color.BLACK);
		     if (dataLength > 0 && dataLength <= MAX_DATA_LENGTH) {
		        Qrcode qrcode = new Qrcode();
		        qrcode.setQrcodeErrorCorrect('M'); 
		        qrcode.setQrcodeEncodeMode('B'); 
		        qrcode.setQrcodeVersion(7);
		        boolean[][] b = qrcode.calQrcode(d);
		        int qrcodeDataLen = b.length;
		        for (int i = 0; i < qrcodeDataLen; i++) {
		           for (int j = 0; j < qrcodeDataLen; j++) {
		              if (b[j][i]) {

		                 g.fillRect(j * 3 + 2, i * 3 + 2, 3, 3); 
		              }
		           }
		        }
		        System.out.println("二维码成功生成！！");
		     } else {
		        System.out.println( dataLength +"大于"+ MAX_DATA_LENGTH);
		        return false;
		     }
		     g.dispose();
		     bi.flush();
		     File f = new File(PathUtil.getClasspath()+ qrcodePicfilePath);
		     path=PathUtil.getClasspath()+ qrcodePicfilePath;
		     System.out.println(PathUtil.getClasspath()+ qrcodePicfilePath);
		    // File f = new File("d:/test/"+qrcodePicfilePath);
		     String suffix = f.getName().substring(f.getName().indexOf(".")+1, f.getName().length());
		     try {
		        ImageIO.write(bi, suffix, f);
		     } catch (IOException ioe) {
		        System.out.println("二维码生成失败" + ioe.getMessage());
		        return false;
		     }
		return true;
		}
	
	public static void main(String[] args) {
		String data = "http://localhost:8080/Tk-WeCht/questionPage/tQPage?pid=fasdfasdfas";

		/**

		* 生成二维码

		*/

		QRcode.encode(data, "alskdjfh.jpg");
 
		/**

		* 解析二维码

		*/

		//CreateQRCode.decode("D:/test/微信公众账号.JPG");

		}
	}

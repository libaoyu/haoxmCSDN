package com.fh.util.exportExcle;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.fh.util.PageData;
import com.fh.util.Tools;

/** 
 *  
 * @类名: ExportToExcelUtil 
 * @描述: 设置excel'的信息 
 * @作者: chenchaoyun0 
 * @日期: 2016-1-28 下午11:19:58 
 * 
 */  
public class ExportToExcelUtil extends AbstractExcelView{  

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		Date date = new Date();
		String filename = Tools.date2Str(date, "yyyyMMddHHmmss");
		HSSFSheet sheet;
		HSSFCell cell;
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename="+filename+".xls");
		sheet = workbook.createSheet("sheet1");
		
		List<String> titles = (List<String>) model.get("titles");
		int len = titles.size();
		HSSFCellStyle headerStyle = workbook.createCellStyle(); //标题样式
		headerStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		headerStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		HSSFFont headerFont = workbook.createFont();	//标题字体
		headerFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		headerFont.setFontHeightInPoints((short)11);
		headerStyle.setFont(headerFont);
		short width = 20,height=25*20;
		sheet.setDefaultColumnWidth(width);
		for(int i=0; i<len; i++){ //设置标题
			String title = titles.get(i);
			cell = getCell(sheet, 0, i);
			cell.setCellStyle(headerStyle);
			setText(cell,title);
		}
		sheet.getRow(0).setHeight(height);
		HSSFPatriarch patriarch = sheet.createDrawingPatriarch();  
		HSSFCellStyle contentStyle = workbook.createCellStyle(); //内容样式
		contentStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		List<PageData> varList = (List<PageData>) model.get("varList");
		int varCount = varList.size();
		for(int i=0; i<varCount; i++){//行数
			PageData vpd = varList.get(i);
			int countCell=0;
			for(int j=0;j<len;j++){//列数
				if(j<8){
					try {
						String varstr = vpd.getString("var"+(j+1)) != null ? vpd.getString("var"+(j+1)) : "";
						cell = getCell(sheet, i+1, j);
						cell.setCellStyle(contentStyle);
						setText(cell,varstr);
					} catch (Exception e) {
						int varInt =  (Integer) vpd.get("var"+(j+1));
						cell = getCell(sheet, i+1, j);
						cell.setCellStyle(contentStyle);
						cell.setCellValue(varInt);
					}
					countCell=j;
				}// addby shanghz 20170703 导出excel列数大于8行时
				else{
					String varstr = vpd.getString("var"+(j+1)) != null ? vpd.getString("var"+(j+1)) : "";
					cell = getCell(sheet, i+1, j);
					cell.setCellStyle(contentStyle);
					setText(cell,varstr);
				}
			}
			List<BufferedImage> listBufferedImage=(List<BufferedImage>)vpd.get("listBufferedImage");
			if(listBufferedImage!=null){
				for (int k = 0; k < listBufferedImage.size(); k++) {
					BufferedImage image=listBufferedImage.get(k);
					ByteArrayOutputStream byteArrayOut = new ByteArrayOutputStream();  
		            ImageIO.write(image, "jpg", byteArrayOut);  
		            HSSFClientAnchor anchor = new HSSFClientAnchor(0, 0, 0, 0,  (short)(k+8), i+1, (short) (k+9), (i+2));  
		            anchor.setAnchorType(0);  
		            // 插入图片  
		            patriarch.createPicture(anchor, workbook.addPicture(  
		                    byteArrayOut.toByteArray(),  
		                    HSSFWorkbook.PICTURE_TYPE_JPEG));
				}
			}
		}
		
	}  
}  
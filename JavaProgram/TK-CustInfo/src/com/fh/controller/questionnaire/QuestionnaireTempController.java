package com.fh.controller.questionnaire;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.set.CompositeSet.SetMutator;
import org.apache.ibatis.annotations.Param;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.xmlbeans.impl.piccolo.io.FileFormatException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.util.Utils;
import com.alibaba.fastjson.JSON;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.questionnaire.QuestionnaireTemp;
import com.fh.entity.system.Questionnaire;
import com.fh.entity.system.Questions;
import com.fh.entity.system.User;
import com.fh.service.fhoa.department.impl.DepartmentService;
import com.fh.service.questionnaire.QuestionnaireTempService;
import com.fh.service.questionnaire.QuestionsService;
import com.fh.service.system.dictionaries.impl.DictionariesService;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.ConversionUtil;
import com.fh.util.DateUtil;
import com.fh.util.FileDownload;
import com.fh.util.FileUpload;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.Tools;
@Controller
@RequestMapping(value="/questionnaireTemp")
public class QuestionnaireTempController extends BaseController{
	
	@Resource(name="questionnaireTempService")
	private  QuestionnaireTempService questionnaireTempService;
	@Resource(name="questionsService")
	private QuestionsService questionsService;
	@Resource(name="departmentService")
	private DepartmentService departmentService;
	
	
	@Resource(name="dictionariesService")
	private DictionariesService dictionariesService;
	
	String menuUrl = "questionnaire/list.do"; //菜单地址(权限用)
	
	@RequestMapping(value="toImportExcle")
	public ModelAndView toImportExcle(){
		ModelAndView view =new ModelAndView();
		view.setViewName("questionnaire/questionnaireTemp/questionnaireTempForImp");
		List<PageData> listPage=new ArrayList<PageData>();
		String batchId=null;
		view.addObject("listPage",listPage);
		view.addObject("batchId", batchId);
		return view;
	}
	
	@RequestMapping(value="importExcle")
	public ModelAndView importExcle(@RequestParam(value = "file", required = true) MultipartFile uploadFile,HttpServletRequest request,@Param("filepath ") String filepath,Page page,String allBatchId ){
		ModelAndView view=new ModelAndView();
		Date date=new Date();
		String questionIdFirst="";
		 List<String> listBatchId=new ArrayList<String>();
		List<QuestionnaireTemp> listPage=null;
		String batchId=null;
		PageData pd=this.getPageData();
		if(uploadFile!=null &&uploadFile.getSize()>0){
			String path=request.getSession().getServletContext().getRealPath("uploadFiles/questionnaire");
			File file = new File(path + File.separator );
			if(!file.exists()){//目录不存在则直接创建
	            file.mkdirs();
		    }
			
			if(uploadFile!=null){
				String body="";  
			    String ext="";
			    String fileName=uploadFile.getOriginalFilename();
			    int pot=fileName.lastIndexOf(".");  
			    if(pot!=-1){  
		          body= date.getTime() +"";  
			    }else{  
		          body=(new Date()).getTime()+"";  
			    }  
			    String newName=body+ext; 
			    FileUpload.fileUp(uploadFile,  file.getAbsolutePath(),newName);
			   
			    try {
			    	ext=fileName.substring(pot);  
			    	String fileReadPath=path+ File.separator+newName+ext;
					Map<String ,Object> map=readExcle(fileReadPath,allBatchId);//(Map<String ,List<QuestionnaireTemp>>)
					 if(map!=null){
						 //                           根据   调查对象去数据字典里面查询       对应的父类          并且只能存在一个父类。否则调查对象全部错误        开始           
						 Map<String,String> levelMap=(Map<String,String>)map.get("levelList");
						 map.remove("levelList");
						 Set<String> setLevel= levelMap.keySet();
						 String levelStr="('";
						 for (String str : setLevel) {
							 levelStr+="','"+str;
						 }
						 levelStr=levelStr+"')";
						 pd.put("levelStr", levelStr);
						 List<PageData> listLevelData= dictionariesService.findListCountByName(pd);
						 
						 boolean isError=false;
						 if(listLevelData!=null&&!listLevelData.isEmpty()){
							 if(listLevelData.size()>=2){
								 isError=true;
							 }else{
								 listLevelData=dictionariesService.findListDataByName(pd);
							 }
						 }else{
							 isError=true;
						 }
						 //结束
						 List<QuestionnaireTemp> saveList=new ArrayList<QuestionnaireTemp>();
						 Set<String> set= map.keySet();
						 for (String str : set) {
							 listBatchId.add(str);
							 @SuppressWarnings("unchecked")
							List<QuestionnaireTemp> list=(List<QuestionnaireTemp>)map.get(str);
							 if(list!=null ){
								 QuestionnaireTemp temp=list.get(0);
								 String questionnaireId=temp.getQuestionnaireId();
								 String questionId=temp.getQuestionId();
								 if(Tools.isEmpty(questionIdFirst)){
									 if(Tools.isEmpty(questionnaireId)&&!Tools.isEmpty(questionId)){
										 questionIdFirst=questionId;
									 }else if(!Tools.isEmpty(questionnaireId)){
										 questionIdFirst=questionnaireId;
									 }
								 }
							 }
//							 questionnaireTempService.saveList(list);
							 saveList.addAll(list);
							 System.out.println(list.toString());
						}
						for (int i = 0; i < saveList.size(); i++) {
							QuestionnaireTemp temp =saveList.get(i);
							if(isError){
								saveList.get(i).setIsRight(1);
								String whereIsError=temp.getWhereIsError();
						        StringBuffer returnStr;
						        if(!Tools.isEmpty(whereIsError)){
						        	 returnStr= new StringBuffer(whereIsError);
						        }else{
						        	 returnStr= new StringBuffer("");
						        }
						        returnStr.append("调查对象填写了多个类型：错误");
								saveList.get(i).setWhereIsError(returnStr.toString());
							}else{
								//获取调查对象的父类id
								PageData pageData=listLevelData.get(0);
								String parentId=pageData.getString("PARENT_CODE");
								String levelStrForTemp=temp.getLevel();
								String levelCode=getLevelForName(levelStrForTemp,listLevelData);
								saveList.get(i).setLevel(levelCode);
								saveList.get(i).setRespondentsParentId(parentId);
							}
						} 
						questionnaireTempService.saveList(saveList);
					 }
					 FileUpload.delFile(file.getAbsolutePath());
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (FileFormatException e) {
					e.printStackTrace();
				}catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		if(!Tools.isEmpty(questionIdFirst)){
			pd.put("questionId", questionIdFirst);
		}
		PageData data=null;
		 if(listBatchId!=null &&listBatchId.size()>0){
			 batchId=listBatchId.get(0);
			 pd.put("batchId", listBatchId.get(0));
			 page.setPd(pd);
			 try {
//				listPage=questionnaireTempService.getListByListBatchId(page);
				 listPage=questionnaireTempService.getListByListBatchIdByPage(page);
				 data=questionnaireTempService.getBatchIdByQuestionnaireId(pd);
			 } catch (Exception e) {
				e.printStackTrace();
			}
			//获取题型
			TreeMap<String,String> questionType=ConversionUtil.getQuestionType(Const.OPTION_ALL,null);
			
//				Map<String,String> staffLvevl=ConversionUtil.getStaffLevel();
			Map<String,String> staffLvevl=new HashMap<String,String>();
			
			staffLvevl=ConversionUtil.getStaffLevelByParentId(data.getString("respondentsParentId"));
			view.addObject("staffLvevl",staffLvevl);
			view.addObject("questionType",questionType);
			view.addObject("page",page);
			pd.put("allBatchId1", allBatchId);
			view.addObject("pd", pd);
			view.addObject("data", data);
			Map<String,String> questionnaireLevel= new HashMap<String,String>();
			 //问卷调查对象
			 questionnaireLevel=ConversionUtil.getStaffLevelByParentId(data.getString("respondentsParentId"));
			 view.addObject("questionnaireLevel",questionnaireLevel);
			view.addObject("listPage",listPage);
			view.addObject("listData", getAllBatchId(pd));
			view.setViewName("questionnaire/questionnaireTemp/listTemp");
			view.addObject("batchId", batchId);
			view.addObject("allBatchId",DateUtil.getTimes());
		 }
		
		return view;
	}
	
	
	private  Map<String ,Object> readExcle(String filePath,String allBatchId)throws FileNotFoundException, FileFormatException{
		 // 检查  
        preReadCheck(filePath);  
        // 获取workbook对象  
        Workbook workbook = null;  
        //定义一个返回map，里面可以装有多个sheet。
        Map<String ,Object>  map=new HashMap<String, Object>();
        //定义一个调查对象的map用于存储调查对象的集合
       // List<QuestionnaireTemp> levelList=new ArrayList<QuestionnaireTemp>();
        Map<String,String> levelList=new  HashMap<String ,String>();
        try {  
            workbook = getWorkbook(filePath);  
            // 读文件 一个sheet一个sheet地读取  
            for (int numSheet = 0; numSheet < workbook.getNumberOfSheets(); numSheet++) { 
            	//定义一个sheet的list集合。
            	List<QuestionnaireTemp> list=new ArrayList<QuestionnaireTemp>();
                Sheet sheet = workbook.getSheetAt(numSheet);  
                if (sheet == null) {  
                	continue;  
                }  
                if(sheet.getSheetName()!=null &&!sheet.getSheetName().isEmpty()&&sheet.getSheetName().equals("问卷导入说明文档")){
                	continue;
                }
                int firstRowIndex = sheet.getFirstRowNum();  
              //  int lastRowIndex = sheet.getLastRowNum();  
            	String batchId=ConversionUtil.getBatchByRandom(Const.importBatchName);//表示当前问卷的批次号
            	String questionnaireId="";
            	String parentId="";
                //int countColumnIndex=0;//计数器，累计是进入基本信息还是，正文
                int rowNum=sheet.getLastRowNum();//获得总行数
                //首行。的数据
                Row firstRow = sheet.getRow(firstRowIndex); 
                String currentModule="";
                // 读取数据行 
                int countQuestions=0;
                String questionnaireTitle="";
                for (int rowIndex = firstRowIndex + 1; rowIndex <= rowNum ; rowIndex++) {  
                	//公用参数----------------结束
                    Row currentRow = sheet.getRow(rowIndex);// 当前行  
                    int firstColumnIndex = currentRow.getFirstCellNum(); // 首列
                    //  int lastColumnIndex = currentRow.getLastCellNum();// 最后一列
                    //获取每行。数据：     
                         //当前行  第一列的数据
                         Cell currentCell = currentRow.getCell(firstColumnIndex);// 当前的行的第一列的 
                         String currentCellValue = getCellValue(currentCell, true);// 当前单元格的值
                    if(!Tools.isEmpty(currentCellValue)&& ("问卷标题".equals(currentCellValue))){
                    	Cell currentCell1 = currentRow.getCell(1);// 当前的行的第一列的 
                    	String currentCellValue1 = getCellValue(currentCell1, true);// 当前单元格的值
                    	questionnaireTitle=currentCellValue1;
                    	continue;
                    }

                	QuestionnaireTemp temp=new QuestionnaireTemp();
                	//公用参数    ---------------开始
                	String questionsId=this.get32UUID();
                	temp.setQuestionId(questionsId);//铸件id
                	temp.setBatchId(batchId);//批次号
                	temp.setCreateTime(DateUtil.getTime());
                	temp.setCreateUser(Jurisdiction.getLoginUser().getUSER_ID());
                	// 获取当前登录用户的信息以及其子级部门列表
            		User user = Jurisdiction.getLoginUser();
//                	部门
                	temp.setDEPARTMENT_ID(user.getDepartment().getDEPARTMENT_ID());
                	temp.setCREATE_USER(user.getUSER_ID());

                	temp.setAllBatchId(allBatchId);
                    //代表第一次进来的时候。值为卷首语
                    if(Tools.isEmpty(currentModule)){
                    	currentModule=currentCellValue;
                    }
                    if((!Tools.isEmpty(currentCellValue) && ("卷首语".equals(currentCellValue)) || "客户基本信息".equals(currentCellValue) || "问卷正文".equals(currentCellValue))){
                    	currentModule=currentCellValue;
                    	//continue;
                    }
                    // || "客户基本信息".equals(currentCellValue) || "问卷正文".equals(currentCellValue))
                    if((!Tools.isEmpty(currentCellValue) && "卷首语".equals(currentCellValue)) || (!Tools.isEmpty(currentModule) && "卷首语".equals(currentModule)) ){
                    	currentModule=currentCellValue;
                    	//区分是问卷还是问题：
                    	temp.setIsQuestionnaire("questionnaire");
                    	questionnaireId=temp.getQuestionId();
                    	//获取卷首语
                    	Cell currentCell1 = currentRow.getCell(1);// 当前的行的第一列的 
                    	String currentCellValue1 = getCellValue(currentCell1, true);// 当前单元格的值
                    	//标题为空的时候。这个数据异常
                    	if(Tools.isEmpty(currentCellValue1)){
                    		temp.setIsRight(1);
                    		String whereIsError=getWhereIsError(2,firstRow,temp);
                    		temp.setWhereIsError(whereIsError);
                    	}else{
                    		temp.setPreface(currentCellValue1);
                    	}
                    	//获取问卷标题
                    	temp.setTitle(questionnaireTitle);
                    	Cell currentCell2 = currentRow.getCell(4);// 当前的行的第一列的 
                    	String currentCellValue2 = getCellValue(currentCell2, true);// 当前单元格的值
                    	String level=getStaffLevel(currentCellValue2,levelList);//直接保存所有的调查对象     
                    	if(Tools.isEmpty(level)){
                    		//说明，这个级别错误了。
                    		temp.setIsRight(1);
                    		String whereIsError=getWhereIsError(4,firstRow,temp);
                    		temp.setWhereIsError(whereIsError);
                    	}
                    	temp.setLevel(level);
                    }
                    //读取问卷卷头信息
                    if( (!Tools.isEmpty(currentModule) && "客户基本信息".equals(currentModule)) ){
                    	if((!Tools.isEmpty(currentCellValue) && "客户基本信息".equals(currentCellValue))){
                    		continue;
                    	}
                    	//判断排序字段是否为纯数字，，不为纯数字就是错误数据
                    	boolean isNum=currentCellValue.matches("[0-9]+");
                    	if(isNum){
                    		temp.setSort(currentCellValue);
                    	}else{
                    		temp.setIsRight(1);
                    		String whereIsError=getWhereIsError(0,firstRow,temp);
                    		temp.setWhereIsError(whereIsError);
                    	}
                    	//问卷id
                    	temp.setQuestionnaireId(questionnaireId);
                    	//问卷级别
                    	temp.setClassification("L0");
                    	//区分是问卷还是问题：
                    	temp.setIsQuestionnaire("question_header");
                    	Cell currentCell1 = currentRow.getCell(1);// 当前的行的第一列的 
                    	String currentCellValue1 = getCellValue(currentCell1, true);// 当前单元格的值
                    	//标题为空的时候。这个数据异常
                    	if(Tools.isEmpty(currentCellValue1)){
                    		temp.setIsRight(1);
                    		String whereIsError=getWhereIsError(2,firstRow,temp);
                    		temp.setWhereIsError(whereIsError);
                    	}else{
                    		temp.setTitle(currentCellValue1);
                    	}
                    	
                    	//获取题型
                    	Cell currentCell2 = currentRow.getCell(2);// 当前的行的第一列的 
                    	String currentCellValue2 = getCellValue(currentCell2, true);// 当前单元格的值
                    	String type=getQuestionType(currentCellValue2,Const.LEVEL_ZERO);
                    	if(Tools.isEmpty(type)){
                    		temp.setIsRight(1);
                    		String whereIsError=getWhereIsError(2,firstRow,temp);
                    		temp.setWhereIsError(whereIsError);
                    	}else{
                			temp.setTypes(type);
                    	}
                    	//获取               选项
                    	Cell currentCell3 = currentRow.getCell(3);// 当前的行的第一列的 
                    	String currentCellValue3 = getCellValue(currentCell3, true);// 当前单元格的值
                    	String questionData=getQuestionData(currentCellValue3);
                    	if(!Tools.isEmpty(type) &&("T1".equals(type) || "T2".equals(type) || "T3".equals(type))){
                    		if(!Tools.isEmpty(questionData)){
                    			temp.setQuestionData(questionData);
                    		}else{
                    			String whereIsError=getWhereIsError(3,firstRow,temp);
                        		temp.setWhereIsError(whereIsError);
                    		}
                    	}
                    	//获取级别
                    	Cell currentCell4 = currentRow.getCell(4);// 当前的行的第一列的 
                    	String currentCellValue4 = getCellValue(currentCell4, true);// 当前单元格的值
                    	String level=getStaffLevel(currentCellValue4,levelList);
                    	if(Tools.isEmpty(level)){
                    		//说明，这个级别错误了。
                    		temp.setIsRight(1);
                    		String whereIsError=getWhereIsError(4,firstRow,temp);
                    		temp.setWhereIsError(whereIsError);
                    	}
                    	temp.setLevel(level);
                    	//必填标志
                    	Cell currentCell5 = currentRow.getCell(5);// 当前的行的第一列的 
                    	String currentCellValue5 = getCellValue(currentCell5, true);// 当前单元格的值
                    	String mustFlag=getMustFlag(currentCellValue5);
                    	if(Tools.isEmpty(mustFlag)){
                    		temp.setIsRight(1);
                    		String whereIsError=getWhereIsError(5,firstRow,temp);
                    		temp.setWhereIsError(whereIsError);
                    	}else{
                    		temp.setMustFlag(Integer.parseInt(mustFlag));
                    	}
                    }
                    if((!Tools.isEmpty(currentModule) && "问卷正文".equals(currentModule)) ){
                    	if((!Tools.isEmpty(currentCellValue) && "问卷正文".equals(currentCellValue))){
                    		continue;
                    	}
                    	temp.setIsQuestionnaire("question");
                    	if(Tools.isEmpty(currentCellValue)){
                    		
                    	}else{
                    		
                    	}
                    	boolean isWord=currentCellValue.matches("[a-zA-Z]+");
                      	boolean result=currentCellValue.matches("[0-9]+");
                      	temp.setQuestionnaireId(questionnaireId);
                      	//获取问题的标题
                      	Cell currentCell1 = currentRow.getCell(1);// 当前的行的第一列的 
                    	String currentCellValue1 = getCellValue(currentCell1, true);// 当前单元格的值
                    	if(Tools.isEmpty(currentCellValue1)){
                    		temp.setIsRight(1);
                    		String whereIsError=getWhereIsError(1,firstRow,temp);
                    		temp.setWhereIsError(whereIsError);
                    	}else{
                    		temp.setTitle(currentCellValue1);
                    	}
                        //说明是一级标题
                      	if(isWord){
                      		countQuestions++;
                      		parentId=temp.getQuestionId();
                      		temp.setQuestionCode(currentCellValue);
                      		temp.setClassification("L1");
                      		temp.setSort(countQuestions+"");
                      		temp.setQuestionData("[]");
                      		 //获取级别
                        	Cell currentCell4 = currentRow.getCell(4);// 当前的行的第一列的 
                        	String currentCellValue4 = getCellValue(currentCell4, true);// 当前单元格的值
                        	String level=getStaffLevel(currentCellValue4,levelList);
                        	if(Tools.isEmpty(level)){
                        		//说明，这个级别错误了。
                        		temp.setIsRight(1);
                        		String whereIsError=getWhereIsError(4,firstRow,temp);
                        		temp.setWhereIsError(whereIsError);
                        	}else{
                        		temp.setLevel(level);
                        	}
                        	 list.add(temp);
                      		continue;
                      		//二级问题
                      	}else if(!isWord && result){
                      		temp.setSort(currentCellValue);
                      		temp.setClassification("L2");
                      		temp.setParentId(parentId);
                      	}else{
                      		temp.setClassification("L2");
                      		temp.setParentId(parentId);
                      		//两个都不是说明。这个就有问题：
                      		temp.setIsRight(1);
                      		String whereIsError=getWhereIsError(0,firstRow,temp);
                    		temp.setWhereIsError(whereIsError);
                      	}
                  		//获取题型
                    	Cell currentCell2 = currentRow.getCell(2);// 当前的行的第一列的 
                    	String currentCellValue2 = getCellValue(currentCell2, true);// 当前单元格的值
                    	String type=getQuestionType(currentCellValue2,Const.LEVEL_TWO);
                    	if(Tools.isEmpty(type)){
                    		temp.setIsRight(1);
                    		String whereIsError=getWhereIsError(2,firstRow,temp);
                    		temp.setWhereIsError(whereIsError);
                    		//获取               选项
                        	Cell currentCell3 = currentRow.getCell(3);// 当前的行的第一列的 
                        	String currentCellValue3 = getCellValue(currentCell3, true);// 当前单元格的值
                        	String questionData=getQuestionData(currentCellValue3);
                        	if(!Tools.isEmpty(type) &&("T1".equals(type) || "T2".equals(type) || "T3".equals(type))){
                        		if(!Tools.isEmpty(questionData)){
                        			temp.setQuestionData(questionData);
                        		}else{
                        			String whereIsError1=getWhereIsError(3,firstRow,temp);
                            		temp.setWhereIsError(whereIsError1);
                        		}
                        	}
                    	}else{
                    		if(type.indexOf(",")>-1){
                    			temp.setTypes(type.split(",")[1]);
                    			temp.setScaleType(type.split(",")[0]);
                    			//如果是量标题。则，插入字段不一样。
                    			//获取               选项
                            	Cell currentCell3 = currentRow.getCell(3);// 当前的行的第一列的 
                            	String currentCellValue3 = getCellValue(currentCell3, true);// 当前单元格的值
                            	temp.setScaleRange(currentCellValue3);
                    		}else{
                    			temp.setTypes(type);
                    			//获取               选项
                            	Cell currentCell3 = currentRow.getCell(3);// 当前的行的第一列的 
                            	String currentCellValue3 = getCellValue(currentCell3, true);// 当前单元格的值
                            	String questionData=getQuestionData(currentCellValue3);
                            	if(!Tools.isEmpty(type) &&("T1".equals(type) || "T2".equals(type) || "T3".equals(type))){
                            		if(!Tools.isEmpty(questionData)){
                            			temp.setQuestionData(questionData);
                            		}else{
                            			String whereIsError=getWhereIsError(3,firstRow,temp);
                                		temp.setWhereIsError(whereIsError);
                            		}
                            	}
                    		}
                    	}
                    	//必填标志
                    	Cell currentCell5 = currentRow.getCell(5);// 当前的行的第一列的 
                    	String currentCellValue5 = getCellValue(currentCell5, true);// 当前单元格的值
                    	String mustFlag=getMustFlag(currentCellValue5);
                    	if(Tools.isEmpty(mustFlag)){
                    		temp.setIsRight(1);
                    		String whereIsError=getWhereIsError(5,firstRow,temp);
                    		temp.setWhereIsError(whereIsError);
                    	}else{
                    		temp.setMustFlag(Integer.parseInt(mustFlag));
                    	}
                    
                      //获取级别
                    	Cell currentCell4 = currentRow.getCell(4);// 当前的行的第一列的 
                    	String currentCellValue4 = getCellValue(currentCell4, true);// 当前单元格的值
                    	String level=getStaffLevel(currentCellValue4,levelList);
                    	if(Tools.isEmpty(level)){
                    		//说明，这个级别错误了。
                    		temp.setIsRight(1);
                    		String whereIsError=getWhereIsError(4,firstRow,temp);
                    		temp.setWhereIsError(whereIsError);
                    	}else{
                    		temp.setLevel(level);
                    	}
                    }
                    list.add(temp);
                }  
//                System.out.println("======================================================");  
                map.put(batchId+"", list);
            }
            map.put("levelList", levelList);
        } catch (Exception e) {  
            e.printStackTrace();  
        }   
		return map;
	}
	
	
	private static final String EXTENSION_XLS = "xls";  
    private static final String EXTENSION_XLSX = "xlsx";  
	  
    /*** 
     * <pre> 
     * 取得Workbook对象(xls和xlsx对象不同,不过都是Workbook的实现类) 
     *   xls:HSSFWorkbook 
     *   xlsx：XSSFWorkbook 
     * @param filePath 
     * @return 
     * @throws IOException 
     * </pre> 
     */  
    private static Workbook getWorkbook(String filePath){  
        Workbook workbook = null;  
        InputStream is;  
        try {  
            is = new FileInputStream(filePath);  
             if (filePath.endsWith(EXTENSION_XLS)) {  
                    workbook = (Workbook) new HSSFWorkbook(is);  
                } else if (filePath.endsWith(EXTENSION_XLSX)) {  
                    workbook = new XSSFWorkbook(is);  
                }  
        } catch (FileNotFoundException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
         
        return workbook;  
    }  
  
    /** 
     * 文件检查 
     * @param filePath 
     * @throws FileNotFoundException 
     * @throws FileFormatException 
     */  
    private static void preReadCheck(String filePath) throws FileNotFoundException, FileFormatException {  
        // 常规检查  
        File file = new File(filePath);  
        if (!file.exists()) {  
            throw new FileNotFoundException("传入的文件不存在：" + filePath);  
        }  
  
        if (!(filePath.endsWith(EXTENSION_XLS) || filePath.endsWith(EXTENSION_XLSX))) {  
            throw new FileFormatException("传入的文件不是excel");  
        }  
    }  
    /** 
     * 取单元格的值 
     * @param cell 单元格对象 
     * @param treatAsStr 为true时，当做文本来取值 (取到的是文本，不会把“1”取成“1.0”) 
     * @return 
     */  
    private static String getCellValue(Cell cell, boolean treatAsStr) {  
        if (cell == null) {  
            return "";  
        }  
  
        if (treatAsStr) {  
            // 虽然excel中设置的都是文本，但是数字文本还被读错，如“1”取成“1.0”  
            // 加上下面这句，临时把它当做文本来读取  
            cell.setCellType(Cell.CELL_TYPE_STRING);  
        }  
  
        if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {  
            return String.valueOf(cell.getBooleanCellValue());  
        } else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {  
            return String.valueOf(cell.getNumericCellValue());  
        } else {  
            return String.valueOf(cell.getStringCellValue());  
        }  
    }
    /**
     * 根据调查对象的值判断
     * @param value
     * @return
     */
    private String getStaffLevel(String value,Map<String ,String > dataMap){
    	/*StringBuffer returnStr=new StringBuffer("");
    	Map<String,String> mapStaffLevel=ConversionUtil.getStaffLevel();
    	if(value!=null&&!value.isEmpty()){
    		if(value.indexOf("/")>-1){
        		String[] levels =value.split("/");
        		for (int i = 0; i < levels.length; i++) {
        			for (String str : mapStaffLevel.keySet()) {
    					String valueStr=mapStaffLevel.get(str);
    					if(valueStr.equals(levels[i])){
    						if(i==0){
    							returnStr.append(str);
    						}else{
    							returnStr.append(","+str);
    						}
    					}
    				}
    			}
        	}else{
        		for (String str : mapStaffLevel.keySet()) {
    				String valueStr=mapStaffLevel.get(str);
    				if(valueStr.equals(value)){
    					returnStr.append(str);
    				}
    			}
        	}
    	}*/
    	if(value!=null&&!value.isEmpty()){
    		if(value.indexOf("/")>-1){
        		String[] levels =value.split("/");
        		for (int i = 0; i < levels.length; i++) {
        			dataMap.put(levels[i], levels[i]);
    			}
        	}else{
        		dataMap.put(value, value);
        	}
    	}
    	return value;
    }
    /**
     * 获取题型
     * @param value
     * @param type
     * @return
     */
    private String getQuestionType(String value,String type){
    	StringBuffer returnStr=new StringBuffer();
    	TreeMap<String,String> map=ConversionUtil.getQuestionType(type,null);
    	TreeMap<String,String> scaleTypeMap=ConversionUtil.getScaleType();
    	if(value!=null&&!value.isEmpty()){
    		if(value.indexOf(",")>-1){
        		
        	}else{
        		if(value.indexOf("/")>-1){
					String scaleTypes=value.split("/")[1];
					for (String str : scaleTypeMap.keySet()) {
						String valueStr=scaleTypeMap.get(str);
	    				if(valueStr.equals(scaleTypes)){
	    					returnStr.append(str);
	    				}
					}
					String types=value.split("/")[0];
					for (String str : map.keySet()) {
	    				String valueStr=map.get(str);
	    				if(valueStr.equals(types)){
	    					returnStr.append(","+str);
	    				}
	    			}
				}else{
					for (String str : map.keySet()) {
	    				String valueStr=map.get(str);
	    				if(valueStr.equals(value)){
	    					returnStr.append(str);
	    				}
	    			}
				}
        		
        	}
    	}
    	return returnStr.toString();
    }
    /**
     * 获取是否必填
     * @param value
     * @return
     * xiaoding
     */
    private String getMustFlag(String value){
    	StringBuffer returnStr=new StringBuffer();
    	if(!Tools.isEmpty(value)&&"是".equals(value)){
    		returnStr.append("1");
    	}else if(!Tools.isEmpty(value)&&"否".equals(value)){
    		returnStr.append("0");
    	}
    	return returnStr.toString();
    }
    /**
     * 获取选项
     * @param value
     * @return
     */
    private String getQuestionData(String value){
    	StringBuffer returnStr=new StringBuffer("");
    	if(!Tools.isEmpty(value)){
    		returnStr.append("[");
    		if(value.indexOf("/")>-1){
        		String[] values=value.split("/");
        		for (int i = 0; i < values.length; i++) {
        			if(i==0){
        				returnStr.append("{key : \""+values[i]+"\" ,value: \""+ values[i]+"\"}");
        			}else{
        				returnStr.append(",{key : \""+values[i]+"\" ,value: \""+ values[i]+"\"}");
        			}
    			}
        	}else{
        		returnStr.append("{key : '"+value+"' ,value: '"+ value+"'}");
        	}
    		returnStr.append("]");
    	}
    	return returnStr.toString();
    }
    /**
     * 
     * @return
     * xiaoding
     */
    private String getWhereIsError(int i,Row firstRow,QuestionnaireTemp temp){
    	Cell cell = firstRow.getCell(i);
        String cellValue = getCellValue(cell, true);  
        String whereIsError=temp.getWhereIsError();
        StringBuffer returnStr;
        if(!Tools.isEmpty(whereIsError)){
        	 returnStr= new StringBuffer(whereIsError);
        }else{
        	 returnStr= new StringBuffer("");
        }
    	returnStr.append(cellValue+": 错误  ;");
        return returnStr.toString();
    }
    
    /**
     * 导出模板
     * @return
     * xiaoding
     */
    @RequestMapping("/exportForModel")
    public void exportForModel(HttpServletResponse response,HttpServletRequest request){
    	String realPath = request.getSession().getServletContext().getRealPath("questionnaire");
    	String filePath=request.getContextPath()+"model/questionnaire/问卷模板.xlsx";
    	String fileName="问卷模板.xlsx";
    	try {
    		
    		String url = request.getScheme()+"://"+ request.getServerName()+request.getRequestURI()+"?"+request.getQueryString();
    		System.out.println("获取全路径（协议类型：//域名/项目名/命名空间/action名称?其他参数）url="+url);
    		String url2=request.getScheme()+"://"+ request.getServerName();//+request.getRequestURI();
    		System.out.println("协议名：//域名="+url2);


    		System.out.println("获取项目名="+request.getContextPath());
    		System.out.println("获取参数="+request.getQueryString());
    		System.out.println("获取全路径="+request.getRequestURL());
			FileDownload.fileDownload(response, filePath, fileName);
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    @RequestMapping("/list")
    public ModelAndView list(Page page){
    	ModelAndView mv=new ModelAndView();
    	List<QuestionnaireTemp> listPage=null;
    	PageData pd=null;
    	PageData data=null;
    	Map<String,String> questionnaireLevel= new HashMap<String,String>();
    	try {
			pd=this.getPageData();
			data=questionnaireTempService.getBatchIdByQuestionnaireId(pd);
			if(data!=null){
				 String batchId=data.getString("batchId");
				 //问卷调查对象
				 questionnaireLevel=ConversionUtil.getStaffLevelByParentId(data.getString("respondentsParentId"));
				 
				 pd.put("batchId", batchId);
				 page.setPd(pd);
				 listPage=questionnaireTempService.getListByListBatchIdByPage(page);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
    	mv.addObject("questionnaireLevel",questionnaireLevel);
    	mv.addObject("data", data);
    	mv.addObject("listPage",listPage);
    	TreeMap<String,String> questionType=ConversionUtil.getQuestionType(Const.OPTION_ALL,null);
		mv.addObject("pd", pd);
//		Map<String,String> staffLvevl=ConversionUtil.getStaffLevel();
		Map<String,String> staffLvevl=new HashMap<String,String>();
		if(listPage!=null){
			staffLvevl=ConversionUtil.getStaffLevelByParentId(data.getString("respondentsParentId"));
		}
		mv.addObject("staffLvevl",staffLvevl);
		mv.addObject("questionType",questionType);
		mv.addObject("allBatchId",DateUtil.getTimes());
    	mv.addObject("listData", getAllBatchId(pd));
    	mv.addObject("page", page);
    	if(!Jurisdiction.buttonJurisdiction(menuUrl, "FromExcel")){return null;} //校验权限
    	mv.addObject(Const.SESSION_QX,Jurisdiction.getHC());	//按钮权限
    	mv.setViewName("questionnaire/questionnaireTemp/listTemp");
    	return mv;
    }
    /**
     * 获取全部导入的问卷不包含题目
     * @return
     * xiaoding
     */
    public List<PageData> getQuestionnaireTempByAll(PageData pd){
    	List<PageData> listData=new ArrayList<PageData>();
    	try {
    		listData=questionnaireTempService.getQuestionnaireTempByAll(pd);
		} catch (Exception e) {
			// TODO: handle exception
		}
    	return listData;
    }
    /**
     * 根据id删除
     * @param out
     * xiaoding
     */
    @RequestMapping("/deleteOne")
    public void delOne(PrintWriter out){
    	logBefore(logger, "单个删除QuestionnaireTemp");
    	int result=0;
    	try {
			PageData pd=this.getPageData();
			result=questionnaireTempService.deleteOne(pd);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			out.print(result);
			out.close();
		}
    }
    /**
     * 根据id批量删除
     * @param out
     * xiaoding
     */
    @RequestMapping("/delAll")
    public void delAll(PrintWriter out){
    	logBefore(logger, "批量删除QuestionnaireTemp");
    	String message="";
    	try {
			PageData pd=this.getPageData();
			message=questionnaireTempService.delAll(pd);
			//questionnaireTempService.deleteAll(pd);
		} catch (Exception e) {
			message="no";
			e.printStackTrace();
		}finally{
			out.print(message);
			out.close();
		}
    }
    /**
     * 获取所有导入的批次。手动设置的。
     * @return
     * xiaoding
     * @throws Exception 
     */
    private List<PageData> getAllBatchId(PageData pd) {
    	try {
    		getUserHC(pd, departmentService);
			return questionnaireTempService.getAllBatchId(pd);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return null;
    }
    /**
     * 根据批次号的id查询导入所有的问卷
     * @param out
     * xiaoding
     */
    @RequestMapping("getTempByAllBatchId")
    public void getTempByAllBatchId(HttpServletResponse resp){
    	PageData pd=this.getPageData();
    	String result=null;
    	resp.setCharacterEncoding("utf-8");
		PrintWriter out=null;
    	try {
    		out = resp.getWriter();
    		List<PageData> list=questionnaireTempService.getTempByAllBatchId(pd);
    		result=JSON.toJSONString(list);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.print(result);
				out.close();
			}
			
		}
    }
    /**
     * 加载修改页面
     * @return
     * xiaoding
     */
    @RequestMapping("goEdit")
    public ModelAndView goEdit(){
    	logBefore(logger, "去修改QuestionnaireTemp页面");
    	ModelAndView mv=new ModelAndView();
    	PageData pd=this.getPageData();
    	try {
    		QuestionnaireTemp data=questionnaireTempService.getTempByQuestionId(pd);
    		mv.addObject("defaultQuestionCode", ConversionUtil.getDefaultQuestionCode());
    		mv.addObject("question", data);
    		mv.addObject("msg", "edit");
    		mv.setViewName("questionnaire/questionnaireTemp/tempEdit");
    		pd.put("respondentParentIdForLevelStr", data.getRespondentsParentId());
    		getDataDictionary(mv,data.getQuestionnaireId(),pd);//加载数据项
    		return mv;
		} catch (Exception e) {
			logger.error(e.toString(), e);
			return null;
		}
    	
    }
    /**
	 * 获取公共数据项
	 * @param mv
	 * @throws Exception
	 */
	private void getDataDictionary(ModelAndView mv,String questionnaireId,PageData pd) throws Exception{
		mv.addObject("questionTypes",ConversionUtil.getQuestionType("",null));//问题类型
		mv.addObject("releaseStatus",ConversionUtil.getReleaseStatus());//发布状态
		mv.addObject("scaleTypes",ConversionUtil.getScaleType());//量表类型
		Map<String,String> staffLvevl=new HashMap<String,String>();
		staffLvevl=ConversionUtil.getStaffLevelByParentId(pd.getString("respondentParentIdForLevelStr"));
		mv.addObject("staffLevels",staffLvevl);//员工级别
		mv.addObject("status",ConversionUtil.getStatus());//数据状态
		mv.addObject("classifications",ConversionUtil.getClassification());//问题分类
		mv.addObject("questionCodes",ConversionUtil.getDefaultQuestionCode());//默认英文字母字符编码
		mv.addObject("getQuestionnaireType", ConversionUtil.getQuestionnaireType());//获取调查对象类型
		//获取该问卷下的所有一级分类问题
		if(!Tools.isEmpty(questionnaireId)){
			mv.addObject("parentList",getOneLevelAll(questionnaireId,""));//该问卷下的所属一级分类
		}
	}
	/**
	 * 获取当前文件一级
	 * @return
	 * @throws Exception
	 */
	private List<Map> getOneLevelAll(String questionnaireId,String levels) throws Exception{
		Map<String,String> parameters=new HashMap();
		StringBuffer sqlBuf=new StringBuffer();
		sqlBuf.append("select CONCAT(IFNULL(questionCode,''),IFNULL(title,''))title,questionId from 	tb_questionnaire_temp  q where parentId is null AND classification='L1' AND questionnaireId=#{questionnaireId} and status = 0   ");
		if(!Tools.isEmpty(levels)){
			String sqlLevel="";
			if(levels.indexOf("|")>0){
				for (String level : levels.split("\\|")) {
					sqlLevel+="level like '%"+level+"%' or ";
				}
				sqlLevel=sqlLevel.substring(0,sqlLevel.lastIndexOf("or"));
				sqlBuf.append("AND (").append(sqlLevel).append(")");
			}else if(levels.indexOf(",")<0){
				sqlBuf.append("AND level like '%"+levels+"%'");
			}
		}
		sqlBuf.append(" ORDER BY sort");
		parameters.put("questionnaireId", questionnaireId);
		parameters.put("sql",sqlBuf.toString());	
		return questionsService.executeSql(parameters);
	}
	/**
	 * 加载级别和 所有题目分类
	 * @return
	 * @throws Exception
	 * xiaoding
	 */
	@RequestMapping(value="/questionnaireTemp_change")
	@ResponseBody
	public Object getQuestionOneLevelById()throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PageData pd=this.getPageData();
		String questionnaireId=pd.getString("questionnaireId");
		logBefore(logger,"questionnaireTemp修改...");
		Map<String,String> parameters=new HashMap();
		StringBuffer sqlBuf=new StringBuffer();
		sqlBuf.append("select CONCAT(IFNULL(questionCode,''),IFNULL(title,''))title,questionId from 	tb_questionnaire_temp  q where parentId is null AND classification='L1' AND questionnaireId=#{questionnaireId} and status = 0   ");
		sqlBuf.append(" ORDER BY sort");
		parameters.put("questionnaireId", questionnaireId);
		parameters.put("sql",sqlBuf.toString());	
		List<Map> OneLevels=questionsService.executeSql(parameters);
		map.put("result", transformListToJson(OneLevels, "questionId","title"));
		pd.put("questionId", questionnaireId);
		QuestionnaireTemp data=questionnaireTempService.getTempByQuestionId(pd);
		
		Map<String,String> staffLvevl=new HashMap<String,String>();
		staffLvevl=ConversionUtil.getStaffLevelByParentId(data.getRespondentsParentId());
		
		Map<String,String> map1=new HashMap<String,String>();
		if(data !=null && !Tools.isEmpty(data.getLevel())){
			if(data.getLevel().indexOf(",")>-1){
				for (String str:data.getLevel().split(",")) {
					map1.put(str, staffLvevl.get(str));
				}
			}else{
				map1.put(data.getLevel(),  staffLvevl.get(data.getLevel()));
			}
		}
		map.put("respondents", transformToJson(map1));
		//}
		return AppUtil.returnObject(new PageData(),map);
	}

		/**
		 * map2json(javascript json)
		 * @param map
		 * @return
		 */
		private String transformToJson(Map<String,String> map){ 
		    StringBuilder json = new StringBuilder();  
		    json.append("[");
		    for (String key : map.keySet()) {
		    	if (!Tools.isEmpty(key)&&!Tools.isEmpty(map.get(key))){
		    		json.append("{key:'"+key+"',value:'"+map.get(key)+"'},");
		    	}
			}
		    if(json.length()>0 && (json.lastIndexOf(",")==(json.length()-1))){
		    	json.deleteCharAt(json.length()-1);
		    }
		    json.append("]");
		    return json.toString();  
		}
     private String transformListToJson(List<Map> list,String key,String valueKey){ 
    	 StringBuilder json = new StringBuilder();  
	     json.append("[");
	     for (Map map : list) {
	     	if (null !=map){
	     		json.append("{key:'"+map.get(key)+"',value:'"+map.get(valueKey)+"'},");
	     	}
			}
	     if(json.length()>0 && (json.lastIndexOf(",")==(json.length()-1))){
	     	json.deleteCharAt(json.length()-1);
	     }
	     json.append("]");
	     return json.toString();  
	}
     /**
 	 * 修改保存
 	 */
 	@RequestMapping(value="/edit")
 	public ModelAndView edit(@ModelAttribute("questionsData")Questions questionsData) throws Exception{
 		logBefore(logger, "修改questionnaireTemp");
 		PageData pd=this.getPageData();
 		
 		QuestionnaireTemp data=questionnaireTempService.getTempByQuestionId(pd);
 		//数据
 		data.setQuestionData(this.transformToJson(questionsData.getQuestionData_code(),questionsData.getQuestionData_name()));
 		//分类名称				假如变换了。。。。。。。。变成问卷      
 		String classificationNow=questionsData.getClassification();
 		String classificationBefore=data.getClassification();
 		if(!Tools.isEmpty(classificationBefore) && !Tools.isEmpty(classificationNow) && !classificationNow.equals(classificationBefore)){
 			if(classificationBefore.equals("L0")){
 				data.setIsQuestionnaire("question");
 			}else{
 				data.setIsQuestionnaire("question_header");
 			}
 		}
 		data.setClassification(questionsData.getClassification());
 		//编码
 		data.setQuestionCode(questionsData.getQuestionCode());
 		//题目
 		data.setTitle(questionsData.getTitle());
 		//备注-----不存在
 		//级别
 		data.setLevel(questionsData.getLevel());
 		//题型 
 		data.setTypes(questionsData.getTypes());
 		//量表题型
 		if(!Tools.isEmpty(questionsData.getScaleType())){
 			data.setScaleType(questionsData.getScaleType());
 		}
 		//量表范围
 		if(!Tools.isEmpty(questionsData.getScaleRange()+"")){
 			data.setScaleRange(questionsData.getScaleRange()+"");
 		}
 		//排序
 		data.setSort(questionsData.getSort()+"");
 		//是否必填
 		data.setMustFlag(questionsData.getMustFlag());
 		//父类
 		data.setParentId(questionsData.getParentId());
 		//校验数据是否正确：                 错误代码                             
 		data.setIsRight(0);
 		data.setModifyTime(DateUtil.getTime());
    	data.setModifyUser(Jurisdiction.getLoginUser().getUSER_ID());
 		data.setWhereIsError(null);
 		questionnaireTempService.editTemp(data);
 		ModelAndView mv = this.getModelAndView();
 		mv.addObject("msg","success");
 		mv.setViewName("save_result");
 		return mv;
 	}
 	/**
	 * 多个数据项转换为json数据格式
	 * @param keys
	 * @param values
	 * @return
	 */
	private String transformToJson(String keys,String values){ 
	        StringBuilder json = new StringBuilder();  
	        json.append("[");//datas:
	        if (!Tools.isEmpty(keys)&&!Tools.isEmpty(values) && !Tools.isEmpty(keys.replace(",","")) && !Tools.isEmpty(values.replace(",",""))) {
	        	String [] valueArray=values.split(","); 
	        	String [] keyArray=keys.split(",");
	            for (int i=0;i<keyArray.length;i++) {  
	                json.append("{key:").append("\""+keyArray[i]+"\",");  
	                json.append("value:").append("\""+valueArray[i]+"\"},");
	            }
	            json.setCharAt(json.length() - 1, ']');
	        } else {  
	            json.append("]");  
	        }  
	        return json.toString();  
	}
	/**
	 * 
	 * 将导入的数据正式入到业务表
	 * xiaoding
	 */
	@RequestMapping("exportQuestionnaire")
	public void exportQuestionnaire(PrintWriter out){
		PageData pd=this.getPageData();
		String message="";
		try {
			pd.put("isRight", 0);
			//导入问卷的list
			List<QuestionnaireTemp> listData=questionnaireTempService.findTempByQuestionnaireId(pd);
			//创建问卷的实体
			Questionnaire questionnaire=new Questionnaire();
			//创建问卷问题的list
			List<Questions> listQuestions=new ArrayList<Questions>();
			if(listData!=null){
				//循环将导入问卷的list放入相应的对象。
				for (int i = 0; i < listData.size(); i++) {
					QuestionnaireTemp temp= listData.get(i);
					String isQuestionnaire=temp.getIsQuestionnaire();
					//问卷相关的
					if("questionnaire".equals(isQuestionnaire)){
						//问卷创建时间
						questionnaire.setCreateTime(temp.getCreateTime());
						//问卷创建人
						questionnaire.setCreateUser(temp.getCreateUser());
						// 获取当前登录用户的信息以及其子级部门列表
						User user = Jurisdiction.getLoginUser();
						
						//部门
						questionnaire.setDepartment_id(user.getDepartment().getDEPARTMENT_ID());
						//创建人
						questionnaire.setCreate_user(user.getUSER_ID());
						
						questionnaire.setModifyTime(temp.getModifyTime());
						
						questionnaire.setModifyUser(temp.getModifyUser());
						//问卷标题
						questionnaire.setTitle(temp.getTitle());
						//问卷卷首语
						questionnaire.setPreface(temp.getPreface());
						//问卷id
						questionnaire.setQuestionnaireId(Const.importQuestionsId+temp.getQuestionId());
						//问卷发布状态
						questionnaire.setReleaseStatus(0+"");
						//调查对象
						questionnaire.setRespondents(temp.getLevel());
						//问卷有效状态
						questionnaire.setValidState(1);
						//问卷调查对象类型
						questionnaire.setRespondentsParentId(temp.getRespondentsParentId());
						//问卷类型
						questionnaire.setQuestionnaireType(Const.QUESTIONNAIRE_TYPE_COMMON);
						//
					//问题相关
					}else{
						Questions entity=new Questions();
						entity.setQuestionId(Const.importQuestionsId+temp.getQuestionId());
						entity.setQuestionnaireId(Const.importQuestionsId+temp.getQuestionnaireId());
						if(!Tools.isEmpty(temp.getParentId())){
							entity.setParentId(Const.importQuestionsId+temp.getParentId());
						}
						entity.setQuestionCode(temp.getQuestionCode());
						entity.setTitle(temp.getTitle());
						entity.setLevel(temp.getLevel());
						entity.setClassification(temp.getClassification());
						entity.setTypes(temp.getTypes());
						entity.setScaleType(temp.getScaleType());
						if(!Tools.isEmpty(temp.getScaleRange())){
							entity.setScaleRange(Integer.parseInt(temp.getScaleRange()));
						}
						
						entity.setQuestionData(temp.getQuestionData());
						entity.setSort(Integer.parseInt(temp.getSort()));
						entity.setMustFlag(temp.getMustFlag());
						entity.setCreateUser(temp.getCreateUser());
						entity.setCreateTime(temp.getCreateTime());
						entity.setModifyTime(temp.getModifyTime());
						entity.setModifyUser(temp.getModifyUser());
						listQuestions.add(entity);
					}
				}
				questionnaireTempService.exportQuestionnaire(questionnaire,listQuestions,pd);
				message="success";
			}else
			message="fail";
		} catch (Exception e) {
			e.printStackTrace();
			message="error";
		}finally{
			out.print(message);
			out.close();
		}
	}
	/**
	 * 问卷导入数据，撤销导入到业务表
	 * @param out
	 * xiaoding
	 */
	@RequestMapping("deleteQuestionnaireByTemp")
	public void deleteQuestionnaireByTemp(PrintWriter out){
		PageData pd=this.getPageData();
		String message="";
		try {
			message=questionnaireTempService.deleteQuestionnaireByTemp(pd);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			out.print(message);
			out.close();
		}
	}
	@RequestMapping("goUpdateTemp")
	public ModelAndView goUpdateTemp(){
		PageData pd=this.getPageData();
		ModelAndView mv=new ModelAndView();
		PageData data=null;
		try {
			data=questionnaireTempService.getBatchIdByQuestionnaireId(pd);
			pd.put("respondentsParentId", data.getString("respondentsParentId"));
			getQuestionnaireDataDictionary(mv,pd);
			mv.addObject("pd", data);
			mv.setViewName("questionnaire/questionnaireTemp/tempQuestionnaireEdit");
			mv.addObject("msg", "updateTemp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	/**
	 * 获取公共数据项
	 * @param mv
	 * @throws Exception
	 */
	private void getQuestionnaireDataDictionary(ModelAndView mv,PageData pd) throws Exception{
		//List<Questionnaire>	questionnaireList = questionnaireService.findQuestionnaireList(pd);	//列出Question列表
		//mv.addObject("questionnaireList", questionnaireList);//所属问卷
		mv.addObject("releaseStatusList",ConversionUtil.getReleaseStatus());//发布状态
		Map<String,String> staffLvevl=new HashMap<String,String>();
		staffLvevl=ConversionUtil.getStaffLevelByParentId(pd.getString("respondentsParentId"));
		
//		mv.addObject("staffLevels",ConversionUtil.getStaffLevel());//员工级别
		mv.addObject("staffLevels",staffLvevl);//员工级别
		mv.addObject("status",ConversionUtil.getStatus());//数据状态
		mv.addObject("getQuestionnaireType", ConversionUtil.getQuestionnaireType());//获取调查对象类型
	}
	@RequestMapping("updateTemp")
	public ModelAndView updateTemp(@ModelAttribute("questionnaireData")Questionnaire questionnaireData){
		PageData pd=this.getPageData();
		String questionId=questionnaireData.getQuestionnaireId();
		pd.put("questionId", questionId);
		String message="";
		try {
			QuestionnaireTemp data=questionnaireTempService.getTempByQuestionId(pd);
			if(data!=null){
				data.setTitle(questionnaireData.getTitle());
				data.setPreface(questionnaireData.getPreface());
				data.setRespondentsParentId(questionnaireData.getRespondentsParentId());
				data.setLevel(questionnaireData.getRespondents());
				data.setIsRight(0);
				data.setWhereIsError(null);
				questionnaireTempService.editTemp(data);
				message="success";
			}else{
				message="fail";
			}
		}catch(Exception e) {
			message="error";
			e.printStackTrace();
		}
		ModelAndView mv = this.getModelAndView();
 		mv.addObject("msg",message);
 		mv.setViewName("save_result");
 		return mv;
	}
	@RequestMapping("deleteAllTempByQuestionnaireId")
	public  void deleteAllTempByQuestionnaireId(PrintWriter out){
		String message="";
		try {
			PageData pd=this.getPageData();
			questionnaireTempService.deleteAllTempByQuestionnaireId(pd);
			message="success";
		} catch (Exception e) {
			message="error";
			e.printStackTrace();
		}finally{
			out.print(message);
			out.close();
		}
	}
	/**
	 * 判断错误数据是否等于0.等于0才能导入业务表
	 * @param out
	 * xiaoding
	 */
	@RequestMapping("findCountTempByQuestionnaireId")
	public  void findCountTempByQuestionnaireId(PrintWriter out){
		String message="";
		try {
			PageData pd=this.getPageData();
			pd.put("isRight", 1);
			message=questionnaireTempService.findCountTempByQuestionnaireId(pd).toString();
		} catch (Exception e) {
			message="error";
			e.printStackTrace();
		}finally{
			out.print(message);
			out.close();
		}
		
		
	}
	private String getLevelForName(String levelStrForTemp,List<PageData> listLevelData){
		String returnValue="";
		if(levelStrForTemp!=null&&!levelStrForTemp.isEmpty()){
    		if(levelStrForTemp.indexOf("/")>-1){
        		String[] levels =levelStrForTemp.split("/");
        		for (int i = 0; i < levels.length; i++) {
        			for (int j = 0; j < listLevelData.size(); j++) {
        				PageData pageData=listLevelData.get(j);
        				String name=pageData.getString("NAME");
        				String code=pageData.getString("BIANMA");
        				if(!Tools.isEmpty(levels[i])&&!Tools.isEmpty(name)&&levels[i].equals(name)){
        					if(Tools.isEmpty(returnValue)){
        						returnValue=code;
        					}else{
        						returnValue+=","+code;
        					}
        				}
					}
    			}
        	}else{
        		for (int j = 0; j < listLevelData.size(); j++) {
    				PageData pageData=listLevelData.get(j);
    				String name=pageData.getString("NAME");
    				String code=pageData.getString("BIANMA");
    				if(!Tools.isEmpty(levelStrForTemp)&&!Tools.isEmpty(name)&&levelStrForTemp.equals(name)){
    					if(Tools.isEmpty(returnValue)){
    						returnValue=code;
    					}
    				}
				}
        	}
    	}
		return returnValue;
	}
}
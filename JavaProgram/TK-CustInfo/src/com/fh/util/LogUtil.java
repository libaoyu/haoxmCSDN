package com.fh.util;

import org.apache.log4j.Logger;

/**
 * 
 * 日志工具，本工具类的意图是屏蔽在开发代码中直接引用第三方的日志类。
 * 本日志工具类使用JCL提供日志功能，Jakarta Commons Logging (JCL)提供的是一个日志(Log)
 * 接口(interface)，同时兼顾轻量级和不依赖于具体的日志实现工具。 它提供给中间件/日志工具
 * 开发者一个简单的日志操作抽象，允许程序开发人员使用不同的具体日志实现工具。用户被假定已
 * 熟悉某种日志实现工具的更高级别的细节。JCL提供的接口，对其它一些日志工具，包括Log4J, 
 * Avalon LogKit, and JDK 1.4等，进行了简单的包装，此接口更接近于Log4J和LogKit的实现. 
 * JCL有两个基本的抽象类：Log(基本记录器)和LogFactory(负责创建Log实例)。当commons-logging.jar
 * 被加入到CLASSPATH之后，它会心可能合理地猜测你喜欢的日志工具，然后进行自我设置，
 * 用户根本不需要做任何设置。默认的LogFactory是按照下列的步骤去发现并决定那个日志工具将被使用
 * 的（按照顺序，寻找过程会在找到第一个工具时中止）:
 * 1.寻找当前factory中名叫org.apache.commons.logging.Log配置属性的值
 * 2.寻找系统中属性中名叫org.apache.commons.logging.Log的值
 * 3.如果应用程序的classpath中有log4j,则使用相关的包装(wrapper)类(Log4JLogger)
 * 4.如果应用程序运行在jdk1.4的系统中，使用相关的包装类(Jdk14Logger)
 * 5.使用简易日志包装类(SimpleLog)
 * 
 * fatal非常严重的错误，导致系统中止。期望这类信息能立即显示在状态控制台上。
 * error其它运行期错误或不是预期的条件。期望这类信息能立即显示在状态控制台上。
 * warn使用了不赞成使用的API、非常拙劣使用API, '几乎就是'错误, 其它运行时不合需要和不合预期的状态但还没必要称为 "错误"。期望这类信息能立即显示在状态控制台上。
 * info运行时产生的有意义的事件。期望这类信息能立即显示在状态控制台上。
 * debug系统流程中的细节信息。期望这类信息仅被写入log文件中。
 * trace更加细节的信息。期望这类信息仅被写入log文件中。
 * 
 * 注意，在JCL的LogFactory的实现中已经使用缓存对象，所以此处在获取特定的log实例时不需要再添加缓存对象。
 */
public class LogUtil {
	
	/**
	 * 致命错误，导致系统中止。
	 * @param logName　配置的日志模块名称
	 * @param message　日志信息
	 * @throws gsf_tool_log_LogUtil_fatal1_1 未能获取logName对应的日志实例对象
	 */
	public static void fatal(String logName,Object message){
		Logger log = Logger.getLogger(logName);
		log.fatal(message);
	}
	
	/**
	 * 致命错误，导致系统中止。
	 * @param logName　配置的日志模块名称
	 * @param message　日志信息
	 * ＠param t 系统例外对象
	 * @throws gsf_tool_log_LogUtil_fatal2_1 未能获取logName对应的日志实例对象
	 */ 
	public static void fatal(String logName,Object message,Throwable t){
		Logger log = Logger.getLogger(logName);
		log.fatal(message,t);
	}
	
	
	/**
	 * 记录普通逻辑错误，但是不会导致系统中止。
	 * @param logName　日志实例名
	 * @param message　记录的日志信息对象
	 * @throws gsf_tool_log_LogUtil_error1_1 未能获取logName对应的日志实例对象
	 */
	public static void error(String logName,Object message) {
		Logger log = Logger.getLogger(logName);
		log.error(message);
	}
	/**
	 * 记录普通逻辑错误，不会导致系统中止
	 * @param logName　日志实例名
	 * @param message　日志信息
	 * @param t　例外对象
	 * @throws gsf_tool_log_LogUtil_error2_1 未能获取logName对应的日志实例对象
	 */ 
	public static void error(String logName,Object message,Throwable t){
		Logger log = Logger.getLogger(logName);
		log.error(message,t);
	}
	
	/**
	 * 记录警告信息
	 * @param logName　日志实例名
	 * @param message　日志信息
	 * @throws gsf_tool_log_LogUtil_warn1_1 未能获取logName对应的日志实例对象
	 */
	public static void warn(String logName,Object message) {
		Logger log = Logger.getLogger(logName);
		log.warn(message);
		
	}
	/**
	 * 记录警告信息。
	 * @param logName　日志实例名
	 * @param message　日志信息
	 * @param t　例外实例
	 * @throws gsf_tool_log_LogUtil_warn2_1 未能获取logName对应的日志实例对象
	 */
	public static void warn(String logName,Object message,Throwable t){
		Logger log = Logger.getLogger(logName);
		log.warn(message,t);
	
		
	}
	/**
	 * 记录提示信息
	 * @param logName　日志实例名称
	 * @param message　日志信息
	 * @throws gsf_tool_log_LogUtil_info1_1 未能获取logName对应的日志实例对象
	 */
	public static void info(String logName,Object message){
		Logger log = Logger.getLogger(logName);
		log.info(message);
	}
		
	/**
	 * 记录提示信息。
	 * @param logName　日志实例名称
	 * @param message　日志信息
	 * @param t　例外对象信息
	 * @throws gsf_tool_log_LogUtil_info2_1 未能获取logName对应的日志实例对象
	 */
	public static void info(String logName,Object message,Throwable t) {
		Logger log = Logger.getLogger(logName);
		log.info(message,t);
	}
	/**
	 * 记录调试信息
	 * @param logName 日志实例名称
	 * @param message　日志信息
	 * @throws gsf_tool_log_LogUtil_debug1_1 未能获取logName对应的日志实例对象
	 */
	public static void debug(String logName,Object message){
		Logger log = Logger.getLogger(logName);
		log.debug(message);
	}
	/**
	 * 记录调试信息。
	 * @param logName　日志实例名称
	 * @param message　日志信息
	 * @param t　例外对象
	 * @throws gsf_tool_log_LogUtil_debug2_1 未能获取logName对应的日志实例对象
	 */
	public static void debug(String logName,Object message,Throwable t) {
		Logger log = Logger.getLogger(logName);
		log.debug(message,t);
	}
	/**
	 * 记录明细跟踪信息
	 * @param logName 日志实例名称
	 * @param message　日志信息
	 * @throws gsf_tool_log_LogUtil_trace1_1 未能获取logName对应的日志实例对象
	 */
	public static void trace(String logName,Object message){
		Logger log = Logger.getLogger(logName);
		log.trace(message);
	}
	/**
	 * 记录跟踪信息
	 * @param logName　日志实例名称
	 * @param message　日志信息
	 * @param t 例外对象
	 * @throws gsf_tool_log_LogUtil_trace2_1 未能获取logName对应的日志实例对象
	 */
	public static void trace(String logName,Object message,Throwable t){
		Logger log = Logger.getLogger(logName);
		log.trace(message,t);
	}
	
}

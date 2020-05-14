EJB（Enterprise Java Bean 3.0）
	* Session Bean（无状态SessionBean和有状态SessionBean）
	* EntityBean（EJB2.X，BMP和CMP），实体类（EJB3.0）
	* Message Drive Bean(MDB),JMS(JbossMQ, ActiveMQ, IBM MQ),
	  JMS实现一般称为MOM（面向消息的中间件），主要有点对点和发布于订阅
	
主流应用服务器： Weblogic、Jboss，IBM websphere
EJB这样架构比较适合于分布式系统项目（跨多个JVM调用）
SSH比较适合于在同一个JVM中运行的项目
	
1、安装jboss4.2.2
		
2、建立EJB项目

3、集成Jboss（和集成Tomcat类似）

4、建立FirstEjb接口

5、建立FirstEjbBean实现FirstEjb接口

6、采用注解Stateless声明为无状态SessionBean

7、采用注解Remote声明为可以远程调用

8、部署到Jboss中







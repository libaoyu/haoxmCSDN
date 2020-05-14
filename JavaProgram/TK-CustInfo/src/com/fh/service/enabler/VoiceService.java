package com.fh.service.enabler;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.util.PageData;

/**
 * 华为小号平台话单推送接口
 * @author shanghaizhao
 * @date 2018-01-03
 */
@Service("voiceService")
public class VoiceService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**saveExtParas
	 * @param pd
	 * @throws Exception
	 */
	public void saveExtParas(PageData pd)throws Exception{
		dao.save("EnablerMapper.saveExtParas", pd);
	}
	
	/**saveExtInfo
	 * @param pd
	 * @throws Exception
	 */
	public void saveExtInfo(PageData pd)throws Exception{
		dao.save("EnablerMapper.saveExtInfo", pd);
	}
	
	/**saveCallEvent
	 * @param pd
	 * @throws Exception
	 */
	public void saveCallEvent(PageData pd)throws Exception{
		dao.save("EnablerMapper.saveCallEvent", pd);
	}
}

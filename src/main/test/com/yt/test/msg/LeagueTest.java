package com.yt.test.msg;

import java.util.Calendar;
import java.util.Date;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import com.yt.framework.mapper.LeagueAuctionMapper;
import com.yt.framework.mapper.admin.ActiveCodeMapper;
import com.yt.framework.persistent.entity.ActiveCode;
import com.yt.framework.persistent.entity.LeagueAuctionCfg;
import com.yt.framework.service.LeagueAuctionService;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 激活码生成
 * @author ylt
 *
 */
@ContextConfiguration(locations= {"classpath:spring/applicationContext.xml","classpath:spring/applicationContext-quartz.xml",
		"classpath:spring/appServlet/spring-beans.xml","classpath:spring/appServlet/spring-security.xml"})
public class LeagueTest extends AbstractJUnit4SpringContextTests{

	@Autowired
	private LeagueAuctionService leagueAuctionService;
	
	/**
	 * 批量短息发送
	 */
	@Test
	public void sendMsgAuction(){
		LeagueAuctionCfg leagueAuctionCfg = new LeagueAuctionCfg();
		leagueAuctionCfg.setLeague_id("1");
		leagueAuctionCfg.setTurn_num(1);
		try {
			leagueAuctionService.sendCalculateMsg(leagueAuctionCfg);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}

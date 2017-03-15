package com.yt.test.teams;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.TeamGame;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.TeamInviteService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 *俱乐部
 *@autor bo.xie
 *@date2015-8-3下午4:06:03
 */
@ContextConfiguration(locations={"classpath*:spring/applicationContext.xml","classpath*:spring/appServlet/*.xml"})
public class TestTeamInvite extends AbstractJUnit4SpringContextTests{

	@Autowired
	TeamInviteService teamInviteService;
	
	/**
	 *俱乐部对战状态更新
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午4:07:54
	 */
	@Test
	public void saveTeamInvite() throws Exception{
		String id =  "3"; // 约战比赛id
		String status = "1"; // 约战比赛状态
		String teaminfo_id = "16"; // 约战比赛状态
		String respond_teaminfo_id = "17"; // 约战比赛状态
		
		AjaxMsg msg = teamInviteService.updateInvite(id,Integer.parseInt(status),
				teaminfo_id,respond_teaminfo_id);
		System.out.println(msg.toJson());
	}
	
	/**
	 *俱乐部约战列表
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午4:07:54
	 */
	@Test
	public void listInvite() throws Exception{
		AjaxMsg msg = teamInviteService.inviteList("16");
		System.out.println(msg.toJson());
	}
	
	/**
	 *俱乐部历史对战列表
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午4:07:54
	 */
	@Test
	public void historyGameList() throws Exception{
		AjaxMsg msg = teamInviteService.historyGameList("16", new PageModel());
		System.out.println(msg.toJson());
	}
	
	/**
	 *俱乐部当前对战记录
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午4:07:54
	 */
	@Test
	public void currentGame() throws Exception{
		AjaxMsg msg = teamInviteService.currentGame("16");
		System.out.println(msg.toJson());
	}
	
	/**
	 *上传比赛记录
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午4:07:54
	 */
	@Test
	public void uploadResult() throws Exception{
		TeamGame tg = new TeamGame();
		tg.setId("2");
		tg.setInitiate_score(2);
		tg.setRespond_score(3);
		//tg.setInitiate_sure(1); //主队确认
		tg.setRespond_sure(1);
		AjaxMsg msg = teamInviteService.uploadResult(tg, "16");
		System.out.println(msg.toJson());
	}
	
	/**
	 *上传比赛记录
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午4:07:54
	 */
	@Test
	public void checkResult() throws Exception{
		String id = "2";
		String teaminfo_id = "16"; 
		int status = 1;//比赛结果 0不通过，1通过
		AjaxMsg msg = teamInviteService.checkResult(id, teaminfo_id, status);
		System.out.println(msg.toJson());
	}
}

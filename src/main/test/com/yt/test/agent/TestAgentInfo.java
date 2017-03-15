package com.yt.test.agent;

import java.util.List;
import java.util.Map;

import org.codehaus.jackson.map.util.BeanUtil;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.AgentInfo;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.AgentInfoService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 *经纪人
 *@autor bo.xie
 *@date2015-8-4上午11:18:01
 */
@ContextConfiguration(locations={"classpath*:spring/applicationContext.xml","classpath*:spring/appServlet/*.xml"})
public class TestAgentInfo extends AbstractJUnit4SpringContextTests{

	@Autowired
	private AgentInfoService agentInfoService;
	
	@Autowired
	private TeamInfoService teamInfoService;
	
	/**
	 *保存经纪人信息
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4上午11:49:18
	 */
	@Test
	public void saveAgentInfo(){
		AgentInfo ai = new AgentInfo();
			ai.setId(UUIDGenerator.getUUID());
			ai.setAgent_plays("赵三,关羽,王五");
			ai.setCases("XXX球员获得大奖");
			ai.setCer_no("NO1239805698090CN");
			ai.setCompany("谢菲特足球俱乐部");
			ai.setEducation("本科");
			ai.setFind_area("成都");
			ai.setIs_player(0);
			ai.setKnow_clubs("恒大足球俱乐部，谢菲特足球俱乐部");
			ai.setTitle("中国第一足球经纪人");
			ai.setUser_id("6");
		AjaxMsg msg = agentInfoService.save(ai);	
		System.out.println(msg.toJson());
	}
	
	/**
	 *编辑经纪人信息
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4上午11:49:06
	 */
	@Test
	public void updateAgentInfo(){
		AgentInfo ai = agentInfoService.getEntityById("2");
		if(ai==null){
			System.out.println("该经纪人不存在");
		}else{
			ai.setCompany("恒大俱乐部");
			AjaxMsg msg = agentInfoService.update(ai);
			System.out.println(msg.toJson());
		}
	}
	
	/**
	 * 根据user_id 获取经纪人信息
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4上午11:48:45
	 */
	@Test
	public void agentInfo(){
		AjaxMsg msg = agentInfoService.getAgentInfoByUserId("6");
		System.out.println(msg.toJson());
	}
	
	/**
	 * 删除经纪人
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4上午11:50:49
	 */
	@Test
	public void deleteAgentInfo(){
		AjaxMsg msg = agentInfoService.delete("2");
		System.out.println(msg.toJson());
	}
	
	/**
	 *经纪人签约球员
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午2:21:26
	 */
	@Test
	public void toSignPlayer(){
		String i="2";
			String agent_id = "5";
			String player_id = i;
			AjaxMsg msg = null;
			try {
				msg = agentInfoService.signPlayer(agent_id, player_id, 1);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println(msg.toJson());
	}
	
	/**
	 * 解约球员
	 *
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午2:34:05
	 */
	@Test
	public void breakPlayer(){
		String agent_id = "5";
		String player_id = "3";
		AjaxMsg msg = null;
		try {
			msg = agentInfoService.breakPlayer(agent_id, player_id, null);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(msg.toJson());
	}
	
	/**
	 * 经济人代理球员退出俱乐部
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午3:23:24
	 */
	@Test
	public void outTeam(){
		String teaminfo_id = "5";
		String player_id ="3";
		AjaxMsg msg = null;
		try {
			msg = teamInfoService.outTeam(teaminfo_id, player_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(msg.toJson());
	}
	
	/**
	 *经纪人代理球员加入俱乐部
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-4下午5:39:05
	 */
	public void joinTeam(){
		String teaminfo_id = "5";
		String player_id = "3";
		AjaxMsg msg = null;
		try {
			msg = teamInfoService.joinTeam(teaminfo_id, player_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(msg.toJson());
	}
	
	/**
	 *经纪人已签约球员信息
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-5上午10:51:29
	 */
	@SuppressWarnings("unchecked")
	@Test
	public void loadSignPlayers(){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("user_id", 1);
		maps.put("status", 1);
		PageModel<Map<String,Object>> pageModel = new PageModel<Map<String,Object>>();
		AjaxMsg msg = agentInfoService.queryAgentPlayerForPage(maps, pageModel);
		if(msg.isSuccess()){
			pageModel = (PageModel<Map<String,Object>>) msg.getData("page");
			List<Map<String,Object>> pis = pageModel.getItems();//获取集合
			int count = pageModel.getTotalCount();//获取总条数
		}else{
			System.out.println("error:"+msg.toJson());
		}
	}
	
	/**
	 *查询申请经纪人的球员用户列表
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-5下午2:17:35
	 */
	@SuppressWarnings("unchecked")
	@Test
	public void applyDatas(){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("user_id", 1);
		maps.put("status", 0);
		PageModel<Map<String,Object>> pageModel = new PageModel<Map<String,Object>>();
		AjaxMsg msg = agentInfoService.queryAgentPlayerForPage(maps, pageModel);
		System.out.println(msg.toJson());
		if(msg.isSuccess()){
			pageModel = (PageModel<Map<String,Object>>) msg.getData("page");
			List<Map<String,Object>> pis = pageModel.getItems();//获取集合
			int count = pageModel.getTotalCount();//获取总条数
		}else{
			System.out.println("error:"+msg.toJson());
		}
	}
	
	
}

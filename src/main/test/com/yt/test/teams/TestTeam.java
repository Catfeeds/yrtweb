package com.yt.test.teams;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;

/**
 *俱乐部
 *@autor bo.xie
 *@date2015-8-3下午4:06:03
 */
@ContextConfiguration(locations={"classpath*:spring/applicationContext.xml","classpath*:spring/appServlet/*.xml"})
public class TestTeam extends AbstractJUnit4SpringContextTests{

	@Autowired
	TeamInfoService teamInfoService;
	
	/**
	 *创建俱乐部信息
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-3下午4:07:54
	 */
	@Test
	public void sveTeamInfo(){
		TeamInfo t = new TeamInfo();
		t.setName("谢菲特俱乐部");
		t.setAllow(1);
		t.setLogo("/images/teamlogo2");
		t.setBall_format(7);
		t.setIs_pk(1);
		t.setPlay_position("成都");
		t.setPlay_time(1);
		t.setUser_id("3");
		
		AjaxMsg msg = teamInfoService.save(t);
		if(msg.isSuccess()){//俱乐部创建成功，创建人为队长，信息写入俱乐部成员表中
			TeamInfo ti = (TeamInfo) msg.getData("data");
			teamInfoService.saveTeamPlayer(ti.getId(), ti.getUser_id(), 1);
		}
		System.out.println(msg.toJson());
	}
	
	/**
	 *更新
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-3下午5:04:03
	 */
	@Test
	public void updateTeamInfo(){
		TeamInfo team = teamInfoService.getEntityById("8");
		team.setBall_format(11);
		teamInfoService.update(team);
	}
	
	/**
	 *获取所有俱乐部
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-3下午5:04:32
	 */
	@Test
	public void loadAllTeamInfo(){
		PageModel<TeamInfo> pageModel = new PageModel<TeamInfo>();
		Map<String,Object> params = Maps.newHashMap();
		params.put("name", "俱乐部");
		//排序方式，默认按俱乐部创建时间排序
		params.put("orderNum", "name");
		AjaxMsg msg = teamInfoService.queryForPage(params, pageModel);
		if(msg.isSuccess()){
			pageModel = (PageModel<TeamInfo>) msg.getData("page");
			List<TeamInfo> teams = pageModel.getItems();
			if(teams!=null && teams.size()>0){
				for (TeamInfo team : teams) {
					System.out.println(team.getName());
				}
			}
		}else{
			System.out.println("error");
		}
	}
	
	/**
	 *获取所有俱乐部成员
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午5:04:32
	 */
	@Test
	public void loadTeamPlayerList(){
		String teaminfo_id = "16";
		//排序方式，默认按俱乐部创建时间排序
		/*maps.put("teaminfo_id", teaminfo_id);
		AjaxMsg plist = teamInfoService.getTeamPlayerList(maps, new PageModel());
		AjaxMsg msg = teamInfoService.getTeamPlayerList(teaminfo_id);*/
//		/System.out.println(msg.toJson());
	}
	
	/**
	 *获取所有俱乐部成员
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午5:04:32
	 */
	@Test
	public void defirendPlayer(){
		String teaminfo_id = "16";
		String player_id = "2";
		//排序方式，默认按俱乐部创建时间排序
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = teamInfoService.defriendPlayer(teaminfo_id, player_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(msg.toJson());
	}
	
	/**
	 *获取所有俱乐部成员
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-3下午5:04:32
	 */
	@Test
	public void kickfirendPlayer(){
		String teaminfo_id = "16";
		String player_id = "2";
		//排序方式，默认按俱乐部创建时间排序
		AjaxMsg msg = teamInfoService.kickfriendPlayer(teaminfo_id, player_id);
		System.out.println(msg.toJson());
	}
	
	/**
	 *俱乐部黑名单列表
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-11下午5:04:32
	 */
	@Test
	public void checkCaption(){
		String teaminfo_id = "16";
		//排序方式，默认按俱乐部创建时间排序
		AjaxMsg msg = teamInfoService.blackList(teaminfo_id, new PageModel());
		System.out.println(msg.toJson());
	}
	
	/**
	 *俱乐部邀站搜索
	 *@autor ylt
	 *@parameter *
	 *@date2015-8-17下午5:04:32
	 */
	@Test
	public void searchInviteTeam(){
		Map<String,Object> map = Maps.newHashMap();
		map.put("sumballs", 1);
		map.put("orderWin", "DESC");
		PageModel pageModel = new PageModel();
		pageModel.setFirstNum(0);
		pageModel.setPageSize(4);
		//排序方式，默认按俱乐部创建时间排序
		AjaxMsg msg = teamInfoService.searchInviteTeam(map,pageModel);
		System.out.println(msg.toJson());
	}
	
}

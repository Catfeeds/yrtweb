package com.yt.test.player;

import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.Focus;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 球员
 *@autor bo.xie
 *@date2015-8-12下午5:06:35
 */
@ContextConfiguration(locations={"classpath*:spring/applicationContext.xml","classpath*:spring/appServlet/*.xml"})
public class TestPlayer extends AbstractJUnit4SpringContextTests{

	@Autowired
	private UserService userService;
	@Autowired
	private PlayerInfoService playerInfoService;
	
	/**
	 * 关注用户
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-12下午5:07:37
	 */
	@Test
	public void focusUser(){
		Focus focus = new Focus();
		focus.setF_type(0);
		focus.setF_user_id("2");
		focus.setStatus(0);
		focus.setUser_id("1");
		AjaxMsg msg = userService.saveFocus(focus);
		System.out.println(msg.toJson());
	}
	
	/**
	 * 取消关注
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-12下午6:04:50
	 */
	@Test
	public void cancelFocus(){
		String user_id = "1";
		String f_user_id = "2";
		int type = 0;
		AjaxMsg msg = userService.deleteFocus(user_id, f_user_id,type);
		System.out.println(msg.toJson());
	}
	
	/**
	 * 查询我关注的所有用户、俱乐部分页
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-12下午5:10:42
	 */
	@Test
	public void loadAllFocusUserPage(){
		String user_id = "1";
		String other_user_id = "1";
		PageModel pageModel = new PageModel<>();
		//pageModel.setPageSize(2);
		AjaxMsg msg = userService.getFocusUsersByUserId(user_id,other_user_id,pageModel);
		System.out.println(msg.toJson());
	}
	
	/**
	 * 购买球员
	 */
	@Test
	public void buyPlayer(){
		String buyer = "";//购买者用户ID
		String id = "";//球员跳蚤市场记录ID
		String price = "1000";//购买球员价格
		Map<String,Object> params = Maps.newHashMap();
		AjaxMsg msg = AjaxMsg.newError();
		try {
			msg = playerInfoService.buyPalyer(params);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(msg.toJson());
	}

}

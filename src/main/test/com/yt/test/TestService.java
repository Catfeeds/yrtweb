package com.yt.test;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.PathMatcher;

import com.alibaba.fastjson.JSONObject;
import com.googlecode.jsonrpc4j.JsonRpcHttpClient;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.Resources;
import com.yt.framework.persistent.entity.Role;
import com.yt.framework.persistent.entity.RoleResources;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.DressResourcesService;
import com.yt.framework.service.DressupService;
import com.yt.framework.service.MessageRecordsService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.SecurityService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Base64Util;
import com.yt.framework.utils.PageModel;

/**
 * 测试
 * @Title: TestService.java 
 * @Package com.yt.test
 * @author GL
 * @date 2015年8月3日 下午4:34:16 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:spring/applicationContext.xml","classpath:spring/appServlet/spring-beans.xml","classpath:spring/appServlet/spring-security.xml"})
public class TestService extends AbstractJUnit4SpringContextTests {

	@Autowired
	private SecurityService securityService;
	@Autowired
	private UserService userService;
	
	@Test
	public void saveUser(){
		/*for (int i = 0; i < 100; i++) {
			User user = new User();
			user.setUsername("test"+i);
			user.setPassword("pass"+i);
			userService.save(user);
		}*/
		for (int i = 0; i < 40; i++) {
			Role role = new Role();
			role.setRole_name("test_role_"+i);
			role.setRole_str("str_"+i);
			securityService.saveRole(role);
			
		}
	}
	@Test
	public void testMatcher(){
//		RequestMatcher requestMatcher = new AntPathRequestMatcher("/test");
		PathMatcher matcher = new AntPathMatcher();
//		String path1 = "/test/**";
//		String path2 = "/test/2/2.html";
		String path1 = "/admin/role/formJsp*";
		String path2 = "/admin/role/formJsp?id=1";
		boolean result = matcher.match(path1, path2);  
		System.out.println(result);
	}
	
	/*@Test
	public void testUserRole(){
		UserRole user = securityService.queryUserRole("test");
		System.out.println(user);
		Set<Role> roles = user.getRoles();
		for (Role role : roles) {
			System.out.println(role.getRole_name());
		}
		System.out.println("1111");
	}*/
	
	@Test
	public void testRoleRes(){
		List<Resources> ress = securityService.queryAllResources();
		for (Resources re : ress) {
			System.out.println(re.getRes_name());
		}
		List<RoleResources> rrs = securityService.queryRoleResources();
		for (RoleResources rr : rrs) {
			System.out.println(rr.getRole_name());
			for (Resources res : rr.getResources()) {
				System.out.println("==========="+res.getRes_name());
			}
		}
	}
	@Autowired
	private DressResourcesService dressResourcesService;
	
	@Test
	public void queryDressRes(){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("user_id", 2);
		/*AjaxMsg msg = dressResourcesService.queryMyDressRes(params, new PageModel<>());
		PageModel page = (PageModel) msg.getData("page");
		List<Map<String,Object>> maps = page.getItems();
		for (Map<String, Object> map : maps) {
			System.out.println(map);
		}
		System.out.println(page);*/
		AjaxMsg msg = dressResourcesService.updateDress("2", "3");
		System.out.println(msg.isSuccess());
	}
	
	@Autowired
	private PlayerInfoService playerInfoService;
	
	@Test
	public void savePlayer(){
		PlayerInfo p = new PlayerInfo();
		p.setId("15");
		p.setUser_id("1");
		p.setHeight(100);
		p.setWeight(20.0);
		p.setPro_status(1);
		p.setTack_ability("80");
		p.setPass_ability("60");
		p.setRespond_ability("100");
		p.setBall_ability("70");
		p.setDistance("5000");
		p.setResults("14.4");
//		PlayerInfo p = playerInfoService.getByUserId(1l);
		try {
			//playerInfoService.updatePlayerInfo(p);
		} catch (Exception e) {
			e.printStackTrace();
		}
		/*PlayerAbility a = new PlayerAbility();
		a.setId(1l);
		a.setUser_id(1l);
		a.setShot("80");
		a.setBalance("90");
		try {
			playerAbilityService.updatePlayerAbility(a);
		} catch (Exception e) {
			e.printStackTrace();
		}*/
	}
	
	@Autowired
	private MessageRecordsService messageRecordsService;
	
	@Test
	public void queryMessage(){
		AjaxMsg msg = messageRecordsService.queryNewMsgRecord();
		System.out.println(msg.toJson());
	}
	
	public static JSONObject findMatchInfosBymatchId(String matchId) {
		JSONObject user_json = new JSONObject();
		try {
			URL url = new URL("http://www.uhisports.com/index.php/Api/Match");
			JsonRpcHttpClient client  = new JsonRpcHttpClient(url);
			String identity = "";
			Long timespan = new Date().getTime();
			identity = Base64Util.encodeBase64("yrtDataKey"+timespan) ;
			JSONObject node = new JSONObject();  
			node.put("identity", identity);
			node.put("matchId", matchId);
			node.put("timespan", timespan);
			Map<String,String> headers = new HashMap();
			headers.put("Content-Type", "application/json; charset=UTF-8");
			client.setHeaders(headers);
			System.out.println(identity);
			System.out.println(node.toString());
			user_json = client.invoke("getMatchDataById", node.toJSONString(),JSONObject.class);
			System.out.println(user_json);
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return user_json;
	}
	
	public static void main(String[] args){
		findMatchInfosBymatchId("206699");
		/*Date nowDate = new Date(System.currentTimeMillis());
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		System.out.println(sf.format(nowDate));
		System.out.println(1111);
		System.out.println(System.currentTimeMillis());
		
		Date date = new Date(1477452578966l);
		System.out.println(sf.format(date));	*/
	}
}

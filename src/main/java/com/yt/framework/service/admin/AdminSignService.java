package com.yt.framework.service.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import com.yt.framework.persistent.entity.AdminSign;
import com.yt.framework.persistent.entity.AdminSignCfg;
import com.yt.framework.persistent.entity.Certification;
import com.yt.framework.persistent.entity.LeagueSign;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.BaseService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 后台足球宝贝管理
 * @author bo.xie
 * @date 2015年10月12日11:14:57
 */
public interface AdminSignService extends BaseService<AdminSign>{
	
	/**
	 * 保存报名信息
	 * @param maps
	 * @return
	 */
	public AjaxMsg saveLeagueSign(LeagueSign leagueSign) throws Exception;
	
	/**
	 * 保存实名信息
	 * @param maps
	 * @return
	 */
	public AjaxMsg saveCertification(Certification certification) throws Exception;
	
	/**
	 * 生成账户信息
	 * @param maps
	 * @return
	 */
	public AjaxMsg saveUser(User user) throws Exception;
	
	/**
	 * 生成球员信息
	 * @param maps
	 * @return
	 */
	public AjaxMsg savePlayer(PlayerInfo playerInfo) throws Exception;
	
	/**
	 * 后台报名接口录入
	 * @param maps
	 * @return
	 */
	public AjaxMsg saveAllInfo(AdminSign adminSign,HttpServletRequest request) throws Exception;
	
	/**
	 * app报名接口录入
	 * @param maps
	 * @return
	 */
	public AjaxMsg saveAllInfoApp(AdminSign adminSign,HttpServletRequest request) throws Exception;
	
	/**
	 * 保存报名配置
	 * @param maps
	 * @return
	 */
	public AjaxMsg saveSignCfg(AdminSignCfg adminSignCfg);
	
	/**
	 * 报名配置对象
	 * @param id
	 * @return
	 */
	public AdminSignCfg getCfgById(String id);
	
	/**
	 * 报名配置列表
	 * @param id
	 * @return
	 */
	public AjaxMsg queryCfgForPage(Map<String, Object> maps, PageModel pageModel);
	
	/**
	 * 报名配置总数
	 * @param id
	 * @return
	 */
	public int countCfg(Map<String, Object> maps);
	
	/**
	 * 报名配置总数
	 * @param id
	 * @return
	 */
	public AjaxMsg deleteAdminSignCfg(String id)throws Exception;
	
	/**
	 * 报名配置
	 * @param id
	 * @return
	 */
	public List<AdminSignCfg> getCfgByMap(Map<String, Object> maps);
	
	/**
	 * 关键字查询
	 * @param id
	 * @return
	 */
	public int queryKeyword(String keyword);

}

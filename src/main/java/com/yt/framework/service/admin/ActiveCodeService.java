package com.yt.framework.service.admin;

import java.util.Map;

import com.yt.framework.persistent.entity.ActiveCode;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 *激活码查询列表
 *@autor bo.xie
 *@date2015-8-27下午1:57:10
 */
public interface ActiveCodeService {

	/**
	 * 载入所有激活码
	 * @param maps
	 * @return
	 */
	public AjaxMsg loadActiveCodes(Map<String,Object>maps,PageModel pageModel);
	
	/**
	 * 更新激活码
	 * @param maps
	 * @return
	 */
	public AjaxMsg updateCode(ActiveCode activeCode) throws Exception;

	/**
	 * 获取验证码
	 * @param maps
	 * @return
	 */
	public ActiveCode getActiveCodeByCode(String code);

	/**
	 * 获取验证码
	 * @param league_id
	 * @param code_str
	 * @return
	 */
	public ActiveCode getActiveCode(String code_str);
	
	/**
	 * 生成邀请码
	 * @param league_id
	 * @param code_count
	 * @param init_price
	 * @return
	 */
	public AjaxMsg saveActiveCode(ActiveCode activeCode)throws Exception;
	
	/**
	 * 获取俱乐部验证码
	 * @param league_id
	 * @param code_count
	 * @param init_price
	 * @return
	 */
	public ActiveCode getActiveCodeByTeam(String league_id, String teaminfo_id);
	
	/**
	 * 获取验证码
	 * @param id
	 * @return
	 */
	public ActiveCode getEntityById(String id);

}

package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.ActiveCode;

/**
 *激活码
 *@autor bo.xie
 *@date2015-8-27上午11:50:59
 */
public interface ActiveCodeMapper {

	/**
	 * 保存激活码
	 * @param activeCode
	 */
	public void saveActiveCode(ActiveCode activeCode);
	
	/**
	 * 载入所有激活码
	 * @param maps
	 * @return
	 */
	public List<Map<String,Object>> loadActiveCodes(@Param(value="maps")Map<String,Object>maps);
	
	/**
	 * 激活码总数
	 * @param maps
	 * @return
	 */
	public int loadActiveCodesCount(@Param(value="maps")Map<String,Object>maps);

	/**
	 * 修改激活码状态
	 * @param maps
	 * @return
	 */		
	public void updateCode(ActiveCode activeCode);
	
	/**
	 * 获取激活码
	 * @param maps
	 * @return
	 */		
	public ActiveCode getActiveCodeByCode(@Param(value="code_str")String code_str);

	public ActiveCode getActiveCode(@Param(value="code_str")String code_str);
	
	/**
	 * 获取激活码
	 * @param maps
	 * @return
	 */	
	public ActiveCode getActiveCodeByTeam(@Param(value="league_id")String league_id,@Param(value="teaminfo_id")String teaminfo_id);

	/**
	 * 获取激活码
	 * @param id
	 * @return
	 */		
	public ActiveCode getEntityById(@Param(value="id")String id);
	
}

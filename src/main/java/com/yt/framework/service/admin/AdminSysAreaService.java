package com.yt.framework.service.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.SysArea;
import com.yt.framework.persistent.entity.SysDict;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 区域处理 
 *@autor ylt
 *@date2016-2-23下午1:57:10
 */
public interface AdminSysAreaService {

	/**
	 * 查询区域列表
	 * @param parent_code
	 * @return
	 */
	public List<Map<String, Object>> querySysArea(String parent_code);
	
	/**
	 * 查询数据区域
	 * @param parent_code
	 * @return
	 */
	public List<SysArea> sysAreaList(String parent_code);
	
	
	/**
	 * 保存区域
	 * @param sysDict
	 * @return
	 */
	public AjaxMsg saveSysArea(SysArea sysArea)throws Exception;
	
	/**
	 * 区域修改
	 * @param sysDict
	 * @return
	 */
	public AjaxMsg updateSysArea(SysArea sysArea)throws Exception;
	
	/**
	 * 区域查询
	 * @param maps pageModel
	 * @return
	 */
	public AjaxMsg queryForPage(Map<String, Object> maps, PageModel pageModel);
	
	/**
	 * 区域查询总数
	 * @param maps pageModel
	 * @return
	 */
	public int count(Map<String, Object> maps);
	
	/**
	 * 区域获取
	 * @param id
	 * @return
	 */
	public SysArea getEntityById(Long id);
	
	/**
	 * 所有区域
	 * @param id
	 * @return
	 */
	public List<SysArea> allSysArea();
	
	/**
	 * 返回对象中文显示名称
	 * @autor ylt
	 * @return id
	 */
	public String id2Name(String area_code);
	
	/**
	 * 区域获取
	 * @param area_code
	 * @return
	 */
	public SysArea getAreaByCode(String area_code);
	
	/**
	 * 删除区域
	 * @param id
	 * @return
	 */
	public AjaxMsg delSysArea(SysArea sysArea)throws Exception;
}

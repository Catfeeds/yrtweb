package com.yt.framework.service.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.SysDict;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 *激活码查询列表
 *@autor bo.xie
 *@date2015-8-27下午1:57:10
 */
public interface SysDictService {

	/**
	 * 查询数据字典
	 * @param clm
	 * @return
	 */
	public List<Map<String, Object>> queryDicts(String clm);
	
	/**
	 * 查询数据字典
	 * @param clm
	 * @return
	 */
	public List<SysDict> dictList(String clm);
	
	/**
	 * 查询字典名称
	 * @param dict_column 字段  dictId 字典id
	 * @return
	 */
	public String dictName(String dict_column,String dictId);
	
	/**
	 * 保存字典
	 * @param sysDict
	 * @return
	 */
	public AjaxMsg saveDict(SysDict sysDict)throws Exception;
	
	/**
	 * 字典修改
	 * @param sysDict
	 * @return
	 */
	public AjaxMsg updateDict(SysDict sysDict)throws Exception;
	
	/**
	 * 字典查询
	 * @param maps pageModel
	 * @return
	 */
	public AjaxMsg queryForPage(Map<String, Object> maps, PageModel pageModel);
	
	/**
	 * 字典查询总数
	 * @param maps pageModel
	 * @return
	 */
	public int count(Map<String, Object> maps);
	
	/**
	 * 字典获取
	 * @param id
	 * @return
	 */
	public SysDict getEntityById(Long id);
	
	/**
	 * 所有字典
	 * @param id
	 * @return
	 */
	public List<SysDict> allDict();
	

}

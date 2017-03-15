package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.SysDict;

/**
 * 系统字典
 *@autor ylt
 *@date2015-8-19下午4:30:32
 */
public interface SysDictMapper extends BaseMapper<SysDict> {

	public void saveDict(SysDict sysDict);

	public void updateDict(SysDict sysDict);

	public SysDict getEntityById(@Param(value="id")Long id);
	
	/**
	 * 查询数据字典
	 * @param clm
	 * @return
	 */
	public List<Map<String, Object>> queryDicts(@Param(value="clm")String clm);
	
	public List<String> queryDictsKey();

	/**
	 * 查询数据字典
	 * @param clm
	 * @return
	 */
	public List<SysDict> dictList(@Param(value="clm")String clm);
	
	/**
	 * 查询字典名称
	 * @param clm
	 * @return
	 */
	public String dictName(@Param(value="dict_column")String dict_column,@Param(value="dictId")String dictId);
	
	/**
	 * 查询所有字典
	 * @param clm
	 * @return
	 */
	public List<SysDict> allDict();
	
}

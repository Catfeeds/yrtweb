package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;


/**
 *接口基类CRUD
 *@autor bo.xie
 *@date2015-7-21下午2:10:21
 */
public interface BaseMapper<T> {

	/**
	 *保存实体类 
	 *@param t 实体类
	 *@autor bo.xie
	 *@date2015-7-22下午6:09:51
	 */
	public void save(T t);
	
	/**
	 * 更新实体类
	 *@param t 实体类
	 *@autor bo.xie
	 *@date2015-7-22下午6:10:41
	 */
	public void update(T t);
	
	/**
	 * 删除某一实体对象
	 *@param id
	 *@autor bo.xie
	 *@date2015-7-22下午6:11:17
	 */
	public void delete(@Param(value="id")String id);
	
	/**
	 * 获取某实体对象
	 *@param id
	 *@return T 实体类
	 *@autor bo.xie
	 *@date2015-7-22下午6:12:22
	 */
	public T getEntityById(@Param(value="id")String id);
	
	
	/**
	 * 批量刪除(可以只删除一条)
	 * @param ids
	 * @autor GL
	 * @return
	 */
	public int deleteByIds(String[] ids);
	
	/**
	 * 查询类型信息,并且支持分页显示，带条件查询(map必须参数：start：开始索引,rows：每页条数)
	 * @param map
	 * @autor GL
	 * @return
	 */
	public List<T> queryForPage(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 分页查询，返回Map
	 * @param map
	 * @autor GL
	 * @return
	 */
	public List<Map<String, Object>> queryForPageForMap(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 查询当前关键字的总记录数(map必须参数：start：开始索引,rows：每页条数)
	 * @param map
	 * @autor GL
	 * @return
	 */
	public int count(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 执行一条查询语句(保留接口，不推荐使用)
	 * @autor GL
	 * @return 返回map封装的结果集合
	 */
	public List<Map<String,Object>> queryBySql(@Param(value="sql")String sql);

	public T getByUserId(@Param(value="userId")String userId);
	
	/**
	 * 返回对象中文显示名称
	 * @autor ylt
	 * @return id
	 */
	public String id2Name(String id);
	
}

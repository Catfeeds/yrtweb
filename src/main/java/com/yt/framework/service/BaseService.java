package com.yt.framework.service;

import java.util.Map;

import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 通用service方法
 * @Title: BaseService.java 
 * @Package com.yt.framework.service
 * @author GL
 * @date 2015年8月3日 下午4:19:53 
 */
public interface BaseService<T> {

	/**
	 * 通過ID查詢实体
	 * @param id
	 * @return
	 */
	public T getEntityById(String id);
	/**
	 * 从实体对象插入(没有id会自动生成,有id则会插入指定id,只会插入实体对象中有值的字段)
	 * @param t
	 * @return
	 */
	public AjaxMsg save(T t);
	/**
	 * 从实体对象保存(必须指定id,只会保存实体对象中有值的字段)
	 * @param t
	 * @return
	 */
	public AjaxMsg update(T t);
	
	/**
	 * 刪除
	 *@param id
	 *@return AjaxMsg
	 */
	public AjaxMsg delete(String id);
	/**
	 * 批量刪除(可以只删除一条)
	 * @param ids
	 * @return
	 */
	public AjaxMsg deleteByIds(String[] ids);
	/**
	 * 查询类型信息,并且支持分页显示，带条件查询(map必须参数：start：开始索引,rows：每页条数)
	 * @param map
	 * @return
	 */
	public AjaxMsg queryForPage(Map<String, Object> map,PageModel<T> pageModel);
	
	/**
	 * 分页查询，返回Map
	 * @param map
	 * @return
	 */
	public AjaxMsg queryForPageForMap(Map<String, Object> map,PageModel pageModel);
	/**
	 * 查询当前关键字的总记录数(map必须参数：start：开始索引,rows：每页条数)
	 * @param map
	 * @return
	 */
	public int count(Map<String, Object> map);
	
	/**
	 * 根据用户ID查询球员
	 * @param userId
	 */
	public AjaxMsg getByUserId(String userId);
	
	/**
	 * 根据对象id获取名称
	 * @param userId
	 */
	public String id2Name(String id);
}

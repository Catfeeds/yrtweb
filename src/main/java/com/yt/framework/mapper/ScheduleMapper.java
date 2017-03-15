package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.yt.framework.persistent.entity.ScheduleJob;

/**
 *  任务调度类
 *@autor ylt
 *@date2015-11-12上午11:50:59
 */
public interface ScheduleMapper {
	/**
	 * 保存任务调度配置
	 * @param activeCode
	 */
	public void save(ScheduleJob scheduleJob);
	
	/**
	 * 更新任务调度配置
	 *@param scheduleJob 
	 */
	public void update(ScheduleJob scheduleJob);
	
	/**
	 * 删除任务调度配置
	 *@param id
	 */
	public void delete(@Param(value="id")String id);
	
	/**
	 * 获取ScheduleJob
	 *@param id
	 */
	public ScheduleJob getEntityById(@Param(value="id")String id);
	
	
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
	 * @autor ylt
	 * @return
	 */
	public List<ScheduleJob> queryForPage(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 分页查询，返回Map
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> queryForPageForMap(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 查询当前关键字的总记录数(map必须参数：start：开始索引,rows：每页条数)
	 * @param map
	 * @return
	 */
	public int count(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * 查看用户配置信息
	 * @param user_id
	 * @return
	 */
	public ScheduleJob getByUserId(@Param(value="user_id")String user_id);
	
	/**
	 * 查看配置任务
	 * @param user_id
	 * @return
	 */
	public List<ScheduleJob> getAllJob();
	
	/**
	 * 查询任务
	 * @param job_name job_group
	 * @return
	 */
	public ScheduleJob getScheduleJobByName(@Param(value="job_name")String job_name,@Param(value="job_group") String job_group);
	
	/**
	 * 查询任务
	 * @param job_name
	 * @return
	 */
	public ScheduleJob getScheduleJobByNameSingle(@Param(value="job_name")String job_name);
	
}

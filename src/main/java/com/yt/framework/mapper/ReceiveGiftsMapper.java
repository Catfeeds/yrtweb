package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.ReceiveGifts;

/**
 * 
 * @author mocoy
 *
 */
public interface ReceiveGiftsMapper {
	
	public void save(ReceiveGifts receiveGifts);

	public void update(ReceiveGifts receiveGifts);
	
	public ReceiveGifts getEntityById(@Param(value="id")String id);

	public List<Map<String,Object>>  getUserReceiveGifts(@Param(value="user_id")String user_id);
	
	
}

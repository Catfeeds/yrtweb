package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.OrderNumData;
import com.yt.framework.persistent.entity.UserProduct;
import com.yt.framework.persistent.entity.UserProductCategory;
import com.yt.framework.persistent.entity.UserProductData;

public interface UserProductMapper extends BaseMapper<UserProduct>{
	
	public int queryProductsCount(Map<String, Object> params);

	public List<Map<String, Object>> queryProducts(Map<String, Object> params);

	public List<Map<String, Object>> queryWinUsers();

	public Map<String, Object> getProduct(@Param(value="id")String id);

	public List<Map<String, Object>> queryIndianaRecords(Map<String, Object> params);

	public int queryIndianaRecordsCount(Map<String, Object> params);

	public List<UserProductCategory> queryProductCategory(Map<String, Object> params);

	public List<OrderNumData> queryOrderNumData(Map<String, Object> params);

	public void updateOrderNumData(OrderNumData o);

	public void updateProductDataNum(@Param(value="data_id")String data_id, 
			@Param(value="data_count")int data_count,@Param(value="data_status")int data_status);
	
	
	public List<UserProductData> queryProductData(Map<String, Object> params);

	public void updateProductData(UserProductData data);

	public List<Map<String, Object>> queryConsumeTop();

}

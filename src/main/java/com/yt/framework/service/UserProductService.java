package com.yt.framework.service;

import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.OrderNumData;
import com.yt.framework.persistent.entity.UserProduct;
import com.yt.framework.persistent.entity.UserProductCategory;
import com.yt.framework.persistent.entity.UserProductData;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

public interface UserProductService extends BaseService<UserProduct> {

	public int queryProductsCount(Map<String, Object> params);
	/**
	 * 商品列表
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> queryProducts(Map<String, Object> params);
	/**
	 * 商品分页列表
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryProducts(Map<String, Object> params, PageModel pageModel);
	/**
	 * 获奖列表
	 * @return
	 */
	public List<Map<String, Object>> queryWinUsers();
	/**
	 * 更具商品ID获取商品详情
	 * @param id
	 * @return
	 */
	public Map<String, Object> getProduct(String id);
	/**
	 * 查询当天夺宝记录
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryIndianaRecords(Map<String, Object> params,PageModel pageModel);
	/**
	 * 商品分类
	 * @param object
	 * @return
	 */
	public List<UserProductCategory> queryProductCategory(Map<String, Object> params);
	/**
	 * 获取夺宝号码
	 * @param object
	 * @return
	 */
	public List<OrderNumData> queryOrderNumData(Map<String, Object> params);
	/**
	 * 更新号码表
	 * @param object
	 * @return
	 */
	public void updateOrderNumData(OrderNumData o);
	
	/**
	 * 更新购买人数
	 * @param object
	 * @return
	 */
	public void updateProductDataNum(String data_id, int data_count,int data_status)throws Exception;
	
	
	/**
	 * 开启下一轮商品
	 * @return
	 * @throws Exception
	 */
	public AjaxMsg updateProductDataNext(String product_id)throws Exception;
	
	
	/**
	 * 获取最新一期商品
	 * @return
	 */
	public UserProductData getRecentProduct(String product_id);
	/**
	 * 查询消费榜
	 * @return
	 */
	public List<Map<String, Object>> queryConsumeTop();
	
}

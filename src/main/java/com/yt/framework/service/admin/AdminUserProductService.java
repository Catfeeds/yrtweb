package com.yt.framework.service.admin;

import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.UserProduct;
import com.yt.framework.persistent.entity.UserProductCategory;
import com.yt.framework.persistent.entity.UserProductData;
import com.yt.framework.service.BaseService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

public interface AdminUserProductService extends BaseService<UserProduct>{

	public int queryProductsCount(Map<String, Object> params);
	public AjaxMsg queryProducts(Map<String, Object> params, PageModel pageModel);
	/**
	 * 产品分类列表
	 * @param maps
	 * @param pageModel
	 * @return
	 */
	public List<Map<String, Object>> queryProductCategorys(Map<String, Object> params);
	public AjaxMsg queryProductCategorys(Map<String, Object> params,PageModel pageModel);
	public int queryProductCategorysCount(Map<String, Object> maps);
	/**
	 * 根据ID查询分类
	 * @param id
	 * @return
	 */
	public UserProductCategory getProductCategory(String id);
	/**
	 * 删除或修改产品
	 * @param product
	 * @return
	 */
	public AjaxMsg saveOrUpdate(UserProduct product) throws Exception;
	public AjaxMsg deleteProduct(String id,String tag);
	/**
	 * 删除或修改分类
	 * @param category
	 * @return
	 */
	public AjaxMsg saveOrUpdateCategory(UserProductCategory category) throws Exception;
	/**
	 * 删除分类
	 * @param id
	 * @return
	 */
	public AjaxMsg deleteCategory(String id) throws Exception;
	/**
	 * 检测是否父类
	 * @param currentId
	 * @return
	 */
	public boolean ifParent(String currentId);
	
	public List<UserProductCategory> queryCategoryChilds(String parentId);
	
	public int queryProductDatasCount(Map<String, Object> params);
	public List<Map<String, Object>> queryProductDatas(Map<String, Object> params);
	public List<UserProductData> queryProductData(Map<String, Object> params);
	public AjaxMsg queryProductDatas(Map<String, Object> params, PageModel pageModel);
	/**
	 * 查询剩余轮次
	 * @param product_id
	 * @return
	 */
	public AjaxMsg getHaveNum(Map<String, Object> params);
	/**
	 * 开启产品夺宝
	 * @param obj
	 * @return
	 */
	public AjaxMsg updateProductOpenStatus(Map<String, String> obj,String type);
	public AjaxMsg saveOrUpdateProductData(UserProductData data);
	public AjaxMsg deleteProductData(String id);
	UserProductData getProductData(String id);
	/**
	 * 查询当前轮次开奖号码
	 * @param maps
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryOrderNums(Map<String, Object> maps, PageModel pageModel);
}

package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.persistent.entity.UserProduct;
import com.yt.framework.persistent.entity.UserProductCategory;
import com.yt.framework.persistent.entity.UserProductData;

public interface AdminUserProductMapper extends BaseMapper<UserProduct> {

	public int queryProductsCount(Map<String, Object> params);
	public List<Map<String, Object>> queryProducts(Map<String, Object> params);
	public List<Map<String, Object>> queryProductCategorys(Map<String, Object> params);
	public void deleteProduct(@Param(value="id")String id);
	public int queryProductCategorysCount(Map<String, Object> params);
	public UserProductCategory getProductCategory(@Param(value="id")String id);
	public void updateCategory(UserProductCategory category);
	public void saveCategory(UserProductCategory category);
	public void deleteCategory(@Param(value="id")String id);
	public List<UserProductCategory> queryCategoryChilds(@Param(value="parentId")String parentId);
	public List<Map<String, Object>> queryProductDatas(Map<String, Object> params);
	public List<UserProductData> queryProductData(Map<String, Object> params);
	public int queryProductDatasCount(Map<String, Object> params);
	public void saveProductData(UserProductData data);
	public void updateProductData(UserProductData data);
	public void deleteProductData(@Param(value="id")String id);
	public UserProductData getProductData(@Param(value="id")String id);
}

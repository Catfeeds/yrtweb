package com.yt.framework.service.Impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.OrderNumData;
import com.yt.framework.persistent.entity.UserProduct;
import com.yt.framework.persistent.entity.UserProductCategory;
import com.yt.framework.persistent.entity.UserProductData;
import com.yt.framework.service.UserProductService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

@Service("userProductService")
public class UserProductServiceImpl extends BaseServiceImpl<UserProduct>implements UserProductService {

	@Override
	public int queryProductsCount(Map<String, Object> params) {
		return userProductMapper.queryProductsCount(params);
	}

	@Override
	public List<Map<String, Object>> queryProducts(Map<String, Object> params) {
		return userProductMapper.queryProducts(params);
	}

	@Override
	public AjaxMsg queryProducts(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = queryProductsCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = queryProducts(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public List<Map<String, Object>> queryWinUsers() {
		return userProductMapper.queryWinUsers();
	}

	@Override
	public Map<String, Object> getProduct(String id) {
		return userProductMapper.getProduct(id);
	}

	@Override
	public AjaxMsg queryIndianaRecords(Map<String, Object> params,PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = userProductMapper.queryIndianaRecordsCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = userProductMapper.queryIndianaRecords(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public List<UserProductCategory> queryProductCategory(Map<String, Object> params) {
		if(params == null){
			params = new HashMap<String, Object>();
		}
		return userProductMapper.queryProductCategory(params);
	}

	@Override
	public List<OrderNumData> queryOrderNumData(Map<String, Object> params) {
		return userProductMapper.queryOrderNumData(params);
	}

	@Override
	public void updateOrderNumData(OrderNumData o) {
		userProductMapper.updateOrderNumData(o);
		
	}

	@Override
	public void updateProductDataNum(String data_id, int data_count,int data_status)throws Exception {
		userProductMapper.updateProductDataNum(data_id,data_count,data_status);
	}

	@Override
	public AjaxMsg updateProductDataNext(String product_id) throws Exception {
		//检测商品是否上架
		UserProduct product = getEntityById(product_id);
		if(product!=null&&"1".equals(product.getProduct_status())){
			//检测是否还有下一轮
			Map<String, Object> params = new HashMap<String,Object>();
			params.put("product_id", product_id);
			params.put("order_by","asc");
			params.put("data_status", "1");
			List<UserProductData> datas = userProductMapper.queryProductData(params);
			if(datas!=null&&datas.size()>0){
				UserProductData data = datas.get(0);
				data.setData_start_time(new Date());//开启轮次正序第一个
				data.setData_status("2");//1等待2进行3待揭晓4结束
				userProductMapper.updateProductData(data);
				addOrderNumData(data);//添加该商品夺宝号码
				product.setProduct_ifopen("1");//product状态开启
			}else{
				product.setProduct_ifopen("0");//product状态开启
			}
			update(product);
		}
		return AjaxMsg.newSuccess();
	}
	
	public void addOrderNumData(UserProductData data) {
		List<String> ls = Common.createAutomaticNum("8", data.getData_total_count());
		Collections.shuffle(ls);
		int i=0;
		for(String num:ls){
			OrderNumData orderNumData = new OrderNumData();
			orderNumData.setData_sn(data.getData_sn());
			orderNumData.setNum_id(UUIDGenerator.getUUID());
			orderNumData.setOrder_num(num);
			orderNumData.setOrder_num_mark(i);
			userOrderMapper.addOrderNumData(orderNumData );
			i++;
		}
	}

	@Override
	public UserProductData getRecentProduct(String product_id) {
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("product_id", product_id);
		params.put("order_by","asc");
		params.put("data_status", "2");
		List<UserProductData> datas = userProductMapper.queryProductData(params);
		if(datas!=null&&datas.size()>0){
			return datas.get(0);
		}
		return null;
	}

	@Override
	public List<Map<String, Object>> queryConsumeTop() {
		return userProductMapper.queryConsumeTop();
	}

	@Override
	public int queryProductRecords() {
		return userProductMapper.queryProductRecords();
	}
	
	
}

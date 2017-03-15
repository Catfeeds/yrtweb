package com.yt.framework.service.Impl.adminImpl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.OrderNumData;
import com.yt.framework.persistent.entity.UserProduct;
import com.yt.framework.persistent.entity.UserProductCategory;
import com.yt.framework.persistent.entity.UserProductData;
import com.yt.framework.service.FileService;
import com.yt.framework.service.admin.AdminUserProductService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.oss.OSSClientFactory;

@Service(value="adminUserProductService")
public class AdminUserProductServiceImpl extends BaseAdminServiceImpl<UserProduct> implements AdminUserProductService {

	@Autowired
	private FileService fileService;
	
	@Override
	public int queryProductsCount(Map<String, Object> params) {
		return userProductMapper.queryProductsCount(params);
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
			datas = userProductMapper.queryProducts(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public List<Map<String, Object>> queryProductCategorys(Map<String, Object> params) {
		return userProductMapper.queryProductCategorys(params);
	}

	@Override
	public AjaxMsg queryProductCategorys(Map<String, Object> params,PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = queryProductCategorysCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = queryProductCategorys(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public int queryProductCategorysCount(Map<String, Object> params) {
		return userProductMapper.queryProductCategorysCount(params);
	}

	@Override
	public UserProductCategory getProductCategory(String id) {
		return userProductMapper.getProductCategory(id);
	}
	
	@Override
	public AjaxMsg saveOrUpdate(UserProduct product) throws Exception{
		AjaxMsg msg = AjaxMsg.newSuccess();
		if(StringUtils.isNotBlank(product.getProduct_id())){
			UserProduct old = getEntityById(product.getProduct_id());
			userProductMapper.update(product);
			msg = fileService.uploadImg2OSS(old.getProduct_header(),product.getProduct_header());
			if(msg.isSuccess()){
				String[] old_banners = StringUtils.isNotBlank(old.getProduct_banner()) ? old.getProduct_banner().split(",") : null;
				String[] new_banners = StringUtils.isNotBlank(product.getProduct_banner()) ? product.getProduct_banner().split(",") : null;
				msg = fileService.uploadImg2OSS(old_banners,new_banners);
			}
			if(msg.isSuccess()){
				String[] old_descs = StringUtils.isNotBlank(old.getProduct_desc()) ? old.getProduct_desc().split(",") : null;
				String[] new_descs = StringUtils.isNotBlank(product.getProduct_desc()) ? product.getProduct_desc().split(",") : null;
				msg = fileService.uploadImg2OSS(old_descs,new_descs);
			}
		}else{
			product.setProduct_id(UUIDGenerator.getUUID());
			if(product.getProduct_recommend_sort()==null) product.setProduct_recommend_sort(0);
			if(StringUtils.isNotBlank(product.getProduct_header())){
				msg = fileService.uploadImg2OSS(product.getProduct_header());
			}
			if(msg.isSuccess()){
				if(StringUtils.isNotBlank(product.getProduct_banner())){
					msg = fileService.uploadImg2OSS(product.getProduct_banner().split(","));
				}
			}
			if(msg.isSuccess()){
				if(StringUtils.isNotBlank(product.getProduct_desc())){
					msg = fileService.uploadImg2OSS(product.getProduct_desc().split(","));
				}
			}
			if(msg.isSuccess()){
				userProductMapper.save(product);
			}
		}
		return msg;
	}
	
	public AjaxMsg deleteProduct(String id,String tag){
		if(StringUtils.isNotBlank(tag)){
			UserProduct product = getEntityById(id);
			if(StringUtils.isNotBlank(product.getProduct_header())){
				OSSClientFactory.deleteFile(product.getProduct_header());
			}
			if(StringUtils.isNotBlank(product.getProduct_banner())){
				String[] banners = product.getProduct_banner().split(",");
				if(banners!=null&&banners.length>0){
					for (String b : banners) {
						if(StringUtils.isNotBlank(b)){
							OSSClientFactory.deleteFile(b);
						}
					}
				}
			}
			if(StringUtils.isNotBlank(product.getProduct_desc())){
				String[] descs = product.getProduct_desc().split(",");
				if(descs!=null&&descs.length>0){
					for (String d : descs) {
						if(StringUtils.isNotBlank(d)){
							OSSClientFactory.deleteFile(d);
						}
					}
				}
			}
			delete(id);
		}else{
			userProductMapper.deleteProduct(id);
		}
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg saveOrUpdateCategory(UserProductCategory category) throws Exception{
		AjaxMsg msg = AjaxMsg.newSuccess();
		if(StringUtils.isNotBlank(category.getCategory_id())){
			UserProductCategory old = getProductCategory(category.getCategory_id());
			msg = fileService.uploadImg2OSS(old.getCategory_header(),category.getCategory_header());
			if(msg.isSuccess()){
				userProductMapper.updateCategory(category);
			}
		}else{
			category.setCategory_id(UUIDGenerator.getUUID());
			msg = fileService.uploadImg2OSS(category.getCategory_header());
			if(msg.isSuccess()){
				userProductMapper.saveCategory(category);
			}
		}
		return msg;
	}

	@Override
	public AjaxMsg deleteCategory(String id) {
		UserProductCategory category = getProductCategory(id);
		if(category!=null){
			if(StringUtils.isNotBlank(category.getCategory_header())){
				OSSClientFactory.deleteFile(category.getCategory_header());
			}
			userProductMapper.deleteCategory(id);
		}
		return AjaxMsg.newSuccess();
	}

	@Override
	public boolean ifParent(String currentId) {
		List<UserProductCategory> childs = queryCategoryChilds(currentId);
		if(childs!=null&&childs.size()>0){
			return true;
		}
		return false;
	}

	@Override
	public List<UserProductCategory> queryCategoryChilds(String parentId) {
		return userProductMapper.queryCategoryChilds(parentId);
	}

	@Override
	public int queryProductDatasCount(Map<String, Object> params) {
		return userProductMapper.queryProductDatasCount(params);
	}

	@Override
	public List<Map<String, Object>> queryProductDatas(Map<String, Object> params) {
		return userProductMapper.queryProductDatas(params);
	}

	@Override
	public AjaxMsg queryProductDatas(Map<String, Object> params,PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = queryProductDatasCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = queryProductDatas(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}
	
	@Override
	public List<UserProductData> queryProductData(Map<String, Object> params) {
		return userProductMapper.queryProductData(params);
	}

	@Override
	public AjaxMsg getHaveNum(Map<String, Object> params) {
		int num = queryProductDatasCount(params);//剩余未开启轮数
		return AjaxMsg.newSuccess().addData("have_num", num);
	}
	
	/**
	 * 检测是否有为结束商品
	 * @param pid
	 * @return
	 */
	private boolean checkProductDataIfend(String pid){
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("product_id", pid);
		params.put("group_by", "asc");//正序
		params.put("not_end", "1");//开始时间为空的
		List<UserProductData> datas = queryProductData(params);
		if(datas!=null&&datas.size()>0){
			return true;
		}
		return false;
	}

	@Override
	public AjaxMsg updateProductOpenStatus(Map<String, String> obj,String type) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		String pid = obj.get("pid");
		int open_num = Integer.valueOf(StringUtils.isNotBlank(obj.get("open_num"))?obj.get("open_num"):"0");
		//检测商品是否上架
		UserProduct product = getEntityById(pid);
		if(product.getProduct_single_price()==null || product.getProduct_single_price().intValue() <= 0 ){
			return AjaxMsg.newError().addMessage("商品单价必须大于0！");
		}
		if(product!=null&&"1".equals(product.getProduct_status())){
			//添加轮数
			if(open_num>0){
				//查询当前产品最后轮次
				Map<String, Object> params = new HashMap<String,Object>();
				params.put("product_id", pid);
				List<Map<String, Object>> datas = queryProductDatas(params);
				int end_turn = 0;
				if(datas!=null&&datas.size()>0){
					Map<String, Object> data = datas.get(0);
					end_turn = Integer.parseInt(data.get("data_turn").toString());
				}
				for (int i = 1; i <= open_num; i++) {
					int data_turn = end_turn+i;
					UserProductData data = new UserProductData();
					data.setData_sn(Common.getDateSn(data_turn));
					data.setProduct_id(pid);
					data.setCategory_id(product.getCategory_id());
					data.setData_single_price(product.getProduct_single_price());
					data.setData_total_price(product.getProduct_final_price());
					data.setData_total_count(product.getProduct_total_count());
					data.setData_count(0);
					data.setData_status("1");
					data.setData_turn(data_turn);
					saveOrUpdateProductData(data);
				}
			}
			//开启夺宝
			if(StringUtils.isBlank(type) || !"1".equals(type)){
				Map<String, Object> params = new HashMap<String,Object>();
				params.put("product_id", pid);
				params.put("group_by", "asc");//正序
				params.put("data_status", "1");//状态未开启
				List<UserProductData> datas = queryProductData(params);
				if(datas!=null&&datas.size()>0){
					UserProductData data = datas.get(0);
					data.setData_start_time(new Date());//开启轮次正序第一个
					data.setData_status("2");
					saveOrUpdateProductData(data);
					addOrderNumData(data);//添加该商品奖品号码
					product.setProduct_ifopen("1");//product状态开启
					update(product);
				}else{
					msg = AjaxMsg.newError().addMessage("请先添加轮次！");
				}
			}
		}
		return msg;
	}
	
	
	@Override
	public UserProductData getProductData(String id) {
		return userProductMapper.getProductData(id);
	}

	@Override
	public AjaxMsg saveOrUpdateProductData(UserProductData data) {
		if(StringUtils.isNotBlank(data.getData_id())){
			userProductMapper.updateProductData(data);
		}else{
			data.setData_id(UUIDGenerator.getUUID());
			userProductMapper.saveProductData(data);
		}
		return AjaxMsg.newSuccess();
	}

	@Override
	public AjaxMsg deleteProductData(String id) {
		userProductMapper.deleteProductData(id);
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
	public AjaxMsg queryOrderNums(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = userOrderMapper.queryOrderNumsCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = userOrderMapper.queryOrderNums(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

}

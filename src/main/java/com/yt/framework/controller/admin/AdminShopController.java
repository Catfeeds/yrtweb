package com.yt.framework.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.controller.BaseController;
import com.yt.framework.persistent.entity.UserOrder;
import com.yt.framework.persistent.entity.UserProduct;
import com.yt.framework.persistent.entity.UserProductCategory;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.admin.AdminUserOrderService;
import com.yt.framework.service.admin.AdminUserProductService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.ObjectExcelView;
import com.yt.framework.utils.PageModel;
/**
 * 订单管理
 * @author ylt
 * @Date 2016年9月29日
 * @version
 */
@RequestMapping(value="/admin/shop/")
@Controller
public class AdminShopController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(AdminShopController.class);
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private AdminUserOrderService adminUserOrderService;
	@Autowired
	private AdminUserProductService adminUserProductService;
	
	/**
	 * 分类列表
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value = "categorys")
	public String categorys(HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		String category_name = request.getParameter("category_name");
		if(StringUtils.isNotBlank(category_name)) maps.put("category_name", category_name);
		AjaxMsg msg = adminUserProductService.queryProductCategorys(maps, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", maps);
		return "admin/shop/product_categorys";
	}
	
	/**
	 * 分类数据 用于树状下拉框
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "queryCategorys")
	@ResponseBody
	public List<Map<String,Object>> queryCategorys(HttpServletRequest request){
		String currentId = request.getParameter("currentId");
		Map<String,Object> maps = Maps.newHashMap();
		if(StringUtils.isNotBlank(currentId)){
			maps.put("currentId", currentId);
			boolean if_parent = adminUserProductService.ifParent(currentId);
			if(if_parent){
				maps.put("if_parent", currentId);
			}
		}
		List<Map<String,Object>> categorys = adminUserProductService.queryProductCategorys(maps);
		return categorys;
	}
	
	@RequestMapping(value="category/formJsp")
	public String categoryFormJsp(HttpServletRequest request){
		String id = request.getParameter("id");
		UserProductCategory category = new UserProductCategory();
		String parent_name = "";
		if(StringUtils.isNotBlank(id)){
			category = adminUserProductService.getProductCategory(id);
			if(StringUtils.isNotBlank(category.getParent_id())){
				UserProductCategory parent = adminUserProductService.getProductCategory(category.getParent_id());
				parent_name = parent.getCategory_name();
			}
		}
		request.setAttribute("category", category);
		request.setAttribute("parent_name", parent_name);
		return "admin/shop/product_category_form"; 
	}
	
	/**
	 * 添加或修改分类
	 * @param request
	 * @param category
	 * @return
	 */
	@RequestMapping(value="category/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdateCategory(HttpServletRequest request,UserProductCategory category){
		try {
			AjaxMsg msg = adminUserProductService.saveOrUpdateCategory(category);
			return msg.toJson();
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().toJson();
		}
	}
	/**
	 * 删除分类
	 * @param request
	 * @return
	 */
	@RequestMapping(value="category/delete")
	@ResponseBody
	public String deleteCategory(HttpServletRequest request){
		String id = request.getParameter("id");
		try {
			AjaxMsg msg = adminUserProductService.deleteCategory(id);
			return msg.toJson();
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().toJson();
		}
	}
	
	/**
	 * 产品列表
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value = "products")
	public String productList(HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		String product_title = request.getParameter("product_title");
		String product_status = request.getParameter("product_status");
		String parent_name = request.getParameter("parent_name");
		String category_id = request.getParameter("category_id");
		String product_type = request.getParameter("product_type");
		String product_ifopen = request.getParameter("product_ifopen");
		String product_no = request.getParameter("product_no");
		if(StringUtils.isNotBlank(product_title)) maps.put("product_title", product_title);
		if(StringUtils.isNotBlank(product_status)) maps.put("product_status", product_status);
		if(StringUtils.isNotBlank(category_id)) maps.put("category_id", category_id);
		if(StringUtils.isNotBlank(parent_name)) maps.put("parent_name", parent_name);
		if(StringUtils.isNotBlank(product_type)) maps.put("product_type", product_type);
		if(StringUtils.isNotBlank(product_ifopen)) maps.put("product_ifopen", product_ifopen);
		if(StringUtils.isNotBlank(product_no)) maps.put("product_no", product_no);
		maps.put("product_ifdel", "0");//查询未删除产品
		AjaxMsg msg = adminUserProductService.queryProducts(maps, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", maps);
		return "admin/shop/product_list";
	}
	
	/**
	 * 进入产品添加修改页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="product/formJsp")
	public String productFormJsp(HttpServletRequest request){
		String id = request.getParameter("id");
		UserProduct product = new UserProduct();
		String parent_name ="";
		if(StringUtils.isNotBlank(id)){
			product = adminUserProductService.getEntityById(id);
			if(StringUtils.isNotBlank(product.getCategory_id())){
				UserProductCategory parent = adminUserProductService.getProductCategory(product.getCategory_id());
				parent_name = parent.getCategory_name();
			}
		}
		request.setAttribute("product", product);
		request.setAttribute("parent_name", parent_name);
		return "admin/shop/product_form"; 
	}
	
	/**
	 * 添加或修改产品
	 * @param request
	 * @param product
	 * @return
	 */
	@RequestMapping(value="product/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(HttpServletRequest request,UserProduct product){
		try {
			AjaxMsg msg = adminUserProductService.saveOrUpdate(product);
			return msg.toJson();
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().toJson();
		}
	}
	/**
	 * 删除商品(tag不为空着真删)
	 * @param request
	 * @return
	 */
	@RequestMapping(value="product/delete")
	@ResponseBody
	public String delete(HttpServletRequest request){
		String id = request.getParameter("id");
		String tag=request.getParameter("tag");
		AjaxMsg msg = adminUserProductService.deleteProduct(id,tag);
		return msg.toJson();
	}
	
	/**
	 * 修改产品上下架
	 * @param request
	 * @return
	 */
	@RequestMapping(value="product/updateStatus")
	@ResponseBody
	public String updateStatus(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError();
		String id = request.getParameter("id");
		String status = request.getParameter("status");
		if(StringUtils.isNotBlank(status)){
			UserProduct product = adminUserProductService.getEntityById(id);
			if(product!=null){
				product.setProduct_status(status);
				msg = adminUserProductService.update(product);
			}
		}
		return msg.toJson();
	}
	/**
	 * 开启一元夺宝
	 * @param request
	 * @return
	 */
	@RequestMapping(value="product/openTheProduct")
	@ResponseBody
	public String openTheProduct(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		String pid = request.getParameter("product_id");
		String open_num = request.getParameter("open_num");
		String type = request.getParameter("type");//type为1只添加商品轮次
		if(StringUtils.isNotBlank(pid)){
			Map<String, String> obj = Maps.newHashMap();
			obj.put("pid", pid);
			obj.put("open_num", open_num);
			msg = adminUserProductService.updateProductOpenStatus(obj,type);
		}
		return msg.toJson();
	}
	/**
	 * 商品轮次列表
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="product/queryProductDatas")
	public String queryProductDatas(HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		String product_id = request.getParameter("product_id");
		String name = request.getParameter("name");
		String username = request.getParameter("username");
		String group_by = request.getParameter("group_by");
		if(StringUtils.isNotBlank(product_id)) maps.put("product_id", product_id);
		if(StringUtils.isNotBlank(name)) maps.put("name", name);
		if(StringUtils.isNotBlank(username)) maps.put("username", username);
		if(StringUtils.isNotBlank(group_by)){
			maps.put("group_by", group_by);
		}else{
			maps.put("group_by", "desc");
		}
		AjaxMsg msg = adminUserProductService.queryProductDatas(maps, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", maps);
		return "admin/shop/product_datas";
	}
	
	/**
	 * 删除商品轮次
	 * @param request
	 * @return
	 */
	@RequestMapping(value="product/deleteProductData")
	@ResponseBody
	public String deleteProductData(HttpServletRequest request){
		String id = request.getParameter("id");
		AjaxMsg msg = adminUserProductService.deleteProductData(id);
		return msg.toJson();
	}
	
	/**
	 * 查询该产品剩余轮数
	 * @param request
	 * @return
	 */
	@RequestMapping(value="product/getHaveNum")
	@ResponseBody
	public String getHaveNum(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		String pid = request.getParameter("pid");
		if(StringUtils.isNotBlank(pid)){
			UserProduct product = adminUserProductService.getEntityById(pid);
			int count = product.getProduct_total_count();
			if(product!=null){
				if("1".equals(product.getProduct_status())){
					if(count>0){
						Map<String, Object> params = new HashMap<String, Object>();
						params.put("product_id", product.getProduct_id());
						params.put("data_status", "1");
						msg = adminUserProductService.getHaveNum(params);
					}else{
						return msg.addData("status", "count").toJson();
					}
				}else{
					return msg.addData("status", "no").toJson();
				}
			}
		}
		return msg.toJson();
	}
	
	
	/**
	 * 查询该轮次开奖号码
	 * @param request
	 * @return
	 */
	@RequestMapping(value="product/queryOrderNums")
	public String queryOrderNums(HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		String data_sn = request.getParameter("data_sn");
		String order_num = request.getParameter("order_num");
		String order_sn = request.getParameter("order_sn");
		String if_use = request.getParameter("if_use");
		if(StringUtils.isNotBlank(data_sn)) maps.put("data_sn", data_sn);
		if(StringUtils.isNotBlank(order_num)) maps.put("order_num", order_num);
		if(StringUtils.isNotBlank(order_sn)) maps.put("order_sn", order_sn);
		if(StringUtils.isNotBlank(if_use)) maps.put("if_use", if_use);
		AjaxMsg msg = adminUserProductService.queryOrderNums(maps, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", maps);
		return "admin/shop/order_num";
	}
	
	/**
	 * <p>Description: 订单列表</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午4:20:58
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value = "orders")
	public String orderList(HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("order_sn", BeanUtils.nullToString(request.getParameter("order_sn")));
		maps.put("order_ifwin",  BeanUtils.nullToString(request.getParameter("order_ifwin")));
		maps.put("order_ifsend", BeanUtils.nullToString(request.getParameter("order_ifsend")));
		maps.put("order_ifcheck",BeanUtils.nullToString(request.getParameter("order_ifcheck")));
		maps.put("begin_time", BeanUtils.nullToString(request.getParameter("begin_time")));
		maps.put("end_time", BeanUtils.nullToString(request.getParameter("end_time")));
		AjaxMsg msg = adminUserOrderService.queryForPageForMap(maps, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", maps);
		return "admin/shop/order_list";
	}
	
	
	/**
	 * <p>Description: 中奖订单列表</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午4:20:58
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value = "winorders")
	public String winOrderList(HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("order_sn", BeanUtils.nullToString(request.getParameter("order_sn")));
		maps.put("order_ifwin", 1);
		maps.put("order_ifsend", BeanUtils.nullToString(request.getParameter("order_ifsend")));
		maps.put("order_ifcheck",BeanUtils.nullToString(request.getParameter("order_ifcheck")));
		maps.put("begin_time", BeanUtils.nullToString(request.getParameter("begin_time")));
		maps.put("end_time", BeanUtils.nullToString(request.getParameter("end_time")));
		AjaxMsg msg = adminUserOrderService.queryForPageForMap(maps, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", maps);
		return "admin/shop/order_list";
	}
	
	/**
	 * <p>Description: 订单详情</p>
	 * @Author ylt
	 * @Date 2016年10月7日 下午4:20:58
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value = "orderForm")
	public String orderForm(HttpServletRequest request){
		Map<String,Object> maps= adminUserOrderService.getOrderById(BeanUtils.nullToString(request.getParameter("id")));
		request.setAttribute("orderForm", maps);
		return "admin/shop/order_form";
	}
	
	/**
	 * <p>Description: 保存</p>
	 * @Author ylt
	 * @Date 2016年10月7日 下午4:20:58
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value = "saveOrder")
	@ResponseBody
	public String saveOrder(HttpServletRequest request,UserOrder userOrder){
		if(StringUtils.isNotBlank(BeanUtils.nullToString(userOrder.getOrder_id()))){
			UserOrder oldAdminUserOrder = adminUserOrderService.getEntityById(userOrder.getOrder_id());
			oldAdminUserOrder.setOrder_ifsend(userOrder.getOrder_ifsend());
			oldAdminUserOrder.setOrder_send_time(userOrder.getOrder_send_time());
			oldAdminUserOrder.setOrder_ifvalid(userOrder.getOrder_ifvalid());
			oldAdminUserOrder.setOrder_send(userOrder.getOrder_send());
			oldAdminUserOrder.setOrder_send_no(userOrder.getOrder_send_no());
			oldAdminUserOrder.setOrder_send_cash(userOrder.getOrder_send_cash());
			oldAdminUserOrder.setOrder_status(userOrder.getOrder_status());
			adminUserOrderService.update(oldAdminUserOrder);
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).toJson();
	}
	
	/*
	 * 导出到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("order_sn", BeanUtils.nullToString(request.getParameter("order_sn")));
		maps.put("order_ifwin", 1);
		maps.put("order_ifsend", BeanUtils.nullToString(request.getParameter("order_ifsend")));
		maps.put("order_ifcheck",BeanUtils.nullToString(request.getParameter("order_ifcheck")));
		maps.put("begin_time", BeanUtils.nullToString(request.getParameter("begin_time")));
		maps.put("end_time", BeanUtils.nullToString(request.getParameter("end_time")));
		List<Map<String,Object>> orders = adminUserOrderService.getOrderMaps(maps);
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = Lists.newArrayList();
			titles.add("期号");
			titles.add("产品名称");
			titles.add("收货人");	
			titles.add("收货人电话");
			titles.add("收货地址");
			titles.add("货号");
			titles.add("确认时间");
			titles.add("用户留言");
			titles.add("是否发货");
			titles.add("运单号");
			titles.add("快递公司");
			titles.add("备注");
			dataMap.put("titles", titles);
			List<Map<String,Object>> varList = Lists.newArrayList();
			for(int i=0;i<orders.size();i++){
				Map<String,Object> order = orders.get(i);
				Map<String,Object> vpd = Maps.newHashMap();
				vpd.put("var1", order.get("data_sn"));	//1
				vpd.put("var2", order.get("product_title") != null?order.get("product_title"):"");	//2
				vpd.put("var3", order.get("order_user_name") != null?order.get("order_user_name"):"");	//3
				vpd.put("var4", order.get("order_user_phone")!= null?order.get("order_user_phone"):"");	//4
				vpd.put("var5", order.get("order_address")!= null?order.get("order_address"):"");	//5
				vpd.put("var6", order.get("order_send_no")!= null?order.get("order_send_no"):"");	//6
				vpd.put("var7", order.get("order_check_time")!= null?BeanUtils.nullToString(order.get("order_check_time")).substring(0, BeanUtils.nullToString(order.get("order_check_time")).length()-2):"");	//7
				vpd.put("var8", order.get("order_user_offer")!= null?order.get("order_user_offer"):"");	//8
				vpd.put("var9", "");	//9
				vpd.put("var10", "");	//10
				vpd.put("var11", "");	//11
				vpd.put("var12", "");	//12
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {  
	       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	       dateFormat.setLenient(false);  
	       binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));  
	   }  
}

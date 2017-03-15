package com.yt.framework.controller;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAddress;
import com.yt.framework.persistent.entity.UserOrder;
import com.yt.framework.persistent.entity.UserProductCategory;
import com.yt.framework.persistent.entity.UserProductData;
import com.yt.framework.service.CertificaService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.UserOrderService;
import com.yt.framework.service.UserProductService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.gson.JSONUtils;
import com.yt.framework.utils.shop.HttpSendShop;

/**
 *用户操作
 *@autor ylt
 *@date2015-8-31下午5:16:49
 */
@RequestMapping(value="/shop/")
@Controller
public class ShopController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(ShopController.class);
	
	@Autowired
	private UserOrderService userOrderService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private UserProductService userProductService;
	@Autowired
	private UserService userService;
	@Autowired
	private CertificaService certificaService;
	@Autowired
	private TeamInfoService teamInfoService;
	
	/**
	 * 保存地址
	 * @param request
	 * @param userAddress
	 * @return
	 */
	@RequestMapping(value="saveAddress")
	@ResponseBody
	public String saveAddress(HttpServletRequest request,UserAddress userAddress){
		String user_id = this.getUserId();
		if(StringUtils.isBlank(user_id)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			userAddress.setUser_id(user_id);
			msg = userOrderService.saveUserAddress(userAddress);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 保存地址
	 * @param request
	 * @param userAddress
	 * @return
	 */
	@RequestMapping(value="setDeaultAddress")
	@ResponseBody
	public String setDeaultAddress(HttpServletRequest request){
		String user_id = this.getUserId();
		if(StringUtils.isBlank(user_id)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		String address_id = BeanUtils.nullToString(request.getParameter("id"));
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			UserAddress userAddress = userOrderService.getUserAddressById(address_id);
			userAddress.setUser_default("1");
			msg = userOrderService.saveUserAddress(userAddress);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 删除地址
	 * @param request
	 * @return
	 */
	@RequestMapping(value="delAddress/{id}")
	public String delAddress(HttpServletRequest request,@PathVariable String id){
		String user_id = this.getUserId();
		if(StringUtils.isBlank(user_id)){
			return "erorr";
		}
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = userOrderService.delUserAddress(id);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "redirect:/shop/addressList";
	}
	
	/**
	 * 删除地址
	 * @param request
	 * @return
	 */
	@RequestMapping(value="getAddress")
	@ResponseBody
	public String getAddress(HttpServletRequest request){
		String user_id = this.getUserId();
		if(StringUtils.isBlank(user_id)){
			return "erorr";
		}
		AjaxMsg msg = AjaxMsg.newSuccess();
		String address_id = BeanUtils.nullToString(request.getParameter("id"));
		try {
			UserAddress userAddress = userOrderService.getUserAddressById(address_id);
			msg.addData("address", userAddress);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 地址列表
	 * @param request
	 * @return
	 */
	@RequestMapping(value="addressList")
	public String addressList(HttpServletRequest request){
		String user_id = this.getUserId();
		if(StringUtils.isBlank(user_id)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		List<UserAddress> list = userOrderService.getUserAddress(user_id);
		request.setAttribute("listAddress", list);
		return "system/order/user_address";
	}
	
	/**
	 * 夺宝纪录
	 * @param request
	 * @return
	 */
	@RequestMapping(value="orderList")
	public String orderList(HttpServletRequest request){
		String user_id = this.getUserId();
		if(StringUtils.isBlank(user_id)){
			return "error";
		}
		return "system/order/order_list";
	}
	
	/**
	 * 夺宝所有纪录
	 * @param request
	 * @return
	 */
	@RequestMapping(value="orderResult")
	public String orderResult(HttpServletRequest request,PageModel pageModel){
		String user_id = this.getUserId();
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("user_id", user_id);
		AjaxMsg msg = userOrderService.queryForPageForMap(maps, pageModel);
		request.setAttribute("rf", msg.getData("page"));
		return "system/order/order_result";
	}
	
	/**
	 * 进行中纪录
	 * @param request
	 * @return
	 */
	@RequestMapping(value="orderInResult")
	public String orderInResult(HttpServletRequest request,PageModel pageModel){
		String user_id = this.getUserId();
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("user_id", user_id);
		maps.put("order_status", "1"); //进行中
		AjaxMsg msg = userOrderService.queryForPageForMap(maps, pageModel);
		request.setAttribute("rf", msg.getData("page"));
		return "system/order/order_inresult";
	}
	
	/**
	 * 幸运纪录
	 * @param request
	 * @return
	 */
	@RequestMapping(value="luckList")
	public String luckList(HttpServletRequest request,PageModel pageModel){
		String user_id = this.getUserId();
		if(StringUtils.isBlank(user_id)){
			return "error";
		}
		return "system/order/luck_list";
	}
	
	/**
	 * 幸运纪录
	 * @param request
	 * @return
	 */
	@RequestMapping(value="luckResult")
	public String luckResult(HttpServletRequest request,PageModel pageModel){
		String user_id = this.getUserId();
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("user_id", user_id);
		maps.put("order_ifwin", "1"); //中奖
		AjaxMsg msg = userOrderService.queryForPageForMap(maps, pageModel);
		request.setAttribute("rf", msg.getData("page"));
		return "system/order/luck_result";
	}
	
	/**
	 * 幸运纪录
	 * @param request
	 * @return
	 */
	@RequestMapping(value="luckResultCount")
	@ResponseBody
	public String luckResultCount(HttpServletRequest request,PageModel pageModel){
		String user_id = this.getUserId();
		if(StringUtils.isBlank(user_id)) return AjaxMsg.newSuccess().addData("page", pageModel).toJson();
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("user_id", user_id);
		maps.put("order_ifwin", "1"); //中奖
		maps.put("order_ifcheck", "0"); //未确认
		AjaxMsg msg = userOrderService.queryForPageForMap(maps, pageModel);
		return msg.toJson();
	}
	
	/**
	 * 查看购买号码
	 * @param request
	 * @return
	 */
	@RequestMapping(value="showNum")
	@ResponseBody
	public String showNum(HttpServletRequest request){
		String id = BeanUtils.nullToString(request.getParameter("id"));
		UserOrder order = userOrderService.getEntityById(id);
		return JSONUtils.bean2json(order);
	}
	
	/**
	 * 跳转确认领奖
	 * @param request
	 * @return
	 */
	@RequestMapping(value="toCheck/{order_sn}")
	public String toCheck(HttpServletRequest request,@PathVariable String order_sn){
		String user_id = this.getUserId();
		if(StringUtils.isBlank(user_id)) return "error";
		if(StringUtils.isBlank(order_sn)) return "error";
		Map<String,Object> order = userOrderService.getOrderBySn(order_sn);
		UserAddress userAddress = userOrderService.getDefaultUserAddress(user_id);
		request.setAttribute("userAddress", userAddress);
		request.setAttribute("o", order);
		return "system/order/order_check";
	}
	
	/**
	 * 跳转确认领奖
	 * @param request
	 * @return
	 */
	@RequestMapping(value="check")
	public String check(HttpServletRequest request){
		String user_id = this.getUserId();
		String order_sn = BeanUtils.nullToString(request.getParameter("order_sn"));
		String order_user_offer = BeanUtils.nullToString(request.getParameter("order_user_offer"));
		if(StringUtils.isBlank(user_id)) return "error";
		if(StringUtils.isBlank(order_sn)) return "error";
		
		UserOrder order = userOrderService.getOrderEntityBySn(order_sn);
		UserAddress userAddress = userOrderService.getDefaultUserAddress(user_id);
		
		if(null == userAddress) return "error";
		order.setOrder_ifcheck(1);
		order.setOrder_check_time(new Date());
		order.setOrder_address(userAddress.getUser_province() + userAddress.getUser_city() + 
				userAddress.getUser_area() + userAddress.getUser_address());
		order.setOrder_user_name(userAddress.getUser_name());
		order.setOrder_user_phone(userAddress.getUser_phone());
		order.setOrder_user_offer(order_user_offer);
		userOrderService.update(order);
		
		return "redirect:/shop/luckList";
	}
	
	/**
	 * 跳转购买
	 * @param request
	 * @return
	 */
	@RequestMapping(value="toBuy/{id}")
	public String toBuy(HttpServletRequest request,@PathVariable String id){
		String user_id = this.getUserId();
		if(StringUtils.isBlank(user_id)) return "login";
		int order_count = 1;
		if(StringUtils.isNotBlank(BeanUtils.nullToString(request.getParameter("num")))){
			order_count = Integer.parseInt(request.getParameter("num"));
		}
		User user = userService.getEntityById(user_id);
		//获取商品信息
		Map<String,Object> maps = userProductService.getProduct(id);
		request.setAttribute("data", maps);
		request.setAttribute("if_protocol", user.getIf_protocol());
		request.setAttribute("order_count", order_count);
		return "/shop/buy";
	}
	
	/**
	 * 检查商品库存是否足够
	 * @param request
	 * @return
	 */
	@RequestMapping(value="checkData")
	@ResponseBody
	public String checkData(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String user_id = this.getUserId();
		if(StringUtils.isNotBlank(user_id)){
			if(!certificaService.checkUserCertifica(user_id)){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.checkcer")).toJson();
			}
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.nologin")).toJson();
		}
		String data_id = BeanUtils.nullToString(request.getParameter("data_id"));
		Integer order_count = new Integer(request.getParameter("order_count"));
		//获取产品信息并校验
		Map<String,Object> data = userProductService.getProduct(data_id);
		int data_total_count = new Integer(BeanUtils.nullToString(data.get("data_total_count")));
		int data_count = new Integer(BeanUtils.nullToString(data.get("data_count")));
		if(data_total_count - data_count < order_count){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.shop.unenough")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 付款详情页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="pay")
	@ResponseBody
	public String pay(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String user_id = this.getUserId();
		String data_id = BeanUtils.nullToString(request.getParameter("data_id"));
		Integer order_count = new Integer(request.getParameter("order_count"));
		String amount_type = BeanUtils.nullToString(request.getParameter("type"));
		//获取产品信息
		try {
			UserOrder userOrder = new UserOrder();
			userOrder.setData_id(data_id);
			userOrder.setOrder_count(order_count);
			userOrder.setUser_id(user_id);
			userOrder.setAmount_type(amount_type); //购买账户类型
			userOrder.setOrder_buy_channel("2");
			msg = userOrderService.pay(userOrder);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return msg.toJson();
	}
	
	/**
	 * 付款详情页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="pay_req")
	@ResponseBody
	public String pay_req(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newSuccess();
		String user_id = BeanUtils.nullToString(request.getParameter("user_id"));
		String data_id = BeanUtils.nullToString(request.getParameter("data_id"));
		Integer order_count = new Integer(request.getParameter("order_count"));
		String amount_type = BeanUtils.nullToString(request.getParameter("amount_type"));
		String token = BeanUtils.nullToString(request.getParameter("token"));
		//获取产品信息
		try {
			boolean flag = HttpSendShop.getInstance().checkKey(token);
			User user = userService.getEntityById(user_id);
			if(flag && null != user){
				UserOrder userOrder = new UserOrder();
				userOrder.setData_id(data_id);
				userOrder.setOrder_count(order_count);
				userOrder.setUser_id(user_id);
				userOrder.setAmount_type(amount_type); //购买账户类型
				userOrder.setOrder_buy_channel("1");
				msg = userOrderService.pay(userOrder);
			}else{
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.shop.noprivilage")).toJson();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.shop.fail")).toJson();
		}	
		return msg.toJson();
	}
	
	/**
	 * 夺宝首页
	 * @param request
	 * @return
	 */
	@RequestMapping(value="index")
	public String index(HttpServletRequest request){
		//个人区域6个
		Map<String, Object> params1 = new HashMap<String, Object>();
		params1.put("order_by","recom");
		params1.put("data_status", "2");
		params1.put("start",0);
		params1.put("rows",9);
		List<Map<String, Object>> user_products = userProductService.queryProducts(params1);
		//中奖列表
		List<Map<String, Object>> win_users = userProductService.queryWinUsers();
		//消费榜列表
		List<Map<String, Object>> consumers = userProductService.queryConsumeTop();
		request.setAttribute("user_products", user_products);
		request.setAttribute("win_users", win_users);
		request.setAttribute("consumers", consumers);
		return "shop/index";
	}
	
	/**
	 * 商品详情
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="products")
	public String productList(HttpServletRequest request,PageModel pageModel){
		String category_id = request.getParameter("category");
		String product_title = request.getParameter("product_title");
		String category_name = null;
		//查询分类
		List<UserProductCategory> categorys = userProductService.queryProductCategory(null);
		request.setAttribute("category_id", category_id);
		request.setAttribute("categorys", categorys);
		if(StringUtils.isNotBlank(category_id)&&categorys!=null&&categorys.size()>0){
			for (UserProductCategory c : categorys) {
				if(category_id.equals(c.getCategory_id())){
					category_name = c.getCategory_name();
				}
			}
		}
		request.setAttribute("category_name", category_name);
		request.setAttribute("product_title", product_title);
		return "shop/product_list";
	}
	
	@RequestMapping(value="productDatas")
	public String productDatas(HttpServletRequest request,PageModel pageModel){
		String category_id = request.getParameter("category_id");
		String product_type = request.getParameter("product_type");
		String product_title = request.getParameter("product_title");
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("data_status", "2");
		params.put("category_id", category_id);
		params.put("product_type", product_type);
		params.put("order_by","recom");
		if(StringUtils.isNotBlank(product_title)) params.put("product_title", product_title);
		AjaxMsg msg = userProductService.queryProducts(params,pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		return "shop/product_datas";
	}
	
	/**
	 * 付款
	 * @param request
	 * @return
	 */
	@RequestMapping(value="toPay")
	public String toPay(HttpServletRequest request){
		String user_id = this.getUserId();
		if(StringUtils.isBlank(user_id)) return "login";
		User user = userService.getEntityById(user_id);
		if(user.getIf_protocol() == 0){
			user.setIf_protocol(1);
			userService.update(user);
		}
		AjaxMsg msg = AjaxMsg.newSuccess();
		String data_id = BeanUtils.nullToString(request.getParameter("data_id"));
		Integer order_count = new Integer(request.getParameter("order_count"));
		//获取产品信息
		Map<String,Object> maps = userProductService.getProduct(data_id);
		//判断用户是否俱乐部主席
		TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(user_id);
		if(null == teamInfo){
			request.setAttribute("amount_type", "user");
		}else{
			request.setAttribute("amount_type", "club");
		}
		request.setAttribute("data", maps);
		request.setAttribute("order_count", order_count);
		return "/shop/buy_pay";
	}
	
	/**
	 * 商品详情
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value="product/{id}")
	public String product(HttpServletRequest request,@PathVariable String id){
		if(StringUtils.isNotBlank(id)){
			Map<String, Object> product = userProductService.getProduct(id);
			if(product!=null){
				String data_status = product.get("data_status").toString();
				String pid = product.get("product_id").toString();
				if("4".equals(data_status)){
					//查询下期夺宝
					UserProductData p = userProductService.getRecentProduct(pid);
					if(p!=null){
						request.setAttribute("recent", p);
					}
				}
				request.setAttribute("product", product);
				return "shop/product";
			}
		}
		return "";
	}
	
	@RequestMapping(value="recentProduct")
	@ResponseBody
	public String recentProduct(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.shop.norecent"));
		String product_id = request.getParameter("product_id");
		if(StringUtils.isNotBlank(product_id)){
			UserProductData product = userProductService.getRecentProduct(product_id);
			if(product!=null){
				msg = AjaxMsg.newSuccess().addData("data_id", product.getData_id());
			}
		}
		return msg.toJson();
	}
	
	/**
	 * 夺宝记录（当天）
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value="indianaRecords")
	public String indianaRecords(HttpServletRequest request,PageModel pageModel){
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("data_id", request.getParameter("id"));
		AjaxMsg msg = userProductService.queryIndianaRecords(params,pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		request.setAttribute("curdate", Common.formatDate(new Date(), "yyyy-MM-dd"));
		return "shop/records";
	}
	
	/**
	 * 往期夺宝
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="indianaPast")
	public String indianaPast(HttpServletRequest request,PageModel pageModel){
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("product_id", request.getParameter("id"));
		params.put("current_id", request.getParameter("current_id"));
		params.put("order_by","turn");
		params.put("data_status", "4");
		params.put("query_type", "past");
		AjaxMsg msg = userProductService.queryProducts(params,pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		return "shop/past";
	}
	

	
	@InitBinder
	public void initBinder(WebDataBinder binder) {  
	       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	       dateFormat.setLenient(false);  
	       binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));  
	   } 
	
	
}

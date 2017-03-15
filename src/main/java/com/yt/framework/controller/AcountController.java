package com.yt.framework.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.alipay.config.AlipayConfig;
import com.yt.framework.alipay.util.AlipayNotify;
import com.yt.framework.persistent.entity.LeagueCost;
import com.yt.framework.persistent.entity.PayRecord;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.enums.AmountEnum.PayType;
import com.yt.framework.persistent.enums.AmountEnum.WayType;
import com.yt.framework.service.AcountService;
import com.yt.framework.service.LeagueCostService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PayCostService;
import com.yt.framework.service.PayRecordService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.ResponseUtil;
import com.yt.framework.utils.ReturnJosnMsg;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.gson.JSONUtils;

/**
 *充值中心
 *@autor bo.xie
 *@date2015-8-10下午2:35:58
 */
@Controller
@RequestMapping(value="/account/")
public class AcountController extends BaseController{
	
	private static Logger logger = LogManager.getLogger(AcountController.class);

	@Autowired
	private AcountService acountService;
	@Autowired
	private PayRecordService payRecordService;
	@Autowired
	private PayCostService payCostService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private LeagueCostService leagueCostService;
	@Autowired
	private TeamInfoService teamInfoService;
	
	/**
	 * 充值中心
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="recharge")
	public String rechargeCenter(Model model,HttpServletRequest request){
		User user = super.getUser();
		UserAmount userAmount = acountService.getUserAmountByUserId(user.getId());
		//update by bo.xie 判断用户是否是俱乐部管理员 start
		TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(user.getId());
		Boolean team_manager = Boolean.FALSE;
		if(null!=teamInfo){
			team_manager = Boolean.TRUE;
		}
		model.addAttribute("team_manager", team_manager);
		//update by bo.xie 判断用户是否是俱乐部管理员 end
		model.addAttribute("user", user);
		model.addAttribute("userAmount", userAmount);
		return "/system/recharge_center";
	}
	
	
	/**
	 * 到商户支付
	 * 
	 * <p>Title: toBankPay</p>
	 * <p>Description: </p>
	 * @author YJH
	 * @date   2014年7月24日
	 * @param osn 订单号
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/toBankPay")
	public String toBankPay(Model model,HttpServletRequest request) {
		String user_id =super.getUserId();
		String osn=Common.createOrderOSN();//订单号
		String pn = "账户充值";//产品名称
		String type = StringUtils.isBlank(request.getParameter("type"))?"1":request.getParameter("type");//充值类型 1：购买宇拓币 2：联赛报名费用
		String u_type = StringUtils.isBlank(request.getParameter("u_type"))?"1":request.getParameter("u_type");//账户类型 1：个人账户 2：俱乐部账户
		String recharge_money = request.getParameter("recharge_money");//充值金额
		BigDecimal amount = new BigDecimal(recharge_money).divide(new BigDecimal(100),2, RoundingMode.HALF_UP);
		//存储一条充值记录
		BigDecimal free = new BigDecimal(0);//手续费
		PayRecord pr = new PayRecord();
			pr.setId(UUIDGenerator.getUUID());
			pr.setAmount(amount);
			pr.setFree(free);
			pr.setOrder_no(osn);
			if(u_type.equals("1")){//充值到个人账户
				pr.setUser_id(user_id);
			}else if(u_type.equals("2")){//充值到俱乐部账户
				String teaminfo_id = request.getParameter("teaminfo_id");
				pr.setTeaminfo_id(teaminfo_id);
			}
			pr.setOperate_id(user_id);
			pr.setReal_amount(amount.subtract(free));
			pr.setStatus(0);
			pr.setSubmit_time(new Date());
			pr.setThird_part(PayType.ZHIFUBAO.toString());
			pr.setWay(WayType.ONLINE.toString());
			pr.setDescrible("账户充值");
			pr.setType(Integer.valueOf(type));
		payRecordService.save(pr);
		if(type.equals("2")){
			String sign_way = request.getParameter("sign_way");//报名方式 1：pc端 2：移动端 3:线下
			String league_id = request.getParameter("league_id");//联赛ID
			LeagueCost lc = new LeagueCost();
			lc.setId(UUIDGenerator.getUUID());
			lc.setAmount(amount.subtract(free));
			lc.setLeague_id(league_id);
			lc.setOrder_no(osn);
			lc.setUser_id(user_id);
			lc.setSign_way(Integer.valueOf(sign_way));
			leagueCostService.save(lc);
		}
		
		model.addAttribute("uid", user_id);
		model.addAttribute("osn", osn);
		model.addAttribute("productName", pn);
		model.addAttribute("amount", amount);
		return "system/alipayPage";
	}
	
	/**
	 * 支付宝回调页面
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-11下午4:28:12
	 */
	@RequestMapping(value="payCallback/alipaySyn", method = RequestMethod.GET)
	public String alipaySynPage(HttpServletRequest request,HttpServletResponse response, ModelMap model){
//		logger.info("alipaySyn 支付返馈.");
		AjaxMsg msg = alipayCallback(request);
		Boolean flag = Boolean.FALSE;//充值失败
		int type=1;//1：购买宇拓币 2：联赛报名费用
		//订单号
		String out_trade_no = getUTF8String(request.getParameter("out_trade_no"));
		//交易金额
		String total_fee = getUTF8String(request.getParameter("total_fee"));
		PayRecord pr = payRecordService.getPayRecordByOrderNo(out_trade_no);
		if(pr!=null){
			type=pr.getType();
		}
		if(msg.isSuccess()){
			flag = Boolean.TRUE;
		}
		model.addAttribute("flag",flag);
		if(type==2){//联赛报名
			LeagueCost leagueCost = leagueCostService.getLeagueCostByOrderNo(out_trade_no);
			if(leagueCost!=null){
				int sign_way = leagueCost.getSign_way();//报名方式 1：pc端 2：移动端 3:线下
				if(sign_way==2){
					//跳转到移动端报名结果页面
					return "html5/signSuccess";
				}else if(sign_way==1){
					//跳转到pc端报名缴费结果页面
					return "league/league_sign_paySuccess";
				}
			}
		}
	
		model.addAttribute("osn",out_trade_no);
		model.addAttribute("payMoney",total_fee);
		return "system/pay_back";//返回充值成功页面
	}
	
	/**
	 * 支付宝异步返回结果入口
	 * 
	 * <p>Title: alipayAsy</p>
	 * <p>Description: </p>
	 * @author YJH
	 * @date   2014年8月12日
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/payCallback/alipayAsy", method = RequestMethod.GET)
	public void alipayAsy(HttpServletRequest request,HttpServletResponse response) {
//		logger.info("alipayAsy 支付返馈GET.");
		AjaxMsg msg = alipayCallback(request);
		ResponseUtil.sendResponseHTML(response, "success");
	}
	@RequestMapping(value = "/payCallback/alipayAsy", method = RequestMethod.POST)
	public void alipayAsyPost(HttpServletRequest request,HttpServletResponse response) {
		logger.info("alipayAsy 支付返馈POST.");
		AjaxMsg msg = alipayCallback(request);
		ResponseUtil.sendResponseHTML(response, "success");
	}
	
	/**
	 * 
	 * 
	 * <p>Title: alipayCallback</p>
	 * <p>Description: </p>
	 * @author YJH
	 * @date   2014年8月12日
	 * @param request
	 * @return
	 */
	private AjaxMsg alipayCallback(HttpServletRequest request) {
		StringBuilder html = new StringBuilder();
		//获取支付宝GET过来反馈信息
		Map<String,String> params = new HashMap<String,String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			//valueStr = getUTF8String(valueStr);
			params.put(name, valueStr);
		}
		//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
		//商户订单号
		String out_trade_no = getUTF8String(request.getParameter("out_trade_no"));
		//买主支付宝帐号
		String buyer_email = getUTF8String(request.getParameter("buyer_email"));
		//支付宝交易号
		String trade_no = getUTF8String(request.getParameter("trade_no"));
		//交易金额
		String total_fee = getUTF8String(request.getParameter("total_fee"));
		//交易状态
		String trade_status = getUTF8String(request.getParameter("trade_status"));
		//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
		//计算得出通知验证结果
		boolean verify_result = AlipayNotify.verify(params);
//		logger.info("**************"+verify_result);
		if(verify_result){
//			logger.info("*******开始进行数据库交互*******");
			if(trade_status.equals("TRADE_FINISHED") || trade_status.equals("TRADE_SUCCESS")){
				AjaxMsg msg = acountService.paySuccess(out_trade_no, buyer_email, trade_no, PayType.ZHIFUBAO.toString(), AlipayConfig.partner, total_fee);
				if(msg.isSuccess()){
					logger.info("充值金额已确认收到!");
					return msg;
				}else{
					logger.error("充值金额确认失败!");
					return msg;
				}
			}else{
				logger.error("充值金额失败！");
				return AjaxMsg.newError();
			}
			/*if(trade_status.equals("TRADE_FINISHED") || trade_status.equals("TRADE_SUCCESS")) {
				html.append("<br>订单号:" + out_trade_no + "<br>充值金额:" + total_fee + "<br>交易流水号:" + trade_no);
			}*/
		}else{
			logger.error("充值失败!交易签名被篡改!");
			return AjaxMsg.newError();
		}
		
	}
	
	private String getUTF8String(String txt){
		try {
			return new String(txt.getBytes("ISO-8859-1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return txt;
	}
	
	@RequestMapping(value="payRecord")
	public String payRecordPage(Model model,HttpServletRequest request){
		User user = super.getUser();
		model.addAttribute("user", user);
		
		return "system/pay_record";
	}
	
	/**
	 * 获取用户充值记录数据
	 *@param user_id 用户ID 必须
	 *@param way 充值方式 ONLINE：线上充值 OFFLINE:线下充值
	 *@param startTime 开始时间
	 *@param endTime 结束时间
	 *@param status 充值状态：0:充值失败，1：充值成功
	 *@return 
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-10下午2:38:17
	 */
	@RequestMapping(value="payData")
	public String loadPayDatas(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
			String user_id =super.getUserId();
			maps.put("user_id", user_id);
		AjaxMsg msg = payRecordService.queryForPage(maps, pageModel);
		if(msg.isSuccess()){
			pageModel = (PageModel) msg.getData("page");
			model.addAttribute("rf", pageModel);
		}
		
		return "system/pay_recordData";
	}
	
	/**
	 * 获取用户消费记录数据
	 *@param user_id 用户ID 必须
	 *@param startTime 开始时间
	 *@param endTime 结束时间
	 *@return 
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-10下午2:38:17
	 */
	@RequestMapping(value="costData")
	public @ResponseBody String loadCostDatas(HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		String user_id =super.getUserId();
		maps.put("user_id", user_id);
		AjaxMsg msg = payCostService.queryForPage(maps, pageModel);
		return msg.toJson();
	}
	
	/**
	 * 消费记录页面
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-24下午4:32:17
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="costRecord")
	public String costRecord(Model model,HttpServletRequest request,PageModel pageModel){
		User user = super.getUser();
		model.addAttribute("user", user);
		return "system/cost_record";
	}
	
	@RequestMapping(value="crDiv")
	public String costRecordDiv(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		String user_id =super.getUserId();
		maps.put("user_id", user_id);
		AjaxMsg msg = payCostService.queryForPage(maps, pageModel);
		if(msg.isSuccess()){
			pageModel = (PageModel) msg.getData("page");
			model.addAttribute("costs", pageModel.getItems());
			model.addAttribute("rf", pageModel);
		}
		return "system/cost_recordData";
	}
	
	/**
	 * 购买装扮
	 * @param d_id 装扮ID
	 * @param request
	 * @return
	 */
	@RequestMapping(value="tobuyDress/{d_id}")
	public @ResponseBody String buyDress(@PathVariable(value="d_id")String d_id,HttpServletRequest request){
		Map<String,Object> params = Maps.newHashMap();
			params.put("d_id", d_id);//装扮ID
			params.put("user_id", super.getUserId());//当前登录用户ID
			String name = request.getParameter("name");//商品名称
			String price = request.getParameter("price");//单价/月
			String count = request.getParameter("count");//购买数量
			String times = request.getParameter("times");//购买期限
			String is_per = request.getParameter("is_per");//是否永久有效 0：不是 1：永久有效
			String sumAmount = request.getParameter("sumAmount");//购买总价
			String order_num = request.getParameter("order_num");//购买订单号
			if(StringUtils.isBlank(d_id) || StringUtils.isBlank(price)|| StringUtils.isBlank(count)
			   || StringUtils.isBlank(times) || StringUtils.isBlank(sumAmount)){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			}
			params.put("name", name);
			params.put("price", price);
			params.put("count", count);
			params.put("times", times);
			params.put("is_per", is_per);
			params.put("sumAmount", sumAmount);
			params.put("order_num", order_num);
		AjaxMsg msg = acountService.buyDress(params);
		return msg.toJson();
	}
	
	/**
	 * 我的装扮 永久购买
	 * @param d_id 装扮ID
	 * @param request
	 * @return
	 */
	@RequestMapping(value="rebuyDress/{d_id}")
	public @ResponseBody String reBuyDress(@PathVariable(value="d_id")String d_id,HttpServletRequest request){
		Map<String,Object> params = Maps.newHashMap();
		String sumAmount = request.getParameter("sumAmount");//购买总价
		String name = request.getParameter("name");//装扮名称
		if(StringUtils.isBlank(d_id) ||StringUtils.isBlank(sumAmount) || StringUtils.isBlank(name)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		params.put("d_id", d_id);//装扮ID
		params.put("user_id", super.getUserId());//当前登录用户ID
		params.put("sumAmount", sumAmount);
		params.put("name", name);
		return acountService.reBuyDress(params).toJson();
	}
	

	@RequestMapping(value="myPayData")
	@ResponseBody
	public String myPayData(HttpServletRequest request, HttpSession session,@RequestBody String pjson) {
		Map<String, String> map = JSONUtils.json2Map(pjson);
		String currentPage = map.get("currentPage");
		PageModel pageModel = new PageModel();
		pageModel.setCurrentPage(JSONUtils.toInt(currentPage));
		Map<String,Object> maps = Maps.newHashMap();
			String user_id =super.getUserId();
			maps.put("user_id", user_id);
		AjaxMsg msg = payRecordService.queryForPage(maps, pageModel);
		String retJson = "{}";
		if(msg.isSuccess()){
			pageModel = (PageModel) msg.getData("page");
			retJson = JSONUtils.bean2json(pageModel);
		}
		
		return retJson;
	}

	@RequestMapping(value="myConsumeData")
	@ResponseBody
	public String myConsumeData(HttpServletRequest request, HttpSession session,@RequestBody String pjson) {
		Map<String, String> map = JSONUtils.json2Map(pjson);
		String currentPage = map.get("currentPage");
		PageModel pageModel = new PageModel();
		pageModel.setCurrentPage(JSONUtils.toInt(currentPage));
		Map<String,Object> maps = Maps.newHashMap();
			String user_id =super.getUserId();
			maps.put("user_id", user_id);
		AjaxMsg msg = payCostService.queryForPage(maps, pageModel);
		String retJson = "{}";
		if(msg.isSuccess()){
			pageModel = (PageModel) msg.getData("page");
			retJson = JSONUtils.bean2json(pageModel);
		}
		
		return retJson;
	}
}

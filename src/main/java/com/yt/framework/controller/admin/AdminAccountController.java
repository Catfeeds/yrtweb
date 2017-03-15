package com.yt.framework.controller.admin;

import java.math.BigDecimal;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.enums.AmountEnum;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.admin.AccountService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 *后台资金管理
 *@autor bo.xie
 *@date2015-8-27上午10:45:47
 */
@Controller
@RequestMapping(value="/admin/account/")
public class AdminAccountController {
	
	private static Logger logger = LogManager.getLogger(AdminAccountController.class);

	@Autowired
	private AccountService accountService;
	@Autowired
	private MessageResourceService messageResourceService;
	
	/**
	 * 充值记录页面
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-27上午10:56:11
	 */
	@RequestMapping(value="payRecord")
	public String payRecord(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("username",request.getParameter("username"));
		maps.put("phone",request.getParameter("phone"));
		maps.put("orderNo",request.getParameter("orderNo"));
		pageModel.setPageSize(15);
		AjaxMsg msg = accountService.loadPayRecords(maps, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("datas", msg.getData("datas"));
			model.addAttribute("page", msg.getData("page"));
			model.addAttribute("params", maps);
			//获取充值成功后的总金额
			BigDecimal sumAmount = accountService.getPayRecordSum(null);
			model.addAttribute("sumAmount", sumAmount);
		}
		return "admin/account/pay_record";
	}
	
	/**
	 * 获取平台用户消费记录
	 *@param model
	 *@param request
	 *@param pageModel
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-27下午5:19:24
	 */
	@RequestMapping(value="costRecord")
	public String payCostRecord(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("username",request.getParameter("username"));
		maps.put("phone",request.getParameter("phone"));
		maps.put("orderNo",request.getParameter("orderNo"));	
		pageModel.setPageSize(15);
		AjaxMsg msg = accountService.loadCostRecord(maps, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("datas", msg.getData("datas"));
			model.addAttribute("page", msg.getData("page"));
			model.addAttribute("params", maps);
		}
		return "admin/account/cost_record";
	}
	
	/**
	 * 用户资金
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="userAcountDatas")
	public String userAcountDatas(Model model,HttpServletRequest request,PageModel pageModel){
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("username",request.getParameter("username"));
		maps.put("phone",request.getParameter("phone"));
		pageModel.setPageSize(15);
		AjaxMsg msg = accountService.loadUserAmountDatas(maps, pageModel);
		if(msg.isSuccess()){
			model.addAttribute("datas", msg.getData("datas"));
			model.addAttribute("page", msg.getData("page"));
			model.addAttribute("params", maps);
		}
		return "admin/account/user_amount";
	}
	
	/**
	 * 更新用户资金状态
	 * @param request
	 * @return
	 */
	@RequestMapping(value="updateStatus")
	public @ResponseBody String updateUserAmountStaus(HttpServletRequest request){
		AjaxMsg msg = AjaxMsg.newError();
		String id = request.getParameter("id");
		String status = request.getParameter("status");
		if(StringUtils.isBlank(id))return msg.addMessage(messageResourceService.getMessage("user.amount.notFound")).toJson();
		UserAmount userAmount = accountService.getUserAmount(id);
		userAmount.setStatus(Integer.valueOf(status));
		accountService.updateUserAmount(userAmount);
		return msg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).toJson();
	}
	
	/**
	 * 用户资金
	 * @param model
	 * @param request
	 * @param pageModel
	 * @return
	 */
	@RequestMapping(value="recordDetail")
	public String recordDetail(HttpServletRequest request){
		//获取平台送出资金汇总
			Map<String,Object>cMap = Maps.newHashMap();
			cMap.put("send_amount", "0");
			Map currentMap =  accountService.loadTotalAmount(cMap);
		//获取平台当前资金汇总
			Map<String,Object>ctMap = Maps.newHashMap();
			Map currentToalMap =  accountService.loadTotalAmount(ctMap);	
		//获取平台充值资金汇总
			Map<String,Object>rMap = Maps.newHashMap();
			rMap.put("third_part", AmountEnum.PayType.ZHIFUBAO);
			Map<String,Object>recordMap = accountService.loadTotalRecord(rMap);
	
			BigDecimal sendTotalAmount = (BigDecimal)currentMap.get("send_amount");//平台送出资金
			BigDecimal sendLeavingsAmount = (BigDecimal)currentMap.get("real_amount");//平台送出资金剩余 
			BigDecimal sendUseredAmount = sendTotalAmount.subtract(sendLeavingsAmount); //平台送出资金消耗 = 平台送出资金 -平台送出资金剩余
			BigDecimal depositAmount = (BigDecimal)recordMap.get("amount"); //平台支付宝充值
			BigDecimal totalAmount = (BigDecimal)currentToalMap.get("real_amount"); //平台当前总资金
			BigDecimal gainAmount = depositAmount.subtract(totalAmount.divide(new BigDecimal(100))); //盈利  = 平台支付宝充值 - 平台当前总资金 
			
			request.setAttribute("sendTotalAmount", sendTotalAmount.divide(new BigDecimal(100)));
			request.setAttribute("sendLeavingsAmount", sendLeavingsAmount.divide(new BigDecimal(100)));
			request.setAttribute("sendUseredAmount", sendUseredAmount.divide(new BigDecimal(100)));
			request.setAttribute("depositAmount",depositAmount);
			request.setAttribute("totalAmount", totalAmount.divide(new BigDecimal(100)));
			request.setAttribute("gainAmount", gainAmount);
			
		return "admin/account/record_detail";
	}
	
}

package com.yt.framework.service.Impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.OrderNumData;
import com.yt.framework.persistent.entity.PayCost;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.UserAddress;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.entity.UserOrder;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PayCostService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.UserAmountService;
import com.yt.framework.service.UserOrderService;
import com.yt.framework.service.UserProductService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.SpringContextUtil;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.queue.QueueContainer;
import com.yt.framework.utils.queue.TaskDetecting;
import com.yt.framework.utils.queue.WorkOrderEntity;

@Service(value="userOrderService")
public class UserOrderServiceImpl extends BaseServiceImpl<UserOrder> implements UserOrderService {
	
	protected static Logger logger = LogManager.getLogger(UserOrderServiceImpl.class);
	@Autowired
	MessageResourceService messageResourceService;
	@Autowired
	UserProductService userProductService;
	@Autowired
	UserAmountService userAmountService;
	@Autowired
	TeamInfoService	teamInfoService;
	@Autowired
	PayCostService payCostService;
	
	@Override
	public Map<String,Object> getOrderById(String order_id) {
		return userOrderMapper.getOrderById(order_id);
	}

	@Override
	public AjaxMsg saveUserAddress(UserAddress userAddress) throws Exception {
		//现将所有地址改为非默认
		if(BeanUtils.nullToString(userAddress.getUser_default()).equals("1")){
			userOrderMapper.updateDefaultBatch(userAddress.getUser_id());
		}
		if(StringUtils.isBlank(userAddress.getAddress_id())){
			userAddress.setAddress_id(UUIDGenerator.getUUID32());
			userOrderMapper.saveUserAddress(userAddress);
		}else{
			userOrderMapper.updateUserAddress(userAddress);
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
		
	}

	@Override
	public List<UserAddress> getUserAddress(String user_id) {
		return userOrderMapper.getUserAddress(user_id);
	}

	@Override
	public AjaxMsg delUserAddress(String address_id)throws Exception  {
		userOrderMapper.delUserAddress(address_id);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public Map<String,Object> getOrderBySn(String order_sn) {
		return userOrderMapper.getOrderBySn(order_sn);
	}

	@Override
	public UserOrder getOrderEntityBySn(String order_sn) {
		return userOrderMapper.getOrderEntityBySn(order_sn);
	}

	@Override
	public UserAddress getDefaultUserAddress(String user_id) {
		return userOrderMapper.getDefaultUserAddress(user_id);
	}

	@Override
	public UserAddress getUserAddressById(String address_id) {
		return userOrderMapper.getUserAddressById(address_id);
	}

	@Override
	public AjaxMsg pay(UserOrder userOrder) throws Exception {
		String order_sn = UUIDGenerator.get12ORID();
		Map<String,Object> data = userProductService.getProduct(userOrder.getData_id());
		BigDecimal order_actual_cash =  new BigDecimal(BeanUtils.nullToString(data.get("data_single_price")));
		BigDecimal order_cash =  new BigDecimal(BeanUtils.nullToString(data.get("data_single_price")));
		BigDecimal t_order_count = new BigDecimal(userOrder.getOrder_count());
		order_actual_cash = order_actual_cash.multiply(t_order_count);
		order_cash = order_cash.multiply(t_order_count);
		//生成订单
		Long currentTime = System.currentTimeMillis();
		Date pay_time = new Date(currentTime);
		userOrder.setOrder_id(UUIDGenerator.getUUID32());
		userOrder.setOrder_actual_cash(order_actual_cash);
		userOrder.setOrder_cash(order_cash);
		userOrder.setOrder_ifvalid(1);
		userOrder.setOrder_pay_time(pay_time);
		userOrder.setOrder_pay_num(currentTime);
		userOrder.setOrder_sn(order_sn);
		userOrder.setOrder_status("1");
		userOrder.setOrder_pay_time(new Date());
		userOrder.setData_sn(BeanUtils.nullToString(data.get("data_sn")));
		userOrder.setOrder_ifsend(0);
		userOrder.setOrder_ifwin(0);
		userOrder.setOrder_ifcheck(0);
		//判断用户账户余额是否足够
		//user 个人  club 俱乐部
		if(userOrder.getAmount_type().equals("user")){
			UserAmount userAmount = userAmountService.getUserAmountByUserId(userOrder.getUser_id());
			if(userAmount.getReal_amount().compareTo(order_actual_cash) < 0){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.accountless"));
			}
		}else{
			TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(userOrder.getUser_id());
			if(null == teamInfo) return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.team.nocaption"));
			UserAmount teamAmount = userAmountService.getUserAmountByTeamInfoID(teamInfo.getId());
			if(teamAmount.getReal_amount().compareTo(order_actual_cash) < 0){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.accountless"));
			}
		}
		
		//判断该产品是否人数已购
		int data_count = (int)data.get("data_count");
		int data_total_count = (int)data.get("data_total_count");
		int order_count = userOrder.getOrder_count();
		if(data_count >= data_total_count){
			logger.info("===============当前人数大于或者等于总人数=================");
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.shop.dataover"));
		}else if(order_count > data_total_count - data_count){
			logger.info("===============号码数量不足=================");
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.shop.unenough"));
		}
		
		WorkOrderEntity taskObject = new WorkOrderEntity(userOrder);
		QueueContainer.getContainer().addTaskDetectingQueue(new TaskDetecting(userOrder.getOrder_sn(), 1, taskObject ));
		
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).addData("order_sn", order_sn);
	}

	@Override
	public AjaxMsg saveQueueUserOrder(UserOrder order)throws Exception {
		
		Map<String,Object> data = userProductService.getProduct(order.getData_id());
		//判断该产品是否人数已购
		int data_count = (int)data.get("data_count");
		int data_total_count = (int)data.get("data_total_count");
		int order_count = order.getOrder_count();
		int data_status = 0;
		if(data_count >= data_total_count){
			logger.info("===============当前人数大于或者等于总人数=================");
			return AjaxMsg.newError();
		}else if(order_count > data_total_count - data_count){
			logger.info("===============号码数量不足=================");
			return AjaxMsg.newError();
		}
		
		//user 个人  club 俱乐部
		Map<String,Object> params = Maps.newHashMap();
		params.put("data_sn", BeanUtils.nullToString(data.get("data_sn")));
		List<OrderNumData> list = userProductService.queryOrderNumData(params);
		if(order_count > list.size()){
			logger.info("===============数量不足=================");
			return AjaxMsg.newError();
		}
		//扣除用户宇币
		if(order.getAmount_type().equals("user") || order.getAmount_type().equals("")){
			UserAmount userAmount = userAmountService.getUserAmountByUserId(order.getUser_id());
			if(userAmount.getReal_amount().compareTo(order.getOrder_actual_cash()) < 0){
				logger.info("===============用户宇币不足=================");
				return AjaxMsg.newError();
			}else{
				userAmount.setReal_amount(userAmount.getReal_amount().subtract(order.getOrder_actual_cash()));
				userAmount.setAmount(userAmount.getAmount().subtract(order.getOrder_actual_cash()));
			}
			userAmountService.update(userAmount);
			/*
			 * 消费记录
			 */
			PayCost pc = new PayCost();
			pc.setId(UUIDGenerator.getUUID());
			pc.setAmount(order.getOrder_actual_cash());
			pc.setDescrible("宇币夺宝消费");
			pc.setNum_str(order.getOrder_sn());
			pc.setStatus(1);
			pc.setOrder_id(order.getOrder_id());
			pc.setUser_id(order.getUser_id());
			pc.setP_code(order.getData_sn());
			payCostService.save(pc);
		}else if(order.getAmount_type().equals("club")){
			TeamInfo teamInfo = teamInfoService.getTeamInfoByUserId(order.getUser_id());
			if(null == teamInfo){
				logger.info("===============非主席无法购买=================");
				return AjaxMsg.newError();
			}
			UserAmount teamAmount = userAmountService.getUserAmountByTeamInfoID(teamInfo.getId());
			if(teamAmount.getReal_amount().compareTo(order.getOrder_actual_cash()) < 0){
				logger.info("===============球队宇币不足=================");
				return AjaxMsg.newError();
			}else{
				teamAmount.setReal_amount(teamAmount.getReal_amount().subtract(order.getOrder_actual_cash()));
				teamAmount.setAmount(teamAmount.getAmount().subtract(order.getOrder_actual_cash()));
			}
			userAmountService.update(teamAmount);
			/*
			 * 消费记录
			 */
			PayCost pc = new PayCost();
			pc.setId(UUIDGenerator.getUUID());
			pc.setAmount(order.getOrder_actual_cash());
			pc.setDescrible("宇币夺宝消费");
			pc.setNum_str(order.getOrder_sn());
			pc.setStatus(1);
			pc.setOrder_id(order.getOrder_id());
			//pc.setUser_id(buyer);
			pc.setTeaminfo_id(teamInfo.getId());
			pc.setP_code(order.getData_sn());
			payCostService.save(pc);
		}
		
		//保存订单
		String order_nums = "";
		for(int i = 0; i < order_count; i++){
			OrderNumData o = (OrderNumData)list.get(i);
			o.setOrder_sn(order.getOrder_sn());
			order_nums += String.valueOf(o.getOrder_num()) + ",";
			userProductService.updateOrderNumData(o);
		}
		order.setOrder_nums(order_nums.substring(0,order_nums.length()-1));
		AjaxMsg msg = this.save(order);
		data_count = data_count + order.getOrder_count(); 
		if(data_count == data_total_count){
			//人数满员
			data_status = 3; //揭晓中
			//并开启开一轮
			userProductService.updateProductDataNext(BeanUtils.nullToString(data.get("product_id")));
		}
		//更新状态
		userProductService.updateProductDataNum(order.getData_id(),data_count,data_status);
		return msg;
	}
	

}

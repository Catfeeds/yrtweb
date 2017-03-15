package com.yt.framework.service.Impl;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.locks.ReentrantLock;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yt.framework.persistent.entity.AmountDetail;
import com.yt.framework.persistent.entity.Dressup;
import com.yt.framework.persistent.entity.LeagueCost;
import com.yt.framework.persistent.entity.PayCost;
import com.yt.framework.persistent.entity.PayRecord;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.enums.SmsEnum.SMSTEMP;
import com.yt.framework.service.AcountService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PayRecordService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.smsSend.SendMsg;

/**
 *充值金额处理
 *@autor bo.xie
 *@date2015-8-11下午5:01:15
 */
@Transactional
@Service("acountService")
public class AcountServiceImpl extends BaseServiceImpl<UserAmount> implements AcountService{
	
	protected static Logger logger = LogManager.getLogger(AcountServiceImpl.class.getName());
	
	@Autowired
	private PayRecordService payRecordService;
	@Autowired
	private MessageResourceService messageResourceService;
	
	// 充值锁
	private static final ReentrantLock rechargeLock = new ReentrantLock();

	@Override
	public AjaxMsg paySuccess(String osn, String payAccount, String tsn,
			String payProvider, String cashAccount, String acount_money) {
		try {
			rechargeLock.lock();
//			logger.info("====================进入数据库交互层");
			PayRecord pr = payRecordService.getPayRecordByOrderNo(osn);
			if(pr==null)return AjaxMsg.newError().addMessage("该条订单不存在！");
			LeagueCost lc = new LeagueCost();
			if(pr.getType()==2){
				lc = leagueCostMapper.getLeagueCostByOrderNo(osn);
				if(lc==null)return AjaxMsg.newError().addMessage("该条联赛报名订单不存在！");
			}
			int status = pr.getStatus();
			if(status==1)return AjaxMsg.newSuccess();
			BigDecimal amount = pr.getAmount();//充值金额
			BigDecimal real_amount = pr.getReal_amount();//实际充值金额
			if(amount.compareTo(new BigDecimal(acount_money))!=0) return AjaxMsg.newError().addMessage("充值金额错误！");
			//更新充值记录表
			pr.setBank_no(tsn);
			pr.setEnd_time(new Date());
			pr.setPayer_no(payAccount);
			pr.setCash_no(cashAccount);
			pr.setStatus(1);
//			logger.info("====================开始更新记录表信息");
			AjaxMsg msg = payRecordService.update(pr);
			if(pr.getType()==2){
				msg.addData("sign_way", lc.getSign_way());
			}
//			logger.info("====================结束更新记录表信息"+msg.toJson());
			if(msg.isSuccess()&&pr.getType()==1){//充值成功后更新充值用户资金账户表资金金额
				UserAmount userAmount = null;
				if(StringUtils.isNotBlank(pr.getUser_id())){
					 userAmount = userAmountMapper.getByUserId(pr.getUser_id());
				}else{
					if(StringUtils.isBlank(pr.getTeaminfo_id()))return AjaxMsg.newError().addMessage("该俱乐部不存在！");
						//往俱乐部贡献榜表中插入数据
						AmountDetail ad = new AmountDetail();
						ad.setId(UUIDGenerator.getUUID32());
						ad.setAmount(real_amount.multiply(new BigDecimal(100)));
						ad.setTeaminfo_id(pr.getTeaminfo_id());
						ad.setUser_id(pr.getOperate_id());
						userAmountMapper.saveTeamAmountDetail(ad);
						//个人为俱乐部充值，应插入个人消费记录一条
						PayCost pc = new PayCost();
						pc.setId(UUIDGenerator.getUUID());
						pc.setAmount(real_amount.multiply(new BigDecimal(100)));
						pc.setUser_id(pr.getOperate_id());
						pc.setNum_str(osn);
						pc.setStatus(1);
						pc.setDescrible("个人为俱乐部充值");
						payCostMapper.save(pc);
					//获取俱乐部资金账户	
					userAmount = userAmountMapper.getUserAmountByTeaminfoID(pr.getTeaminfo_id());
				}
					userAmount.setAmount(userAmount.getAmount().add(amount.multiply(new BigDecimal(100))));
					userAmount.setReal_amount(userAmount.getReal_amount().add(real_amount.multiply(new BigDecimal(100))));
					userAmountMapper.update(userAmount);
			
			}else if(msg.isSuccess()&&pr.getType()==2){//充值成功后，保存用户联赛报名信息
				lc.setStatus(1);
				leagueCostMapper.update(lc);
				//插入一条消费记录
				PayCost pc = new PayCost();
				pc.setId(UUIDGenerator.getUUID());
				pc.setAmount(real_amount.multiply(new BigDecimal(100)));
				pc.setUser_id(pr.getUser_id());
				pc.setNum_str(osn);
				pc.setStatus(1);
				pc.setDescrible("联赛报名费用");
				payCostMapper.save(pc);
			
				User user= userMapper.getEntityById(pr.getUser_id());
				if(user!=null){
					SendMsg.getInstance().sendSMS(user.getPhone(),"", SMSTEMP.JSM405880029.toString());
				}
				
			}
			return msg;
		} finally{
			rechargeLock.unlock();
		}
	}

	@Override
	public UserAmount getUserAmountByUserId(String user_id) {
		return userAmountMapper.getByUserId(user_id);
	}

	@Override
	public AjaxMsg buyDress(Map<String, Object> params) {
		AjaxMsg msg = AjaxMsg.newError();
		String d_id = (String) params.get("d_id");//装扮ID
		String user_id = String.valueOf(params.get("user_id"));//当前登录用户ID
		String name = (String) params.get("name");//单价/月
		String price = (String) params.get("price");//单价/月
		String count = (String) params.get("count");//购买数量
		String times = (String) params.get("times");//购买期限
		String is_per = (String) params.get("is_per");//是否永久有效 0：不是 1：永久有效
		String sumAmount = (String) params.get("sumAmount");//购买总价
		String order_num = (String) params.get("order_num");//购买订单号
		
		//获取当前用户可用资金宇拓币
		UserAmount userAmount = userAmountMapper.getByUserId(user_id);
		//判断资金用户是否可用
		if(userAmount.getStatus()==2)return msg.addMessage(messageResourceService.getMessage("user.amount.freeze"));
		
		BigDecimal sum_amount = userAmount.getAmount();//剩余总金额
		BigDecimal real_amount = userAmount.getReal_amount();//可用金额
		BigDecimal buy_amount = new BigDecimal(sumAmount);//购买总价
		if(real_amount.compareTo(buy_amount)<0)return msg.addMessage(messageResourceService.getMessage("user.amount.not_enough"));
		//插入消费记录
		PayCost pc = new PayCost();
		pc.setId(UUIDGenerator.getUUID());
		pc.setAmount(buy_amount);
		pc.setDescrible("购买装扮皮肤"+name);
		pc.setNum_str(order_num);
		pc.setStatus(1);
		pc.setUser_id(user_id);
		pc.setP_code("dress");
		payCostMapper.save(pc);
		
		//购买的装扮放入我的装扮当中、
		Dressup dressup = new Dressup();
		dressup.setId(UUIDGenerator.getUUID());
		dressup.setDr_id(d_id);
		dressup.setIs_per(Integer.valueOf(is_per));
		Calendar date = Calendar.getInstance();//当前时间
		dressup.setCreate_time(date.getTime());
		if(!times.equals("A")){
			dressup.setPeriod(Integer.valueOf(times));
			//时间增加购买月份
			date.add(Calendar.MONTH,Integer.valueOf(times));
			dressup.setEnd_time(date.getTime());
		}
		dressup.setUser_id(user_id);
		dressupMapper.save(dressup);
		
		//更新可用余额
		userAmount.setAmount(sum_amount.subtract(buy_amount));
		userAmount.setReal_amount(real_amount.subtract(buy_amount));
		userAmountMapper.update(userAmount);
		return msg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg reBuyDress(Map<String, Object> params) {
		AjaxMsg msg = AjaxMsg.newError();
		String d_id = (String) params.get("d_id");//装扮ID
		String user_id = String.valueOf(params.get("user_id"));//当前登录用户ID
		String sumAmount = (String) params.get("sumAmount");//购买总价
		String name = (String) params.get("name");//购买总价
		//获取当前用户可用资金宇拓币
		UserAmount userAmount = userAmountMapper.getByUserId(user_id);
		//判断资金用户是否可用
		if(userAmount.getStatus()==2)return msg.addMessage(messageResourceService.getMessage("user.amount.freeze"));
		BigDecimal sum_amount = userAmount.getAmount();//剩余总金额
		BigDecimal real_amount = userAmount.getReal_amount();//可用金额
		BigDecimal buy_amount = new BigDecimal(sumAmount);//购买总价
		if(real_amount.compareTo(buy_amount)<0)return msg.addMessage(messageResourceService.getMessage("user.amount.not_enough"));
		
		Dressup dressup = dressupMapper.getEntityById(d_id); 
		
		//插入消费记录
		PayCost pc = new PayCost();
		pc.setId(UUIDGenerator.getUUID());
		pc.setAmount(new BigDecimal(sumAmount));
		pc.setDescrible("购买装扮皮肤"+name);
		pc.setNum_str(Common.createOrderOSN());
		pc.setStatus(1);
		pc.setUser_id(user_id);
		pc.setP_code("dress");
		payCostMapper.save(pc);
		//更新我的装扮
		dressup.setIs_per(1);
		dressup.setEnable(1);
		dressup.setEnd_time(null);
		dressupMapper.update(dressup);
		//更新可用余额
		userAmount.setAmount(sum_amount.subtract(buy_amount));
		userAmount.setReal_amount(real_amount.subtract(buy_amount));
		userAmountMapper.update(userAmount);
		
		return msg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

}

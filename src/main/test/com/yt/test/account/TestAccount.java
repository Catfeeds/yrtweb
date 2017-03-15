package com.yt.test.account;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.PayCost;
import com.yt.framework.persistent.entity.PayRecord;
import com.yt.framework.persistent.enums.AmountEnum.PayType;
import com.yt.framework.persistent.enums.AmountEnum.WayType;
import com.yt.framework.service.PayCostService;
import com.yt.framework.service.PayRecordService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 *
 *@autor bo.xie
 *@date2015-8-10下午4:28:58
 */
@ContextConfiguration(locations={"classpath*:spring/applicationContext.xml","classpath*:spring/appServlet/*.xml"})
public class TestAccount extends AbstractJUnit4SpringContextTests{

	@Autowired
	private PayRecordService payRecordService;
	@Autowired
	private PayCostService payCostService;
	
	/**
	 * 保存充值记录
	 *
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-10下午4:44:16
	 */
	@Test
	public void savePayRecord(){
		PayRecord t = new PayRecord();
			t.setUser_id("1");
			t.setAmount(new BigDecimal(1000));
			t.setBank_no("19286513216513179348CN");
			t.setDescrible("充值");
			t.setFree(new BigDecimal(0));
			t.setOrder_no("YT569802834082340912388551");
			t.setPayer_no("560980293409840845236523");
			t.setReal_amount(new BigDecimal(1000));
			t.setStatus(1);
			t.setSubmit_time(new Date());
			t.setThird_part(PayType.ZHIFUBAO.toString());
			t.setWay(WayType.ONLINE.toString());
			t.setEnd_time(new Date());
		AjaxMsg msg = payRecordService.save(t);
		System.out.println(msg.toJson());;
	}
	
	/**
	 * 保存用户消费记录
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-10下午4:53:38
	 */
	@Test
	public void savePayCost(){
		int i=1;
		while(true){
			if(i>10)break;
			PayCost pc = new PayCost();
			pc.setAmount(new BigDecimal(1000));
			pc.setDescrible("消费记录"+i);
			pc.setNum_str("YT56980283408234091212312"+i);
			pc.setUser_id("1");
			pc.setStatus(0);
			AjaxMsg msg = payCostService.save(pc);
			System.out.println(msg.toJson());
			i++;
		}
	}
	
	/**
	 * 查询用户所有充值记录
	 *
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-10下午5:03:35
	 */
	@Test
	public void loadPayRecord(){
		Map<String,Object> maps = Maps.newHashMap();
		PageModel<PayRecord> pageModel = new PageModel<PayRecord>();
		maps.put("user_id", 1l);
		maps.put("way", WayType.ONLINE.toString());//充值方式
//		maps.put("startTime", null);//开始时间
//		maps.put("endTime", null);//结束时间
//		maps.put("status", null);//充值状态：0:充值失败，1：充值成功
		AjaxMsg msg = payRecordService.queryForPage(maps, pageModel);
		System.out.println(msg.toJson());
	}
	
	/**
	 *获取用户所有消费记录
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-10下午5:11:24
	 */
	@Test
	public void loadPayCost(){
		Map<String,Object> maps = Maps.newHashMap();
		PageModel<PayCost> pageModel = new PageModel<PayCost>();
		maps.put("user_id", 1l);
//		maps.put("startTime", null);//开始时间
//		maps.put("endTime", null);//结束时间
		AjaxMsg msg = payCostService.queryForPage(maps, pageModel);
		System.out.println(msg.toJson());
	}
}

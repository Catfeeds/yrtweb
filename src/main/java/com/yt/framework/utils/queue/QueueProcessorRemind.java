package com.yt.framework.utils.queue;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.yt.framework.persistent.enums.SmsEnum.SMSTEMP;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.SpringContextUtil;
import com.yt.framework.utils.smsSend.SendMsg;
import com.yt.framework.utils.smsSend.SystemMsg;

public class QueueProcessorRemind extends QueueProcessor {
	static Logger logger = LogManager.getLogger(QueueProcessorRemind.class.getName());
	Random random = new Random();
	long testCount = 0;// 次数
	boolean startCycle = false;

	public void process(QueueContainer eventContainer) {
		if (startCycle == false) {
			startCycle = true;
			// 添加1个循环检查任务
			QueueContainer.getContainer().addTaskRemindQueue(new TaskDetecting());
		}
		TaskDetecting tse = null;
		try {
			tse = eventContainer.takeTaskRemindEntity();
			if (tse.isTest()) {// 每10秒执行一次
				try {
					exec10();

					if (testCount % 3 == 0) {// 每2分钟执行一次
						exec2Minute();
					}

					if (testCount % 30 == 0) {// 每5分钟执行一次
						// 在此写代码
						System.out.println("每5分钟执行一次.");
					}

					if (testCount % 600 == 0) {// 每100分钟执行一次
						// 在此写代码
					}

					if (testCount % 6000 == 0) {// 每16小时执行一次
						// 在此写代码
					}

					testCount++;
					return;
				} catch (Exception e) {
					logger.error(e.getLocalizedMessage(), e);
				} finally {
					tse.sleep(10000);
					QueueContainer.getContainer().addTaskRemindQueue(new TaskDetecting());
				}
			} else {// 需要执行任务
				if (tse.getTaskType() == 1) {

				}

			}

		} catch (InterruptedException e) {
			logger.error(e.getLocalizedMessage(), e);
		}
	}

	public void exec10() {
//		exec2Minute();
	}

	/**
	 * 每两分钟执行一次
	 */
	public void exec2Minute() {
		List<ProductDataVO> ls = findProgress(3);
		if (Common.isEmpty(ls)) {
			return;
		}
		String opencode = ApiplusUtils.getCQssc_last();
		for (ProductDataVO pd : ls) {
			plan_winning(pd, opencode);
		}
	}

	/*
	 * 
	 * 1商品的最后一个号码分配完毕后，将公示截止该时间点本站全部商品的最后50个参与时间；
	 * 2将这50个时间的数值进行求和（得出数值A）（每个时间按日、时、分、秒的顺序组合，如2016-10-26 20:15:25则为25152620）；
	 * 3为保证公平公正公开，系统还会等待一小段时间，取最近下一期中国福利彩票“老时时彩”的揭晓结果（一个五位数值B）；
	 * 4（数值A+数值B）除以该商品总需人次得到的余数 + 原始数 80000001，得到最终幸运号码，拥有该幸运号码者，直接获得该商品。
	 * 注：如遇福彩中心通讯故障，无法获取上述期数的中国福利彩票“老时时彩”揭晓结果，且24小时内该期“老时时彩”揭晓结果仍未公布，则默认“老时时彩”
	 * 揭晓结果为00000。
	 * 
	 */
	public boolean plan_winning(ProductDataVO pd, String opencode) {
		Connection conn = null;
		PreparedStatement st = null;

		int countbuy = pd.getData_total_count();
		int random = 80000001;
		int code = toInt(opencode);
		List<Integer> ls = findOrderTimes(pd.getData_id());
		long sum = code;
		int p_count = 0;//参与计算人次
		for (Integer vtim : ls) {
			sum += vtim;
			p_count += 1; 
			System.out.println(sum + "+" + vtim);
		}
		long remainder = sum % countbuy;
		long winningNumbers = random + sum % countbuy;

		System.out.println("(数值A:" + sum + "+数值B:" + opencode +")%总参与次数"+countbuy+ "+"+random+"=中奖号码:" + winningNumbers);
		
//		System.out.println("购买总次:" + countbuy + ",彩票号码:" + code + ",中奖号码:" + winningNumbers);
		try {
			conn = (Connection) SpringContextUtil.getConnection();
			int i = 1;
			st = conn.prepareStatement("select * from order_num where order_num = ? and data_sn = ?");
			st.setString(i++, "" + winningNumbers);
			st.setString(i++, pd.getData_sn());

			ResultSet rs = st.executeQuery();
			String winningOrder_sn = null;
			while (rs.next()) {
				winningOrder_sn = rs.getString("order_sn");
			}
			System.out.println("order_num="+winningNumbers+",data_sn="+pd.getData_sn()+",中奖者订单="+winningOrder_sn);
			
			
			i = 1;
			st = conn.prepareStatement("select * from or_order where order_sn = ? ");
			st.setString(i++, winningOrder_sn);
			rs = st.executeQuery();
			String data_win_user = "";
			while (rs.next()) {
				data_win_user = rs.getString("user_id");
			}
			
			i = 1;
			st = conn.prepareStatement("update or_order set order_status = 2 where data_sn =?");
			st.setString(i++, pd.getData_sn());
			st.executeUpdate();
			
			i = 1;
			st = conn.prepareStatement("update or_order set order_status = 3, order_ifwin = 1 where order_sn =?");
			st.setString(i++, winningOrder_sn);
			st.executeUpdate();
			
			i = 1;
			st = conn.prepareStatement("update product_data set data_finish_time=?, data_win_num = ?,data_win_user =?, data_total_num =?,data_remainder =?, data_calculate_count =?, data_ticket =?, data_status = 4 where data_id =?");
			st.setTimestamp(i++, new Timestamp(System.currentTimeMillis()));
			st.setString(i++, "" + winningNumbers);
			st.setString(i++, data_win_user);
			st.setString(i++, String.valueOf(sum));
			st.setString(i++, String.valueOf(remainder));
			st.setString(i++, String.valueOf(p_count));
			st.setString(i++, opencode);
			st.setString(i++, pd.getData_id());
			st.executeUpdate();// 更新中奖号码
			
			//发送短信
			i = 1;
			st = conn.prepareStatement("select * from m_user where id = ? ");
			st.setString(i++, data_win_user);
			rs = st.executeQuery();
			while (rs.next()) {
				String phone = rs.getString("phone");
				if(StringUtils.isNotBlank(phone)){
					StringBuilder sb = new StringBuilder();
					sb.append("@1@=").append(pd.getData_sn());	
					AjaxMsg re_msg = SendMsg.getInstance().sendSMS(phone, sb.toString(), SMSTEMP.JSM405880045.toString());
					logger.info("发送短信结果："+re_msg);
				}
				SystemMsg.getInstance().saveCNMessageNoReply(new Object[]{pd.getData_sn()},"user.shop.win", data_win_user, data_win_user,1);
				SystemMsg.getInstance().saveDynamicMessageNoReply(new Object[]{pd.getData_sn(),BeanUtils.nullToString(rs.getString("username"))},"user.shop.windynamic", data_win_user);
			}
			return true;
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		} finally {
			SpringContextUtil.closeConnection(conn);
		}
		return false;
	}

	public List<ProductDataVO> findProgress(int balance_status) {
		List<ProductDataVO> retList = new ArrayList<ProductDataVO>();
		Connection conn = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			int i = 1;
			conn = (Connection) SpringContextUtil.getConnection();
			String sql = "select * from product_data where data_status = ? and data_win_num is null";
			st = conn.prepareStatement(sql);
			st.setInt(i++, balance_status);// 商品状态：1等待开始、2进行中、3待揭晓、4已公布中奖
			rs = st.executeQuery();
			while (rs.next()) {
				ProductDataVO pdv = new ProductDataVO();
				pdv.setData_id(rs.getString("data_id"));
				pdv.setData_sn(rs.getString("data_sn"));
				pdv.setData_total_count(rs.getInt("data_total_count"));
				retList.add(pdv);
			}

		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		} finally {
			SpringContextUtil.closeConnection(conn);
		}
		return retList;
	}

	public List<Integer> findOrderTimes(String data_id) {
		List<Integer> retList = new ArrayList<Integer>();
		Connection conn = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			int i = 1;
			conn = (Connection) SpringContextUtil.getConnection();
			String sql = "select * from or_order where data_id = ? order by order_pay_time desc";
			st = conn.prepareStatement(sql);
			st.setString(i++, data_id);// 商品状态：0等待开始、1进行中、2待揭晓、3已公布中奖
			rs = st.executeQuery();
			int x = 0;
			while (rs.next()) {
				long time = rs.getLong("order_pay_num");
				String ptime = Common.formatDate(new Date(time), "HHmmssSSS");
				retList.add(toInt(ptime));
				x++;
				if (x >= 50)
					break;
			}

		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		} finally {
			SpringContextUtil.closeConnection(conn);
		}
		return retList;
	}

	public static int toInt(String v) {
		if (!Common.isEmpty(v)) {
			try {
				return Integer.parseInt(v.trim(), 10);
			} catch (Exception e) {
				// logger.error(e.getLocalizedMessage(), e);
				return dealIntErr(v);
			}
		}
		return 0;
	}

	private static int dealIntErr(String str) {
		int i = str.indexOf(".");
		if (i != -1)
			str = str.substring(0, i);
		String num = str.replaceAll("\\D", "");
		try {
			return Integer.parseInt(num, 10);
		} catch (NumberFormatException e) {
			return 0;
		}
	}
}

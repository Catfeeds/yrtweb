package com.yt.framework.utils.smsSend;

import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.MsgHistory;
import com.yt.framework.persistent.enums.SmsEnum.SMSTEMP;
import com.yt.framework.service.CommonService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PropertiesUtils;
import com.yt.framework.utils.SpringContextUtil;
import com.yt.framework.utils.http.HttpRequestUtil;

/**
 *短信发送工具
 *@autor bo.xie
 *@date2015-7-24上午11:46:16
 */
public class SendMsg{
	static Logger logger = LogManager.getLogger(SendMsg.class.getName());
	public static SendMsg sendMsg = null;
	private CommonService commonService;
	
	public SendMsg() {
		commonService = (CommonService) SpringContextUtil.getBean("commonService");
	}

	public static SendMsg getInstance() {
		if (sendMsg == null)
			sendMsg = new SendMsg();
		return sendMsg;
	}
	
	/**
	 *短信发送
	 *@param phoneNum 手机号
	 *@param Content 文本发送内容
	 *@return
	 *@autor bo.xie
	 *@date2015-7-24上午11:47:46
	 */
	public AjaxMsg sendSMS(String phoneNum,String content) {
		Map<String,String> map = Maps.newHashMap();
		MsgHistory history = new MsgHistory();//保存历史记录
		StringBuilder sb = new StringBuilder("@1@=");
		Properties p = PropertiesUtils.loadSetting("/messages/common.properties");
		String url = String.valueOf(p.get("sms.send.httpurl"));
		Boolean sms_use = Boolean.valueOf(String.valueOf(p.get("sms.use")));//是否启用短信发送接口
		//关闭短信发送接口，直接返回结果
		if(!sms_use)return AjaxMsg.newSuccess().addMessage("短信发送接口未启用，不会向用户发送短信通知！");
		
		map.put("username", String.valueOf(p.get("sms.send.username")));// 此处填写用户账号
		map.put("password", String.valueOf(p.get("sms.send.password")));// 此处填写用户密码
		map.put("mobile", phoneNum);// 此处填写发送号码
		map.put("veryCode", "xeqlf724pe8j");
		map.put("msgtype", "2");
		history.setPhone(phoneNum);
		map.put("tempid", SMSTEMP.JSM405880002.toString());// 此处填写模板短信编号
		map.put("content",sb.append(content).toString());// 此处填写模板短信内容
		history.setContent(sb.append(content).toString());
		if(StringUtils.isBlank(phoneNum)){
			return AjaxMsg.newError().addMessage("手机号为空");
		}
		if(Common.isMobile(phoneNum)){
			String ret = HttpRequestUtil.doPost(url, map, "GBK");
			String res_str = Common.convertUTF2GBK(ret);
			String status = this.getContext(res_str, "status");
			history.setType(1);
			history.setResult(status);
			commonService.saveMsgHistory(history);
			return AjaxMsg.newSuccess().addMessage(res_str);
		}else{
			return AjaxMsg.newError().addMessage("手机号格式不对");
		}
	}
	
	/**
	 * 发送短信
	 *@param phoneNum 手机号
	 *@param content 发送内容
	 *@param modelID 短信模板ID
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-18下午5:29:48
	 */
	public AjaxMsg sendSMS(String phoneNum,String content,String modelID){
		Map<String,String> map = Maps.newHashMap();
		MsgHistory history = new MsgHistory();//保存历史记录
		Properties p = PropertiesUtils.loadSetting("/messages/common.properties");
		String url = String.valueOf(p.get("sms.send.httpurl"));
		Boolean sms_use = Boolean.valueOf(String.valueOf(p.get("sms.use")));//是否启用短信发送接口
		//关闭短信发送接口，直接返回结果
		if(!sms_use)return AjaxMsg.newSuccess().addMessage("短信发送接口未启用，不会向用户发送短信通知！");
		map.put("username", String.valueOf(p.get("sms.send.username")));// 此处填写用户账号
		map.put("password", String.valueOf(p.get("sms.send.password")));// 此处填写用户密码
		map.put("mobile", phoneNum);// 此处填写发送号码
		map.put("veryCode", "xeqlf724pe8j");
		map.put("msgtype", "2");
		history.setPhone(phoneNum);
		if(StringUtils.isNotBlank(modelID))map.put("tempid", modelID);// 此处填写模板短信编号
		map.put("content",content);// 此处填写模板短信内容
		history.setContent("短信模板ID:"+modelID+"；发送内容："+content);
		if(StringUtils.isBlank(phoneNum)){
			return AjaxMsg.newError().addMessage("手机号为空");
		}
		if(Common.isMobile(phoneNum)){
			String ret = HttpRequestUtil.doPost(url, map, "GBK");
			String res_str = Common.convertUTF2GBK(ret);
			String status = this.getContext(res_str, "status");
			history.setType(1);
			history.setResult(status);
			commonService.saveMsgHistory(history);
			return AjaxMsg.newSuccess().addMessage(res_str);
		}else{
			return AjaxMsg.newError().addMessage("手机号格式不对");
		}
			//return AjaxMsg.newSuccess().addMessage("");
	}
	
	public String getContext(String xml, String node) {
		StringBuilder sb = new StringBuilder();
		Matcher m = Pattern.compile("<" + node + ">([^<]+)</" + node + ">").matcher(xml);
		if (m.find()) {
			sb.append(m.group(1)).append(",");
		}
		int len = sb.length();
		if (len > 0)
			sb.deleteCharAt(len - 1);
		return sb.toString();
	}
	
}

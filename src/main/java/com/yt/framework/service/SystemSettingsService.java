package com.yt.framework.service;

import javax.servlet.http.HttpSession;

import com.yt.framework.utils.AjaxMsg;

/**
 * @ClassName: SystemSettingsService 
 * @Description: 系统设置相关 
 * @author zjh
 * @date 2015年8月3日 上午11:01:24 
 */
public interface SystemSettingsService {
	/**
	 * @Title: isHavaEmailOrPhone 
	 * @Description: 检查用户是否设置手机号或者邮箱
	 * @param @param type
	 * @param @param id
	 * @param @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date  2015年8月5日上午11:57:05
	 */
	public AjaxMsg isHavaEmailOrPhone(String type,String id);
	/**
	 * @Title: sendEmail 
	 * @Description: 发送邮件 
	 * @param @param txt 发送内容
	 * @param @param addr 发送地址
	 * @param @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date  2015年8月5日下午2:44:52
	 */
	public AjaxMsg sendEmail(String txt,String addr);
	/**
	 * @Title: checkCode 
	 * @Description: 校验验证码
	 * @param @param code 验证码（phone/email）
	 * @param @param txt 邮箱或者手机号
	 * @param @param type phone?email
	 * @param @param session
	 * @param @return    设定文件 
	 * @return AjaxMsg    返回类型 
	 * @throws 
	 * @author zjh
	 * @date  2015年8月5日下午2:47:32
	 */
	public AjaxMsg checkCode(String code,String txt,HttpSession session);
}

package com.yt.framework.service;

import com.yt.framework.persistent.entity.Certification;
import com.yt.framework.utils.AjaxMsg;

/**
 *
 *@autor bo.xie
 *@date2015-8-25下午2:35:17
 */
public interface CertificaService extends BaseService<Certification> {

	/**
	 * 获取用户的认证信息
	 *@param user_id
	 *@param type 类型
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-25下午2:01:49
	 */
	public Certification getCertificationByUserId(String user_id,String type);
	
	/**
	 * 判断该身份证号码是否已存在认证
	 * @param id_card
	 * @param type
	 * @return
	 */
	public AjaxMsg isExitCertification(String id_card,String type);

	/**
	 * 判断该身份证号码是否已存在认证
	 * @param id_card
	 * @param type
	 * @return
	 */
	public int getCertificationByIdCardCount(String id_card,String type, int status);
	
	
	/**
	 * 审核
	 * @param id_card
	 * @param type
	 * @return
	 */
	public AjaxMsg playerAuditResult(Certification certification)throws Exception;
	
	/**
	 * 保存身份证认证
	 * 存入数据时需要校验该身份证号是否已被认证成功或者正在认证当中
	 * @param certification
	 * @return
	 */
	public AjaxMsg saveCertification(Certification certification);
	
	public AjaxMsg updateCertification(Certification certification);
	
	/**
	 * 获取认证信息(包括已认证、未认证、认证中)
	 * @param id_card 身份证号
	 * @param type 类型
	 * @return
	 */
	public Certification getCertificationByIdCard(String id_card,String type);
	
	/**
	 * 判断用户是否实名认证
	 * @param user_id
	 * @return
	 */
	public boolean checkUserCertifica(String user_id);
	
}

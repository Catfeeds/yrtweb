package com.yt.framework.mapper;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.Certification;


/**
 *认证
 *@autor bo.xie
 *@date2015-8-3下午7:05:43
 */
public interface CertificationMapper extends BaseMapper<Certification> {

	/**
	 * 获取用户的认证信息
	 *@param user_id
	 *@param type 类型
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-25下午2:01:49
	 */
	public Certification getCertificationByUserId(@Param(value="user_id")String user_id,@Param(value="type")String type);
	
	/**
	 * 获取认证信息
	 * @param id_card 身份证号
	 * @param type 类型
	 * @return
	 */
	public Certification getCertificationByIdcardAndType(@Param(value="id_card")String id_card,@Param(value="type")String type);
	
	/**
	 * 获取认证信息
	 * @param id_card 身份证号
	 * @param type 类型
	 * @return
	 */
	public int getCertificationByIdCardCount(@Param(value="id_card")String id_card,@Param(value="type")String type,@Param(value="status")int status);
	
	/**
	 * 获取认证信息(包括已认证、未认证、认证中)
	 * @param id_card 身份证号
	 * @param type 类型
	 * @return
	 */
	public Certification getCertificationByIdCard(@Param(value="id_card")String id_card,@Param(value="type")String type);
	
	/**
	 * 获取认证信息(已认证)
	 * @param user_id
	 * @return
	 */
	public Certification getUserSuccessCertificaByUserId(@Param(value="user_id")String user_id);
	
}

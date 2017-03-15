package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
/**
 * 
 * <p>
 * 附件购买记录实体对象
 * <p>
 * 
 * @author zhangwei
 * @Date 2016年1月7日 下午12:00:42
 * @version
 */
public class BbsChargeInfo implements Serializable{

	private static final long serialVersionUID = 3273589509574948183L;
    private String id;
    private String user_id;//购买用户
    private BigDecimal amount;//金额
    private String note_id;//帖子id
    private String acc_id;//附件插件ID
    private Date create_tiem;//购买时间
    
	public String getAcc_id() {
		return acc_id;
	}
	public void setAcc_id(String acc_id) {
		this.acc_id = acc_id;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	public String getNote_id() {
		return note_id;
	}
	public void setNote_id(String note_id) {
		this.note_id = note_id;
	}
	public Date getCreate_tiem() {
		return create_tiem;
	}
	public void setCreate_tiem(Date create_tiem) {
		this.create_tiem = create_tiem;
	}
}

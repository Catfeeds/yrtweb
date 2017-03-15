
package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * 激活码
 *@autor ylt
 *@date2015-10-14下午6:59:46
 */
public class ActiveCode implements Serializable{
	private static final long serialVersionUID = 4370762207379903250L;
	private String id;
	private String user_id; //俱乐部创始人ID
	private String league_id; // 联赛ID
	private String teaminfo_id; //俱乐部ID
	private String code_str; //激活码
	private Integer status; //是否可用 1：可用 2：不可用  3：默认可用
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")  
	private Date use_time;//使用日期
	private Date create_time;//创建日期
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")  
	private Date end_time;//截止日期
	private int code_count;//球员激活码数量
	private BigDecimal init_price; //购买初始价格  默认：0
	private BigDecimal init_capital;//俱乐部初始资金 默认：0
	private Integer if_loan; //是否可用租借 0不可用  1可用
	private Integer if_transfer;//是否可用定向转会 0不可用  1可用
	private Integer p_status;//是否允许带人 0否1是
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public Date getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
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
	
	public String getLeague_id() {
		return league_id;
	}
	public void setLeague_id(String league_id) {
		this.league_id = league_id;
	}
	public String getTeaminfo_id() {
		return teaminfo_id;
	}
	public void setTeaminfo_id(String teaminfo_id) {
		this.teaminfo_id = teaminfo_id;
	}
	public String getCode_str() {
		return code_str;
	}
	public void setCode_str(String code_str) {
		this.code_str = code_str;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Date getUse_time() {
		return use_time;
	}
	public void setUse_time(Date use_time) {
		this.use_time = use_time;
	}
	public int getCode_count() {
		return code_count;
	}
	public void setCode_count(int code_count) {
		this.code_count = code_count;
	}
	public BigDecimal getInit_price() {
		return init_price;
	}
	public void setInit_price(BigDecimal init_price) {
		this.init_price = init_price;
	}
	public BigDecimal getInit_capital() {
		return init_capital;
	}
	public void setInit_capital(BigDecimal init_capital) {
		this.init_capital = init_capital;
	}
	public Integer getIf_loan() {
		return if_loan;
	}
	public void setIf_loan(Integer if_loan) {
		this.if_loan = if_loan;
	}
	public Integer getIf_transfer() {
		return if_transfer;
	}
	public void setIf_transfer(Integer if_transfer) {
		this.if_transfer = if_transfer;
	}
	public Integer getP_status() {
		return p_status;
	}
	public void setP_status(Integer p_status) {
		this.p_status = p_status;
	}
	
}

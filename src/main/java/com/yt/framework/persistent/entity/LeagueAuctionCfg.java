package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * 交易市场配置表
 * @author ylt
 *
 */
public class LeagueAuctionCfg implements Serializable {
	private static final long serialVersionUID = 8522817804915605641L;
	private String id;
	/**
	 * 联赛ID
	 */
	private String league_id;
	
	/**
	 * 赛季分类id
	 */
	private String s_id;
	/**
	 * 竞拍轮数 1、2、3 。。
	 */
	private Integer turn_num; 
	
	/**
	 * 滚入下一轮竞拍轮数 1、2、3 。。
	 */
	private Integer next_num; 
	
	/**
	 * 竞拍开始时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")	
	private Date start_time;
	/**
	 * 竞拍结束时间 
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date end_time;
	/**
	 * 市场是否开放 1：是 0：否
	 */
	private int status;
	/**
	 * 规则创建时间
	 */
	private Date create_time;
	
	private BigDecimal init_price;//初始默认竞拍价
	
	private BigDecimal y_init_price;//妖人初始默认竞拍价
	
	private BigDecimal per_price;//每次加价配置
	
	private BigDecimal add_price;//浮动初始价
	
	private float user_percent;//用户竞拍分成 例如 ：0.33
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLeague_id() {
		return league_id;
	}
	public void setLeague_id(String league_id) {
		this.league_id = league_id;
	}
	public Integer getTurn_num() {
		return turn_num;
	}
	public void setTurn_num(Integer turn_num) {
		this.turn_num = turn_num;
	}
	public Date getStart_time() {
		return start_time;
	}
	public void setStart_time(Date start_time) {
		this.start_time = start_time;
	}
	public Date getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public BigDecimal getInit_price() {
		return init_price;
	}
	public void setInit_price(BigDecimal init_price) {
		this.init_price = init_price;
	}
	public BigDecimal getPer_price() {
		return per_price;
	}
	public void setPer_price(BigDecimal per_price) {
		this.per_price = per_price;
	}
	public Integer getNext_num() {
		return next_num;
	}
	public void setNext_num(Integer next_num) {
		this.next_num = next_num;
	}
	public BigDecimal getAdd_price() {
		return add_price;
	}
	public void setAdd_price(BigDecimal add_price) {
		this.add_price = add_price;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public float getUser_percent() {
		return user_percent;
	}
	public void setUser_percent(float user_percent) {
		this.user_percent = user_percent;
	}
	public BigDecimal getY_init_price() {
		return y_init_price;
	}
	public void setY_init_price(BigDecimal y_init_price) {
		this.y_init_price = y_init_price;
	}
	
	
}

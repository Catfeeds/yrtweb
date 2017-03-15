package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;
/**
 * 
 * <p>
 * 论坛附件实体对象
 * <p>
 * 
 * @author zhangwei
 * @Date 2016年1月7日 上午11:54:15
 * @version
 */
public class BbsAccessories implements Serializable{
     
	private static final long serialVersionUID = 2280000594209226980L;
	private String id;
	private String name;//附件名称
	private String size;//大小
	private String note_id;//帖子id
	private String user_id;//上传用户id
	private String file_url;//附件地址
	private String if_del;//是否删除
	private BigDecimal price;//附件价格
	private int download;//下载次数
	private String remark;//备注
	private int buyCount;//购买次数
	
	public int getBuyCount() {
		return buyCount;
	}
	public void setBuyCount(int buyCount) {
		this.buyCount = buyCount;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getNote_id() {
		return note_id;
	}
	public void setNote_id(String note_id) {
		this.note_id = note_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getFile_url() {
		return file_url;
	}
	public void setFile_url(String file_url) {
		this.file_url = file_url;
	}
	public String getIf_del() {
		return if_del;
	}
	public void setIf_del(String if_del) {
		this.if_del = if_del;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getDownload() {
		return download;
	}
	public void setDownload(int download) {
		this.download = download;
	}
	
}

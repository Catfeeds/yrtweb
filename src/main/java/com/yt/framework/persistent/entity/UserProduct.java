package com.yt.framework.persistent.entity;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 亿元夺宝产品
 * 
 * @author gl
 *
 */
public class UserProduct implements Serializable {
	private static final long serialVersionUID = -5097122317520548303L;

	private String product_id;
	private String product_title;//产品标题
	private String category_id;//分类id
	private String product_banner;//产品头像轮播
	private BigDecimal product_single_price;//夺宝单价
	private BigDecimal product_total_price;//夺宝总价
	private Integer product_total_count;//商品夺宝总需人次
	private String product_header;//商品头像
	private String product_second_title;//商品副标题
	private String product_desc;//商品详情
	private Integer product_recommend_sort;//产品推荐排序
	private String product_status;//产品状态:是否上架
	private String product_keyword;//商品关键词
	private String product_recommend;//产品推荐
	private String product_hot;//产品热销
	private String product_ifopen;
	private String product_ifdel;
	private String product_type; //user 个人  club 俱乐部
	private BigDecimal product_in_price;//进价
	private String product_no;//货号
	private String product_rate;//溢价率
	private BigDecimal product_final_price;
	private String product_remark;//备注

	public String getProduct_id() {
		return product_id;
	}

	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}

	public String getProduct_title() {
		return product_title;
	}

	public void setProduct_title(String product_title) {
		this.product_title = product_title;
	}

	public String getCategory_id() {
		return category_id;
	}

	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}

	public String getProduct_banner() {
		return product_banner;
	}

	public void setProduct_banner(String product_banner) {
		this.product_banner = product_banner;
	}

	public BigDecimal getProduct_single_price() {
		return product_single_price;
	}

	public void setProduct_single_price(BigDecimal product_single_price) {
		this.product_single_price = product_single_price;
	}

	public BigDecimal getProduct_total_price() {
		return product_total_price;
	}

	public void setProduct_total_price(BigDecimal product_total_price) {
		this.product_total_price = product_total_price;
	}

	public Integer getProduct_total_count() {
		return product_total_count;
	}

	public void setProduct_total_count(Integer product_total_count) {
		this.product_total_count = product_total_count;
	}

	public String getProduct_header() {
		return product_header;
	}

	public void setProduct_header(String product_header) {
		this.product_header = product_header;
	}

	public String getProduct_second_title() {
		return product_second_title;
	}

	public void setProduct_second_title(String product_second_title) {
		this.product_second_title = product_second_title;
	}

	public String getProduct_desc() {
		return product_desc;
	}

	public void setProduct_desc(String product_desc) {
		this.product_desc = product_desc;
	}

	public Integer getProduct_recommend_sort() {
		return product_recommend_sort;
	}

	public void setProduct_recommend_sort(Integer product_recommend_sort) {
		this.product_recommend_sort = product_recommend_sort;
	}

	public String getProduct_status() {
		return product_status;
	}

	public void setProduct_status(String product_status) {
		this.product_status = product_status;
	}

	public String getProduct_keyword() {
		return product_keyword;
	}

	public void setProduct_keyword(String product_keyword) {
		this.product_keyword = product_keyword;
	}

	public String getProduct_recommend() {
		return product_recommend;
	}

	public void setProduct_recommend(String product_recommend) {
		this.product_recommend = product_recommend;
	}

	public String getProduct_hot() {
		return product_hot;
	}

	public void setProduct_hot(String product_hot) {
		this.product_hot = product_hot;
	}

	public String getProduct_ifopen() {
		return product_ifopen;
	}

	public void setProduct_ifopen(String product_ifopen) {
		this.product_ifopen = product_ifopen;
	}

	public String getProduct_ifdel() {
		return product_ifdel;
	}

	public void setProduct_ifdel(String product_ifdel) {
		this.product_ifdel = product_ifdel;
	}

	public String getProduct_type() {
		return product_type;
	}

	public void setProduct_type(String product_type) {
		this.product_type = product_type;
	}

	public BigDecimal getProduct_in_price() {
		return product_in_price;
	}

	public void setProduct_in_price(BigDecimal product_in_price) {
		this.product_in_price = product_in_price;
	}

	public String getProduct_no() {
		return product_no;
	}

	public void setProduct_no(String product_no) {
		this.product_no = product_no;
	}

	public String getProduct_rate() {
		return product_rate;
	}

	public void setProduct_rate(String product_rate) {
		this.product_rate = product_rate;
	}

	public BigDecimal getProduct_final_price() {
		return product_final_price;
	}

	public void setProduct_final_price(BigDecimal product_final_price) {
		this.product_final_price = product_final_price;
	}

	public String getProduct_remark() {
		return product_remark;
	}

	public void setProduct_remark(String product_remark) {
		this.product_remark = product_remark;
	}
	
	
}

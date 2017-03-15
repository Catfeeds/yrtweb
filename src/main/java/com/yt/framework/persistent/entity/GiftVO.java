package com.yt.framework.persistent.entity;

import java.util.ArrayList;
import java.util.List;

public class GiftVO implements Cloneable {
	private String rec_user_id;
	private String pay_user_id;
	private String p_code;
	private String p_name;
	private String image_src;
	private int charm_value;
	private int price;
	private int quantity;
	
	public static List<GiftVO> getAllGiftList(){
		List<GiftVO> retList=new ArrayList<GiftVO>();
		retList.add(new GiftVO("resources/images/gi1.png","gift001","红玫瑰",100,200));
		retList.add(new GiftVO("resources/images/gi2.png","gift002","巧克力",200,300));
		retList.add(new GiftVO("resources/images/gi3.png","gift003","魅力香水",300,500));
		retList.add(new GiftVO("resources/images/gi4.png","gift004","正品球衣",600,1000));
		retList.add(new GiftVO("resources/images/gi5.png","gift005","专业球鞋",800,1200));
		retList.add(new GiftVO("resources/images/gi6.png","gift006","暖心围脖",1000,1500));
		retList.add(new GiftVO("resources/images/gi7.png","gift007","炫酷超跑",6000,9000));
		retList.add(new GiftVO("resources/images/gi8.png","gift008","豪宅",9000,12000));
		retList.add(new GiftVO("resources/images/gi9.png","gift009","荣耀奖杯",12000,18000));
		return retList;
	}
	public static GiftVO getGiftBypcode(String p_code){
		List<GiftVO> ls = getAllGiftList();
		for(GiftVO giftVO:ls){
			if(giftVO.getP_code().equals(p_code))return giftVO;
		}
		return null;
	}
	
	public GiftVO(String p_code,int quantity) {
		super();
		this.p_code = p_code;
		this.quantity = quantity;
	}
	public GiftVO(String p_code, String p_name, int charm_value, int price) {
		super();
		this.p_code = p_code;
		this.p_name = p_name;
		this.charm_value = charm_value;
		this.price = price;
	}
	public GiftVO(String image_src,String p_code, String p_name, int charm_value, int price) {
		super();
		this.image_src = image_src;
		this.p_code = p_code;
		this.p_name = p_name;
		this.charm_value = charm_value;
		this.price = price;
	}

	public String getRec_user_id() {
		return rec_user_id;
	}

	public void setRec_user_id(String rec_user_id) {
		this.rec_user_id = rec_user_id;
	}

	public String getPay_user_id() {
		return pay_user_id;
	}

	public void setPay_user_id(String pay_user_id) {
		this.pay_user_id = pay_user_id;
	}

	public String getP_code() {
		return p_code;
	}

	public void setP_code(String p_code) {
		this.p_code = p_code;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getImage_src() {
		return image_src;
	}

	public void setImage_src(String image_src) {
		this.image_src = image_src;
	}

	public int getCharm_value() {
		return charm_value;
	}

	public void setCharm_value(int charm_value) {
		this.charm_value = charm_value;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public GiftVO clone() {
		try {
			return (GiftVO) super.clone();
		} catch (CloneNotSupportedException e) {
			return null;
		}
	}
}

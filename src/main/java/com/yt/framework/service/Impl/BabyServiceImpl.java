package com.yt.framework.service.Impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
import com.yt.framework.mapper.ReceiveGiftsMapper;
import com.yt.framework.mapper.UserMapper;
import com.yt.framework.persistent.entity.BabyInfo;
import com.yt.framework.persistent.entity.GiftVO;
import com.yt.framework.persistent.entity.ImageVideo;
import com.yt.framework.persistent.entity.ImageVideoBaby;
import com.yt.framework.persistent.entity.PayCost;
import com.yt.framework.persistent.entity.PriceSlave;
import com.yt.framework.persistent.entity.ReceiveGifts;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.enums.SystemEnum;
import com.yt.framework.service.BabyService;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PriceSlaveService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.ReturnJosnMsg;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.gson.JSONUtils;

/**
 *
 *@autor bo.xie
 *@date2015-9-24下午6:44:50
 */
@Service("babyService")
public class BabyServiceImpl extends BaseServiceImpl<BabyInfo> implements BabyService{
	
	protected static Logger logger = LogManager.getLogger(BabyServiceImpl.class);

	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private PriceSlaveService priceSlaveService;
	@Autowired
	protected ReceiveGiftsMapper receiveGiftsMapper;
	@Autowired
	protected UserMapper userMapper;
	@Autowired
	protected ImageVideoService imageVideoService;
	
	@Override
	public AjaxMsg saveOrUpdateInfo(BabyInfo babyInfo,HttpServletRequest request) throws Exception {
		String price = request.getParameter("price");//前端传递宝贝身价
		if(StringUtils.isBlank(price))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.baby.price"));
		if(babyInfo!=null && StringUtils.isBlank(babyInfo.getId())){//保存
			babyInfo.setId(UUIDGenerator.getUUID());
			babyInfoMapper.save(babyInfo);
			//baby_id注入session中
			Common.setSessionValue("session_baby_id", babyInfo.getId());
			User user = userMapper.getEntityById(babyInfo.getUser_id());
			AjaxMsg msg = securityService.saveUserRole(user,"7",request);
			if(msg.isError()){
				throw new RuntimeException();
			}
			if(StringUtils.isNotBlank(babyInfo.getImages_url())){
				ImageVideo imageVideo = new ImageVideo();
				imageVideo.setUser_id(babyInfo.getUser_id());
				imageVideo.setIf_show(0);
				imageVideo.setF_status(1);
				imageVideo.setType("image");
				imageVideo.setRole_type(SystemEnum.IMAGE.BABY.toString());
				/*String[] imgs = babyInfo.getImages_url().split(",");
				for (int i = 0; i < imgs.length; i++) {
					imageVideo.setId(UUIDGenerator.getUUID());
					imageVideo.setF_src(imgs[i]);
					//babyInfoMapper.saveImgOrVideos(imageVideo);
					imageVideoMapper.saveImage(imageVideo);
				}*/
				imageVideoService.saveImgOrVideos(imageVideo, babyInfo.getImages_url());
			}	
		}else if(babyInfo!=null && StringUtils.isNotBlank(babyInfo.getId())){//更新
			BabyInfo old_babyInfo = babyInfoMapper.getEntityById(babyInfo.getId());
				old_babyInfo.setAchievement(babyInfo.getAchievement());
				old_babyInfo.setChest(babyInfo.getChest());
				old_babyInfo.setConstellation(babyInfo.getConstellation());
				old_babyInfo.setHeight(babyInfo.getHeight());
				old_babyInfo.setHip(babyInfo.getHip());
				old_babyInfo.setHobby(babyInfo.getHobby());
				old_babyInfo.setIntro(babyInfo.getIntro());
				old_babyInfo.setLove_team(babyInfo.getLove_team());
				old_babyInfo.setWaist(babyInfo.getWaist());
				old_babyInfo.setWeight(babyInfo.getWeight());
			babyInfoMapper.update(old_babyInfo);
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		}
		PriceSlave ps = new PriceSlave();
		ps.setId(UUIDGenerator.getUUID());
		ps.setPrice(new BigDecimal(price));
		ps.setRole_type(6);
		ps.setUser_id(babyInfo.getUser_id());
		priceSlaveService.save(ps);
		
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).addData("data", babyInfo);
	}

	public AjaxMsg getBabyUser(String baby_id){
		Map<String,Object> maps = Maps.newHashMap();
		maps = babyInfoMapper.getBabyUser(baby_id);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success")).addData("data", maps);
	}

	@Override
	public List<Map<String, Object>> loadAllBabyImageByUserId(String user_id, String role_type) {
		return babyInfoMapper.loadAllBabyImageByUserId(user_id, role_type);
	}
	
	@Override
	public List<Map<String, Object>> loadAllBabyVideoByUserId(String user_id, String role_type) {
		return babyInfoMapper.loadAllBabyVideoByUserId(user_id, role_type);
	}
	
	@Override
	public Map<String, Object> getInviteAndCheerCount(String user_id) {
		return babyInfoMapper.getInviteAndCheerCount(user_id);
	}

	@Override
	public AjaxMsg saveBabyImages(String userId, String images,String type) {
		int itype = 1;
		if(StringUtils.isNotBlank(type)&&"2".equals(type)){
			itype = 2;
		}
		if(StringUtils.isNotBlank(userId)){
			Map<String, Object> map = babyInfoMapper.getBabyUser(userId);
			ImageVideoBaby imageVideo = new ImageVideoBaby();
			imageVideo.setUser_id(userId);
			imageVideo.setBabyinfo_id(map.get("id")!=null ? map.get("id").toString():"");
			imageVideo.setIf_show(1);
			imageVideo.setStatus(1);
			imageVideo.setType(itype);
			String[] imgs = images.split(",");
			for (int i = 0; i < imgs.length; i++) {
				imageVideo.setId(UUIDGenerator.getUUID());
				imageVideo.setSrc(imgs[i]);
				imageVideo.setV_cover(imageVideo.getSrc().substring(0,imageVideo.getSrc().indexOf("."))+".jpg");
				babyInfoMapper.saveImgOrVideos(imageVideo);
			}
			return AjaxMsg.newSuccess();
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg queryBabyImages(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = babyImgCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = babyInfoMapper.queryBabyImages(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public int babyImgCount(Map<String, Object> params) {
		return babyInfoMapper.babyImgCount(params);
	}

	@Override
	public AjaxMsg deleteBabyImg(String id) {
		int num = babyInfoMapper.deleteBabyImg(id);
		if(num>0){
			return AjaxMsg.newSuccess();
		}
		return AjaxMsg.newError();
	}

	@Override
	public List<Map<String, Object>> loadRecommendBabyImages(Map<String, Object> maps) {
		return babyInfoMapper.loadRecommendBabyImages(maps);
	}

	@Override
	public TeamInfo getTeamInfoByUserId(String baby_user_id) {
		return babyInfoMapper.getTeamInfoByUserId(baby_user_id);
	}

	@Override
	public BabyInfo getBabyInfoByUserId(String user_id) {
		return babyInfoMapper.getByUserId(user_id);
	}

	@Override
	public ReturnJosnMsg buyGift(Map<String, String> maps) {
		String login_user_id = maps.get("login_user_id");
		String p_code = maps.get("p_code");
		String rec_user_id = maps.get("rec_user_id");
		String price = maps.get("price");
		String charm_value = maps.get("charm_value");
		String p_name="赠送礼物";
		GiftVO p_g = GiftVO.getGiftBypcode(p_code);
		if(p_g!=null){
			p_name=p_g.getP_name();
		}
		GiftVO gv=new GiftVO(p_code, p_name, JSONUtils.toInt(charm_value), JSONUtils.toInt(price));
		gv.setPay_user_id(login_user_id);
		gv.setRec_user_id(rec_user_id);
		int stuts = updateUserAmount(gv);
		String errMsg = null;
		ReturnJosnMsg retmsg = ReturnJosnMsg.newError();
		if(stuts==0){
			retmsg =ReturnJosnMsg.newSuccess();
			
		}if(stuts==1){
			errMsg = messageResourceService.getMessage("user.amount.freeze");
			retmsg = new ReturnJosnMsg(-1,errMsg);
		}else if(stuts==2){
			errMsg =messageResourceService.getMessage("user.amount.not_enough");
			retmsg = new ReturnJosnMsg(-1,errMsg);
		}
		
		return retmsg;
	}

	private int updateUserAmount(GiftVO giftVO) {
		BigDecimal priceSum = new BigDecimal(giftVO.getPrice());
		//获取购买者资金账户,并判断可用资金是否足够
		UserAmount payUserAmount = userAmountMapper.getByUserId(giftVO.getPay_user_id());
		if(payUserAmount==null||payUserAmount.getStatus()==2)return 1;
		if(payUserAmount.getReal_amount().compareTo(priceSum)<0){
			return 2;
		}
		//更新用户资金表
		payUserAmount.setAmount(payUserAmount.getAmount().subtract(priceSum));
		payUserAmount.setReal_amount(payUserAmount.getReal_amount().subtract(priceSum));
		userAmountMapper.update(payUserAmount);
		//创建消费记录
		String order_num = Common.createOrderOSN();
		PayCost pcPay = new PayCost();
		pcPay.setId(UUIDGenerator.getUUID());
		pcPay.setAmount(priceSum);
		pcPay.setDescrible(giftVO.getP_name());
		pcPay.setNum_str(order_num);
		pcPay.setStatus(1);
		pcPay.setOrder_id(null);
		pcPay.setUser_id(giftVO.getPay_user_id());
		pcPay.setP_code(giftVO.getP_code());
		payCostMapper.save(pcPay);
		//更新魅力值
		 User user = userMapper.getEntityById(giftVO.getRec_user_id());
		 User pay_user = userMapper.getEntityById(giftVO.getPay_user_id());
		int usercp=user.getUsercp()+giftVO.getCharm_value();
		user.setUsercp(usercp);
		userMapper.update(user);
		ReceiveGifts receiveGifts=new ReceiveGifts();
		receiveGifts.setCharm_value(giftVO.getCharm_value());
		receiveGifts.setCreateTime(new Date());
		receiveGifts.setId(UUIDGenerator.getUUID());
		receiveGifts.setP_code(giftVO.getP_code());
		receiveGifts.setPay_user_id(giftVO.getPay_user_id());
		receiveGifts.setRec_user_id(giftVO.getRec_user_id());
		receiveGifts.setPrice(giftVO.getPrice());
		receiveGifts.setP_name(giftVO.getP_name());
		receiveGiftsMapper.save(receiveGifts);
		try {
			messageResourceService.saveMessageNoReply(new Object[]{pay_user.getUsernick(),giftVO.getP_name()}, 
					"user.player.gift", giftVO.getRec_user_id(), giftVO.getPay_user_id(),1);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	@Override
	public List<GiftVO> getReceiveGiftList(String user_id) {
		List<GiftVO> retList = new ArrayList<GiftVO>();
		List<Map<String, Object>> ls = receiveGiftsMapper.getUserReceiveGifts(user_id);
		for(Map<String, Object> mp:ls){
			String p_code = (String)mp.get("p_code");
			int _count=JSONUtils.toInt(mp.get("_count").toString());
			GiftVO gv= GiftVO.getGiftBypcode(p_code);
			gv.setQuantity(_count);
			retList.add(gv);
		}
		return retList;
	}
	
	
}

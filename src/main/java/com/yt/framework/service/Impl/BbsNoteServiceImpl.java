package com.yt.framework.service.Impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.io.File;
import java.math.BigDecimal;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.BbsAccessories;
import com.yt.framework.persistent.entity.BbsChargeInfo;
import com.yt.framework.persistent.entity.BbsLeader;
import com.yt.framework.persistent.entity.BbsNote;
import com.yt.framework.persistent.entity.BbsNoteReply;
import com.yt.framework.persistent.entity.BbsPraise;
import com.yt.framework.persistent.entity.BbsPlate;
import com.yt.framework.persistent.entity.BbsVote;
import com.yt.framework.persistent.entity.BbsVoteClick;
import com.yt.framework.persistent.entity.BbsVoteData;
import com.yt.framework.persistent.entity.Order;
import com.yt.framework.persistent.entity.PayCost;
import com.yt.framework.persistent.entity.SysDict;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.persistent.entity.BbsTip;
import com.yt.framework.service.BbsNoteService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.ImageKit;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.file.FileRepository;

/**
 * 论坛
 *@autor ylt
 *@date2016-1-7下午11:39:32
 */
@Transactional
@Service("bbsNoteService")
public class BbsNoteServiceImpl extends BaseServiceImpl<BbsNote> implements BbsNoteService {
	
	protected static Logger logger = LogManager.getLogger(BbsNoteServiceImpl.class);
	@Autowired
	UserService userService;
	@Autowired
	private MessageResourceService messageResourceService;
	
	
	@Override
	public AjaxMsg saveOrUpdateNote(Map<String, Object> params,List<BbsAccessories> attrcs) throws Exception {
		String user_id = String.valueOf(params.get("user_id"));//用户ID
		String note_id = String.valueOf(params.get("note_id"));//贴子ID
		String ac_id = String.valueOf(params.get("ac_id"));//附件ID
		String plate_id = String.valueOf(params.get("plate_id"));//板块ID
		String title = String.valueOf(params.get("title"));//贴子标题
		String content = String.valueOf(params.get("content"));//贴子内容
		String pre_content = String.valueOf(params.get("pre_content"));//勾选回复可见，填写内容
		String type = String.valueOf(params.get("type"));//贴子类型
		String charge = String.valueOf(params.get("charge"));//下载附件是否收费  1:收费 
		String reply_look = String.valueOf(params.get("reply_look"));//内容是否回复可见 1：需回复可见
		String if_image = String.valueOf(params.get("if_image"));//是否有图片
		String if_video = String.valueOf(params.get("if_video"));//是否有视频
		
		if(StringUtils.isBlank(user_id)||StringUtils.isBlank(plate_id)||StringUtils.isBlank(title)
		||StringUtils.isBlank(content)||StringUtils.isBlank(type))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(note_id)){//保存
			BbsNote bbsNote = new BbsNote();
			note_id = UUIDGenerator.getUUID32();
			bbsNote.setId(note_id);
			bbsNote.setUser_id(user_id);
			bbsNote.setPlate_id(plate_id);
			bbsNote.setTitle(title);
			bbsNote.setContent(content);
			bbsNote.setIf_image(Integer.valueOf(if_image));
			bbsNote.setIf_video(Integer.valueOf(if_video));
			if("1".equals(reply_look)){
				bbsNote.setPre_content(pre_content);
				bbsNote.setIf_reply(1);
			}else{
				bbsNote.setIf_reply(2);
			}
			bbsNote.setType(type);
			msg = super.save(bbsNote);
			
			if(msg.isSuccess()){
				//贴子保存成功，若有需要上传附件内容，保存对应附件内容
				/*if(StringUtils.isNotBlank(ac_file_url)&&StringUtils.isNotBlank(ac_name)){
					this.saveBbsAccessories(user_id, note_id, charge, ac_name, ac_file_url, ac_price,ac_size);
				}*/
				if(attrcs!=null&&attrcs.size()>0){
					for (BbsAccessories acc : attrcs) {
						if(StringUtils.isNotBlank(acc.getFile_url())){
							acc.setUser_id(user_id);
							acc.setNote_id(note_id);
							saveBbsAccessories(acc);
						}
					}
				}
				//发送广场动态
				String usernick = userService.id2Name(user_id);
				messageResourceService.saveUserDynamicMessage(new Object[]{title,note_id}, "bbs.note.saveNote", user_id);
			}
		}else{//更新
			BbsNote old_bbsNote = super.getEntityById(note_id);
			old_bbsNote.setTitle(title);
			old_bbsNote.setContent(content);
			if("1".equals(reply_look)){
				old_bbsNote.setPre_content(pre_content);
				old_bbsNote.setIf_reply(1);
			}else{
				old_bbsNote.setPre_content(null);
				old_bbsNote.setIf_reply(2);
			}
			old_bbsNote.setUpdate_time(new Date());
			old_bbsNote.setIf_image(Integer.valueOf(if_image));
			old_bbsNote.setIf_video(Integer.valueOf(if_video));
			msg = super.update(old_bbsNote);
			if(msg.isSuccess()){
				if(attrcs!=null&&attrcs.size()>0){
					for (BbsAccessories acc : attrcs) {
						if(StringUtils.isNotBlank(acc.getFile_url())){
							acc.setUser_id(user_id);
							acc.setNote_id(note_id);
							saveBbsAccessories(acc);
						}
					}
				}
			}
		}
		
		return msg;
	}
	
	@Override
	public AjaxMsg saveVote(BbsVote bbsVote, BbsNote bbsNote, String[] names)throws Exception {
		String n_id = UUIDGenerator.getUUID();
		bbsNote.setId(n_id);
		bbsNote.setType("2");
		bbsNote.setIf_image(2);
		bbsNote.setIf_video(2);
		bbsNoteMapper.save(bbsNote);
		String v_id = UUIDGenerator.getUUID();
		bbsVote.setId(v_id);
		bbsVote.setNote_id(n_id);
		bbsNoteMapper.saveVote(bbsVote);
		for (int i=0;i<names.length;i++) {
			BbsVoteData bbsVoteData =  new BbsVoteData();
			bbsVoteData.setId(UUIDGenerator.getUUID());
			bbsVoteData.setSort(i);
			bbsVoteData.setName(names[i]);
			bbsVoteData.setVote_id(v_id);
			bbsNoteMapper.saveVoteData(bbsVoteData);
		}
		String usernick = userService.id2Name(bbsNote.getUser_id());
		messageResourceService.saveUserDynamicMessage(new Object[]{bbsNote.getTitle(),n_id}, "bbs.note.saveNote", bbsNote.getUser_id());
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	
	@Override
	public AjaxMsg updateVote(String[] ids,String user_id)throws Exception{
		for(int i=0;i<ids.length;i++){
			BbsVoteData bbsVoteData =  bbsNoteMapper.getVoteDate(ids[i]);
			bbsVoteData.setVote_count(bbsVoteData.getVote_count()+1);
			BbsVoteClick bbsVoteClick = new BbsVoteClick();
			bbsVoteClick.setId(UUIDGenerator.getUUID());
			bbsVoteClick.setUser_id(user_id);
			bbsVoteClick.setVotedata_id(bbsVoteData.getId());
			bbsNoteMapper.updateVoteData(bbsVoteData);
			bbsNoteMapper.saveVoteClick(bbsVoteClick);
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	
	@Override
	public boolean ifVote(String note_id,String user_id){
		List<BbsVoteClick> datas = bbsNoteMapper.getVoteClickByNoteIdAndUserId(note_id,user_id);
		if(datas.isEmpty()){
			return false;
		}else{
			return true;
		}
	}
	
	@Override
	public AjaxMsg saveBbsTip(BbsTip tip) {
		tip.setId(UUIDGenerator.getUUID());
	    bbsNoteMapper.saveTip(tip);
	    return  AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.error"));
	}

	@Resource(name = "fileRepository")
	private FileRepository fileRepository;
	
	/**
	 * 保存贴子附件
	 * @param user_id
	 * @param note_id
	 * @param charge
	 * @param ac_name
	 * @param ac_file_url
	 * @param ac_price
	 */
	private void saveBbsAccessories(BbsAccessories acc) throws Exception {
		acc.setId(UUIDGenerator.getUUID32());
		String ac_file_url = acc.getFile_url();
		String ext = ac_file_url.substring(ac_file_url.lastIndexOf(".")+1);
		File file = new File(fileRepository.getRealPath(ac_file_url));
		String url = fileRepository.storeByExt("attac", ext, file);
		acc.setFile_url(url);
		bbsNoteMapper.saveBbsAccessories(acc);
		ImageKit.delFile(fileRepository.getRealPath(ac_file_url));
	}
	@Override
	public BbsTip getTipById(String id) {
		return bbsNoteMapper.getTipById(id);
	}

	@Override
	public AjaxMsg saveOrUpateBbsNoteReplay(Map<String, Object> params)throws Exception {
		String user_id = String.valueOf(params.get("user_id"));//用户ID
		String reply_id = String.valueOf(params.get("reply_id"));//回复ID
		String note_id = String.valueOf(params.get("note_id"));//贴子ID
		String content = String.valueOf(params.get("content"));//回复内容
		
		if(StringUtils.isBlank(user_id)||StringUtils.isBlank(content)
			||StringUtils.isBlank(note_id))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		
		BbsNote bnote = bbsNoteMapper.getEntityById(note_id);
		if(bnote!=null){
			//判断该贴子是否被锁定，锁定的贴子不能进行回帖功能
			int if_lock = bnote.getIf_lock();
			if(if_lock==1)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("bbs.note.is_locked"));
		}
		
		if(StringUtils.isBlank(reply_id)){//保存
			BbsNoteReply last_bbsNoteReply = bbsNoteMapper.getLastBbsNoteReply(note_id);
			BbsNoteReply bbsNoteReply = new BbsNoteReply();
			if(last_bbsNoteReply!=null){
				bbsNoteReply.setFloor_num(last_bbsNoteReply.getFloor_num()+1);
			}else{
				bbsNoteReply.setFloor_num(2);
			}
			reply_id = UUIDGenerator.getUUID32();
			bbsNoteReply.setId(reply_id);
			bbsNoteReply.setContent(content);
			bbsNoteReply.setNote_id(note_id);
			bbsNoteReply.setUser_id(user_id);
			bbsNoteMapper.saveBBbsNoteReply(bbsNoteReply);
			String usernick = userService.id2Name(bnote.getUser_id());
			String v_usernick = userService.id2Name(user_id);
			messageResourceService.saveUserDynamicMessage(new Object[]{bnote.getUser_id(),usernick,bnote.getTitle(),bnote.getId()},
					"bbs.note.saveNoteReply", user_id);
			
			
		}else{//更新
			BbsNoteReply old_bnr = bbsNoteMapper.getBbsNoteReplyById(reply_id);
			if(old_bnr!=null){
				old_bnr.setContent(content);
				bbsNoteMapper.updateBbsNoteReply(old_bnr);
			}
		}
		//更新贴子最后回复者ID
		BbsNote bn = bbsNoteMapper.getEntityById(note_id);
			bn.setLast_reply_time(new Date());
			bn.setLast_reply_user_id(user_id);
		bbsNoteMapper.update(bn);	
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg queryTipsForPageSign(Map<String, Object> map, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(map!=null){
			if(pageModel!=null){
				count = countTips(map);
				pageModel.setTotalCount(count);
				map.put("start",pageModel.getFirstNum());
				map.put("rows",pageModel.getPageSize());
			}
			datas = bbsNoteMapper.queryTipsForPageSign(map);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}

	@Override
	public int countTips(Map<String, Object> maps) {
		return bbsNoteMapper.countTips(maps);
	}

	@Override
	public Map<String, Object> getBbsNoteById(String note_id,String user_id) {
		if(StringUtils.isNotBlank(note_id)){
			return bbsNoteMapper.getBbsNoteById(note_id,user_id);
		}
		return null;
	}

	@Override
	public PageModel queryBbsNoteReplys(Map<String, Object> params,PageModel pageModel) {
		List<Map<String, Object>> replys = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		int page = pageModel.getCurrent();
		if(params!=null){
			if(pageModel!=null){
				count = bbsNoteMapper.queryBbsNoteReplysCount(params);
				pageModel.setTotalCount(count);
				int size = count/pageModel.getPageSize();
				if(count%pageModel.getPageSize()!=0) size++;
				if(page>=size){
					pageModel.setCurrentPage(size);
				}
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}else{
				pageModel = new PageModel();
			}
			replys = bbsNoteMapper.queryBbsNoteReplys(params);
			pageModel.setItems(replys);
			return pageModel;
		}
		return null;
	}

	@Override
	public AjaxMsg getVoteDataByNoteId(String note_id) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		List<Map<String,Object>>datas = Lists.newArrayList();
		datas = bbsNoteMapper.getVoteDataByNoteId(note_id);
		return msg.addData("datas", datas);
	}

	@Override
	public AjaxMsg updateBbsTip(BbsTip tip) {
		bbsNoteMapper.updateTip(tip);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg updatePraise(BbsPraise params) throws Exception {
		String state = params.getState().toString();
		String bid = params.getB_id();
		String type = params.getType().toString();
		if(StringUtils.isNotBlank(state)){
			List<Map<String, Object>> praise = bbsNoteMapper.queryPraise(params);
			List<String> praises = bbsNoteMapper.praiseCount(bid);
			int num = 0;
			int count = "1".equals(state)?Integer.parseInt(praises.get(0)):Integer.parseInt(praises.get(1));
			int flag = 1;
			if(praise!=null&&praise.size()>0){
				num = bbsNoteMapper.deletePraise(params);
				count = count>0?count-1:0;
				flag = 0;
			}else{
				params.setId(UUIDGenerator.getUUID());
				num = bbsNoteMapper.savePraise(params);
				count = count+1;
			}
			if("1".equals(type)){
				BbsNote note = bbsNoteMapper.getEntityById(bid);
				if("1".equals(state)){
					note.setPriase_count(count);
				}else{
					note.setUnpriase_count(count);
				}
				bbsNoteMapper.update(note);
			}else{
				BbsNoteReply reply = bbsNoteMapper.getBbsNoteReplyById(bid);
				if("1".equals(state)){
					reply.setPriase_count(count);
				}else{
					reply.setUnpriase_count(count);
				}
				bbsNoteMapper.updateBbsNoteReply(reply);
			}
			if(num>0){
				return AjaxMsg.newSuccess().addData("praiseCount", count).addData("flag", flag);
			}
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg saveChargeInfo(Map<String,Object> params)throws Exception{
		String user_id = String.valueOf(params.get("user_id"));
		String note_id = String.valueOf(params.get("note_id"));
		String amount = String.valueOf(params.get("amount"));
		String acc_id = String.valueOf(params.get("acc_id"));
		if(StringUtils.isBlank(user_id)||StringUtils.isBlank(note_id)||StringUtils.isBlank(amount)||StringUtils.isBlank(acc_id))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		
		//获取当前用户可用资金宇拓币
		UserAmount userAmount = userAmountMapper.getByUserId(user_id);
		//判断资金用户是否可用
		if(userAmount.getStatus()==2)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.amount.freeze"));
		
		BigDecimal sum_amount = userAmount.getAmount();//剩余总金额
		BigDecimal real_amount = userAmount.getReal_amount();//可用金额
		BigDecimal buy_amount = new BigDecimal(amount);//购买总价
		
		if(real_amount.compareTo(buy_amount)<0)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.amount.not_enough"));
		//保存购买贴子附件记录
		BbsChargeInfo bbsChargeInfo = new BbsChargeInfo();
		bbsChargeInfo.setId(UUIDGenerator.getUUID32());
		bbsChargeInfo.setAmount(buy_amount);
		bbsChargeInfo.setNote_id(note_id);
		bbsChargeInfo.setUser_id(user_id);
		bbsChargeInfo.setAcc_id(acc_id);
		bbsNoteMapper.saveChargeInfo(bbsChargeInfo);
		
		//更新可用余额
		userAmount.setAmount(sum_amount.subtract(buy_amount));
		userAmount.setReal_amount(real_amount.subtract(buy_amount));
		userAmountMapper.update(userAmount);
		
		//保存用户订单信息
		Order order = new Order();
		order.setId(UUIDGenerator.getUUID());
		order.setMount(1);
		order.setNum_str(Common.createOrderOSN());
		order.setP_code("note");
		order.setPrice(buy_amount);
		order.setSum_amount(buy_amount);
		order.setUser_id(user_id);
		orderMapper.save(order);
		
		//插入消费记录
		PayCost pc = new PayCost();
		pc.setId(UUIDGenerator.getUUID());
		pc.setAmount(buy_amount);
		pc.setDescrible("购买贴子附件");
		pc.setNum_str(Common.createOrderOSN());
		pc.setStatus(1);
		pc.setOrder_id(order.getId());
		pc.setUser_id(user_id);
		pc.setP_code("note");
		payCostMapper.save(pc);
		
		
		//购买附件的钱直接转入到上传附件用户资金账户中
		BbsNote bbsNote = bbsNoteMapper.getEntityById(note_id);
		if(bbsNote!=null){
			String bbs_user_id = bbsNote.getUser_id();
			String user_nick = userService.id2Name(user_id);
			UserAmount bbsAmount = userAmountMapper.getByUserId(bbs_user_id);
			if(bbsAmount!=null){
				bbsAmount.setAmount(bbsAmount.getAmount().add(buy_amount));
				bbsAmount.setReal_amount(bbsAmount.getReal_amount().add(buy_amount));
				userAmountMapper.update(bbsAmount);
				messageResourceService.saveMessageNoReply(new Object[]{user_id,user_nick,buy_amount}, "bbs.note.buyInfo", bbs_user_id, user_id, 1);
			}
		}
		
		return AjaxMsg.newSuccess().addData("data", bbsChargeInfo).addMessage(messageResourceService.getMessage("bbs.note.buySuccess"));
	}

	@Override
	public AjaxMsg getBbsChargeInfoByIds(String user_id, String note_id) {
		if(StringUtils.isBlank(user_id)||StringUtils.isBlank(note_id))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		List<BbsChargeInfo> bcis = bbsNoteMapper.getBbsChargeInfoByIds(user_id, note_id);
		return AjaxMsg.newSuccess().addData("data", bcis);
	}

	@Override
	public AjaxMsg getBbsTipById(String id) {
		if(StringUtils.isNotBlank(id)){
			BbsTip t = (BbsTip) bbsNoteMapper.getBbsTipById(id);
			if(t!=null){
				return AjaxMsg.newSuccess().addData("data", t);
			}
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg updateBbsNoteIf(BbsNote note) {
		bbsNoteMapper.updateBbsNoteIf(note);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg updateBbsNotewriteContent(String id) {
		bbsNoteMapper.updateBbsNotewriteContent(id);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public BbsPlate getPlateById(String id) {
		return bbsNoteMapper.getPlateById(id);
	}

	@Override
	public int queryTipsCountByReplyIdAndNoteId(Map<String, Object> params) {
		return bbsNoteMapper.queryTipsCountByReplyIdAndNoteId(params);
	}

	@Override
	public AjaxMsg queryPlateList() {
		AjaxMsg msg = AjaxMsg.newSuccess();
		Map<String,Object> pMap = Maps.newHashMap();
		List pList = null;
		List<SysDict> dicts = sysDictMapper.dictList("p_plate_type");
		List<Map<String,Object>> plates = bbsNoteMapper.queryPlateList();
		for(SysDict dict: dicts){
			pList = Lists.newArrayList();
			for (Map<String, Object> plateMap : plates) {
				if(dict.getDict_value().equals(plateMap.get("type"))){
					pList.add(plateMap);
				}
			}
			pMap.put(dict.getDict_value(), pList);
		}
		return msg.addData("pMap", pMap);
	}

	@Override
	public AjaxMsg savePlate(BbsPlate bbsPlate)throws Exception {
		bbsNoteMapper.savePlate(bbsPlate);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg updatePlate(BbsPlate bbsPlate)throws Exception{
		bbsNoteMapper.updatePlate(bbsPlate);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg deletePlate(String id) throws Exception {
		bbsNoteMapper.deletePlate(id);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg queryLeaderList(String id) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		List<Map<String,Object>> datas = Lists.newArrayList();
		datas = bbsNoteMapper.queryLeaderList(id);
		return msg.addData("rf", datas);
	}

	@Override
	public List<BbsAccessories> getBbsAccessoriesByNoteId(String note_id) {
		
		return bbsNoteMapper.getBbsAccessoriesByNoteId(note_id);
	}

	@Override
	public int getBuyBbsChargeCountByNoteId(String note_id) {
		return bbsNoteMapper.getBuyBbsChargeCountByNoteId(note_id);
	}

	@Override
	public int getBbsNoteReplyCountByIds(String note_id, String user_id) {
		return bbsNoteMapper.getBbsNoteReplyCountByIds(note_id, user_id);
	}

	@Override
	public AjaxMsg updateBbsLeader(BbsLeader bbsLeader) throws Exception {
		bbsNoteMapper.updateBbsLeader(bbsLeader);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg saveBbsLeader(BbsLeader bbsLeader) throws Exception {
		bbsNoteMapper.saveBbsLeader(bbsLeader);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg deleteBbsLeader(String id) throws Exception {
		bbsNoteMapper.deleteBbsLeader(id);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public BbsLeader getBbsLeaderById(String id) {
		BbsLeader bbsLeader = bbsNoteMapper.getBbsLeaderById(id);
		return bbsLeader;
	}

	@Override
	public AjaxMsg updateBbsAccessories(String ac_id) {
		if(StringUtils.isBlank(ac_id))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		BbsAccessories accessories = bbsNoteMapper.getBbsAccessoriesById(ac_id);
		int downloadCount = accessories.getDownload();
		accessories.setDownload(downloadCount+1);
		bbsNoteMapper.updateBbsAccessories(accessories);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg deleteNoteBYOwner(String user_id,String plate_id, String note_id) {
		if(StringUtils.isBlank(user_id)||StringUtils.isBlank(plate_id)||StringUtils.isBlank(note_id))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		//判断当前用户是否是版主，若是版主，贴子未被锁定就可以删除
		//BbsLeader bbsLeader = bbsNoteMapper.getBbsLeaderByUserID(user_id, plate_id);
		boolean flag = this.ifLeader(user_id, plate_id);
		if(flag == true){
			BbsNote bbsNote = bbsNoteMapper.getEntityById(note_id);
			return this.updateNoteStatusforDel(bbsNote);
		}else{
			//判断该贴子是否为当前用户发布，若是当前用户发布，贴子未被锁定可以直接删除
			BbsNote bbsNote = bbsNoteMapper.getBbsNoteByNoteIdUserID(note_id, user_id);
			return this.updateNoteStatusforDel(bbsNote);
		}
		
	}

	/**
	 * 更新贴子状态为已删除状态
	 * @param bbsNote
	 * @return
	 */
	private AjaxMsg updateNoteStatusforDel(BbsNote bbsNote) {
		if(bbsNote!=null){
			int lock = bbsNote.getIf_lock();
			if(lock==2){
				bbsNote.setIf_del(1);
				bbsNoteMapper.update(bbsNote);
				return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
			}
		}
		return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
	}

	@Override
	public boolean checkIfVote(String note_id, String user_id) {
		List<BbsVoteClick> listClick = bbsNoteMapper.getVoteClickByNoteIdAndUserId(note_id,user_id);
		if(listClick.isEmpty()){
			return false;
		}
		return true;
	}

	@Override
	public AjaxMsg saveVoteClick(String ids, String user_id, String note_id)throws Exception {
		String[] id = ids.split(",");
		for (int i = 0; i < id.length; i++) {
			BbsVoteClick bbsVoteClick = new BbsVoteClick();
			bbsVoteClick.setId(UUIDGenerator.getUUID());
			bbsVoteClick.setVotedata_id(id[i]);
			bbsVoteClick.setUser_id(user_id);
			bbsNoteMapper.saveVoteClick(bbsVoteClick);
			bbsNoteMapper.updateVoteDataCount(id[i]);
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg deleteNoteReply(String reply_id, String user_id,String plate_id,String note_id) {
		if(StringUtils.isBlank(user_id)||StringUtils.isBlank(reply_id)||StringUtils.isBlank(note_id))return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		//判断当前用户是否是版主，若是版主，贴子未被锁定就可以删除
		//BbsLeader bbsLeader = bbsNoteMapper.getBbsLeaderByUserID(user_id, plate_id);
		boolean flag = this.ifLeader(user_id, plate_id);
		if(flag == true){
			BbsNote bbsNote = bbsNoteMapper.getEntityById(note_id);
			int lock = bbsNote.getIf_lock();
			if(lock==2){
				BbsNoteReply bbsNoteReply = bbsNoteMapper.getBbsNoteReplyById(reply_id);
				if(bbsNoteReply!=null){
					bbsNoteReply.setIf_del(2);
					bbsNoteMapper.updateBbsNoteReply(bbsNoteReply);
					return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
				}
			}
		}else{
			//判断当前用户是否是该贴子回复作者，若是，贴子未被锁定就可以删除
			BbsNote bbsNote = bbsNoteMapper.getEntityById(note_id);
			int lock = bbsNote.getIf_lock();
			if(lock==2){
				BbsNoteReply bbsNoteReply = bbsNoteMapper.getBbsNoteReplyById(reply_id);
				if(bbsNoteReply!=null){
					String reply_user_id = bbsNoteReply.getUser_id();
					if(reply_user_id.equals(user_id)){
						bbsNoteReply.setIf_del(2);
						bbsNoteMapper.updateBbsNoteReply(bbsNoteReply);
						return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
					}
				}
			}
		}
		return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
	}

	@Override
	public AjaxMsg getBbsNoteReplyById(String rid) {
		if(StringUtils.isNotBlank(rid)){
			BbsNoteReply reply = bbsNoteMapper.getBbsNoteReplyById(rid);
			if(reply!=null){
				return AjaxMsg.newSuccess().addData("reply", reply);
			}
		}
		return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
	}

	@Override
	public boolean ifLeader(String user_id, String plate_id) {
		BbsLeader bbsLeader = bbsNoteMapper.getBbsLeaderByUserID(user_id, plate_id);
		boolean flag = false;
		if(null != bbsLeader && !("").equals(BeanUtils.nullToString(bbsLeader.getUser_id()))){
			Date nowDate = new Date();
			flag = Common.compareDates(nowDate, bbsLeader.getDuty_time());
		}
		return flag;
	}

	@Override
	public AjaxMsg deleteAccessories(String aid) {
		/*try {
			BbsAccessories acc = bbsNoteMapper.getBbsAccessoriesById(aid);
			if(acc!=null){
				bbsNoteMapper.deleteAccessories(aid);
				ImageKit.delFile(fileRepository.getRealPath(acc.getFile_url()));
			}
			return AjaxMsg.newSuccess();
		} catch (Exception e) {
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		}*/
		bbsNoteMapper.deleteAccessories(aid);
		return AjaxMsg.newSuccess();
	}

	@Override
	public int queryBbsNoteTopCount(String plate_id) {
		return bbsNoteMapper.queryBbsNoteTopCount(plate_id);
	}

	@Override
	public int getBuyBbsChargeCountByIDs(String note_id, String acc_id) {
		return bbsNoteMapper.getBuyBbsChargeCountByIDs(note_id, acc_id);
	}

	@Override
	public List<String> getAccIDFromBbsCharge(String user_id, String note_id) {
		return bbsNoteMapper.getAccIDFromBbsCharge(user_id, note_id);
	}
	
}

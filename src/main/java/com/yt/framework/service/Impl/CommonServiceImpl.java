package com.yt.framework.service.Impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yt.framework.mapper.CommonMapper;
import com.yt.framework.persistent.entity.IvComment;
import com.yt.framework.persistent.entity.MsgHistory;
import com.yt.framework.persistent.entity.PageCount;
import com.yt.framework.persistent.entity.UserComment;
import com.yt.framework.service.CommonService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

/**
 * @Title: CommonServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author GL
 * @date 2015年8月11日 下午3:40:56 
 */
@Service(value="commonService")
public class CommonServiceImpl implements CommonService{
	
	protected static Logger logger = LogManager.getLogger(CommonServiceImpl.class);
	
	@Autowired
	private CommonMapper commonMapper;
	@Autowired
	private UserService userService;
	@Autowired
	private MessageResourceService messageResourceService;

	@Override
	public AjaxMsg queryIvComments(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = ivCommentCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = commonMapper.queryIvComments(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public int ivCommentCount(Map<String, Object> params) {
		return commonMapper.ivCommentCount(params);
	}

	@Override
	public AjaxMsg replyIvComment(IvComment comment) {
		if(comment.getUser_id()!=null&&comment.getIv_id()!=null){
			int num = commonMapper.replyIvComment(comment);
			if(num==1){
				AjaxMsg.newSuccess();
			}
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg savePraiseIv(Map<String, Object> params) throws Exception {
		String ivId = params.get("iv_id")!=null?params.get("iv_id").toString():"";
		if(StringUtils.isNotBlank(ivId)){
			if(StringUtils.isBlank(params.get("id").toString())){
				params.put("id", UUIDGenerator.getUUID());
			}
			int num = commonMapper.savePraiseRecord(params);
			int numIv = commonMapper.praiseIv(ivId);
			if(num!=1||numIv!=1){
				throw new RuntimeException();
			}
		}
		return AjaxMsg.newSuccess();
	}
	@Override
	public List<Map<String, Object>> queryIndexImages(){
		return commonMapper.queryIndexImages();
	}


	@Override
	public AjaxMsg saveMsgHistory(MsgHistory msgHistory) {
		msgHistory.setId(UUIDGenerator.getUUID());
		int num = commonMapper.saveMsgHistory(msgHistory);
		if(num>0){
			return AjaxMsg.newSuccess();
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg queryUserComments(Map<String, Object> params,
			PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = commonMapper.userCommentsCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = commonMapper.queryUserComments(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg queryUserCommentChilds(Map<String, Object> params,
			PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = commonMapper.userCommentChildsCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = commonMapper.queryUserCommentChilds(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg saveUserComment(UserComment comment,String type) throws Exception{
		comment.setId(UUIDGenerator.getUUID());
		int num = commonMapper.saveUserComment(comment);
		String username = userService.id2Name(comment.getUser_id());
		if(StringUtils.isNotBlank(type)){
			messageResourceService.saveMessageNoReply(new Object[]{username}, "user.player.comment", comment.getS_user_id(), comment.getUser_id(),1);
		}else{
			username = userService.id2Name(comment.getC_user_id());
			messageResourceService.saveMessageNoReply(new Object[]{username,comment.getC_user_id()}, "user.player.reply", comment.getS_user_id(), comment.getUser_id(),1);
		}
		return AjaxMsg.newSuccess().addData("comment", comment);
	}

	@Override
	public AjaxMsg deleteUserComment(String id) {
		int num = commonMapper.deleteUserComment(id);
		return AjaxMsg.newSuccess();
	}
	
	@Override
	public AjaxMsg savePageCount(PageCount pageCount) {
		if(pageCount!=null){
			String user_id = pageCount.getUser_id();
			String code_str = pageCount.getCode_str();
			if(StringUtils.isNotBlank(user_id)&&StringUtils.isNotBlank(code_str)){
				PageCount old_pageCount =  commonMapper.getPageCount(user_id, code_str);
				int count = 0;
				if(old_pageCount!=null){
					count = old_pageCount.getCount();
					count=count+1;
					old_pageCount.setCount(count);
					commonMapper.updatePageCount(old_pageCount);
					return AjaxMsg.newSuccess().addData("pageCount", old_pageCount);
				}else{
					Random random = new Random();
					count = random.nextInt(200);
					pageCount.setId(UUIDGenerator.getUUID32());
					pageCount.setCount(count);
					commonMapper.savePageCount(pageCount);
					return AjaxMsg.newSuccess().addData("pageCount", pageCount);
				}
				
			}
		}
		return AjaxMsg.newError();
	}

	@Override
	public int getPageCount(String user_id, String code_str) {
		return 0;
	}

}


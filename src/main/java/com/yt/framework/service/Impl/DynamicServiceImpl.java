package com.yt.framework.service.Impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yt.framework.mapper.CommonMapper;
import com.yt.framework.mapper.TeamInfoMapper;
import com.yt.framework.mapper.UserMapper;
import com.yt.framework.persistent.entity.Comment;
import com.yt.framework.persistent.entity.ComparatorDynamicMsg;
import com.yt.framework.persistent.entity.Dynamic;
import com.yt.framework.persistent.entity.DynamicMsg;
import com.yt.framework.persistent.entity.Message;
import com.yt.framework.persistent.entity.TeamDynamic;
import com.yt.framework.persistent.entity.TeamInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.service.DynamicService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.EhCache;
import com.yt.framework.utils.EhCacheObj;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.gson.JSONUtils;

/**
 * @Title: DynamicServiceImpl.java 
 * @Package com.yt.framework.service.Impl
 * @author GL
 * @date 2015年8月11日 下午3:41:01 
 */
@Service(value="dynamicService")
public class DynamicServiceImpl extends BaseServiceImpl<Dynamic> implements DynamicService{
	
	protected static Logger logger = LogManager.getLogger(DynamicServiceImpl.class);

	@Autowired
	private UserService userService;
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private CommonMapper commonMapper;
	@Autowired
	private TeamInfoMapper teamInfoMapper;

	@Override
	public AjaxMsg queryComments(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = commentCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			datas = dynamicMapper.queryComments(params);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}

	@Override
	public int commentCount(Map<String, Object> params) {
		return dynamicMapper.commentCount(params);
	}

	@Override
	public AjaxMsg replyComment(Comment comment) {
		if(comment.getUser_id()!=null&&comment.getDynamic_id()!=null){
			if(StringUtils.isBlank(comment.getId())){
				comment.setId(UUIDGenerator.getUUID());
			}
			int num = dynamicMapper.replyComment(comment);
			if(num==1){
				return AjaxMsg.newSuccess();
			}
		}
		return AjaxMsg.newError();
	}
	
	@Override
	public AjaxMsg queryDynamics(Map<String, Object> params, PageModel pageModel) {
		AjaxMsg msg = queryForPageForMap(params,pageModel);
		if(msg!=null){
			pageModel = (PageModel) msg.getData("page");
			List<Map<String, Object>> dyns = pageModel.getItems();
			for (Map<String, Object> map : dyns) {
				String dtype = map.get("dtype")!=null?map.get("dtype").toString():"";
				if(StringUtils.isNotBlank(dtype)&&(!"0".equals(dtype))){
					//查询评论条数
					String did = map.get("id").toString();
					Map<String, Object> cparams = new HashMap<String,Object>();
					cparams.put("dynId", did);
					int comCount = commentCount(cparams);
					map.put("comCount", comCount);
				}
			}
			return msg;
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg queryMyDynamic(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		String userId = params.get("id").toString()!=null?params.get("id").toString():null;
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = dynamicMapper.myDataCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			List<Map<String, Object>> dyns = dynamicMapper.queryMyDynamic(params);
			if(dyns!=null&&dyns.size()>0){
				for (Map<String, Object> map : dyns) {
					//查询评论条数
					String did = map.get("id").toString();
					Map<String, Object> cparams = new HashMap<String,Object>();
					cparams.put("dynId", did);
					int comCount = commentCount(cparams);
					map.put("comCount", comCount);
					datas.add(map);
				}
			}
			pageModel.setItems(datas);
			Map<String, Object> dynCount = getDynCount(userId);
			return AjaxMsg.newSuccess().addData("page", pageModel).addData("dynCount", dynCount);
		}
		return AjaxMsg.newError();
	}
	
	private Map<String, Object> getDynCount(String userId){
		if(StringUtils.isNotBlank(userId)){
			List<String> counts = dynamicMapper.dynCount(userId);
			Map<String, Object> count = new HashMap<String, Object>();
			count.put("gznum", counts.get(0));
			count.put("bgznum", counts.get(1));
			count.put("dtnum", counts.get(2));
			return count;
		}
		return null;
	}

	@Override
	public AjaxMsg dynCount(String userId) {
		if(StringUtils.isNotBlank(userId)){
			List<String> counts = dynamicMapper.dynCount(userId);
			Map<String, Object> count = new HashMap<String, Object>();
			count.put("gznum", counts.get(0));
			count.put("bgznum", counts.get(1));
			count.put("dtnum", counts.get(2));
			return AjaxMsg.newSuccess().addData("data", count);
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg savePraiseDyn(Map<String, Object> params) throws Exception {
		String dynId = params.get("dynamic_id")!=null?params.get("dynamic_id").toString():"";
		if(StringUtils.isNotBlank(dynId)){
			List<Map<String, Object>> prs = commonMapper.queryPraiseRecord(params);
			Dynamic dyn = dynamicMapper.getEntityById(dynId);
			int num = 0;
			int numDyn = 0;
			int count = dyn.getPraise_count();
			int flag = 1;
			if(prs!=null&&prs.size()>0){
				num = commonMapper.deletePraiseRecord(params);
				count = count>0?count-1:0;
				numDyn = dynamicMapper.praiseDyn(dynId,count);
				flag = 0;
			}else{
				if(StringUtils.isBlank(params.get("id").toString())){
					params.put("id", UUIDGenerator.getUUID());
				}
				num = commonMapper.savePraiseRecord(params);
				count = count+1;
				numDyn = dynamicMapper.praiseDyn(dynId,count);
			}
			if(num!=1||numDyn!=1){
				throw new RuntimeException();
			}
			return AjaxMsg.newSuccess().addData("praiseCount", count).addData("flag", flag);
		}
		return AjaxMsg.newError();
	}

	@Override
	public AjaxMsg queryHotDynamic() {
		List<Map<String, Object>> datas = dynamicMapper.queryHotDynamic(null);
		return AjaxMsg.newSuccess().addData("players", datas);
	}
	
	@Override
	public List<Map<String, Object>> queryHotTeamDynamicList(Map<String,Object> maps) {
		List<Map<String, Object>> datas = dynamicMapper.queryHotTeamDynamic(maps);
		return datas;
	}
	
	@Override
	public List<Map<String, Object>> queryHotDynamicList(Map<String,Object> maps) {
		List<Map<String, Object>> datas = dynamicMapper.queryHotDynamic(maps);
		return datas;
	}

	@Override
	public AjaxMsg deleteDynamic(String did) {
		try {
			dynamicMapper.deleteDynamic(did);
			return AjaxMsg.newSuccess();
		} catch (Exception e) {
			return AjaxMsg.newError();
		}
	}

	@Override
	public void saveTeamDynamic(TeamDynamic teamDynamic) {
		if(StringUtils.isBlank(teamDynamic.getId())){
			teamDynamic.setId(UUIDGenerator.getUUID());
		}
		dynamicMapper.saveTeamDynamic(teamDynamic);
		EhCache.getInstance().setNewDynamic(true);
	}

	@Override
	public int queryHotDynamicCount(Map<String, Object> maps) {
		return dynamicMapper.queryHotDynamicCount(maps);
		
	}

	@Override
	public int queryHotTeamDynamicCount(Map<String, Object> maps) {
		return dynamicMapper.queryHotTeamDynamicCount(maps);
		
	}

	@Override
	public AjaxMsg queryNewDynamic(Map<String, Object> params, PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		String userId = params.get("id")!=null?params.get("id").toString():null;
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = dynamicMapper.newDataCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			List<Map<String, Object>> dyns = dynamicMapper.queryNewDynamic(params);
			if(dyns!=null&&dyns.size()>0){
				for (Map<String, Object> map : dyns) {
					//查询评论条数
					String did = map.get("id").toString();
					Map<String, Object> cparams = new HashMap<String,Object>();
					cparams.put("dynId", did);
					int comCount = commentCount(cparams);
					map.put("comCount", comCount);
					datas.add(map);
				}
			}
			pageModel.setItems(datas);
			Map<String, Object> dynCount = getDynCount(userId);
			return AjaxMsg.newSuccess().addData("page", pageModel).addData("dynCount", dynCount);
		}
		return AjaxMsg.newError();
	}

	@Override
	public List<DynamicMsg> queryTopDynamics(int size) {
		List<Dynamic> retls = dynamicMapper.queryTopDynamics(size);
		List<DynamicMsg> retLs = new ArrayList<DynamicMsg>();
		for (Dynamic dy : retls) {
			retLs.add(0, transformationDynamic(dy));
		}
		return retLs;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public AjaxMsg queryNewTeamDynamic(Map<String, Object> maps,PageModel pageModel) {
		if(pageModel!=null){
			maps.put("start",pageModel.getFirstNum());
			maps.put("rows",pageModel.getPageSize());
		}else{
			pageModel = new PageModel();
			pageModel.setPageSize(10);
			maps.put("start",pageModel.getFirstNum());
			maps.put("rows",pageModel.getPageSize());
		}
		dynamicMapper.queryNewTeamDynamicCount(maps);
		List<Map<String,Object>> result = dynamicMapper.queryNewTeamDynamic(maps);
		pageModel.setItems(result);
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}

	@Override
	public List<DynamicMsg> queryDynamicsDef(Map<String, Object> params) {
		
		List<DynamicMsg> retLs = new ArrayList<DynamicMsg>();
		retLs.addAll(queryDynamicList(params));
//		retLs.addAll(queryMessageList(params));
		retLs.addAll(queryTeamDynamicList(params));
		return retLs;
	}

	private List<DynamicMsg> queryMessageList(Map<String, Object> params) {
		List<DynamicMsg> retLs = new ArrayList<DynamicMsg>();
		List<Message> ls = dynamicMapper.queryMessageDef(params);
		for (Message dy : ls) {
			User user = null;
			String userid = dy.getUser_id();
			DynamicMsg dymsg = new DynamicMsg();
			dymsg.setCreatetime(dy.getCreate_time().getTime());
			dymsg.setCreate_time(Common.formatDate24H(dy.getCreate_time()));
			dymsg.setDynamic_id(dy.getId());
			dymsg.setMsg_type("sys");
			dymsg.setText(dy.getContent());
			dymsg.setUser_id(userid);
			
			if (EhCache.getInstance().isCache(userid)) {
				EhCacheObj o = EhCache.getInstance().get(userid);
				user = (User) o.getObj();
			} else {
				user = userMapper.getEntityById(userid);
				if (user != null) {
					EhCache.getInstance().add(userid, new EhCacheObj(user));
				}
			}

			if (user != null) {
				dymsg.setUser_name("系统");
				dymsg.setUser_head_src(user.getHead_icon());
			}
			retLs.add(0, dymsg);
		}
		
		return retLs;
	}

	private List<DynamicMsg> queryTeamDynamicList(Map<String, Object> params) {
		List<DynamicMsg> retLs = new ArrayList<DynamicMsg>();
		List<TeamDynamic> ls = dynamicMapper.queryTeamDynamicDef(params);
		for (TeamDynamic dy : ls) {
			TeamInfo team = null;
			String teamid = dy.getTeaminfo_id();
			DynamicMsg dymsg = new DynamicMsg();
			dymsg.setCreatetime(dy.getCreate_time().getTime());
			dymsg.setCreate_time(Common.formatDate24H(dy.getCreate_time()));
			dymsg.setDynamic_id(dy.getId());
			dymsg.setMsg_type("sys");
			dymsg.setText(dy.getText());
			dymsg.setUser_id(dy.getTeaminfo_id());
			if(dy.getImage()!=null){
				dymsg.setImage_src(dy.getImage());
				dymsg.setImages(true);
			}
			
			if (EhCache.getInstance().isCache(teamid)) {
				EhCacheObj o = EhCache.getInstance().get(teamid);
				team = (TeamInfo) o.getObj();
			} else {
				team = teamInfoMapper.getTeamInfoById(teamid);
				if (team != null) {
					EhCache.getInstance().add(teamid, new EhCacheObj(team));
				}
			}

			if (team != null) {
				dymsg.setUser_name(team.getName());
				dymsg.setUser_head_src(team.getLogo());
			}
			retLs.add(0, dymsg);
		}
		return retLs;
	}

	private List<DynamicMsg> queryDynamicList(Map<String, Object> params) {
		List<Dynamic> ls = dynamicMapper.queryDynamicsDef(params);
		List<DynamicMsg> retLs = new ArrayList<DynamicMsg>();
		for (Dynamic dy : ls) {
			retLs.add(0, transformationDynamic(dy));
		}
		return retLs;
	}

	@Override
	public List<DynamicMsg> findNewMsg(Map<String, Object> params) {
		return loadNewMsg(params);
	}
	public List<DynamicMsg> loadNewMsg(Map<String, Object> params) {
		List<DynamicMsg> dynList = null;
		dynList = loadNewMsgs(params);
		if(dynList.size()==0){
			for (int i = 0; i < 15; i++) {
				dynList = loadNewMsgs(params);
				if (dynList.size()> 0) {
					break;
				} 
				try {
					Thread.sleep(700);
				} catch (Exception e) {
				}
			}
		}
		return dynList;
	}

	private List<DynamicMsg> loadNewMsgs(Map<String, Object> params) {
		if(EhCache.getInstance().isNewDynamic()){
			String sDate = EhCache.getInstance().getMaxDate();
			Map<String, Object> p = new HashMap<String, Object>();
			p.put("sDate", sDate);
			p.put("eDate", JSONUtils.formatDate(new Date(System.currentTimeMillis()+60000), null));
			List<DynamicMsg> retLs = new ArrayList<DynamicMsg>();
			retLs.addAll(queryDynamicList(p));
//			retLs.addAll(queryMessageList(p));
			retLs.addAll(queryTeamDynamicList(p));
			EhCache.getInstance().addDymsgList(retLs);
			List<DynamicMsg> dylist = EhCache.getInstance().getDymsgList();
			Collections.sort(dylist,new ComparatorDynamicMsg());
			EhCache.getInstance().setNewDynamic(false);
		}
		long lastTime=Long.parseLong((String) params.get("lastTime"));
		List<DynamicMsg> cachels= EhCache.getInstance().getDymsgNewList(lastTime);
		String loadData = (String) params.get("loadData");
		String userid = (String) params.get("userid");
		
		List<DynamicMsg> retList = new ArrayList<DynamicMsg>();
		if("news".equals(loadData)){
			for(DynamicMsg dymsg:cachels){
				DynamicMsg dd = dymsg.clone();
				retList.add(dd);
			}
		}else if("followers".equals(loadData)){
			if(userid!=null){
				List<String> userids = findMyFocus(userid);
				for(DynamicMsg dymsg:cachels){
					DynamicMsg dd = dymsg.clone();
					String dyuserid = dymsg.getUser_id();
					if(dyuserid.equals(userid)){
						retList.add(dd);
					}else if(userids.contains(dyuserid)){
						retList.add(dd);
					}
				}
			}
		}else if("my".equals(loadData)){
			for(DynamicMsg dymsg:cachels){
				DynamicMsg dd = dymsg.clone();
				if(dymsg.getUser_id().equals(userid)){
					retList.add(dd);
				}
			}
		}
		for(DynamicMsg dymsg:retList){
			if(dymsg.getUser_id().equals(userid)){
				dymsg.setMsg_me(true);
			}
		}
		return retList;
	}

	@Override
	public List<String> findMyFocus(String userid) {
		return userMapper.getFocusByUserId(userid);
	}


	public DynamicMsg transformationDynamic(Dynamic dy) {
		User user = null;
		String userid = dy.getUser_id();
		DynamicMsg dymsg = new DynamicMsg();
		dymsg.setCreatetime(dy.getCreate_time().getTime());
		dymsg.setCreate_time(dy.getCreate_time_format());
		dymsg.setDynamic_id(dy.getId());
		dymsg.setMsg_type("msg");
		dymsg.setText(dy.getText());
		dymsg.setUser_id(userid);
		if(dy.getImage()!=null){
			dymsg.setImage_src(dy.getImage());
			dymsg.setImages(true);
		}
		
		if (EhCache.getInstance().isCache(userid)) {
			EhCacheObj o = EhCache.getInstance().get(userid);
			user = (User) o.getObj();
		} else {
			user=EhCache.getInstance().addUserToCache(userService, userid);
		}

		if (user != null) {
			dymsg.setUser_type(user.getUser_type());
			dymsg.setUser_name(user.getUsernick());
			dymsg.setUser_head_src(user.getHead_icon());
		}
	
		return dymsg;
	}
}

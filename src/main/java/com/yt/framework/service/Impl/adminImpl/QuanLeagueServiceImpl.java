package com.yt.framework.service.Impl.adminImpl;

import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.googlecode.jsonrpc4j.JsonRpcHttpClient;
import com.yt.framework.mapper.admin.QuanLeagueMapper;
import com.yt.framework.persistent.entity.AdminEventRecord;
import com.yt.framework.persistent.entity.QMatchInfo;
import com.yt.framework.persistent.entity.QScoreInfo;
import com.yt.framework.persistent.entity.QSummaryInfo;
import com.yt.framework.persistent.entity.QSummaryList;
import com.yt.framework.persistent.entity.QUserData;
import com.yt.framework.persistent.entity.TeamLoanPlayer;
import com.yt.framework.persistent.entity.TeamPlayer;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.TeamInfoService;
import com.yt.framework.service.TeamLoanPlayerService;
import com.yt.framework.service.UserService;
import com.yt.framework.service.admin.AdminEventRecordService;
import com.yt.framework.service.admin.QuanLeagueService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Base64Util;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;

@Service(value="quanLeagueService")
public class QuanLeagueServiceImpl implements QuanLeagueService{
	
	protected static Logger logger = LogManager.getLogger(IndexModelServiceImpl.class);
	
	@Autowired
	private QuanLeagueMapper quanLeagueMapper;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired
	private TeamInfoService teamInfoService;
	@Autowired
	private AdminEventRecordService adminEventRecordService;
	@Autowired
	private UserService userService;
	@Autowired
	private TeamLoanPlayerService teamLoanPlayerService;
	
	@Override
	public AjaxMsg saveQMatchInfo(QMatchInfo match) {
		quanLeagueMapper.saveQMatchInfo(match);
		 return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public QMatchInfo getMatchInfoByMatchId(String matchId) {
		return quanLeagueMapper.getMatchInfoByMatchId(matchId);
	}
	@Override
	public AjaxMsg updateQMatchInfo(QMatchInfo match) {
		quanLeagueMapper.updateQMatchInfo(match);
		//批量保存
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public AjaxMsg saveQSummaryInfo(QSummaryInfo qSummary) {
		quanLeagueMapper.saveQSummaryInfo(qSummary);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public AjaxMsg saveQUserDataInfo(QUserData qUserData) {
		quanLeagueMapper.saveQUserDataInfo(qUserData);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public QMatchInfo getMatchInfoById(String id) {
		return quanLeagueMapper.getMatchInfoById(id);
	}
	@Override
	public AjaxMsg deleteQmatchDatasByQmatchId(String qmatchId) {
		List<QSummaryInfo> list = quanLeagueMapper.getQSummaryListByQmatchId(qmatchId, null);
		if(!list.isEmpty()){
			quanLeagueMapper.deleteQSummaryInfoByQmatchId(qmatchId);
			quanLeagueMapper.deleteQUserDataByQmatchId(qmatchId);
			quanLeagueMapper.deleteQScoreInfoByQmatchId(qmatchId);
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public List<Map<String, Object>> queryQplayers(Map<String, Object> params) {
		List<Map<String, Object>> players = quanLeagueMapper.queryQplayers(params);
		return players;
	}
	@Override
	public AjaxMsg updateAllQUserData(List<QUserData> userDatas) {
		for (QUserData qUserData : userDatas) {
			int num = quanLeagueMapper.updateAllQUserData(qUserData);
			String qid = qUserData.getId();
			String uid = qUserData.getRel_palyer_id();
			int s_num = quanLeagueMapper.updateQScoreUserId(qid,uid);
		}
		return AjaxMsg.newSuccess();
	}
	@Override
	public List<QUserData> getQUserDataListByQmatchId(String qmatchId, String teamId) {
		Map<String,Object> params = Maps.newHashMap();
		params.put("q_match_id", qmatchId);
		params.put("team_id",teamId);
		return quanLeagueMapper.getQUserDataListByQmatchId(params);
	}
	@Override
	public AjaxMsg updateQUserData(QUserData qUserData) {
		quanLeagueMapper.updateQUserData(qUserData);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public List<QSummaryInfo> getQSummaryListByQmatchId(String qmatchId,String teamId) {
		return quanLeagueMapper.getQSummaryListByQmatchId(qmatchId,teamId);
	}
	@Override
	public AjaxMsg saveQScoreInfo(QScoreInfo scoreInfo) {
		quanLeagueMapper.saveQScoreInfo(scoreInfo);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	
	@Override
	public AjaxMsg updateQScoreInfo(QScoreInfo scoreInfo)throws Exception{
		quanLeagueMapper.updateQScoreInfo(scoreInfo);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	
	@Override
	public QUserData getQUserDataByPlayerId(String q_match_id,String player_id) {
		return quanLeagueMapper.getQUserDataByPlayerId(q_match_id,player_id);
	}
	@Override	
	public AjaxMsg updateQSummaryInfo(QSummaryInfo info)throws Exception {
		quanLeagueMapper.updateQSummaryInfo(info);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public AjaxMsg modifyQMatchInfos(String urlAddress,String gameId,String key,String league_id){
		AjaxMsg msg = AjaxMsg.newError();
		Map<String,Object> params = Maps.newHashMap();
		String matchId = BeanUtils.nullToString(gameId);
		QMatchInfo qmatchInfo = getMatchInfoByMatchId(matchId);
		params.put("matchId", gameId);
		params.put("urlAddress", urlAddress);
		params.put("key", key);
		params.put("league_id", league_id);
		
		if(qmatchInfo != null){
			if(qmatchInfo.getStatus() != 2){//如果数据已经发布就不可以重新获取数据
				deleteQmatchDatasByQmatchId(qmatchInfo.getId());
				AjaxMsg ajaxMsg = getMatchInfoToAdd(params,qmatchInfo);
				if(ajaxMsg.isSuccess()){
					/**匹配球队及球赛相关信息*/
					AjaxMsg ajaxValidate = validateTeamInfo(qmatchInfo.getId());
					if(ajaxValidate.isSuccess()){
						logger.info("匹配球队及球赛相关信息成功");
					}
					/**匹配球员相关信息*/
					AjaxMsg ajaxValidatePlayers = validatePlayerInfos(qmatchInfo.getId());
					if(ajaxValidatePlayers.isSuccess()){
						logger.info("匹配球员相关信息成功");
					}
					msg = AjaxMsg.newSuccess();
				}
			}
		}

		return	msg;
	}
	
	/**
	 * <p>Description: 得到赛事信息并添加相应数据</p>
	 * @Author zhangwie
	 * @Date 2015年12月23日 下午7:10:31
	 * @param maps
	 * @param qmatchInfo
	 * @return
	 */
	public AjaxMsg getMatchInfoToAdd(Map<String,Object> maps,QMatchInfo qmatchInfo){
		AjaxMsg ajax = AjaxMsg.newSuccess();
		String urlAddress = maps.get("urlAddress").toString();
		String gameId = maps.get("matchId").toString();
		String key = maps.get("key").toString();
		String league_id = BeanUtils.nullToString(maps.get("league_id"));
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			if(qmatchInfo != null ){//接口赛事id已存在
				JSONObject user_json = findMatchInfosBymatchId(urlAddress,gameId,key);
				Map<String,Object> datas = (Map<String, Object>) user_json.get("Data");
				boolean status = (boolean) user_json.get("Success");
				if(status){
					Map<String,Object> matchInfo = (Map<String, Object>) datas.get("matchInfo");//获取matchInfo 对象
					String homeId = BeanUtils.nullToString(matchInfo.get("home"));
					String visitId = BeanUtils.nullToString(matchInfo.get("visiting"));
					String dateTimeStr = matchInfo.get("date")+" "+matchInfo.get("time");
					
					Map<String,Object> homeTeam = (Map<String, Object>)datas.get("homeTeam");//获取主队homeTeam对象值
					String homeName = homeTeam.get("name").toString();
					
					Map<String,Object> visitTeam = (Map<String, Object>)datas.get("visitTeam");//获取客队visitTeam对象值
					String visitName = visitTeam.get("name").toString();
					
					Map<String,Object> venueInfo = (Map<String, Object>)datas.get("venueInfo");//获取场地venueInfo对象值
					String spaceName = venueInfo.get("name").toString();
					String spaceAddress = venueInfo.get("address").toString();
					
					qmatchInfo.setHome_id(homeId);
					qmatchInfo.setVisit_id(visitId);
					qmatchInfo.setHome_name(homeName);
					qmatchInfo.setVisit_name(visitName);
				    qmatchInfo.setDate_time(format.parse(dateTimeStr));
				    qmatchInfo.setSpace_name(spaceName);
				    qmatchInfo.setSpace_address(spaceAddress);
				    qmatchInfo.setStatus(1);
				    qmatchInfo.setReview_status(1);
				    qmatchInfo.setLeague_id(league_id);//联赛id目前默认为1
				    /**获取到联赛数据之后将其相关数据修改*/
				    AjaxMsg updateQmatchMsg = updateQMatchInfo(qmatchInfo);
				    String qMatchId = qmatchInfo.getId();
				    validateTeamInfo(qMatchId);
				    qmatchInfo = getMatchInfoById(qMatchId);
				    if(updateQmatchMsg.isSuccess()){
				    	logger.info("修改接口联赛数据成功");
				    }else{
				    	logger.info("修改接口联赛数据失败");
				    }
				    
				    QSummaryInfo homeQSummary = new QSummaryInfo();//主球队对象
				    homeQSummary.setId(UUIDGenerator.getUUID());
				    homeQSummary.setTeam_id(homeId);
				    homeQSummary.setQ_match_id(qmatchInfo.getId());
				    homeQSummary.setTeaminfo_id(qmatchInfo.getH_team_id());
				    QSummaryInfo visitQSummary = new QSummaryInfo();//客球队对象
				    visitQSummary.setId(UUIDGenerator.getUUID());
				    visitQSummary.setTeam_id(visitId);
				    visitQSummary.setQ_match_id(qmatchInfo.getId());
				    visitQSummary.setTeaminfo_id(qmatchInfo.getV_team_id());
				    Map<String,Object> controlTime = (Map<String,Object>)datas.get("controlTime");//控球时间
				    String homeControlTime = controlTime.get("home").toString();//主队控球时间
				    String visitControlTime = controlTime.get("visit").toString();//客队控球时间
				    
				    homeQSummary.setControl_time(homeControlTime);
				    visitQSummary.setControl_time(visitControlTime);
				    
				    Map<String,Object> scoreInfo = (Map<String,Object>)datas.get("scoreInfo");//比分时间
				    String homeScore = BeanUtils.nullToString(scoreInfo.get("home")) == "" ? "0" : BeanUtils.nullToString(scoreInfo.get("home"));
				    String visitScore = BeanUtils.nullToString(scoreInfo.get("visit")) == "" ? "0" : BeanUtils.nullToString(scoreInfo.get("visit"));
				    
				    homeQSummary.setScore(homeScore);
				    visitQSummary.setScore(visitScore);
				    
				    List<Map<String,Object>> summaryInfo = (List<Map<String, Object>>) datas.get("summaryInfo");//比赛汇总数据
				    for (Map<String, Object> map : summaryInfo) {
				    	String name = map.get("name").toString();
				    	String home = BeanUtils.nullToString(map.get("home")) == "" ? "0" : BeanUtils.nullToString(map.get("home"));//主队数据
						String visit =BeanUtils.nullToString(map.get("visit")) == "" ? "0" : BeanUtils.nullToString(map.get("visit"));//客队数据
						if(name.equals("进球")){
							homeQSummary.setJinqiu_num(home);
							visitQSummary.setJinqiu_num(visit);
						}
						if(name.equals("射正")){
							homeQSummary.setShezheng_num(home);
							visitQSummary.setShezheng_num(visit);
						}
						if(name.equals("射门")){
							homeQSummary.setShemen_num(home);
							visitQSummary.setShemen_num(visit);
						}
						if(name.equals("射正率")){
							homeQSummary.setShezheng_lv(home);
							visitQSummary.setShezheng_lv(visit);
						}
						if(name.equals("角球")){
							homeQSummary.setJiaoqiu_num(home);
							visitQSummary.setJiaoqiu_num(visit);
						}
						if(name.equals("任意球")){
							homeQSummary.setRenyi_num(home);
							visitQSummary.setRenyi_num(visit);
						}
						if(name.equals("抢断")){
							homeQSummary.setQiangduan_num(home);
							visitQSummary.setQiangduan_num(visit);
						}
						if(name.equals("拦截")){
							homeQSummary.setLanjie_num(home);
							visitQSummary.setLanjie_num(visit);
						}
						if(name.equals("扑救")){
							homeQSummary.setPujiu_num(home);
							visitQSummary.setPujiu_num(visit);
						}
						if(name.equals("解围")){
							homeQSummary.setJiewei_num(home);
							visitQSummary.setJiewei_num(visit);
						}
						if(name.equals("犯规")){
							homeQSummary.setFangui_num(home);
							visitQSummary.setFangui_num(visit);
						}
						if(name.equals("乌龙球")){
							homeQSummary.setWulong_num(home);
							visitQSummary.setWulong_num(visit);
						}
						if(name.equals("越位")){
							homeQSummary.setYuewei_num(home);
							visitQSummary.setYuewei_num(visit);
						}
						if(name.equals("黄牌")){
							homeQSummary.setHuangpai_num(home);
							visitQSummary.setHuangpai_num(visit);
						}
						if(name.equals("红牌")){
							homeQSummary.setHongpai_num(home);
							visitQSummary.setHongpai_num(visit);
						}
						
					}
				    homeQSummary.setTeam_status(1);//主队
				    visitQSummary.setTeam_status(2);//客队
				    /*
				     *保存主队汇总数据 
				     */
				    AjaxMsg saveHQSummaryInfoMsg = saveQSummaryInfo(homeQSummary);
				    if(saveHQSummaryInfoMsg.isSuccess()){
				    	logger.info("添加赛事id为【"+gameId+"】主球队比赛汇总数据成功");
				    }
				    
				    AjaxMsg saveVQSummaryInfoMsg = saveQSummaryInfo(visitQSummary);
				    if(saveVQSummaryInfoMsg.isSuccess()){
				    	logger.info("添加赛事id为【"+gameId+"】客球队比赛汇总数据成功");
				    }
				    
				    Map<String,Object> userData = (Map<String,Object>)datas.get("userData");//参赛球员详细数据
				    List<Map<String,Object>> homeUserData = (List<Map<String, Object>>) userData.get("homeUserData");
				    QUserData hQuserData = null;//主球队队友对象
				    for (Map<String, Object> map : homeUserData) {
				    	hQuserData = new QUserData();
				    	hQuserData.setId(UUIDGenerator.getUUID());
				    	hQuserData.setTeam_status(1);//1表示主球队
				    	hQuserData.setQ_match_id(qmatchInfo.getId());
				    	hQuserData.setTeam_id(homeId);
				    	hQuserData.setTeaminfo_id(qmatchInfo.getH_team_id());
				    	hQuserData.setPlayer_id(BeanUtils.nullToString(map.get("id")) == "" ? "0" : BeanUtils.nullToString(map.get("id")));
				    	hQuserData.setName(map.get("name").toString());
				    	hQuserData.setNumber(BeanUtils.nullToString(map.get("number")) == "" ? "0" : BeanUtils.nullToString(map.get("number")));
				    	hQuserData.setDurtime(map.get("durtime").toString());
				    	hQuserData.setJinqiu_num(BeanUtils.nullToString(map.get("jinqiu")) == "" ? "0" : BeanUtils.nullToString(map.get("jinqiu")));
				    	hQuserData.setFangui_num(BeanUtils.nullToString(map.get("fangui")) == "" ? "0" : BeanUtils.nullToString(map.get("fangui")));
				    	hQuserData.setHuangpai_num(BeanUtils.nullToString(map.get("huangpai")) == "" ? "0" : BeanUtils.nullToString(map.get("huangpai")));
				    	hQuserData.setHongpai_num(BeanUtils.nullToString(map.get("hongpai")) == "" ? "0" : BeanUtils.nullToString(map.get("hongpai")));
				    	hQuserData.setPujiu_num(BeanUtils.nullToString(map.get("pujiu")) == "" ? "0" : BeanUtils.nullToString(map.get("pujiu")));
				    	hQuserData.setJiewei_num(BeanUtils.nullToString(map.get("jiewei")) == "" ? "0" : BeanUtils.nullToString(map.get("jiewei")));
				    	hQuserData.setLanjie_num(BeanUtils.nullToString(map.get("lanjie")) == "" ? "0" : BeanUtils.nullToString(map.get("lanjie")));
				    	hQuserData.setZhugong_num(BeanUtils.nullToString(map.get("zhugong")) == "" ? "0" : BeanUtils.nullToString(map.get("zhugong")));
				    	hQuserData.setWulong_num(BeanUtils.nullToString(map.get("wulongqiu")) == "" ? "0" : BeanUtils.nullToString(map.get("wulongqiu")));
				    	hQuserData.setShemen_num(BeanUtils.nullToString(map.get("shemen")) == "" ? "0" : BeanUtils.nullToString(map.get("shemen")));
				    	hQuserData.setShepian_num(BeanUtils.nullToString(map.get("shepian")) == "" ? "0" : BeanUtils.nullToString(map.get("shepian")));
				    	hQuserData.setShezheng_num(BeanUtils.nullToString(map.get("shezheng")) == "" ? "0" : BeanUtils.nullToString(map.get("shezheng")));
				    	hQuserData.setQiangduan_num(BeanUtils.nullToString(map.get("qiangduan")) == "" ? "0" : BeanUtils.nullToString(map.get("qiangduan")));
				    	hQuserData.setPosition("");
				        saveQUserDataInfo(hQuserData);//添加主球队队员信息
				    }
				    QUserData vQuserData = null;//客球队队友对象
				    List<Map<String,Object>> visitUserData = (List<Map<String, Object>>) userData.get("visitUserData");
				    for (Map<String, Object> map : visitUserData) {
				    	vQuserData = new QUserData();
				    	vQuserData.setId(UUIDGenerator.getUUID());
				    	vQuserData.setQ_match_id(qmatchInfo.getId());
				    	vQuserData.setTeam_status(2);//2表示客球队
				    	vQuserData.setTeam_id(visitId);
				    	vQuserData.setTeaminfo_id(qmatchInfo.getV_team_id());
				    	vQuserData.setPlayer_id(BeanUtils.nullToString(map.get("id")) == "" ? "0" : BeanUtils.nullToString(map.get("id")));
				    	vQuserData.setName(map.get("name").toString());
				    	vQuserData.setNumber(BeanUtils.nullToString(map.get("number")) == "" ? "0" : BeanUtils.nullToString(map.get("number")));
				    	vQuserData.setDurtime(map.get("durtime").toString());
				    	vQuserData.setJinqiu_num(BeanUtils.nullToString(map.get("jinqiu")) == "" ? "0" : BeanUtils.nullToString(map.get("jinqiu")));
				    	vQuserData.setFangui_num(BeanUtils.nullToString(map.get("fangui")) == "" ? "0" : BeanUtils.nullToString(map.get("fangui")));
				    	vQuserData.setHuangpai_num(BeanUtils.nullToString(map.get("huangpai")) == "" ? "0" : BeanUtils.nullToString(map.get("huangpai")));
				    	vQuserData.setHongpai_num(BeanUtils.nullToString(map.get("hongpai")) == "" ? "0" : BeanUtils.nullToString(map.get("hongpai")));
				    	vQuserData.setPujiu_num(BeanUtils.nullToString(map.get("pujiu")) == "" ? "0" : BeanUtils.nullToString(map.get("pujiu")));
				    	vQuserData.setJiewei_num(BeanUtils.nullToString(map.get("jiewei")) == "" ? "0" : BeanUtils.nullToString(map.get("jiewei")));
				    	vQuserData.setLanjie_num(BeanUtils.nullToString(map.get("lanjie")) == "" ? "0" : BeanUtils.nullToString(map.get("lanjie")));
				    	vQuserData.setZhugong_num(BeanUtils.nullToString(map.get("zhugong")) == "" ? "0" : BeanUtils.nullToString(map.get("zhugong")));
				    	vQuserData.setWulong_num(BeanUtils.nullToString(map.get("wulongqiu")) == "" ? "0" : BeanUtils.nullToString(map.get("wulongqiu")));
				    	vQuserData.setShemen_num(BeanUtils.nullToString(map.get("shemen")) == "" ? "0" : BeanUtils.nullToString(map.get("shemen")));
				    	vQuserData.setShepian_num(BeanUtils.nullToString(map.get("shepian")) == "" ? "0" : BeanUtils.nullToString(map.get("shepian")));
				    	vQuserData.setShezheng_num(BeanUtils.nullToString(map.get("shezheng")) == "" ? "0" : BeanUtils.nullToString(map.get("shezheng")));
				    	vQuserData.setQiangduan_num(BeanUtils.nullToString(map.get("qiangduan")) == "" ? "0" : BeanUtils.nullToString(map.get("qiangduan")));
				    	vQuserData.setPosition("");
				    	saveQUserDataInfo(vQuserData);//添加客球队队员信息
				    }
				    
				    /**
				     * 添加赛事主球队球员进球数据
				     **/
				    Map<String,Object> goalData = (Map<String,Object>)datas.get("jinqiuData");//获取赛事进球数据
				    List<Map<String,Object>> homeData = (List<Map<String, Object>>) goalData.get("home");
				    QScoreInfo qScoreInfo = null;
				    if(homeData.size() > 0){
				    	for (Map<String, Object> map : homeData) {
				    		qScoreInfo = new QScoreInfo();
				    		String playerId = BeanUtils.nullToString(map.get("userId"));
				    		String jinqiu_time = BeanUtils.nullToString(map.get("time"));
				    		String is_wulong = BeanUtils.nullToString(map.get("isWulongqiu")) == "" ? "N" : BeanUtils.nullToString(map.get("isWulongqiu"));

				    		QUserData qUserData = getQUserDataByPlayerId(qMatchId,playerId);
				    		if(qUserData != null){
					    		qScoreInfo = new QScoreInfo();
					    		qScoreInfo.setId(UUIDGenerator.getUUID());
					    		qScoreInfo.setQ_match_id(qMatchId);
					    		qScoreInfo.setTeam_id(homeId);
					    		qScoreInfo.setTeaminfo_id(qmatchInfo.getH_team_id());//主球队关联球队id
					    		qScoreInfo.setQ_user_id(qUserData.getId());
					    		qScoreInfo.setUser_id(qUserData.getRel_palyer_id());
					    		qScoreInfo.setJinqiu_time(jinqiu_time);//值取自全网
					    		qScoreInfo.setIs_wulong(is_wulong);
					    		saveQScoreInfo(qScoreInfo);
				    		}
						}
				    }
				    /**
				     * 添加赛事客球队球员进球数据
				     **/
				    List<Map<String,Object>> visitData = (List<Map<String, Object>>) goalData.get("visit");
	                if(visitData.size() > 0){
	                	for (Map<String, Object> map : visitData) {
				    		qScoreInfo = new QScoreInfo();
				    		String playerId = BeanUtils.nullToString(map.get("userId"));
				    		String jinqiu_time = BeanUtils.nullToString(map.get("time"));
				    		String is_wulong = BeanUtils.nullToString(map.get("isWulongqiu")) == "" ? "N" : BeanUtils.nullToString(map.get("isWulongqiu"));
				    		
				    		QUserData qUserData = getQUserDataByPlayerId(qMatchId,playerId);
				    		if(qUserData != null){
					    		qScoreInfo = new QScoreInfo();
					    		qScoreInfo.setId(UUIDGenerator.getUUID());
					    		qScoreInfo.setQ_match_id(qMatchId);
					    		qScoreInfo.setTeam_id(visitId);
					    		qScoreInfo.setTeaminfo_id(qmatchInfo.getV_team_id());//客球队关联球队id
					    		qScoreInfo.setQ_user_id(qUserData.getId());
					    		qScoreInfo.setUser_id(qUserData.getRel_palyer_id());
					    		qScoreInfo.setJinqiu_time(jinqiu_time);//值取自全网
					    		qScoreInfo.setNumber(qUserData.getNumber());
					    		qScoreInfo.setIs_wulong(is_wulong);
					    		saveQScoreInfo(qScoreInfo);
				    		}
						}
				    }
				}else{
					ajax = AjaxMsg.newError();
				}
			}
		}catch (Exception e) {
			ajax = AjaxMsg.newError();
			logger.error("=========================interface error ：" + e.getMessage());
			e.printStackTrace();
		}
		return ajax;
	}
	
	/**
	 * <p>Title:通过接口赛事id获取接口联赛比赛数据 </p>
	 * <p>Description: </p>
	 * @Author zhangwei
	 * @Date 2015年12月23日 下午12:09:29
	 * @param urlAddress
	 * @param matchId
	 * @param key
	 * @return
	 */
	public JSONObject findMatchInfosBymatchId(String urlAddress,String matchId,String key) {
		JSONObject user_json = new JSONObject();
		try {
			URL url = new URL(urlAddress);
			JsonRpcHttpClient client  = new JsonRpcHttpClient(url);
			String identity = "";
			Long timespan = new Date().getTime();
			identity = Base64Util.encodeBase64(key+timespan) ;
			JSONObject node = new JSONObject();  
			node.put("identity", identity);
			node.put("matchId", matchId);
			node.put("timespan", timespan);
			Map<String,String> headers = new HashMap();
			headers.put("Content-Type", "application/json; charset=UTF-8");
			client.setHeaders(headers);
			System.out.println(identity);
			System.out.println(node.toString());
			user_json = client.invoke("getMatchDataById", node.toJSONString(),JSONObject.class);
			System.out.println(user_json);
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return user_json;
	}

	/**
	 * <p>Description: 匹配球队信息</p>
	 * @Author zhangwei
	 * @Date 2015年12月23日 下午7:35:32
	 * @param matchId
	 * @return
	 */
	public AjaxMsg validateTeamInfo(String pMatchId) {
		AjaxMsg ajax = null;
		QMatchInfo matchInfo = getMatchInfoById(pMatchId);
		try {
			if(matchInfo != null){
				String homeName = matchInfo.getHome_name();
				String visitName = matchInfo.getVisit_name();
				
				List<Map<String,Object>> hteaminfos = teamInfoService.queryTeamInfoByName(homeName);//根据接口主球队名称查询俱乐部信息
				if(hteaminfos.size() == 1){
					matchInfo.setH_team_id(hteaminfos.get(0).get("id").toString());
				}
				List<Map<String,Object>> vteaminfos = teamInfoService.queryTeamInfoByName(visitName);//根据接口客球队名称查询俱乐部信息
				if(vteaminfos.size() == 1){
					matchInfo.setV_team_id(vteaminfos.get(0).get("id").toString());
				}
				if(StringUtils.isNotBlank(matchInfo.getH_team_id()) && StringUtils.isNotBlank(matchInfo.getV_team_id())){
					Map<String,Object> params = Maps.newHashMap();
					params.put("m_teaminfo_id", matchInfo.getH_team_id());
					params.put("g_teaminfo_id",matchInfo.getV_team_id());
					params.put("league_id", matchInfo.getLeague_id());
					AdminEventRecord eventRecord =  adminEventRecordService.getEventRecordByTidAndVid(params);
					if(eventRecord != null){
						matchInfo.setRecord_id(eventRecord.getId());
					}
				}
				updateQMatchInfo(matchInfo);
			}
			ajax=AjaxMsg.newSuccess();
		} catch (Exception e) {
			ajax=AjaxMsg.newError();
			e.printStackTrace();
		}
		return ajax;
	}
	
	
	/**
	 * <p>Description:验证球员相关信息 </p>
	 * @Author zhangwei
	 * @Date 2015年12月24日 下午1:09:12
	 * @param pMatchId
	 * @return
	 */
	public AjaxMsg validatePlayerInfos(String pMatchId){
		AjaxMsg ajax = null;
		
		QMatchInfo qmatchInfo = getMatchInfoById(pMatchId);
		try {
			String qMatchId = qmatchInfo.getId();
			String hTeaminfo_id = qmatchInfo.getH_team_id();
			String vTeamInfo_id = qmatchInfo.getV_team_id();
			String home_id = qmatchInfo.getHome_id();
			String visit_id = qmatchInfo.getVisit_id();
			/**
			 * 匹配主队球员信息
			 **/
			List<QUserData> homeUserDataList = getQUserDataListByQmatchId(qMatchId,home_id);
			List<TeamPlayer> homeTeamInfolist = teamInfoService.getTeamPlayersByTeamInfoId(hTeaminfo_id); 
			List<TeamLoanPlayer> homeLoanPlayerList = teamLoanPlayerService.getTeamPlayersByTeamInfoId(hTeaminfo_id);
			
			for (QUserData qUserData : homeUserDataList) {
				//String  qnumber = BeanUtils.nullToString(qUserData.getNumber()).trim();
				String teaminfoId = BeanUtils.nullToString(qUserData.getTeaminfo_id());
				String playerName = BeanUtils.nullToString(qUserData.getName());
				if(StringUtils.isNotBlank(teaminfoId)){
					//正式球员
					for (TeamPlayer teamPlayer : homeTeamInfolist) {
						//String number = BeanUtils.nullToString(teamPlayer.getPlayer_num()).trim();
						if(teamPlayer.getTeaminfo_id().equals(teaminfoId)){ //匹配球队 
							String userId = teamPlayer.getUser_id();
							String username  = userService.id2UserName(userId);
							if(null != username && playerName.equals(username)){//匹配球员姓名 同名球员存在BUG
								qUserData.setRel_palyer_id(userId);
								qUserData.setPosition(BeanUtils.nullToString(teamPlayer.getPosition()));
							    updateQUserData(qUserData);//关联球员id并修改数据
							}
						}
					}
					//租借球员
					for (TeamLoanPlayer teamLoanPlayer : homeLoanPlayerList) {
						//String number = BeanUtils.nullToString(teamLoanPlayer.getPlayer_num()).trim();
						if(teamLoanPlayer.getNew_teaminfo_id().equals(teaminfoId)){//匹配球衣号
							String userId = teamLoanPlayer.getUser_id();
							String username  = userService.id2UserName(userId);
							if(null != username && playerName.equals(username)){//匹配球员姓名
								qUserData.setRel_palyer_id(userId);
								qUserData.setPosition(BeanUtils.nullToString(teamLoanPlayer.getPosition()));
							    updateQUserData(qUserData);//关联球员id并修改数据
							}
						}
					}
				}
			}
			
			/**
			 * 匹配客队球员信息
			 **/
			List<QUserData> visitUserDataList = getQUserDataListByQmatchId(qMatchId,visit_id);
			List<TeamPlayer> visitTeamInfolist = teamInfoService.getTeamPlayersByTeamInfoId(vTeamInfo_id);
			List<TeamLoanPlayer> visitLoanPlayerList = teamLoanPlayerService.getTeamPlayersByTeamInfoId(hTeaminfo_id);
			for (QUserData qUserData : visitUserDataList) {
				//String  qnumber = BeanUtils.nullToString(qUserData.getNumber()).trim();
				String teaminfoId = qUserData.getTeaminfo_id();
				String playerName = qUserData.getName();
				if(StringUtils.isNotBlank(teaminfoId)){
					//正式球员
					for (TeamPlayer teamPlayer : visitTeamInfolist) {
						//String number = BeanUtils.nullToString(teamPlayer.getPlayer_num()).trim();
						if(teamPlayer.getTeaminfo_id().equals(teaminfoId)){//匹配球衣号
							String userId = teamPlayer.getUser_id();
							String username  = userService.id2UserName(userId);
							if(null != username && playerName.equals(username)){//匹配球员姓名 
								qUserData.setRel_palyer_id(userId);
								qUserData.setPosition(BeanUtils.nullToString(teamPlayer.getPosition()));
								updateQUserData(qUserData);//关联球员id并修改数据
							}
						}
					}
					//租借球员
					for (TeamLoanPlayer teamLoanPlayer : visitLoanPlayerList) {
						//String number = BeanUtils.nullToString(teamLoanPlayer.getPlayer_num()).trim();
						if(teamLoanPlayer.getNew_teaminfo_id().equals(teaminfoId)){//匹配球衣号
							String userId = teamLoanPlayer.getUser_id();
							String username  = userService.id2UserName(userId);
							if(null != username && playerName.equals(username)){//匹配球员姓名
								qUserData.setRel_palyer_id(userId);
								qUserData.setPosition(BeanUtils.nullToString(teamLoanPlayer.getPosition()));
							    updateQUserData(qUserData);//关联球员id并修改数据
							}
						}
					}
				}
			}
			ajax = AjaxMsg.newSuccess();
		} catch (Exception e) {
			e.printStackTrace();
			ajax = AjaxMsg.newError();
		}
		return ajax;
	}
	@Override
	public List<Map<String, Object>> queryPlayerJinQiu(Map<String, Object> params) {
		List<Map<String, Object>> jinQiuList = quanLeagueMapper.queryPlayerJinQiu(params);
		return jinQiuList;
	}
	@Override
	public AjaxMsg getQMatchInfoList(Map<String, Object> maps, PageModel pageModel) {
		List<QMatchInfo> datas = Lists.newArrayList();
		int count = 0 ;
		if(maps!=null){
			if(pageModel!=null){
				count = quanLeagueMapper.matchInfoListCount(maps);
				maps.put("start",pageModel.getFirstNum());
				maps.put("rows",pageModel.getPageSize());
			}
			datas = quanLeagueMapper.getQmatchInfoList(maps);
			if(pageModel == null){
				PageModel page = new PageModel();
				page.setTotalCount(datas.size());
				page.setItems(datas);
				return AjaxMsg.newSuccess().addData("page", page);
			}else{
				pageModel.setTotalCount(count);
				pageModel.setItems(datas);
			}
		}
		return AjaxMsg.newSuccess().addData("page", pageModel);
	}
	@Override
	public List<QScoreInfo> getScoreInfoListByQmatchId(String matchId,Integer team_id,String teaminfo_id) {
		return quanLeagueMapper.getScoreInfoListByQmatchId(matchId,team_id,teaminfo_id);
	}
	
	
	@Override
	public void updateMatchInfo(QMatchInfo qMatchInfo, QSummaryList list)throws Exception {
		if(StringUtils.isNotBlank(qMatchInfo.getId())){
			//保存赛事纪录信息
			QMatchInfo qInfo = this.getMatchInfoById(qMatchInfo.getId());
			qInfo.setH_team_id(qMatchInfo.getH_team_id());
			qInfo.setV_team_id(qMatchInfo.getV_team_id());
			qInfo.setDate_time(qMatchInfo.getDate_time());
			qInfo.setSpace_address(qMatchInfo.getSpace_address());
			Map<String,Object> maps = Maps.newHashMap();
			maps.put("m_teaminfo_id", qMatchInfo.getH_team_id());
			maps.put("g_teaminfo_id", qMatchInfo.getV_team_id());
			maps.put("league_id", qMatchInfo.getLeague_id());
			AdminEventRecord record = adminEventRecordService.getEventRecordByTidAndVid(maps);
			if(record != null){
				qInfo.setRecord_id(record.getId());
			}
			this.updateQMatchInfo(qInfo);
		
			//保存详细球队比赛信息
			for (QSummaryInfo info : list.getSummarys()) {
				//QSummaryInfo dataInfo = quanLeagueService.getQSummaryInfoById(info.getId());
				if(info.getTeam_status() == 1){
					info.setTeaminfo_id(BeanUtils.nullToString(qMatchInfo.getH_team_id()));
				}else{
					info.setTeaminfo_id(BeanUtils.nullToString(qMatchInfo.getV_team_id()));
				}
				this.updateQSummaryInfo(info);
				
			}
			
			//更新球队球员球队信息
			List<QUserData> userDatas = this.getQUserDataListByQmatchId(qInfo.getId(), null);
			for (QUserData qUserData : userDatas) {
				if(qUserData.getTeam_id() == qInfo.getHome_id()){
					qUserData.setTeaminfo_id(qInfo.getH_team_id());
				}else if(qUserData.getTeam_id() == qInfo.getVisit_id()){
					qUserData.setTeaminfo_id(qInfo.getV_team_id());
				}
				this.updateQUserData(qUserData);
			}
			
			//更新球队进球球员球队信息
			List<QScoreInfo> scoreDatas = this.getScoreInfoListByQmatchId(qInfo.getId(), null, "");
			for (QScoreInfo qScoreInfo : scoreDatas) {
				if(qScoreInfo.getTeam_id() == qInfo.getHome_id()){
					qScoreInfo.setTeaminfo_id(qInfo.getH_team_id());
				}else if(qScoreInfo.getTeam_id() == qInfo.getVisit_id()){
					qScoreInfo.setTeaminfo_id(qInfo.getV_team_id());
				}
				this.updateQScoreInfo(qScoreInfo);
			}
		}
	}
	@Override
	public List<Map<String, Object>> queryPlayerScore(Map<String, Object> params) {
		List<Map<String, Object>> scores = quanLeagueMapper.queryPlayerScore(params);
		return scores;
	}
	@Override
	public AjaxMsg saveOrUpdateQUserData(List<QScoreInfo> scores) {
		for (QScoreInfo qScoreInfo : scores) {
			if(StringUtils.isNotBlank(qScoreInfo.getId())){
				quanLeagueMapper.updateQScoreInfo(qScoreInfo);
			}else{
				qScoreInfo.setId(UUIDGenerator.getUUID());
				quanLeagueMapper.saveQScoreInfo(qScoreInfo);
			}
		}
		return AjaxMsg.newSuccess();
	}
	
	@Override
	public QMatchInfo getMatchInfoByRecordId(String r_id) {
		return quanLeagueMapper.getMatchInfoByRecordId(r_id);
	}
	@Override
	public AjaxMsg deleteMatchsByInfos(QMatchInfo matchInfo) {
		String qmatchId = matchInfo.getId();
		quanLeagueMapper.deleteQSummaryInfoByQmatchId(qmatchId);
		quanLeagueMapper.deleteQUserDataByQmatchId(qmatchId);
		quanLeagueMapper.deleteQScoreInfoByQmatchId(qmatchId);
		matchInfo.setStatus(3);
		matchInfo.setReview_status(1);
		quanLeagueMapper.updateQMatchInfo(matchInfo);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	@Override
	public AjaxMsg deleteScore(String id) {
		quanLeagueMapper.deleteScore(id);
		return AjaxMsg.newSuccess();
	}
	@Override
	public AjaxMsg getQUserDataCardStatics(Map<String, Object> maps, PageModel pageModel) {
		List<Map<String, Object>> datas = Lists.newArrayList();
		int count = 0 ;
		if(maps!=null){
			if(pageModel!=null){
				count = quanLeagueMapper.getQUserDataCardStaticsCount(maps);
				maps.put("start",pageModel.getFirstNum());
				maps.put("rows",pageModel.getPageSize());
			}
			datas = quanLeagueMapper.getQUserDataCardStatics(maps);
			pageModel.setTotalCount(count);
			pageModel.setItems(datas);
		}
		return AjaxMsg.newSuccess().addData("page", pageModel);
		
	}
	@Override
	public List<QScoreInfo> getWulongData(String q_match_id, String teaminfo_id) {
		return quanLeagueMapper.getWulongData(q_match_id,teaminfo_id);
	}
	@Override
	public AjaxMsg queryPlayerDatas(Map<String, Object> params,PageModel pageModel) {
		List<Map<String, Object>> datas = new ArrayList<Map<String,Object>>();
		int count = 0 ;
		if(params!=null){
			if(pageModel!=null){
				count = quanLeagueMapper.queryPlayerDatasCount(params);
				pageModel.setTotalCount(count);
				params.put("start",pageModel.getFirstNum());
				params.put("rows",pageModel.getPageSize());
			}
			List<Map<String, Object>> players = quanLeagueMapper.queryPlayerDatas(params);
			pageModel.setItems(players);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return AjaxMsg.newError();
	}
}

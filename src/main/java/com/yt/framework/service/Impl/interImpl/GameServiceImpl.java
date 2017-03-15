package com.yt.framework.service.Impl.interImpl;

import java.util.Date;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.QMatchInfo;
import com.yt.framework.service.admin.QuanLeagueService;
import com.yt.framework.service.inter.GameService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.Base64Util;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.UUIDGenerator;

@Transactional
@Service("gameService")
public class GameServiceImpl implements GameService {
	
	protected static Logger logger = LogManager.getLogger(GameServiceImpl.class);
	
	@Autowired
	private QuanLeagueService quanLeagueService;
	
	@Override
	public String isAlive() {
		Map<String,Object> params = Maps.newHashMap();
		try {
			System.out.println("into this way");
			params.put("status", "success");
		} catch (Exception e) {
			e.printStackTrace();
			params.put("status", "error");
		}
		
		return AjaxMsg.toJson(params);
	}

	@Override
	public String saveGameId(String gameId, String key, String create_time) {
		/**
		 * 添加全网id信息
		 */
		Map<String,Object> params = Maps.newHashMap();
		try {
			String oldkey = Base64Util.decodeBase64(key);
			if(oldkey.equals("Yrt2015team")){
				String matchId = BeanUtils.nullToString(gameId);
				QMatchInfo match = quanLeagueService.getMatchInfoByMatchId(matchId);
				if(match == null){
					match = new QMatchInfo();
					match.setId(UUIDGenerator.getUUID());
					match.setMatch_id(matchId);
					long time=Long.parseLong(create_time);
					Date date=new Date(time);
					match.setCreate_time(date);
					match.setStatus(1);
					/**添加接口比赛数据*/
					AjaxMsg ajaxmsg = quanLeagueService.saveQMatchInfo(match);
					if(ajaxmsg.isSuccess()){
						params.put("status", "success");
					}else{
						params.put("status", "error");
					}
				}else{
					/**如果数据已经存在，就将请求接口数量+1*/
					match.setInvokeCount(match.getInvokeCount()+1);
					AjaxMsg ajaxmsg = quanLeagueService.updateQMatchInfo(match);
					if(ajaxmsg.isSuccess()){
						params.put("status", "success");
					}else{
						params.put("status", "error");
					}
				}
			}else{
				params.put("status", "key is error");
			}
		} catch (Exception e) {
			e.printStackTrace();
			params.put("status", "error");
		}
		return AjaxMsg.toJson(params);
	}
}

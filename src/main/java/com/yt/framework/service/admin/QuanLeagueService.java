package com.yt.framework.service.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.QMatchInfo;
import com.yt.framework.persistent.entity.QScoreInfo;
import com.yt.framework.persistent.entity.QSummaryInfo;
import com.yt.framework.persistent.entity.QSummaryList;
import com.yt.framework.persistent.entity.QUserData;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * 全网接口
 *
 */
public interface QuanLeagueService {
	
	/**
	 * 保存接口联赛信息
	 * @param params
	 * @return
	 */
	public AjaxMsg saveQMatchInfo(QMatchInfo match);

	/**
	 * 编辑接口联赛信息
	 * @param params
	 * @return
	 */
	public AjaxMsg updateQMatchInfo(QMatchInfo match);
	
	/**
	 * 根据接口赛事id查询联赛信息
	 * @param params
	 * @return
	 */
	public QMatchInfo getMatchInfoByMatchId(@Param("matchId")String matchId);
	
	/**
	 * 保存接口联赛信息
	 * @param params
	 * @return
	 */
	public AjaxMsg saveQSummaryInfo(QSummaryInfo qSummary);
	
	/**
	 * 保存接口比赛球员数据
	 * @param params
	 * @return
	 */
	public AjaxMsg saveQUserDataInfo(QUserData qUserData);
	/**
	 * 根据id获取比赛球员数据
	 * @param params
	 * @return
	 */
	public QMatchInfo getMatchInfoById(String id);
	/**
	 * 根据全网联赛id删除相关联赛汇总数据跟球员信息
	 * @Author zhangwei
	 * @Date 2015年12月24日 上午11:10:12
	 * @param qmatchId
	 */
	public AjaxMsg deleteQmatchDatasByQmatchId(String qmatchId);
	/**
	 * <p>Description:通过接口赛事id查询球员信息列表 </p>
	 * @Author zhangwei
	 * @Date 2015年12月24日 下午2:33:27
	 * @param teamInfoId
	 * @return
	 */
	public List<QUserData> getQUserDataListByQmatchId(String qmatchId,String teamId);
	/**
	 * <p>Description: 根据id修改接口球员详细信息</p>
	 * @Author zhangwei
	 * @Date 2015年12月24日 下午3:25:05
	 * @param id
	 * @return
	 */
	public AjaxMsg updateQUserData(QUserData qUserData);
	
	/**
	 * <p>Description:通过接口赛事id查询球队比赛列表 </p>
	 * @Author ylt
	 * @Date 2015年12月24日 下午2:33:27
	 * @param id
	 * @return
	 */
	public List<QSummaryInfo> getQSummaryListByQmatchId(String qmatchId,String teamId);

	/**
	 * 查询主队或客队球员
	 * gl
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> queryQplayers(Map<String, Object> params);

	/**
	 * 批量修改球员数据
	 * @param userDatas
	 * @return
	 */
	public AjaxMsg updateAllQUserData(List<QUserData> userDatas);
	/**
	 * <p>Description:添加接口赛事进球统计数据 </p>
	 * @Author zhangwei
	 * @Date 2015年12月24日 下午5:23:23
	 * @param scoreInfo
	 * @return
	 */
	public AjaxMsg saveQScoreInfo(QScoreInfo scoreInfo);
	/**
	 * <p>Description:根据接口球员id查询接口球员信息 </p>
	 * @Author zhangwei
	 * @Date 2015年12月24日 下午5:50:18
	 * @param id
	 * @return
	 */
	public QUserData getQUserDataByPlayerId(String q_match_id,String player_id);
	
	/**
	 * <p>Description:更新球队比赛统计数据 </p>
	 * @Author ylt
	 * @Date 2015年12月24日 下午5:50:18
	 * @param id
	 * @return
	 */
	public AjaxMsg updateQSummaryInfo(QSummaryInfo info)throws Exception;
	
	/**
	 * 根据matchId去查询相关赛事信息 
	 * @Author zhangwei
	 * @Date 2015年12月25日 下午2:42:30
	 * @param urlAddress 接口地址
	 * @param gameId 接口赛事id
	 * @param key  关键词
	 * @return
	 */
	public AjaxMsg modifyQMatchInfos(String urlAddress,String gameId,String key,String league_id);
	
	/**
	 * <p>Description: 查询接口赛事列表信息</p>
	 * @Author zhangwei
	 * @Date 2015年12月25日 下午3:15:09
	 * @param maps
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg getQMatchInfoList(Map<String, Object> maps,PageModel pageModel);
	
	/**
	 * <p>Description:进球数据 </p>
	 * @Author ylt
	 * @Date 2015年12月24日 下午5:50:18
	 * @param id
	 * @return
	 */
	public List<QScoreInfo> getScoreInfoListByQmatchId(String matchId,Integer team_id,String teaminfo_id);
	
	
	/**
	 * <p>Description:更新球队详细信息 </p>
	 * @Author ylt
	 * @Date 2015年12月24日 下午5:50:18
	 * @param id
	 * @return
	 */
	public void updateMatchInfo(QMatchInfo qMatchInfo, QSummaryList list)throws Exception;
	
	/**
	 * <p>Description:更新进球信息 </p>
	 * @Author ylt
	 * @Date 2015年12月24日 下午5:50:18
	 * @param id
	 * @return
	 */
	public AjaxMsg updateQScoreInfo(QScoreInfo scoreInfo)throws Exception;
	
	
	/**
	 * 查询球员进球详情
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> queryPlayerJinQiu(Map<String, Object> params);

	public List<Map<String, Object>> queryPlayerScore(Map<String, Object> params);

	public AjaxMsg saveOrUpdateQUserData(List<QScoreInfo> scores);
	
	/**
	 * 根据赛事ID查询比赛信息
	 * @param params
	 * @return
	 */
	public QMatchInfo getMatchInfoByRecordId(String r_id);
	
	/**
	 * <p>Description:删除与接口赛事有关的所有数据 </p>
	 * @Author zhangwei
	 * @Date 2015年12月26日 上午11:28:09
	 * @param matchInfo
	 * @return
	 */
	public AjaxMsg deleteMatchsByInfos(QMatchInfo matchInfo);

	/**
	 * 删除进球详情
	 * @param id
	 * @return
	 */
	public AjaxMsg deleteScore(String id);
	
	/**
	 * 红黄牌统计
	 * @param id
	 * @return
	 */
	public AjaxMsg getQUserDataCardStatics(Map<String, Object> maps, PageModel pageModel);
	
	/**
	 * 获取乌龙球员列表
	 * @param q_match_id
	 * @param teaminfo_id
	 * @return
	 */
	public List<QScoreInfo> getWulongData(String q_match_id, String teaminfo_id);

	/**
	 * 查询匹配球员
	 * @param maps
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryPlayerDatas(Map<String, Object> maps,PageModel pageModel);
}

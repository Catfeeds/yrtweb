package com.yt.framework.mapper.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.QMatchInfo;
import com.yt.framework.persistent.entity.QScoreInfo;
import com.yt.framework.persistent.entity.QSummaryInfo;
import com.yt.framework.persistent.entity.QUserData;


public interface QuanLeagueMapper {

	/**
	 * 保存接口联赛信息
	 * @param params
	 * @return
	 */
	public void saveQMatchInfo(QMatchInfo match);
	
	
	/**
	 * 编辑接口联赛信息
	 * @param params
	 * @return
	 */
	public void updateQMatchInfo(QMatchInfo match);
	
	/**
	 * 根据接口赛事id查询联赛信息
	 * @param params
	 * @return
	 */
	public QMatchInfo getMatchInfoByMatchId(@Param("matchId")String matchId);
	
	/**
	 * 保存接口比赛汇总数据
	 * @param params
	 * @return
	 */
	public void saveQSummaryInfo(QSummaryInfo qSummary);
	
	/**
	 * 保存接口比赛球员数据
	 * @param params
	 * @return
	 */
	public void saveQUserDataInfo(QUserData qUserData);
	
	/**
	 * <p>Description:根据id查询接口赛事信息 </p>
	 * @Author zhangwei
	 * @Date 2015年12月23日 下午6:53:18
	 * @param id
	 * @return
	 */
	public QMatchInfo getMatchInfoById(@Param("id")String id);
	
	/**
	 * <p>Description: 根据接口赛事id删除相关赛事汇总数据</p>
	 * @Author zhangwei
	 * @Date 2015年12月23日 下午8:51:18
	 * @param qmatchId
	 */
	public void deleteQSummaryInfoByQmatchId(@Param("qmatchId")String qmatchId);
	
	/**
	 * <p>Description: 根据接口赛事id删除相关赛事球员数据</p>
	 * @Author zhangwei
	 * @Date 2015年12月23日 下午8:54:18
	 * @param qmatchId
	 */
	public void deleteQUserDataByQmatchId(@Param("qmatchId")String qmatchId);
	/**
	 * <p>Description: </p>
	 * @Author zhangwei
	 * @Date 2015年12月24日 下午2:26:17
	 * @param params
	 * @return
	 */
	public List<QUserData> getQUserDataListByQmatchId(@Param(value="maps")Map<String, Object> maps);


	/**
	 * 查询主队或客队球员
	 * gl
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> queryQplayers(Map<String, Object> params);


	public int updateAllQUserData(QUserData qUserData);

	
	/**
	 * 编辑接口球员信息
	 * @param params
	 * @return
	 */
	public void updateQUserData(QUserData qUserData);
	
	/**
	 * <p>Description:通过接口赛事id查询球队比赛列表 </p>
	 * @Author ylt
	 * @Date 2015年12月24日 下午2:33:27
	 * @param id
	 * @return
	 */
	public List<QSummaryInfo> getQSummaryListByQmatchId(@Param(value="qmatchId")String qmatchId, @Param(value="teamId")String teamId);
	
	/**
	 * <p>Description: 保存接口球队进球数据</p>
	 * @Author zhangwie
	 * @Date 2015年12月24日 下午5:16:19
	 * @param scoreInfo
	 */
	public void saveQScoreInfo(QScoreInfo scoreInfo);
	
	/**
	 * <p>Description:根据接口球员id查询接口球员信息 </p>
	 * @Author zhangwei
	 * @Date 2015年12月23日 下午6:53:18
	 * @param id
	 * @return
	 */
	public QUserData getQUserDataByPlayerId(@Param("q_match_id")String q_match_id,@Param("player_id")String player_id);
	
	/**
	 * <p>Description: 根据接口赛事id删除相关进球详情数据</p>
	 * @Author zhangwei
	 * @Date 2015年12月25日 上午12:08:18
	 * @param qmatchId
	 */
	public void deleteQScoreInfoByQmatchId(@Param("qmatchId")String qmatchId);
	
	/**
	 * 全网赛事列表
	 * @param teaminfo_id
	 * @return
	 * @author ylt
	 * @date 2015-8-10 上午10:41:19
	 */
	public List<QMatchInfo> getQmatchInfoList(@Param(value="maps")Map<String, Object> maps);
	
	public int matchInfoListCount(@Param(value="maps")Map<String, Object> maps);


	public List<Map<String, Object>> queryPlayerJinQiu(Map<String, Object> params);

	/**
	 * <p>Description: 更新球队数据信息</p>
	 * @Author zhangwei
	 * @Date 2015年12月25日 上午12:08:18
	 * @param qmatchId
	 */
	public void updateQSummaryInfo(QSummaryInfo info);
	
	/**
	 * <p>Description:进球数据 </p>
	 * @Author ylt
	 * @Date 2015年12月24日 下午5:50:18
	 * @param id
	 * @return
	 */
	public List<QScoreInfo> getScoreInfoListByQmatchId(@Param("qmatchId")String qmatchId,@Param("team_id")Integer team_id,@Param("teaminfo_id")String teaminfo_id);
	
	/**
	 * <p>Description:更新进球数据 </p>
	 * @Author ylt
	 * @Date 2015年12月24日 下午5:50:18
	 * @param id
	 * @return
	 */
	public void updateQScoreInfo(QScoreInfo scoreInfo);


	public List<Map<String, Object>> queryPlayerScore(Map<String, Object> params);


	public int updateQScoreUserId(@Param("qid")String qid, @Param("uid")String uid);

	/**
	 * <p>Description:根据赛事id获取比赛记录统计 </p>
	 * @Author ylt
	 * @Date 2015年12月24日 下午5:50:18
	 * @param id
	 * @return
	 */
	public QMatchInfo getMatchInfoByRecordId(@Param("r_id")String r_id);


	public void deleteScore(@Param("id")String id);

	/**
	 * 红黄榜统计
	 * @param maps
	 * @return
	 */
	public int getQUserDataCardStaticsCount(@Param("maps")Map<String, Object> maps);

	/**
	 * 红黄榜统计
	 * @param maps
	 * @return
	 */
	public List<Map<String, Object>> getQUserDataCardStatics(@Param("maps")Map<String, Object> maps);

	/**
	 * 获取乌龙球员列表
	 * @param q_match_id
	 * @param teaminfo_id
	 * @return
	 */
	public List<QScoreInfo> getWulongData(@Param("q_match_id")String q_match_id,@Param("teaminfo_id")String teaminfo_id);


	public int queryPlayerDatasCount(Map<String, Object> params);


	public List<Map<String, Object>> queryPlayerDatas(Map<String, Object> params);
	
}

package com.yt.framework.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.BbsAccessories;
import com.yt.framework.persistent.entity.BbsChargeInfo;
import com.yt.framework.persistent.entity.BbsLeader;
import com.yt.framework.persistent.entity.BbsNote;
import com.yt.framework.persistent.entity.BbsNoteReply;
import com.yt.framework.persistent.entity.BbsPraise;
import com.yt.framework.persistent.entity.BbsPlate;
import com.yt.framework.persistent.entity.BbsTip;
import com.yt.framework.persistent.entity.BbsVote;
import com.yt.framework.persistent.entity.BbsVoteClick;
import com.yt.framework.persistent.entity.BbsVoteData;
import com.yt.framework.utils.AjaxMsg;

/**
 * 论坛mapper
 * @autor ylt
 * @date2016-1-7下午2:39:10
 */
public interface BbsNoteMapper extends BaseMapper<BbsNote>{

	/**
	 * 保存贴子附件
	 * @param bbsAccessories
	 */
	public void saveBbsAccessories(BbsAccessories bbsAccessories);
	
	/**
	 * 获取当前附件
	 * @param ac_id
	 */
	public BbsAccessories getBbsAccessoriesById(@Param(value="ac_id")String ac_id);
	
	/**
	 * 更新贴子附件
	 * @param bbsAccessories
	 */
	public void updateBbsAccessories(BbsAccessories bbsAccessories);
	
	/**
	 * 获取该贴子附件
	 * @param note_id
	 * @return
	 */
	public List<BbsAccessories> getBbsAccessoriesByNoteId(@Param(value="note_id")String note_id);
	
	/**
	 * <p>Description:添加举报 </p>
	 * @Author zhangwei
	 * @Date 2016年1月7日 下午3:55:23
	 * @param tip
	 */
	public void saveTip(BbsTip tip);
	/**
	 * <p>Description:修改举报状态 </p>
	 * @Author zhangwei
	 * @Date 2016年1月8日 下午2:16:16
	 * @param tip
	 */
	public void updateTip(BbsTip tip);
	/**
	 * <p>Description: 根据id获取举报信息</p>
	 * @Author zhangwei
	 * @Date 2016年1月7日 下午3:56:48
	 * @param id
	 * @return
	 */
	public BbsTip getTipById(String id);
	
	/**
	 * <p>Description: 分页查询举报</p>
	 * @Author zhangwei
	 * @Date 2016年1月7日 下午4:15:57
	 * @param maps
	 * @return
	 */
	public List<Map<String, Object>> queryTipsForPageSign(@Param(value="maps")Map<String,Object> maps);
	
	public int countTips(@Param(value="maps")Map<String,Object> maps);
	
	/**
	 * <p>Description: 保存投票信息</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:56:48
	 * @param id
	 * @return
	 */
	public void saveVote(BbsVote bbsVote);
		
	/**
	 * <p>Description: 更新投票信息</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:56:48
	 * @param id
	 * @return
	 */
	public void updateVote(BbsVote bbsVote);
	
	/**
	 * <p>Description: 删除投票信息</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:56:48
	 * @param id
	 * @return
	 */
	public void deleteVote(@Param(value="id")String id);
	
	/**
	 * <p>Description: 保存投票点击信息</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:56:48
	 * @param id
	 * @return
	 */
	public void saveVoteClick(BbsVoteClick bbsVoteClick);
		
	/**
	 * <p>Description: 更新投票点击信息</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:56:48
	 * @param id
	 * @return
	 */
	public void updateVoteClick(BbsVoteClick bbsVoteClick);
	
	/**
	 * <p>Description: 删除投票点击信息</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:56:48
	 * @param id
	 * @return
	 */
	public void deleteVoteClick(@Param(value="id")String id);
	
	
	/**
	 * <p>Description: 查询投票选项信息</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:56:48
	 * @param id
	 * @return
	 */
	public BbsVoteData getVoteDate(@Param(value="id")String id);
	
	/**
	 * <p>Description: 保存投票选项信息</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:56:48
	 * @param id
	 * @return
	 */
	public void saveVoteData(BbsVoteData bbsVoteData);
		
	/**
	 * <p>Description: 更新投票选项信息</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:56:48
	 * @param id
	 * @return
	 */
	public void updateVoteData(BbsVoteData bbsVoteData);
	
	/**
	 * <p>Description: 删除投票选项信息</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:56:48
	 * @param id
	 * @return
	 */
	public void deleteVoteData(@Param(value="id")String id);
	
	/**
	 * 保存回复贴子
	 * @param bbsNoteReply
	 */
	public void saveBBbsNoteReply(BbsNoteReply bbsNoteReply);
	
	/**
	 * 根据回复ID,获取回复内容
	 * @param id
	 * @return
	 */
	public BbsNoteReply getBbsNoteReplyById(@Param(value="id")String id);
	
	/**
	 * 更新贴子回复内容
	 * @param bbsNoteReplay
	 */
	public void updateBbsNoteReply(BbsNoteReply bbsNoteReply);
	
	/**
	 * 获取最新一条回复
	 * @return
	 */
	public BbsNoteReply getLastBbsNoteReply(@Param(value="note_id")String note_id);

	/**
	 * 通过ID查询帖子内容
	 * @param note_id
	 * @return
	 */
	public Map<String, Object> getBbsNoteById(@Param(value="note_id")String note_id,@Param(value="user_id")String user_id);
	
	/**
	 * 获取贴子内容
	 * @param note_id
	 * @param user_id
	 * @return
	 */
	public BbsNote getBbsNoteByNoteIdUserID(@Param(value="note_id")String note_id,@Param(value="user_id")String user_id);

	/**
	 * 根据note_id查询该帖子回复
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public List<Map<String, Object>> queryBbsNoteReplys(@Param(value="maps")Map<String, Object> params);

	public int queryBbsNoteReplysCount(@Param(value="maps")Map<String, Object> params);
	
	/**
	 * 获取用户回复贴子的次数
	 * @param note_id 贴子ID
	 * @param user_id 用户ID
	 * @return
	 */
	public int getBbsNoteReplyCountByIds(@Param(value="note_id")String note_id,@Param(value="user_id")String user_id);
	
	/**
	 * 保存购买贴子附件记录
	 * @param bbsChargeInfo
	 */
	public void saveChargeInfo(BbsChargeInfo bbsChargeInfo);
	
	/**
	 * 获取购买贴子附件记录信息
	 * @param user_id
	 * @param note_id
	 * @return
	 */
	public List<BbsChargeInfo> getBbsChargeInfoByIds(@Param(value="user_id")String user_id,@Param(value="note_id")String note_id);
	/**
	 * 获取用户购买附件IDs
	 * @param user_id
	 * @param note_id
	 * @return
	 */
	public List<String> getAccIDFromBbsCharge(@Param(value="user_id")String user_id,@Param(value="note_id")String note_id);
	
	/**
	 * 获取购买该贴子附件总数
	 * @param note_id
	 * @return
	 */
	public int getBuyBbsChargeCountByNoteId(@Param(value="note_id")String note_id);
	
	/**
	 * 获取购买该贴子附件总数
	 * @param note_id 贴子ID
	 * @param acc_id  插件ID
	 * @return
	 */
	public int getBuyBbsChargeCountByIDs(@Param(value="note_id")String note_id,@Param(value="acc_id")String acc_id);
	
	/**
	 * <p>Description: 查询投票选项</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:43:16
	 * @param note_id
	 * @return
	 */
	public List<Map<String, Object>> getVoteDataByNoteId(@Param(value="note_id")String note_id);
	
	/**
	 * <p>Description: 查询投票详情</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:43:16
	 * @param note_id
	 * @return
	 */
	public List<BbsVoteClick> getVoteClickByNoteIdAndUserId(@Param(value="note_id")String note_id,@Param(value="user_id")String user_id);

	/**
	 * 查询以点数据
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> queryPraise(BbsPraise params);

	/**
	 * 查询帖子的点赞和点踩
	 * @param bid
	 * @return
	 */
	public List<String> praiseCount(@Param(value="bid")String bid);

	/**
	 * 删除点赞或点踩
	 * @param params
	 * @return
	 */
	public int deletePraise(BbsPraise params);

	/**
	 * 保存点赞或点踩
	 * @param params
	 * @return
	 */
	public int savePraise(BbsPraise params);
	
	/**
	 * <p>Description:根据举报id获取举报相关信息 </p>
	 * @Author zhangwei
	 * @Date 2016年1月8日 下午4:52:57
	 * @param id
	 */
	public BbsTip getBbsTipById(@Param(value="id")String id);
	
	/**
	 * <p>Description: 设置帖子置顶，精华，锁定，屏蔽功能</p>
	 * @Author zhangwei
	 * @Date 2016年1月9日 下午12:04:19
	 * @param note
	 */
	public void updateBbsNoteIf(BbsNote note);
	
	/**
	 * <p>Description: 帖子的阅读量增一</p>
	 * @Author zhangwei
	 * @Date 2016年1月9日 下午3:35:16
	 * @param id
	 */
	public void updateBbsNotewriteContent(@Param(value="id")String id);
	
	/**
	 * <p>Description: 查询版本id</p>
	 * @Author ylt
	 * @Date 2016年1月9日 下午3:35:16
	 * @param id
	 */
	public BbsPlate getPlateById(@Param(value="id")String id);
	
	/**
	 * <p>Description: 根据帖子id，用户id，回复楼层查询该用户是否对这一帖子的这一楼层是否进行投诉</p>
	 * @Author zhangwei
	 * @Date 2016年1月11日 下午4:27:20
	 * @param params
	 * @return
	 */
	public int queryTipsCountByReplyIdAndNoteId(@Param(value="maps")Map<String, Object> params);
	
	/**
	 * <p>Description:查询平台列表</p>
	 * @Author ylt
	 * @Date 2016年1月11日 下午4:27:20
	 * @return
	 */
	public List<Map<String, Object>> queryPlateList();
	
	/**
	 * <p>Description: 保存板块</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20
	 * @param params
	 * @return
	 */
	public void savePlate(BbsPlate bbsPlate);
	
	/**
	 * <p>Description: 更新板块</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20
	 * @param params
	 * @return
	 */
	public void updatePlate(BbsPlate bbsPlate);
	/**
	 * <p>Description: 删除板块</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20
	 * @param params
	 * @return
	 */
	public void deletePlate(@Param(value="id")String id);
	
	/**
	 * <p>Description: 查询版主列表</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> queryLeaderList(@Param(value="id")String id);
	
	/**
	 * <p>Description: 更新版主</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20
	 * @param bbsLeader
	 * @return
	 */
	public void updateBbsLeader(BbsLeader bbsLeader);
	
	/**
	 * <p>Description: 保存版主</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20 
	 * @param bbsLeader
	 * @return
	 */
	public void saveBbsLeader(BbsLeader bbsLeader);
	
	/**
	 * <p>Description: 删除版主</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20 
	 * @param id
	 * @return
	 */
	public void deleteBbsLeader(@Param(value="id")String id);
	
	/**
	 * <p>Description: 查询版主</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20 
	 * @param id
	 * @return
	 */
	public BbsLeader getBbsLeaderById(@Param(value="id")String id);
	
	/**
	 * 获取用户版主信息
	 * @param user_id 用户ID
	 * @param plate_id 版块ID
	 * @return
	 */
	public BbsLeader getBbsLeaderByUserID(@Param("user_id")String user_id,@Param("plate_id")String plate_id);
	
	/**
	 * 更新投票总数
	 * @param user_id 用户ID
	 * @param plate_id 版块ID
	 * @return
	 */
	public void updateVoteDataCount(@Param("data_id")String data_id);

	/**
	 * 删除附件 假删
	 * @param aid
	 */
	public void deleteAccessories(@Param("id")String id);
	
	/**
	 * <p>Description: 查询一个版块置顶的帖子的个数</p>
	 * @Author zhangwei
	 * @Date 2016年1月15日 下午2:46:03
	 * @param plate_id
	 * @return
	 */
	public int queryBbsNoteTopCount(@Param("plate_id")String plate_id);
	
}

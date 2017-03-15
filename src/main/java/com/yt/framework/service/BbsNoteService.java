package com.yt.framework.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.BbsAccessories;
import com.yt.framework.persistent.entity.BbsChargeInfo;
import com.yt.framework.persistent.entity.BbsLeader;
import com.yt.framework.persistent.entity.BbsNote;
import com.yt.framework.persistent.entity.BbsPlate;
import com.yt.framework.persistent.entity.BbsPraise;
import com.yt.framework.persistent.entity.BbsTip;
import com.yt.framework.persistent.entity.BbsVote;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 * @Title: NoteService.java 
 * @Package com.yt.framework.service
 * @author YLT
 * @date 2016年1月7日 上午11:57:21 
 */
public interface BbsNoteService extends BaseService<BbsNote>{
	/**
	 * <p>Description: 添加论坛举报</p>
	 * @Author zhangwei
	 * @Date 2016年1月7日 下午3:43:16
	 * @param tip
	 * @return
	 */
	public AjaxMsg saveBbsTip(BbsTip tip);
	/**
	 * <p>Description:修改举报信息 </p>
	 * @Author zhangwei
	 * @Date 2016年1月8日 下午2:19:40
	 * @param tip
	 * @return
	 */
	public AjaxMsg updateBbsTip(BbsTip tip);
	/**
	 * 更新或保存发布贴子
	 * @param params
	 * @return
	 */
	public AjaxMsg saveOrUpdateNote(Map<String,Object> params,List<BbsAccessories> attrcs) throws Exception;	
	/**
	 * <p>Description: 保存投票信息</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:43:16
	 * @param bbsVote bbsNote names
	 * @return
	 */
	public AjaxMsg saveVote(BbsVote bbsVote, BbsNote bbsNote, String[] names)throws Exception;
	
	/**
	 * <p>Description: 查询投票选项</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:43:16
	 * @param note_id
	 * @return
	 */
	public AjaxMsg getVoteDataByNoteId(String note_id);
	
	/**
	 * <p>Description: 更新投票选项</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:43:16
	 * @param note_id
	 * @return
	 */
	public AjaxMsg updateVote(String []ids,String user_id)throws Exception;
	
	/**
	 * <p>Description: 判断是否已投票</p>
	 * @Author ylt
	 * @Date 2016年1月7日 下午3:43:16
	 * @param note_id
	 * @return
	 */
	public boolean ifVote(String note_id,String user_id);
	
	/**
	 * <p>Description: 根据id获取举报信息</p>
	 * @Author zhangwei
	 * @Date 2016年1月7日 下午3:56:48
	 * @param id
	 * @return
	 */
	public BbsTip getTipById(String id);
	
	/**
	 * 保存或更新贴子回复
	 * @param params
	 * @return
	 */
	public AjaxMsg saveOrUpateBbsNoteReplay(Map<String,Object> params)throws Exception;
	
	/**
	 * <p>Description:查询论坛举报列表 </p>
	 * @Author zhangwei
	 * @Date 2016年1月7日 下午4:15:28
	 * @param map
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryTipsForPageSign(Map<String, Object> map, PageModel pageModel);
	
	public int countTips(Map<String,Object> maps);
	/**
	 * 通过ID查询帖子内容
	 * @param note_id
	 * @return
	 */
	public Map<String, Object> getBbsNoteById(String note_id,String user_id);
	/**
	 * 根据note_id查询该帖子回复
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public PageModel queryBbsNoteReplys(Map<String, Object> params,PageModel pageModel);
	/**
	 * 帖子点赞或点踩
	 * @param praise
	 * @return
	 */
	public AjaxMsg updatePraise(BbsPraise praise) throws Exception;
	
	/**
	 * 购买贴子附件
	 * @param params
	 * @return
	 */
	public AjaxMsg saveChargeInfo(Map<String,Object> params)throws Exception;
	
	/**
	 * 获取购买贴子附件记录信息
	 * @param user_id
	 * @param note_id
	 */
	public AjaxMsg getBbsChargeInfoByIds(String user_id,String note_id);
	
	/**
	 * <p>Description: 根据举报id获取举报相关信息</p>
	 * @Author zhangwei
	 * @Date 2016年1月8日 下午4:56:03
	 * @param id
	 * @return
	 */
	public AjaxMsg getBbsTipById(String id);
	
	/**
	 * <p>Description:设置帖子置顶，精华，锁定，屏蔽功能 </p>
	 * @Author zhangwei
	 * @Date 2016年1月9日 下午12:21:23
	 * @param note
	 * @return
	 */
	public AjaxMsg updateBbsNoteIf(BbsNote note);
	
	/**
	 * <p>Description:帖子的阅读量增一统计 </p>
	 * @Author zhangwei
	 * @Date 2016年1月9日 下午3:39:43
	 * @param id
	 * @return
	 */
	public AjaxMsg updateBbsNotewriteContent(String id);
	
	/**
	 * <p>Description: 查询版本id</p>
	 * @Author ylt
	 * @Date 2016年1月9日 下午3:35:16
	 * @param id
	 */
	public BbsPlate getPlateById(String id);
	
	/**
	 * <p>Description: 根据回复id，帖子id，用户id，回复楼层查询该用户是否对这一帖子的这一楼层是否进行投诉</p>
	 * @Author zhangwei
	 * @Date 2016年1月11日 下午4:27:20
	 * @param params
	 * @return
	 */
	public int queryTipsCountByReplyIdAndNoteId(Map<String, Object> params);
	
	/**
	 * <p>Description: 查询板块信息</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20
	 * @param params
	 * @return
	 */
	public AjaxMsg queryPlateList();
	/**
	 * <p>Description: 保存板块</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20
	 * @param params
	 * @return
	 */
	public AjaxMsg savePlate(BbsPlate bbsPlate)throws Exception;
	
	/**
	 * <p>Description: 更新板块</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20
	 * @param params
	 * @return
	 */
	public AjaxMsg updatePlate(BbsPlate bbsPlate)throws Exception;
	
	/**
	 * <p>Description: 删除板块</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20
	 * @param params
	 * @return
	 */
	public AjaxMsg deletePlate(String id)throws Exception;
	/**
	 * <p>Description: 获取版主列表</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20
	 * @param params
	 * @return
	 */
	public AjaxMsg queryLeaderList(String id);
	
	/**
	 * 获取该贴子附件
	 * @param note_id
	 * @return
	 */
	public List<BbsAccessories> getBbsAccessoriesByNoteId(String note_id);
	
	/**
	 * 获取购买该贴子附件总数
	 * @param note_id
	 * @return
	 */
	public int getBuyBbsChargeCountByNoteId(String note_id);
	
	/**
	 * 获取用户回复贴子的次数
	 * @param note_id 贴子ID
	 * @param user_id 用户ID
	 * @return
	 */
	public int getBbsNoteReplyCountByIds(String note_id,String user_id);
	/**
	 * <p>Description: 更新版主信息</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20
	 * @param params
	 * @return
	 */
	public AjaxMsg updateBbsLeader(BbsLeader bbsLeader)throws Exception;
	/**
	 * <p>Description: 保存版主信息</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20
	 * @param params
	 * @return
	 */
	public AjaxMsg saveBbsLeader(BbsLeader bbsLeader)throws Exception;
	
	/**
	 * <p>Description: 删除版主信息</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20
	 * @param params
	 * @return
	 */
	public AjaxMsg deleteBbsLeader(String id)throws Exception;
	
	/**
	 * <p>Description: 删除版主信息</p>
	 * @Author ylt
	 * @Date 2016年1月12日 下午4:27:20
	 * @param params
	 * @return
	 */
	public BbsLeader getBbsLeaderById(String id);
	
	/**
	 * 更新附件信息
	 * @param ac_id
	 * @return
	 */
	public AjaxMsg updateBbsAccessories(String ac_id);
	
	/**
	 * 删除用户发布贴子
	 * @param user_id
	 * @param note_id
	 * @return
	 */
	public AjaxMsg deleteNoteBYOwner(String user_id,String plate_id,String note_id);
	
	/**
	 * 判断用户是否已投票
	 * @param user_id
	 * @param note_id
	 * @return
	 */
	public boolean checkIfVote(String note_id, String user_id);
	
	/**
	 * 用户投票保存
	 * @param user_id
	 * @param note_id
	 * @return
	 */
	public AjaxMsg saveVoteClick(String ids, String user_id, String note_id)throws Exception;
	
	/**
	 * 删除用户对贴子的回复
	 * @param reply_id 贴子回复表ID
	 * @param user_id 用户ID
	 * @param note_id 贴子ID
	 * @return
	 */
	public AjaxMsg deleteNoteReply(String reply_id,String user_id,String plate_id,String note_id);
	/**
	 * 更具ID获取帖子回复
	 * @param rid
	 * @return
	 */
	public AjaxMsg getBbsNoteReplyById(String rid);
	
	/**
	 * 判断是否版主
	 * @param rid
	 * @return
	 */
	public boolean ifLeader(String user_id,String plate_id);
	/**
	 * 编辑帖子里删除附件
	 * @param aid
	 * @return
	 */
	public AjaxMsg deleteAccessories(String aid);
	
	/**
	 * <p>Description: 查询一个版块置顶的帖子的个数</p>
	 * @Author zhangwei
	 * @Date 2016年1月15日 下午2:47:05
	 * @param plate_id
	 * @return
	 */
	public int queryBbsNoteTopCount(String plate_id);
	
	/**
	 * 获取购买该贴子附件总数
	 * @param note_id 贴子ID
	 * @param acc_id  插件ID
	 * @return
	 */
	public int getBuyBbsChargeCountByIDs(String note_id,String acc_id);
	
	/**
	 * 获取用户购买附件IDs
	 * @param user_id
	 * @param note_id
	 * @return
	 */
	public List<String> getAccIDFromBbsCharge(@Param(value="user_id")String user_id,@Param(value="note_id")String note_id);
}

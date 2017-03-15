package com.yt.framework.service;

import java.util.List;
import java.util.Map;

import com.yt.framework.persistent.entity.TeamLoanMsg;
import com.yt.framework.persistent.entity.TeamLoanPlayer;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;
/**
 *俱乐部对战
 *@autor ylt
 *@date2016-6-13下午3:15:49
 */
public interface TeamLoanPlayerService extends BaseService<TeamLoanPlayer>{

	/**
	 * 查询租借申请信息
	 * @autor gl
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg queryTeamLoanMsg(Map<String, Object> params, PageModel pageModel);
	
	public int teamLoanMsgCount(Map<String, Object> params);

	/**
	 * 修改租借信息状态
	 * @autor gl
	 * @param id
	 * @param type
	 * @return
	 */
	public AjaxMsg updateLoanManage(TeamLoanMsg loanMsg,String type) throws Exception;

	public TeamLoanMsg getTeamLoanMsgById(String id);
	
	
	/**
	 * 保存申请信息
	 * @autor gl
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg saveLoanMsg(TeamLoanMsg teamLoanMsg)throws Exception;
	
	/**
	 * 修改租借消息
	 * @autor ylt
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public AjaxMsg updateLoanMsg(TeamLoanMsg teamLoanMsg)throws Exception;
	
	/**
	 * 检测出租方和租借方是否可以租借
	 * @param sellTeamId 出租方
	 * @param buyTeamId  租借方
	 * @return
	 */
	public String checkIfLoan(String sellTeamId,String buyTeamId);
	
	/**
	 * 检测租借方是否可以查看租借按钮
	 * @param buyTeamId  租借方
	 * @return
	 */
	public boolean checkIfLoanShow(String buyTeamId);
	
	/**
	 * 删除租借信息
	 * @autor ylt
	 * @param id
	 * @param type
	 * @return
	 */
	public AjaxMsg deleteTeamLoanMsg(String id) throws Exception;
	
	/**
	 * 查询租借申请信息
	 * @autor gl
	 * @param params
	 * @param pageModel
	 * @return
	 */
	public List<TeamLoanPlayer> getTeamPlayersByTeamInfoId(String teaminfo_id);
	
	/**
	 * 更新租借号码
	 * @autor ylt
	 * @param id
	 * @param parseInt
	 * @return
	 */
	public AjaxMsg updateNum(String id, int num)throws Exception;
	
	/**
	 * 租借详情
	 * @autor ylt
	 * @param s_id
	 * @param turn_num
	 * @return
	 */
	public List<Map<String, Object>> getTeamLoanDetailData(String s_id, String turn_num);
	
}

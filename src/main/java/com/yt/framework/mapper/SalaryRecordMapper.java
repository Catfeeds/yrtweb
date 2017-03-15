package com.yt.framework.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yt.framework.persistent.entity.QMatchInfo;
import com.yt.framework.persistent.entity.QUserData;
import com.yt.framework.persistent.entity.SalaryMsg;
import com.yt.framework.persistent.entity.SalaryRecord;

/**
 * 工资发送记录
 * 
 * @autor bo.xie
 * @date 2016年3月2日16:14:36
 */
public interface SalaryRecordMapper extends BaseMapper<SalaryRecord> {

	public List<SalaryMsg> getSalaryMsg(@Param(value = "event_id") String event_id,
			@Param(value = "teaminfo_id") String teaminfo_id);

	public List<SalaryRecord> getSalaryRecord(@Param(value = "srmsg_id") String srmsg_id);

	public List<QMatchInfo> getMatchInfo(@Param(value = "event_id") String event_id);

	public List<QUserData> getQuserData(@Param(value = "q_match_id") String q_match_id);

	public void updateSalaryRecord(@Param(value = "o") SalaryRecord o);

	public SalaryMsg getSalaryMsgByID(@Param(value = "id") String id);

	public void updateSalaryMsg(@Param(value = "o")SalaryMsg o);
}

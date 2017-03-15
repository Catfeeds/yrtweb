package com.yt.framework.service.Impl.adminImpl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yt.framework.mapper.admin.AccountMapper;
import com.yt.framework.persistent.entity.UserAmount;
import com.yt.framework.service.Impl.VisitorServiceImpl;
import com.yt.framework.service.admin.AccountService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 *
 *@autor bo.xie
 *@date2015-8-27下午2:22:53
 */
@Transactional
@Service("accountService")
public class AccountServiceImpl implements AccountService{
	
	protected static Logger logger = LogManager.getLogger(AccountServiceImpl.class);
	
	@Autowired
	private AccountMapper accountMapper;

	@Override
	public AjaxMsg loadPayRecords(Map<String, Object> maps,
			PageModel pageModel) {
		if(pageModel!=null){
			maps.put("start", pageModel.getFirstNum());
			maps.put("rows", pageModel.getPageSize());
			int totalCount = accountMapper.getPayRecordsCount(maps);
			pageModel.setTotalCount(totalCount);
		}
		List<Map<String,Object>> datas = accountMapper.loadPayRecords(maps);
		return AjaxMsg.newSuccess().addData("datas", datas).addData("page", pageModel);
	}

	@Override
	public BigDecimal getPayRecordSum(String status) {
		return accountMapper.getPayRecordSum(StringUtils.isBlank(status)?"1":status);
	}

	@Override
	public AjaxMsg loadCostRecord(Map<String, Object> maps, PageModel pageModel) {
		if(pageModel!=null){
			maps.put("start", pageModel.getFirstNum());
			maps.put("rows", pageModel.getPageSize());
			int totalCount = accountMapper.getPayCostCount(maps);
			pageModel.setTotalCount(totalCount);
		}
		List<Map<String,Object>> datas = accountMapper.loadCostRecord(maps);
		return AjaxMsg.newSuccess().addData("datas", datas).addData("page", pageModel);
	}

	@Override
	public AjaxMsg loadUserAmountDatas(Map<String, Object> maps, PageModel pageModel) {
		if(pageModel!=null){
			maps.put("start", pageModel.getFirstNum());
			maps.put("rows", pageModel.getPageSize());
			int totalCount = accountMapper.loadUserAmountDatasCount(maps);
			pageModel.setTotalCount(totalCount);
		}
		List<Map<String,Object>> datas = accountMapper.loadUserAmountDatas(maps);
		return AjaxMsg.newSuccess().addData("datas", datas).addData("page", pageModel);
	}

	@Override
	public void updateUserAmount(UserAmount userAmount) {
		accountMapper.updateUserAmount(userAmount);
	}

	@Override
	public UserAmount getUserAmount(String id) {
		return accountMapper.getUserAmount(id);
	}

	@Override
	public Map<String, Object> loadTotalAmount(Map<String, Object> maps) {
		return accountMapper.loadTotalAmount(maps);
	}

	@Override
	public Map<String, Object> loadTotalRecord(Map<String, Object> maps) {
		return accountMapper.loadTotalRecord(maps);
	}

}

package com.yt.framework.service.Impl.adminImpl;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yt.framework.mapper.admin.AdminBabyInfoMapper;
import com.yt.framework.persistent.entity.BabyInfo;
import com.yt.framework.service.admin.AdminBabyInfoService;
import com.yt.framework.utils.PageModel;

@Service("adminBabyInfoService")
public class AdminBabyInfoServiceImpl implements AdminBabyInfoService {
	
	protected static Logger logger = LogManager.getLogger(AdminBabyInfoServiceImpl.class);

	@Autowired
	private AdminBabyInfoMapper adminBabyInfoMapper;
	
	@Override
	public void updateBabyInfo(BabyInfo babyInfo) {
		adminBabyInfoMapper.updateBabyInfo(babyInfo);
	}

	@Override
	public List<Map<String, Object>> loadBabyDataPage(Map<String, Object> maps,PageModel pageModel) {

		int totalCount = adminBabyInfoMapper.loadBabyDataCount(maps);
		pageModel.setTotalCount(totalCount);
		maps.put("start",pageModel.getFirstNum());
		maps.put("rows",pageModel.getPageSize());
		
		return adminBabyInfoMapper.loadBabyDataPage(maps);
	}

	@Override
	public BabyInfo getBabyInfoById(String id) {
		return adminBabyInfoMapper.getBabyInfoById(id);
	}

	@Override
	public int isExistByShowNum(String show_num) {
		return adminBabyInfoMapper.isExistByShowNum(show_num);
	}

}

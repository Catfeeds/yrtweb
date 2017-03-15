package com.yt.framework.service.Impl.adminImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.yt.framework.mapper.admin.AdminSysAreaMapper;
import com.yt.framework.persistent.entity.SysArea;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.admin.AdminSysAreaService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

@Service("adminSysAreaService")
public class AdminSysAreaServiceImpl implements AdminSysAreaService{
	
	protected static Logger logger = LogManager.getLogger(AdminSysAreaServiceImpl.class);
	@Autowired
	MessageResourceService messageResourceService;
	@Autowired
	AdminSysAreaMapper adminSysAreaMapper;
	
	public List<Map<String, Object>> querySysArea(String parent_code) {
		return adminSysAreaMapper.querySysArea(parent_code);
	}
	
	public List<SysArea> sysAreaList(String parent_code) {
		return adminSysAreaMapper.sysAreaList(parent_code);
	}
	
	public AjaxMsg saveSysArea(SysArea sysArea) throws Exception {
		String paren_code = sysArea.getParent_code();
		SysArea parentArea = adminSysAreaMapper.getAreaByCode(paren_code);
		if(parentArea.getLeaf() == 1){
			parentArea.setLeaf(0);
			adminSysAreaMapper.updateSysArea(parentArea);
		}
		adminSysAreaMapper.saveSysArea(sysArea);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	
	//@CacheEvict(value="areaCache",key="'areaCache'+#sysArea.area_code")
	@CacheEvict(value={"objCache","areaCache"},key="'areaCode'+#sysArea.area_code")
	public AjaxMsg updateSysArea(SysArea sysArea) throws Exception {
		adminSysAreaMapper.updateSysArea(sysArea);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	
	public AjaxMsg queryForPage(Map<String, Object> maps, PageModel pageModel) {
		List<SysArea> datas = new ArrayList<SysArea>();
		int count = 0 ;
		if(maps!=null){
			if(pageModel!=null){
				count = count(maps);
				pageModel.setTotalCount(count);
				maps.put("start",pageModel.getFirstNum());
				maps.put("rows",pageModel.getPageSize());
			}
			datas = adminSysAreaMapper.queryForPage(maps);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}
	
	public int count(Map<String, Object> maps) {
		return adminSysAreaMapper.count(maps);
	}
	
	public SysArea getEntityById(Long id) {
		return adminSysAreaMapper.getEntityById(id);
	}
	
	public List<SysArea> allSysArea() {
		return adminSysAreaMapper.allSysArea();
	}
	
	
	@Cacheable(value="objCache",key="'areaCode'+#area_code")
	public String id2Name(String area_code) {
		return adminSysAreaMapper.id2Name(area_code);
	}
	
	
	@Cacheable(value="areaCache",key="'areaCode'+#area_code")
	public SysArea getAreaByCode(@Param(value="area_code")String area_code){
		return adminSysAreaMapper.getAreaByCode(area_code);
	}
	
	@CacheEvict(value={"objCache","areaCache"},key="'areaCode'+#sysArea.area_code")
	public AjaxMsg delSysArea(SysArea sysArea) throws Exception {
		adminSysAreaMapper.delSysArea(sysArea.getId());
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}
	
}
	
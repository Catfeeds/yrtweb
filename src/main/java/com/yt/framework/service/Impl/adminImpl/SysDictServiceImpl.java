package com.yt.framework.service.Impl.adminImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.yt.framework.mapper.SysDictMapper;
import com.yt.framework.persistent.entity.SysDict;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.admin.SysDictService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

@Service("sysDictService")
public class SysDictServiceImpl implements SysDictService{
	
	protected static Logger logger = LogManager.getLogger(SysDictServiceImpl.class);
	@Autowired
	MessageResourceService messageResourceService;
	
	@Autowired
	SysDictMapper sysDictMapper;
	
	@Override
	@Cacheable(value = "dictCache",key="'queryDicts'+#clm")
	public List<Map<String, Object>> queryDicts(String clm) {
		return sysDictMapper.queryDicts(clm);
	}

	@Override
	@Cacheable(value = "dictCache",key="'dictList'+#clm")
	public List<SysDict> dictList(String clm) {
		return sysDictMapper.dictList(clm);
	}

	@Override
	@Cacheable(value = "dictCache",key="'dictName'+#dict_column+#dictId")
	public String dictName(String dict_column,String dictId) {
		return sysDictMapper.dictName(dict_column,dictId);
	}

	@Override
	public AjaxMsg saveDict(SysDict sysDict)throws Exception {
		sysDictMapper.saveDict(sysDict);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	@CacheEvict(value = "dictCache",allEntries = true)
	public AjaxMsg updateDict(SysDict sysDict)throws Exception {
		sysDictMapper.updateDict(sysDict);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AjaxMsg queryForPage(Map<String, Object> maps, PageModel pageModel) {
		List<SysDict> datas = new ArrayList<SysDict>();
		int count = 0 ;
		if(maps!=null){
			if(pageModel!=null){
				count = count(maps);
				pageModel.setTotalCount(count);
				maps.put("start",pageModel.getFirstNum());
				maps.put("rows",pageModel.getPageSize());
			}
			datas = sysDictMapper.queryForPage(maps);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}
	
	@Override
	public int count(Map<String, Object> maps) {
		return sysDictMapper.count(maps);
	}
	
	@Override
	public SysDict getEntityById(Long id) {
		return sysDictMapper.getEntityById(id);
	}

	@Override
	public List<SysDict> allDict() {
		return sysDictMapper.allDict();
	}

}
	
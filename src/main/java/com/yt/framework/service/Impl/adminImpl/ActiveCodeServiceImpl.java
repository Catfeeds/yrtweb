package com.yt.framework.service.Impl.adminImpl;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yt.framework.mapper.admin.ActiveCodeMapper;
import com.yt.framework.persistent.entity.ActiveCode;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.admin.ActiveCodeService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

@Service("activeCodeService")
public class ActiveCodeServiceImpl implements ActiveCodeService{
	
	protected static Logger logger = LogManager.getLogger(ActiveCodeServiceImpl.class);

	@Autowired
	private ActiveCodeMapper activeCodeMapper;
	@Autowired 
	private MessageResourceService messageResourceService;
	
	@Override
	public AjaxMsg loadActiveCodes(Map<String, Object> maps,PageModel pageModel) {
		if(pageModel!=null){
			maps.put("start", pageModel.getFirstNum());
			maps.put("rows", pageModel.getPageSize());
			int totalCount = activeCodeMapper.loadActiveCodesCount(maps);
			pageModel.setTotalCount(totalCount);
		}
		List<Map<String,Object>> datas = activeCodeMapper.loadActiveCodes(maps);
		return AjaxMsg.newSuccess().addData("datas", datas).addData("page", pageModel);
	}

	@Override
	public AjaxMsg updateCode(ActiveCode activeCode) throws Exception{
		activeCodeMapper.updateCode(activeCode);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.error.league.codeactiveok"));
	}

	@Override
	public ActiveCode getActiveCodeByCode(String code_str) {
		return activeCodeMapper.getActiveCodeByCode(code_str);
	}

	@Override
	public ActiveCode getActiveCode(String code_str) {
		return activeCodeMapper.getActiveCode(code_str);
	}

	@Override
	public AjaxMsg saveActiveCode(ActiveCode activeCode)throws Exception{
		activeCodeMapper.saveActiveCode(activeCode);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public ActiveCode getActiveCodeByTeam(String league_id, String teaminfo_id) {
		return activeCodeMapper.getActiveCodeByTeam(league_id, teaminfo_id);
		
	}

	@Override
	public ActiveCode getEntityById(String id) {
		return activeCodeMapper.getEntityById(id);
	}

		
}

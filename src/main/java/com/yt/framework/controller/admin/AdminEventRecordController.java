package com.yt.framework.controller.admin;

import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.collect.Lists;
import com.yt.framework.controller.BaseController;
import com.yt.framework.persistent.entity.AdminEventRecord;
import com.yt.framework.persistent.entity.League;
import com.yt.framework.service.FileService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.admin.AdminEventRecordService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.file.UploadUtils;

/**
 * 赛程管理
 * @author YJH
 *
 * 2015年11月10日
 */
@Controller
@RequestMapping(value = "/admin/eventRecord")
public class AdminEventRecordController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(AdminEventRecordController.class);

	@Autowired
	private AdminEventRecordService adminEventRecordService;
	@Autowired
	private LeagueService leagueService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Autowired 
	private	FileService fileService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {  
	       SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	       dateFormat.setLenient(false);  
	       binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));  
	   } 
	
	@RequestMapping(value = "")
	public String index(HttpServletRequest request, PageModel pageModel) {
		String name = request.getParameter("league_name");
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		Map<String, Object> params = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(name)){
			params.put("name", name);
		}
		params.put("league_id", league_id);
		AjaxMsg msg = leagueService.queryForPage(params, pageModel);
		 //adminLeagueGroupService.queryForPageForMap(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		request.setAttribute("params", params);
		request.setAttribute("league_id", league_id);
		return "admin/eventrecord/eventLeague";
	}
	
	@RequestMapping(value="/selectEventRecord")
	public String dialog(HttpServletRequest request,PageModel pageModel){
		String league_id = request.getParameter("league_id");
		String teaminfoName = request.getParameter("teaminfo_name");
		String type = request.getParameter("type");
		Map<String, Object> params = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(league_id)) params.put("league_id", league_id);
		if(StringUtils.isNotBlank(teaminfoName)) params.put("teaminfo_name", teaminfoName);
		AjaxMsg msg = adminEventRecordService.queryForPageForMap(params, pageModel);
		request.setAttribute("page", msg.getData("page"));
		params.put("type", type);
		request.setAttribute("params",params);
		return "admin/eventrecord/select_eventrecord"; 
	}

	/**
	 * 进入编辑页面
	 * 
	 * @param request
	 * @return form.jsp
	 */
	@RequestMapping(value = "/eventList")
	public String eventList(HttpServletRequest request) {
		String league_id = BeanUtils.nullToString(request.getParameter("id"));
		League league = leagueService.getEntityById(league_id);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("league_id", league_id);
		params.put("group_id",  BeanUtils.nullToString(request.getParameter("group_id")));
		AjaxMsg msg = adminEventRecordService.queryEventRecordByLeague(params);
		request.setAttribute("listGroup", msg.getData("listGroup"));
		request.setAttribute("events", msg.getData("events"));
		request.setAttribute("league", league);
		return "admin/eventrecord/eventList";
	}

	/**
	 * 进入编辑页面
	 * 
	 * @param request
	 * @return form.jsp
	 */
	@RequestMapping(value = "/newEventList")
	public String newEventList(HttpServletRequest request) {
		String league_id = BeanUtils.nullToString(request.getParameter("id"));
		League league = leagueService.getEntityById(league_id);
		int rounds =  league.getRounds();
		Map<String, Object> params = new HashMap<String, Object>();
		List<Object> turnList = Lists.newArrayList();
		params.put("league_id", league_id);
		params.put("group_id",  BeanUtils.nullToString(request.getParameter("group_id")));
		AjaxMsg msg = adminEventRecordService.queryEventRecordByLeague(params);
		List<Map<String,Object>> list =  (List<Map<String, Object>>) msg.getData("events");
		for(int i = 1 ;i <= rounds ;i++){
			List<Object> resultList = Lists.newArrayList();
			for (Map<String, Object> map : list) {
				if((int)map.get("rounds") == i){
					resultList.add(map);
				}
			}
			turnList.add(resultList);
		}
		
		request.setAttribute("events", msg.getData("events"));
		request.setAttribute("rounds", rounds);
		request.setAttribute("turnList", turnList);
		request.setAttribute("league", league);
		return "admin/eventrecord/newEventList";
	}	
	
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public String saveOrUpdate(HttpServletRequest request,
			AdminEventRecord aef) {
		AjaxMsg msg = AjaxMsg.newSuccess();
		
		if (StringUtils.isNotBlank(aef.getId())) {
			try {
				msg = adminEventRecordService.updateEventRecord(aef);
			} catch (Exception e) {
				e.printStackTrace();
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
			}
			
		} else {
			aef.setId(UUIDGenerator.getUUID());
			msg = adminEventRecordService.save(aef);
		}
		return msg.toJson();
	}

	@RequestMapping(value = "/delete")
	@ResponseBody
	public String deleteRole(HttpServletRequest request) {
		String id = request.getParameter("id");
		AjaxMsg msg = adminEventRecordService.delete(id);
		return msg.toJson();
	}
	
	/**
	 * 进入编辑页面
	 * 
	 * @param request
	 * @return form.jsp
	 */
	@RequestMapping(value = "/formJsp")
	public String formJsp(HttpServletRequest request) {
		String league_id = request.getParameter("league_id");
		String id = request.getParameter("id");
		String flag = request.getParameter("flag");
		League league = leagueService.getEntityById(league_id);
		AdminEventRecord adminEventRecord = new AdminEventRecord();
		if(StringUtils.isNotBlank(id)){
			adminEventRecord = adminEventRecordService.getEntityById(id);
			request.setAttribute("event", adminEventRecord);
		}
		if(StringUtils.isNotBlank(flag)){
			request.setAttribute("flag", flag);
		}
		request.setAttribute("league", league);
		return "admin/eventrecord/form";
	}
	
	/**
	 * 进入编辑页面
	 * 
	 * @param request
	 * @return formBathcJsp.jsp
	 */
	@RequestMapping(value = "/formBathcJsp")
	public String formBathcJsp(HttpServletRequest request) {
		String league_id = request.getParameter("league_id");
		League league = leagueService.getEntityById(league_id);
		request.setAttribute("league", league);
		return "admin/eventrecord/batch_form";
	}
	
	
	
	@RequestMapping(value="/dialog")
	public String dialog(HttpServletRequest request){
		String dom_id = request.getParameter("dom_id");
		String dom_name = request.getParameter("dom_name");
		String group_id = request.getParameter("group_id");
		String league_id = request.getParameter("league_id");
		request.setAttribute("dom_id", BeanUtils.nullToString(dom_id));
		request.setAttribute("dom_name", BeanUtils.nullToString(dom_name));
		request.setAttribute("group_id", BeanUtils.nullToString(group_id));
		request.setAttribute("league_id", BeanUtils.nullToString(league_id));
		return "admin/leagueteam/dialog";
	}
	/**
	 * 生成俱乐部对战历史记录：修改俱乐部对战数据包括胜平负、战斗力等，添加俱乐部对战历史记录
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/saveGame")
	@ResponseBody
	public String saveGame(HttpServletRequest request){
		String id = BeanUtils.nullToString(request.getParameter("id"));
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = adminEventRecordService.saveGameByRecordId(id);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	/**
	 * 生成俱乐部对战历史记录：修改俱乐部对战数据包括胜平负、战斗力等，添加俱乐部对战历史记录
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/delGame")
	@ResponseBody
	public String delGame(HttpServletRequest request){
		String id = BeanUtils.nullToString(request.getParameter("id"));
		AjaxMsg msg = AjaxMsg.newSuccess();
		try {
			msg = adminEventRecordService.delGameByRecordId(id);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		return msg.toJson();
	}
	
	@RequestMapping(value = "/uploadFile")
	@ResponseBody
	public String uploadFile(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request,HttpServletResponse response){
		AjaxMsg msg = AjaxMsg.newSuccess();
		needLoginAjaxJson(request);
		String league_id = BeanUtils.nullToString(request.getParameter("league_id"));
		String group_id = BeanUtils.nullToString(request.getParameter("group_id"));
		if(StringUtils.isBlank(league_id)){
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error")).toJson();
		}
		try {
			msg = fileService.uploadExcelFile(file);
			if(msg.isSuccess()){
				String fileName = String.valueOf(msg.getData("src"));
				String realPath = UploadUtils.getRealPath(fileName);
				msg = this.readExcelFile(realPath,league_id,group_id);
			}
		} catch (IOException e) {
			logger.error("上传失败");
			
		}
		
		return  msg.toJson();
	} 
	
	 public AjaxMsg readExcelFile(String fileName,String league_id,String group_id){
		  //创建对Excel工作薄文件的引用
		  try{
			   FileInputStream in = new FileInputStream(fileName);
			   Workbook wb;
			   if(fileName.endsWith(".xls")) { 
				   //Excel2003
			   		wb = new HSSFWorkbook(in); 
			   }else{ 
			    	wb = new XSSFWorkbook(in); 
			   } 
			   //创建对工作表的引用
			   Sheet sheet= wb.getSheetAt(0);
			   //遍历所有单元格，读取单元格
			   int row_num = sheet.getLastRowNum();
			   //项目名称
			   for(int i=1 ;i<= row_num ;i++){
				   Row row = sheet.getRow(i);
				   int rounds = Integer.parseInt(getValue(row.getCell(0)));
				   String m_team_name = getValue(row.getCell(1));
				   String g_team_name = getValue(row.getCell(2));
				   Date play_time = row.getCell(3).getDateCellValue();
				   String position = getValue(row.getCell(4));
				   int ball_format = Integer.parseInt(getValue(row.getCell(5)));
				   AdminEventRecord adminEventRecord = new AdminEventRecord();
				   adminEventRecord.setId(UUIDGenerator.getUUID32());
				   adminEventRecord.setLeague_id(league_id);
				   adminEventRecord.setGroup_id(group_id);
				   adminEventRecord.setRounds(rounds);
				   adminEventRecord.setPlay_time(play_time);
				   adminEventRecord.setPosition(position);
				   adminEventRecord.setBall_format(ball_format);
				   List<Map<String, Object>> teams = leagueService.getTeamLeagueByLeague(league_id);
				   for (Iterator<Map<String, Object>> iterator = teams.iterator(); iterator.hasNext();) {
					   Map<String, Object> team = (Map<String, Object>) iterator.next();
					   if(BeanUtils.nullToString(team.get("name")).equals(m_team_name)){
						   adminEventRecord.setM_team_name(m_team_name);
						   adminEventRecord.setM_teaminfo_id(BeanUtils.nullToString(team.get("teaminfo_id")));
					   }else if(BeanUtils.nullToString(team.get("name")).equals(g_team_name)){
						   adminEventRecord.setG_team_name(g_team_name);
						   adminEventRecord.setG_teaminfo_id(BeanUtils.nullToString(team.get("teaminfo_id")));
					   }
				   }
				   adminEventRecordService.save(adminEventRecord);
			   }
		  	}catch (Exception e) {
		  		e.printStackTrace();
		  		return  AjaxMsg.newError().addMessage("上传失败");
		  	}
		  return AjaxMsg.newSuccess().addMessage("上传成功");
	 } 
	 
	 @SuppressWarnings("deprecation")
	private String getValue(Cell hssfCell) {
	     if(hssfCell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
		     return String.valueOf(hssfCell.getBooleanCellValue());
		 }else if(hssfCell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
		     return String.valueOf(Math.round(hssfCell.getNumericCellValue()));
		 }else{
		     return String.valueOf(hssfCell.getStringCellValue());
	     }
	 }
}

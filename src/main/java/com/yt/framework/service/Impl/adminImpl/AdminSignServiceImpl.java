package com.yt.framework.service.Impl.adminImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
import com.yt.framework.persistent.entity.AdminSign;
import com.yt.framework.persistent.entity.AdminSignCfg;
import com.yt.framework.persistent.entity.Certification;
import com.yt.framework.persistent.entity.LeagueSign;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.enums.SmsEnum.SMSTEMP;
import com.yt.framework.service.AcountService;
import com.yt.framework.service.CertificaService;
import com.yt.framework.service.LeagueService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.SecurityService;
import com.yt.framework.service.UserService;
import com.yt.framework.service.Impl.BaseServiceImpl;
import com.yt.framework.service.admin.AdminSignService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.BeanUtils;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.PageModel;
import com.yt.framework.utils.UUIDGenerator;
import com.yt.framework.utils.smsSend.SendMsg;

@Service("adminSignService")
public class AdminSignServiceImpl extends BaseServiceImpl<AdminSign> implements AdminSignService {
	
	protected static Logger logger = LogManager.getLogger(AdminSignServiceImpl.class);
	@Autowired
	LeagueService leagueService;
	@Autowired
	CertificaService certificaService;
	@Autowired
	AcountService acountService;
	@Autowired
	UserService userService;
	@Autowired
	PlayerInfoService playerInfoService;
	@Autowired
	MessageResourceService messageResourceService;
	@Autowired
	SecurityService securityService;
	
	@Override
	public AjaxMsg saveLeagueSign(LeagueSign leagueSign) throws Exception{
		LeagueSign l = leagueService.getLeagueSign(leagueSign.getUser_id(), leagueSign.getS_id());
		if(null == l || StringUtils.isBlank(l.getId())){
			return leagueService.saveLeagueSign(leagueSign);
		}else{
			System.out.println("leagueSign exist");
			return AjaxMsg.newSuccess();
		}
	}

	@Override
	public AjaxMsg saveCertification(Certification certification)throws Exception{
		Certification c = certificaService.getCertificationByUserId(certification.getUser_id(), "idcard");
		if(null == c || StringUtils.isBlank(c.getId())){
			Certification ci = certificaService.getCertificationByIdCard(certification.getId_card(), "idcard");
			//判断该身份证是否已经被其他账号占用
			if(null == ci || StringUtils.isBlank(c.getId())){
				certificaService.save(certification);
			}else{
				return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
			}
		}else{
			c.setId_card(certification.getId_card());
			certificaService.update(c);
			System.out.println("certification exist");
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
		
	}

	@Override
	public AjaxMsg saveUser(User user)throws Exception{
		return userService.savaAccount(null, user);
	}

	@Override
	public AjaxMsg savePlayer(PlayerInfo playerInfo)throws Exception{
		PlayerInfo p = playerInfoService.getPlayerInfoByUserId(playerInfo.getUser_id());
		if(null == p || StringUtils.isBlank(p.getId())){
			return playerInfoService.savePlayerInfo(playerInfo, null);
		}else{
			System.out.println("playerInfo exist");
			return AjaxMsg.newSuccess();
		}
	}

	@Override
	public AjaxMsg saveAllInfo(AdminSign adminSign,HttpServletRequest request)throws Exception {
		AjaxMsg msg = AjaxMsg.newSuccess();
		AdminSign as = adminSignMapper.getAdminSign(adminSign.getMobile(),adminSign.getS_id());
		if(null == as){
			if(StringUtils.isBlank(adminSign.getId())){
				adminSign.setId(UUIDGenerator.getUUID());
				adminSignMapper.save(adminSign);
			}
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.league.dataexist"));
		}
		//保存账户信息	
		User u = userService.getUserByPhoneOrEmail(adminSign.getMobile());
		String user_id = "";
		if(null == u){
			String password = "";
			User user = new User();
			user_id = UUIDGenerator.getUUID();
			user.setUsernick(adminSign.getMobile());
			user.setUsername(adminSign.getUsername());
			user.setId(user_id);
			user.setPhone(adminSign.getMobile());
			password = Common.getRandomNum6()+"";
			user.setPassword(password);
			user.setId_card(adminSign.getIdcard());
			user.setSex(1);
			msg = userService.savaAccount(request, user);
			//发短信
			if(msg.isSuccess()){
				SendMsg.getInstance().sendSMS(adminSign.getMobile(), "@1@="+password, SMSTEMP.JSM405880028.toString());
			}
		}else{
			user_id = u.getId();
		}
		
		//保存实名信息
		Certification certification = new Certification();
		certification.setId(UUIDGenerator.getUUID());
		certification.setName(adminSign.getUsername());
		certification.setType("idcard");
		certification.setUser_id(user_id);
		certification.setStatus(2);
		certification.setId_card(adminSign.getIdcard());
		msg = this.saveCertification(certification);
		
		//保存报名信息
		LeagueSign leagueSign = new LeagueSign();
		leagueSign.setId(UUIDGenerator.getUUID());
		leagueSign.setUser_id(user_id);
		leagueSign.setS_id(adminSign.getS_id());
		leagueSign.setMobile(adminSign.getMobile());
		leagueSign.setStatus(2);
		leagueSign.setSex(1);
		leagueSign.setInvalid(1);
		msg = this.saveLeagueSign(leagueSign);
		
		//保存球员信息
		PlayerInfo playerInfo = new PlayerInfo();
		playerInfo.setUser_id(user_id);
		msg = this.savePlayer(playerInfo);
		
		/*if(adminSign.getIf_pay() == 1){
			String order_id = Common.createOrderOSN();
			//保存资金充值信息
			// 充值记录
			PayRecord pr = new PayRecord();
			pr.setId(UUIDGenerator.getUUID());
			pr.setAmount(new BigDecimal(50));
			pr.setFree(new BigDecimal(0));
			pr.setOrder_no(order_id);
			pr.setUser_id(user_id);
			pr.setReal_amount(new BigDecimal(50));
			pr.setStatus(0);
			pr.setSubmit_time(new Date());
			pr.setWay(WayType.OFFLINE.toString());
			pr.setDescrible("账户充值");
			pr.setType(2);
			payRecordMapper.save(pr);
			//消费表
			PayCost pc = new PayCost();
			pc.setId(UUIDGenerator.getUUID());
			pc.setAmount(new BigDecimal(50));
			pc.setUser_id(user_id);
			pc.setNum_str(order_id);
			pc.setStatus(1);
			pc.setDescrible("联赛报名费用");
			payCostMapper.save(pc);
			//联赛交费记录
			LeagueCost leagueCost = new LeagueCost();
			leagueCost.setAmount(new BigDecimal(50));
			leagueCost.setUser_id(user_id);
			leagueCost.setS_id(adminSign.getS_id());
			leagueCost.setStatus(1);
			leagueCost.setOrder_no(order_id);
			leagueCost.setId(UUIDGenerator.getUUID());
			leagueCostMapper.save(leagueCost);
		}*/
		return msg;
	}
	
	@Override
	public AjaxMsg saveAllInfoApp(AdminSign adminSign,HttpServletRequest request)throws Exception {
		AjaxMsg msg = AjaxMsg.newSuccess();
		AdminSignCfg adminSignCfg = adminSignMapper.getCfgById(adminSign.getSign_id());
		if(StringUtils.isNotBlank(adminSignCfg.getS_id())){ //赛季报名
			if(StringUtils.isBlank(adminSign.getIdcard())){
				return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.sign.idcard"));
			}
		}
		Map<String,Object> maps = Maps.newHashMap();
		maps.put("sign_id",BeanUtils.nullToString(adminSign.getSign_id()));
		maps.put("mobile",BeanUtils.nullToString(adminSign.getMobile()));
		AdminSign as = adminSignMapper.getAdminSignBySign(maps);
		if(null == as){
			if(StringUtils.isBlank(adminSign.getId())){
				adminSign.setId(UUIDGenerator.getUUID());
				adminSign.setS_id(BeanUtils.nullToString(adminSignCfg.getS_id()));
				adminSignMapper.save(adminSign);
				SendMsg.getInstance().sendSMS(adminSign.getMobile(), "@1@="+adminSignCfg.getTitle(), SMSTEMP.JSM405880044.toString());
			}
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.warn.sign"));
		}
		//保存账户信息	
		User u = userService.getUserByPhoneOrEmail(adminSign.getMobile());
		String user_id = "";
		if(null == u){
			User user = new User();
			String password = "";
			user_id = UUIDGenerator.getUUID();
			password = Common.getRandomNum6()+"";
			user.setUsernick(adminSign.getMobile());
			user.setUsername(adminSign.getUsername());
			user.setId(user_id);
			user.setPhone(adminSign.getMobile());
			user.setPassword(password);
			
			user.setSex(1);
			msg = userService.savaAccount(request, user);
		}else{
			user_id = u.getId();
			securityService.reloadUserRole(u,request);
		}
		if(StringUtils.isNotBlank(adminSignCfg.getS_id())){ //赛季报名
			//保存实名信息
			Certification certification = new Certification();
			certification.setId(UUIDGenerator.getUUID());
			certification.setName(adminSign.getUsername());
			certification.setType("idcard");
			certification.setUser_id(user_id);
			certification.setStatus(2);
			certification.setId_card(adminSign.getIdcard());
			msg = this.saveCertification(certification);
			
			//保存报名信息
			LeagueSign leagueSign = new LeagueSign();
			leagueSign.setId(UUIDGenerator.getUUID());
			leagueSign.setUser_id(user_id);
			leagueSign.setS_id(adminSign.getS_id());
			leagueSign.setMobile(adminSign.getMobile());
			leagueSign.setStatus(2);
			leagueSign.setSex(1);
			leagueSign.setInvalid(1);
			msg = this.saveLeagueSign(leagueSign);
			
			//保存球员信息
			PlayerInfo playerInfo = new PlayerInfo();
			playerInfo.setUser_id(user_id);
			msg = this.savePlayer(playerInfo);
			SendMsg.getInstance().sendSMS(adminSign.getMobile(),"", SMSTEMP.JSM405880032.toString());
			msg.addData("flag", "true");
		}else{
			msg.addData("flag", "false");
		}
		return msg;
	}

	@Override
	public AjaxMsg saveSignCfg(AdminSignCfg adminSignCfg) {
		if(StringUtils.isBlank(adminSignCfg.getId())){
			adminSignCfg.setId(UUIDGenerator.getUUID());
			adminSignMapper.saveAdminSignCfg(adminSignCfg);
		}else{
			adminSignMapper.updateAdminSignCfg(adminSignCfg);
		}
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public AdminSignCfg getCfgById(String id) {
		return adminSignMapper.getCfgById(id);
	}

	@Override
	public AjaxMsg queryCfgForPage(Map<String, Object> maps, PageModel pageModel) {
		List<AdminSignCfg> datas = new ArrayList<AdminSignCfg>();
		int count = 0 ;
		if(maps!=null){
			if(pageModel!=null){
				count = countCfg(maps);
				pageModel.setTotalCount(count);
				maps.put("start",pageModel.getFirstNum());
				maps.put("rows",pageModel.getPageSize());
			}
			datas = adminSignMapper.queryCfgForPage(maps);
			pageModel.setItems(datas);
			return AjaxMsg.newSuccess().addData("page", pageModel);
		}
		return null;
	}
	
	@Override
	public int countCfg(Map<String, Object> maps) {
		return adminSignMapper.countCfg(maps);
	}

	@Override
	public AjaxMsg deleteAdminSignCfg(String id) throws Exception {
		adminSignMapper.deleteAdminSignCfg(id);
		return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
	}

	@Override
	public List<AdminSignCfg> getCfgByMap(Map<String, Object> maps) {
		return adminSignMapper.queryCfgForPage(maps);
	}

	@Override
	public int queryKeyword(String keyword) {
		return adminSignMapper.queryKeyword(keyword);
	}

}

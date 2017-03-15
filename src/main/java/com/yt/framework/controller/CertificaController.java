package com.yt.framework.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yt.framework.persistent.entity.Certification;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.enums.CertificationEnum.CerType;
import com.yt.framework.service.CertificaService;
import com.yt.framework.service.FileService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.UUIDGenerator;

/**
 *认证
 *@autor bo.xie
 *@date2015-8-24下午3:22:48
 */
@Controller
@RequestMapping(value="/certificat/")
public class CertificaController extends BaseController {
	
	private static Logger logger = LogManager.getLogger(CertificaController.class);

	@Autowired
	private CertificaService certificaService;
	
	@Autowired
	private UserService userService;
	@Autowired
	private FileService fileService;
	
	
	/**
	 * 身份证认证页面
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-25下午5:14:38
	 */
	@RequestMapping(value="IDinfo")
	public String iDCardInfoPage(Model model,HttpServletRequest request){
		User user = super.getUser();
		String uid = user.getId();
		Certification cer = certificaService.getCertificationByUserId(uid, CerType.IDCARD.toString());
		model.addAttribute("cer", cer);
		model.addAttribute("user", user);
		return "system/cer_info";
	}
	
	/**
	 * 编辑身份证认证页面
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-25下午5:14:27
	 */
	@RequestMapping(value="edit")
	public String editIDCardInfoPage(Model model,HttpServletRequest request){
		String uid = super.getUserId();
		Certification cer = certificaService.getCertificationByUserId(uid, CerType.IDCARD.toString());
		model.addAttribute("cer", cer);
		return "system/cer_edit";
	}
	
	/**
	 * 保存实名认证
	 *@param request
	 *@param cer
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-8-25下午5:14:12
	 */
	@RequestMapping(value="save")
	public @ResponseBody String saveIDCardInfo(HttpServletRequest request,Certification cer){
		String user_id = super.getUserId();
		/*update by bo.xie 前台上传不同步更新用户表信息，认证信息由后台去更新
		 * User user = userService.getEntityById(user_id);*/
		AjaxMsg msg = AjaxMsg.newError();
		String ano_img_src = request.getParameter("ano_img_src");
		if(StringUtils.isBlank(cer.getName()) || StringUtils.isBlank(cer.getId_card()) || StringUtils.isBlank(cer.getImg_src())
				|| StringUtils.isBlank(ano_img_src)) return msg.addMessage("姓名或身份证为空").toJson();
		Certification old_cer = certificaService.getCertificationByUserId(user_id, CerType.IDCARD.toString());
		StringBuilder sb = new StringBuilder();
		sb.append(cer.getImg_src()).append(",").append(ano_img_src);
		if(old_cer==null){
			//判断用户身份证认证是否已有用户认证
			AjaxMsg reMsg = certificaService.isExitCertification(cer.getId_card(), CerType.IDCARD.toString());
			if(reMsg.isError())return reMsg.toJson();
			cer.setDescripe("用户身份证认证");
			cer.setType(CerType.IDCARD.toString());
			cer.setUser_id(user_id);
			cer.setImg_src(sb.toString());
			cer.setStatus(2);
			cer.setId(UUIDGenerator.getUUID());
			msg = certificaService.saveCertification(cer);
		}else{
			old_cer.setName(cer.getName());
			old_cer.setId_card(cer.getId_card());
			old_cer.setImg_src(sb.toString());
			old_cer.setStatus(2);
			msg = certificaService.updateCertification(old_cer);
		}
	/* update by bo.xie 前台上传不同步更新用户表信息，认证信息由后台去更新
	 * 	if(msg.isSuccess()){
			user.setUsername(cer.getName());
			user.setId_card(cer.getId_card());
			msg = userService.update(user);
		}*/
		
		return msg.toJson();
	}
	
	/**
	 * 职业球员认证页面
	 *@param model
	 *@param request
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-10下午4:48:12
	 */
	@RequestMapping(value="player")
	public String professionalPlayer(Model model,HttpServletRequest request){
		User user = userService.getEntityById(super.getUserId());
		//判断当前用户是否已认证职业球员
		Certification cer = certificaService.getCertificationByUserId(user.getId(), CerType.PROFESSIONAL.toString());
		if(cer!=null){
			String[] imgs = cer.getImg_src().split(",");
			model.addAttribute("cer", cer);
			model.addAttribute("imgs", imgs);
		}
		model.addAttribute("user", user);
		return "player/player_cert";
	}
	
	/**
	 * 
	 *@param request
	 *@param cer
	 *@return
	 *@autor bo.xie
	 *@parameter *
	 *@date2015-9-10下午6:28:39
	 */
	@RequestMapping(value="savePlayerCert")
	public @ResponseBody String savePlayerCert(HttpServletRequest request,Certification cer) throws Exception{
		String user_id = super.getUserId();
		AjaxMsg msg = AjaxMsg.newError();	
		if(StringUtils.isBlank(cer.getName()) || StringUtils.isBlank(cer.getId_card()))return msg.addMessage("姓名或者身份证号为空，请先实名认证！").toJson();
		
		String img_srcs = cer.getImg_src();
		if(StringUtils.isBlank(img_srcs) || img_srcs.length()<3)return msg.addMessage("请上传球员参赛照片！").toJson();
		if(StringUtils.isBlank(cer.getPermit_img_src()))return msg.addMessage("请上传参赛证照片！").toJson();
		
		Certification old_cer = certificaService.getCertificationByUserId(user_id, CerType.PROFESSIONAL.toString());
		//判断该用户是否是重新认证
		if(old_cer!=null){
			String[] old_imgs = StringUtils.isNotBlank(old_cer.getImg_src()) ? old_cer.getImg_src().split(",") : null;
			String[] new_imgs = StringUtils.isNotBlank(cer.getImg_src()) ? cer.getImg_src().split(",") : null;
			String old_src = old_cer.getPermit_img_src();
			String new_src = cer.getPermit_img_src();
			old_cer.setImg_src(img_srcs);
			old_cer.setPermit_img_src(cer.getPermit_img_src());
			old_cer.setStatus(2);
			msg = certificaService.update(old_cer);
			if(msg.isSuccess()){
				fileService.uploadImg2OSS(old_imgs,new_imgs);
			}
			fileService.uploadImg2OSS(old_src,new_src);
		}else{
			//判断用户身份证认证是否已有用户认证职业球员
			AjaxMsg reMsg = certificaService.isExitCertification(cer.getId_card(), CerType.PROFESSIONAL.toString());
			if(reMsg.isError())return reMsg.toJson();
			cer.setDescripe("职业球员认证");
			cer.setType(CerType.PROFESSIONAL.toString());
			cer.setUser_id(user_id);
			cer.setStatus(2);
			cer.setId(UUIDGenerator.getUUID());
			msg = fileService.uploadImg2OSS(cer.getImg_src().split(","));
			msg = fileService.uploadImg2OSS(cer.getPermit_img_src());
			if(msg.isSuccess()){
				msg = certificaService.save(cer);
			}
		}
		
		return msg.toJson();
	}
}

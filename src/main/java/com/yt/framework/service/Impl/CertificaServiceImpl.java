package com.yt.framework.service.Impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.yt.framework.persistent.entity.Certification;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.enums.CertificationEnum.CerType;
import com.yt.framework.service.CertificaService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.PlayerInfoService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.ImageKit;
import com.yt.framework.utils.file.FileRepository;
import com.yt.framework.utils.oss.Global;
import com.yt.framework.utils.oss.OSSClientFactory;

/**
 *
 *@autor bo.xie
 *@date2015-8-25下午2:39:32
 */
@Transactional
@Service("certificaService")
public class CertificaServiceImpl extends BaseServiceImpl<Certification> implements
		CertificaService {
	
	protected static Logger logger = LogManager.getLogger(CertificaServiceImpl.class);
	@Autowired
	PlayerInfoService playerInfoService;
	@Autowired
	UserService userService;
	@Autowired
	private MessageResourceService messageResourceService;
	@Resource(name = "fileRepository")
	private FileRepository fileRepository;
	
	@Override
	public Certification getCertificationByUserId(String user_id, String type) {
		return certificationMapper.getCertificationByUserId(user_id, type);
	}

	@SuppressWarnings("static-access")
	@Override
	public AjaxMsg isExitCertification(String id_card, String type) {
		AjaxMsg msg = AjaxMsg.newError();
		if(StringUtils.isBlank(id_card)||StringUtils.isBlank(type))return msg.addMessage(messageResourceService.getMessage("system.error"));
		
		Certification certification = certificationMapper.getCertificationByIdcardAndType(id_card, type);
		if(certification!=null)return msg.addMessage(messageResourceService.getMessage("user.certification.exist"));
		
		return msg.newSuccess();
	}

	@Override
	public int getCertificationByIdCardCount(String id_card, String type,int status) {
		return certificationMapper.getCertificationByIdCardCount(id_card,type,status);
	}

	@Override
	public AjaxMsg playerAuditResult(Certification certification) throws Exception {
		AjaxMsg msg = AjaxMsg.newSuccess();
		certificationMapper.update(certification);
			if(certification.getType().equals(CerType.PROFESSIONAL.toString())){
				PlayerInfo playerInfo = playerInfoService.getPlayerInfoByUserId(certification.getUser_id());
				playerInfo.setPro_status(new Integer(1));
				msg = playerInfoService.update(playerInfo);
			}else{
				if(certification.getStatus() == 1){
					User user = userService.getEntityById(certification.getUser_id());
					user.setUsername(certification.getName());
					user.setId_card(certification.getId_card());
					user.setUsernick(certification.getName());
					msg = userService.update(user);
				}
			}
		return msg;
	}

	@Override
	public AjaxMsg saveCertification(Certification certification) {
		if(certification!=null){
			String id_card = certification.getId_card();
			if(StringUtils.isNotBlank(id_card)){
				Certification old_certification = certificationMapper.getCertificationByIdCard(id_card, CerType.IDCARD.toString());
				if(old_certification!=null)return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.ifBind"));
				String imgStr = certification.getImg_src();
				String imgs[] = imgStr.split(",");
				for (String img : imgs) {
					if(StringUtils.isNotBlank(img)){
						int result = OSSClientFactory.uploadFile(img, new File(fileRepository.getRealPath(img)));
						if(result == Global.SUCCESS){
							ImageKit.delFile(fileRepository.getRealPath(img));
						}else{
							return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
						}
					}
				}
				certificationMapper.save(certification);
			}
		}
		return AjaxMsg.newSuccess();
	}
	
	@Override
	public AjaxMsg updateCertification(Certification certification) {
		Certification old = getCertificationByUserId(certification.getUser_id(), CerType.IDCARD.toString());
		String old_img = old.getImg_src();
		String new_img = certification.getImg_src();
		if(StringUtils.isNotBlank(old_img)){
			List<String> oldImgs = Lists.newArrayList(old_img.split(","));
			List<String> ss1 = new ArrayList<String>();
			ss1.addAll(oldImgs);
			if(StringUtils.isNotBlank(new_img)){
				List<String> newImgs = Lists.newArrayList(new_img.split(","));
				oldImgs.removeAll(newImgs);//缺少的
				newImgs.removeAll(ss1);//多出来的
				if(oldImgs!=null&&oldImgs.size()>0){
					for (String oi : oldImgs) {
						OSSClientFactory.deleteFile(oi);
					}
				}
				if(newImgs!=null&&newImgs.size()>0){
					for (String ni : newImgs) {
						int flag = OSSClientFactory.uploadFile(ni, new File(fileRepository.getRealPath(ni)));
						if(flag == Global.SUCCESS){
							ImageKit.delFile(fileRepository.getRealPath(ni));
						}
					}
				}
			}else{
				for (String oi : oldImgs) {
					OSSClientFactory.deleteFile(oi);
				}
			}
		}else{
			if(StringUtils.isNotBlank(new_img)){
				List<String> newImgs = Lists.newArrayList(new_img.split(","));
				if(newImgs!=null&&newImgs.size()>0){
					for (String ni : newImgs) {
						int flag = OSSClientFactory.uploadFile(ni, new File(fileRepository.getRealPath(ni)));
						if(flag == Global.SUCCESS){
							ImageKit.delFile(fileRepository.getRealPath(ni));
						}
					}
				}
			}
		}
		update(certification);
		return AjaxMsg.newSuccess();
	}

	@Override
	public Certification getCertificationByIdCard(String id_card, String type) {
		return certificationMapper.getCertificationByIdCard(id_card, type);
	}

	@Override
	public boolean checkUserCertifica(String user_id) {
		Certification c = certificationMapper.getUserSuccessCertificaByUserId(user_id);
		if(null != c){
			return true;
		}
		return false;
	}
}

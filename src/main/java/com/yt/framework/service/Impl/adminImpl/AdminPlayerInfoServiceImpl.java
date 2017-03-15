package com.yt.framework.service.Impl.adminImpl;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.Certification;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.persistent.entity.User;
import com.yt.framework.persistent.enums.SmsEnum.SMSTEMP;
import com.yt.framework.service.CertificaService;
import com.yt.framework.service.MessageResourceService;
import com.yt.framework.service.UserService;
import com.yt.framework.service.admin.AdminPlayerInfoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.smsSend.SendMsg;

@Service(value="adminPlayerInfoService")
public class AdminPlayerInfoServiceImpl extends BaseAdminServiceImpl<PlayerInfo> implements AdminPlayerInfoService {
	
	@Autowired
	MessageResourceService messageResourceService;
	@Autowired
	CertificaService certificaService;
	@Autowired
	UserService userService;
	
	@Override
	public AjaxMsg updatePlayerLevel(PlayerInfo playerInfo) {
		PlayerInfo player = this.getEntityById(playerInfo.getId());
		if(player == null){ //是否开通球员
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error.user.noplayer"));
		}
		Certification c = certificaService.getCertificationByUserId(player.getUser_id(), "idcard");
		if(c == null){ //是否身份证认证
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("user.certification.noexist"));
		}
		int num = playerInfoMapper.updatePlayerLevel(playerInfo);
		if(num>0){
			User user = userService.getEntityById(player.getUser_id());
			if(StringUtils.isNotBlank(user.getPhone())){
				//SendMsg.getInstance().sendSMS(user.getPhone(), "@1@="+password, SMSTEMP.JSM405880028.toString());
			}
			try {
				if(playerInfo.getLevel() == 0){ //设置普通球员
					messageResourceService.saveUserDynamicMessage(new Object[]{user.getUsername(),user.getId()}, "user.player.downlevel", player.getUser_id());
				}else{
					messageResourceService.saveUserDynamicMessage(new Object[]{user.getUsername(),user.getId()}, "user.player.uplevel", player.getUser_id());
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return AjaxMsg.newSuccess().addMessage(messageResourceService.getMessage("system.success"));
		}else{
			return AjaxMsg.newError().addMessage(messageResourceService.getMessage("system.error"));
		}
	}

}

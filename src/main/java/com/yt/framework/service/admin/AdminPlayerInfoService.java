package com.yt.framework.service.admin;

import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.service.BaseService;
import com.yt.framework.utils.AjaxMsg;

public interface AdminPlayerInfoService extends BaseService<PlayerInfo>{

	public AjaxMsg updatePlayerLevel(PlayerInfo playerInfo);

}

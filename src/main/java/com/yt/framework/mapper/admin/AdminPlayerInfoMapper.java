package com.yt.framework.mapper.admin;

import com.yt.framework.mapper.BaseMapper;
import com.yt.framework.persistent.entity.PlayerInfo;
import com.yt.framework.utils.AjaxMsg;

public interface AdminPlayerInfoMapper extends BaseMapper<PlayerInfo> {

	public int updatePlayerLevel(PlayerInfo playerInfo);

}

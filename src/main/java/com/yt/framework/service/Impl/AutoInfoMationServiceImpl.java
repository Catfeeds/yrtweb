package com.yt.framework.service.Impl;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yt.framework.mapper.MessageMapper;
import com.yt.framework.persistent.entity.Message;
import com.yt.framework.persistent.entity.MessageRecords;
import com.yt.framework.persistent.enums.SystemEnum.MSGTYPE;
import com.yt.framework.service.AutoInfoMationService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.UUIDGenerator;

/**
 *
 *@autor bo.xie
 *@date2015-8-18上午11:56:21
 */
@Service("autoInfoMationService")
public class AutoInfoMationServiceImpl implements AutoInfoMationService {
	
	protected static Logger logger = LogManager.getLogger(AutoInfoMationServiceImpl.class);

	@Autowired
	private MessageMapper messageMapper;
	
	@Override
	public AjaxMsg sendInfo(String user_id, String s_user_id,String msgType, String type,
			String content) {
			if(msgType.equals(MSGTYPE.USER.toString())){
				//个人信息存储
				Message  message = new Message();
				message.setId(UUIDGenerator.getUUID());
				message.setUser_id(user_id);
				message.setS_user_id(s_user_id);
				message.setContent(content);
				message.setStatus(0);
				message.setType(type);
				messageMapper.save(message);
//				if(type.equals(SYSTYPE.INTEAM.toString()) || type.equals(SYSTYPE.OUTTEAM.toString())){//俱乐部存入一条公告
//					Dynamic dyn = new Dynamic();
//					dyn.setUser_id(s_user_id);//球员ID
//					dyn.setText(content);
//					dyn.setType(2);//type 2:球员
//					dynamicMapper.save(dyn);
//				}
			}else if(msgType.equals(MSGTYPE.INDEX.toString())){
				//推送信息记录
				MessageRecords mr = new MessageRecords();
				mr.setId(UUIDGenerator.getUUID());
				mr.setUser_ids(user_id.toString());
				mr.setUser_id(s_user_id);
				mr.setContent(content);
				mr.setType(type);
				mr.setIs_show(1);
				messageMapper.saveMessageRecord(mr);
			}
		return AjaxMsg.newSuccess();
	}

}

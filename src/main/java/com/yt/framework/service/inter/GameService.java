package com.yt.framework.service.inter;

import com.googlecode.jsonrpc4j.JsonRpcError;
import com.googlecode.jsonrpc4j.JsonRpcErrors;
import com.googlecode.jsonrpc4j.JsonRpcService;
import com.yt.framework.persistent.entity.QMatchInfo;
import com.yt.framework.persistent.entity.User;

@JsonRpcService("/GameService.json")
public interface GameService {
	@JsonRpcErrors({
		@JsonRpcError(exception = Exception.class,
	            code=-5678, message="User already exists", data="The Data"),
		@JsonRpcError(exception=Throwable.class,code=-187)
	})
	/*public User getUser(@JsonRpcParam("user_id")String id);
	
	
	public String getUserJson(@JsonRpcParam("user_id")String id);*/
	public String isAlive();
	
	
	public String saveGameId(String gameId,String key,String create_time);	
	
}

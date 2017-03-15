package com.yt.framework.service.Impl.adminImpl;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.yt.framework.persistent.entity.IndexModel;
import com.yt.framework.service.Impl.BaseServiceImpl;
import com.yt.framework.service.admin.IndexModelService;

@Service(value="indexModelService")
public class IndexModelServiceImpl extends BaseServiceImpl<IndexModel> implements IndexModelService {
	
	protected static Logger logger = LogManager.getLogger(IndexModelServiceImpl.class);

}

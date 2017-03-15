package com.yt.test.image;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import com.yt.framework.persistent.entity.ImageVideo;
import com.yt.framework.service.ImageVideoService;
import com.yt.framework.utils.AjaxMsg;
import com.yt.framework.utils.PageModel;

/**
 *
 *@autor bo.xie
 *@date2015-8-14下午4:06:30
 */
@ContextConfiguration(locations={"classpath*:spring/applicationContext.xml","classpath*:spring/appServlet/*.xml"})
public class TestImage extends AbstractJUnit4SpringContextTests{

	@Autowired
	private ImageVideoService imageVideoService;
	
	@Test
	public void loadAllData(){
		String user_id = "1";
		int type = 1;
		int role_type = 1;
		PageModel<ImageVideo> pageModel = new PageModel<>();
		AjaxMsg msg = imageVideoService.getImageVideosByUserId(user_id, type, role_type, pageModel);
		System.out.println(msg.toJson());
	}
}

package com.yt.test;

import java.util.Calendar;
import java.util.Date;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;

import com.yt.framework.mapper.admin.ActiveCodeMapper;
import com.yt.framework.persistent.entity.ActiveCode;
import com.yt.framework.utils.Common;
import com.yt.framework.utils.UUIDGenerator;

/**
 * 激活码生成
 * @author bo.xie
 *
 */
@ContextConfiguration(locations={"classpath*:spring/applicationContext.xml","classpath*:spring/appServlet/*.xml"})
public class ActiveCodeTest extends AbstractJUnit4SpringContextTests{

	@Autowired
	private ActiveCodeMapper activeCodeMapper;
	
	/**
	 * 生成激活码
	 */
	@Test
	public void createCode(){
		int i=0;
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DAY_OF_YEAR, 30);
		while(i<24){
			StringBuilder sb = new StringBuilder("U2015Team");
			int a =Common.getRandomNum6();
			String b = Common.formatDate(new Date(), "yyyy");
			String code_str = sb.append(a).append(b).append(Common.getRandomNum4()).toString();
			ActiveCode activeCode = new ActiveCode();
			activeCode.setId(UUIDGenerator.getUUID());
			activeCode.setLeague_id("1");
			activeCode.setCode_str(code_str);
			activeCode.setEnd_time(Common.parseStringDate("2015-12-12", "yyyy-MM-dd"));
			activeCodeMapper.saveActiveCode(activeCode);
			i++;
		}
		
	}
	
}

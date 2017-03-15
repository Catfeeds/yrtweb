package com.yt.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.yt.framework.service.CommonService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:spring/applicationContext.xml","classpath:spring/appServlet/spring-beans.xml","classpath:spring/appServlet/spring-security.xml"})
public class CaTest extends AbstractJUnit4SpringContextTests {
	
	@Autowired
	public CommonService commonService;
	
	@Test
	public void testGet(){
	/*	String name = commonService.dictName("p_tags", "jqzh");
		System.out.println("========================" + name);
		String name1 = commonService.dictName("p_tags", "jqzh");*/
		//System.out.println("========================" + name1);
	}
}

package com.yt.framework.utils;


import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.yt.framework.utils.queue.ProcessorManager;


public class InitWebListener implements ServletContextListener {

	static Logger logger = LogManager.getLogger(InitWebListener.class.getName());
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {

	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		ProcessorManager.getInstance().startQueueProcessor();
        logger.info("webroot:"+arg0.getServletContext().getRealPath("/"));
	}
}

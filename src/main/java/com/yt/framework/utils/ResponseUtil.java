package com.yt.framework.utils;

import java.io.ByteArrayOutputStream;
import java.util.zip.GZIPOutputStream;

import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletResponse;



public class ResponseUtil {

	private static Logger logger = Logger.getLogger(ResponseUtil.class);
	
	public static void sendResponseXML(HttpServletResponse response,
			String responseMsg) {
		if(responseMsg==null)return ;
		try {
			response.setContentType("text/xml;charset=UTF-8");
			byte[] msgs = responseMsg.getBytes("UTF-8");
			response.setContentLength(msgs.length);
			response.getOutputStream().write(msgs);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (Exception e) {
			logger.error("ResponseUtil sendResponse() " + e.getMessage());
		}
	}
	
	public static void sendResponseHTML(HttpServletResponse response,
			String responseMsg) {
		if(responseMsg==null)return ;
		try {
			/*
				text/html--HTML 
				text/plain--TXT
				text/xml--XML
			 */
			
			
			byte[] msgs = responseMsg.getBytes("UTF-8");

			boolean bgzip = false;//暂时不启用json数据压缩
			if (bgzip) {
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				GZIPOutputStream gzip = new GZIPOutputStream(baos);
				gzip.write(msgs);
				gzip.close();
				msgs= baos.toByteArray() ;
				response.setHeader("Content-Encoding", "gzip");
			}
            
			response.setContentType("text/html;charset=UTF-8");
	        response.setHeader("Cache-Control","no-store, max-age=0, no-cache, must-revalidate");     
	        response.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
	        response.setHeader("Pragma", "no-cache");  
	        response.setDateHeader("Expires", 0);
			response.setContentLength(msgs.length);
			response.getOutputStream().write(msgs);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (Exception e) {
			logger.error("ResponseUtil sendResponseText() " + e.getMessage());
		}
	}
	
	public static void sendResponseMsg(HttpServletResponse response,Integer code,String responseMsg) {
		StringBuffer sb = new StringBuffer();
		sb.append("<response>")
		.append("<statusCode>").append(code).append("</statusCode>")
		.append("<message>").append(responseMsg).append("</message>")
		.append("</response>");
		sendResponseXML(response, sb.toString());
	}

	public static void sendResponseStatus(HttpServletResponse response,AjaxMsg rv) {
		sendResponseHTML(response, rv.toJson());
	}

}



package com.yt.framework.utils;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

public class DownLoad {

	static Logger logger = LogManager.getLogger(DownLoad.class.getName());
	public static AjaxMsg download(File file, String name,
			HttpServletResponse response) {
		AjaxMsg msg = AjaxMsg.newError();
		try {
			// 以流的形式下载文件。
			InputStream fis = new BufferedInputStream(new FileInputStream(file));
			response.reset();
			response.setContentLength((int) file.length());
			response.setContentType("application/octet-stream;charset=GBK");
			response.addHeader("Content-Disposition", "attachment;filename=\""
					+ new String(name.getBytes("UTF-8"), "ISO-8859-1") + "\"");

			byte[] b = new byte[10240];
			int len;
			while ((len = fis.read(b)) > 0)
				response.getOutputStream().write(b, 0, len);
			fis.close();
			msg = AjaxMsg.newSuccess().addMessage("下载成功");
		} catch (IOException ex) {
			logger.error(ex.getLocalizedMessage(),ex);
		}
		return msg;
	}
}

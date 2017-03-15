package com.yt.framework.uploadlistener;

import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.ProgressListener;
import org.springframework.stereotype.Component;

import com.yt.framework.persistent.entity.Progress;

/**
 * @ClassName: FileUploadProgressListener 
 * @Description: 文件上传进度 
 * @author zjh
 * @date 2015年7月24日 下午3:02:05 
 */
public class FileUploadProgressListener implements ProgressListener{  
	    private HttpSession session;  
	    public FileUploadProgressListener() {  
	    }  
	    public FileUploadProgressListener(HttpSession _session) {  
	        session=_session;  
	        Progress ps = new Progress();  
	        session.setAttribute("upload_ps", ps);  
	    }  
	    public void update(long pBytesRead, long pContentLength, int pItems) {  
	        Progress ps = (Progress) session.getAttribute("upload_ps");  
	        ps.setBytesRead(pBytesRead);  
	        ps.setContentLength(pContentLength);  
	        ps.setItems(pItems);
	        ps.setMbRead(ps.getMbRead());
	        ps.setPercent(ps.getPercent());
	        ps.setSpeed(ps.getSpeed());
	        //更新  
	        session.setAttribute("upload_ps", ps);  
	    }  
	  
}  

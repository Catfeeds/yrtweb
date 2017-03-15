package com.yt.framework.utils.tag;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.yt.framework.persistent.entity.SysDict;
import com.yt.framework.service.CommonService;
import com.yt.framework.service.admin.SysDictService;
import com.yt.framework.utils.SpringContextUtil;

public class DictNameTag extends TagSupport{
	private String key;

    private String nodeKey;

    public int doStartTag() throws JspTagException {
        return EVAL_PAGE;
    }

    public int doEndTag() throws JspTagException {
        try {
            JspWriter out = this.pageContext.getOut();
            out.print(dictName().toString());
        } catch (IOException e) {
            e.printStackTrace(); 
        }
        return EVAL_PAGE;
    }
    
    public StringBuffer dictName() {
        StringBuffer sb = new StringBuffer();
        //ServletContext servletContext = pageContext.getServletContext();  
        /*ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(servletContext);
        CommonService  commonService = (CommonService)context.getBean("commonService");*/
        SysDictService sysDictService = (SysDictService)SpringContextUtil.getBean("sysDictService");
        String dictName = "";
        if(StringUtils.isBlank(this.getNodeKey()) || StringUtils.isBlank(this.getKey())){
        	sb.append("");
        	//System.out.println("nodeKey or key is null");
        }else{
        	dictName = sysDictService.dictName(this.getNodeKey(),this.getKey());
        	if(null == dictName || dictName.equals("")) {
        		//System.out.println("return dictName is null");
        		sb.append("");
        	}else{
        		sb.append(dictName);
        	}
        }
        return sb;
    }
    
    public String getNodeKey() {
        return nodeKey;
    }

    public void setNodeKey(String nodeKey) {
        this.nodeKey = nodeKey;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }
}

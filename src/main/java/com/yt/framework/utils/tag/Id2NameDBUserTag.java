package com.yt.framework.utils.tag;

import java.io.IOException;
import javax.servlet.ServletContext;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import org.apache.commons.lang.StringUtils;

import com.yt.framework.service.BaseService;
import com.yt.framework.service.UserService;
import com.yt.framework.utils.SpringContextUtil;

/**
 * id转换名称标签
 * @author ylt
 *
 */
public class Id2NameDBUserTag extends TagSupport{
    private String id ="";
    private String clazz = "";
    
    public int doStartTag() throws JspTagException {
        return EVAL_PAGE;
    }

    public int doEndTag() throws JspTagException {
        try {
            JspWriter out = this.pageContext.getOut();
            out.print(end().toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }

    public StringBuffer end() {
        StringBuffer sb = new StringBuffer();
        try{
	        UserService userService = (UserService) SpringContextUtil.getBean("userService");
	    	String name = userService.id2UserName(id);
	    	if(StringUtils.isBlank(name)){
	        	System.out.println("name is null");
	        	return sb;
	        }else{
	        	if (StringUtils.isNotBlank(name)) {
	            	if(StringUtils.isNotBlank(clazz)){
	            		sb.append("<span class='"+clazz+"'>"+name+"</span>");
	            	}else{
	            		sb.append("<span>"+name+"</span>");
	            	}
	            }
	        }
        }catch (Exception e) {
            e.printStackTrace();
            return sb;
        }
        return sb;
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getClazz() {
		return clazz;
	}

	public void setClazz(String clazz) {
		this.clazz = clazz;
	}

}

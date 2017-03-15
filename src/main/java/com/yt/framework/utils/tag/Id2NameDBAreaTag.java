package com.yt.framework.utils.tag;

import java.io.IOException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import org.apache.commons.lang.StringUtils;
import com.yt.framework.service.admin.AdminSysAreaService;
import com.yt.framework.utils.SpringContextUtil;

/**
 * 区域areacode转换名称标签
 * @author ylt
 *
 */
public class Id2NameDBAreaTag extends TagSupport{
    private String code ="";
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
	        AdminSysAreaService adminSysAreaService = (AdminSysAreaService) SpringContextUtil.getBean("adminSysAreaService");
	    	String name = adminSysAreaService.id2Name(code);
	    	if(StringUtils.isBlank(name)){
	        	System.out.println("name is null");
	        	return sb;
	        }else{
	        	if (StringUtils.isNotBlank(name)) {
	            		sb.append(name);
	            }
	        }
        }catch (Exception e) {
            e.printStackTrace();
            return sb;
        }
        return sb;
    }

	

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getClazz() {
		return clazz;
	}

	public void setClazz(String clazz) {
		this.clazz = clazz;
	}

}
